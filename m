Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62A2F74FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbhAOJLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:11:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:49684 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbhAOJLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:11:45 -0500
IronPort-SDR: 9Ebwi5rnuDbvSl0rPPzRoskIXqV5dlPyevRCWpxPdb1D55DKMH0l4e7D3Un5b5mtqeeKhthaPs
 99effKwBng5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="175016682"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="175016682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:10:49 -0800
IronPort-SDR: eyiiGhH5MwPsKOj5HNyrIgPwDW8+LLcTUZBbMRWFRXV9N8Ue3Su8N/yMKSAhx1D4UOfoHPXJ5Z
 ezrIcOvb+M+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="382597797"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by orsmga008.jf.intel.com with ESMTP; 15 Jan 2021 01:10:47 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com
Subject: [PATCH 3/3] perf/x86/rapl: Fix psys-energy event on Intel SPR platform
Date:   Fri, 15 Jan 2021 17:22:08 +0800
Message-Id: <20210115092208.20866-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115092208.20866-1-rui.zhang@intel.com>
References: <20210115092208.20866-1-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several things special for the RAPL Psys energy counter, on
Intel Sapphire Rapids platform.
1. it contains one Psys master package, and only CPUs on the master
   package can read valid value of the Psys energy counter, reading the
   MSR on CPUs in the slave package returns 0.
2. The master package does not have to be Physical package 0. And when
   all the CPUs on the Psys master package are offlined, we lose the Psys
   energy counter, at runtime.
3. The Psys energy counter can be disabled by BIOS, while all the other
   energy counters are not affected.

It is not easy to handle all of these in the current RAPL PMU design
because
a) perf_msr_probe() validates the MSR on some random CPU, which may either
   be in the Psys master package or in the Psys slave package.
b) all the RAPL events share the same PMU, and there is not API to remove
   the psys-energy event cleanly, without affecting the other events in
   the same PMU.

This patch addresses the problems in a simple way.

First, by setting .no_check bit for RAPL Psys MSR, the psys-energy event
is always added, so we don't have to check the Psys ENERGY_STATUS MSR on
master package.

Then, rapl_not_visible() is removed because
1. it is useless for RAPL MSRs with .no_check cleared, because the
   .is_visible() callbacks is always overridden in perf_msr_probe().
2. it is useless for RAPL MSRs with .no_check set, because we actually
   want the sysfs attributes always be visible for those MSRs.

With the above changes, we always probe the psys-energy event on Intel SPR
platform. Difference is that the event counter returns 0 when the Psys
RAPL Domain is disabled by BIOS, or the Psys master package is offlined.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/rapl.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7ed25b2ba05f..f42a70496a24 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -454,16 +454,9 @@ static struct attribute *rapl_events_cores[] = {
 	NULL,
 };
 
-static umode_t
-rapl_not_visible(struct kobject *kobj, struct attribute *attr, int i)
-{
-	return 0;
-}
-
 static struct attribute_group rapl_events_cores_group = {
 	.name  = "events",
 	.attrs = rapl_events_cores,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_pkg[] = {
@@ -476,7 +469,6 @@ static struct attribute *rapl_events_pkg[] = {
 static struct attribute_group rapl_events_pkg_group = {
 	.name  = "events",
 	.attrs = rapl_events_pkg,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_ram[] = {
@@ -489,7 +481,6 @@ static struct attribute *rapl_events_ram[] = {
 static struct attribute_group rapl_events_ram_group = {
 	.name  = "events",
 	.attrs = rapl_events_ram,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_gpu[] = {
@@ -502,7 +493,6 @@ static struct attribute *rapl_events_gpu[] = {
 static struct attribute_group rapl_events_gpu_group = {
 	.name  = "events",
 	.attrs = rapl_events_gpu,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_psys[] = {
@@ -515,7 +505,6 @@ static struct attribute *rapl_events_psys[] = {
 static struct attribute_group rapl_events_psys_group = {
 	.name  = "events",
 	.attrs = rapl_events_psys,
-	.is_visible = rapl_not_visible,
 };
 
 static bool test_msr(int idx, void *data)
@@ -534,6 +523,14 @@ static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
 };
 
+static struct perf_msr intel_rapl_spr_msrs[] = {
+	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, true, RAPL_MSR_MASK },
+};
+
 /*
  * Force to PERF_RAPL_MAX size due to:
  * - perf_msr_probe(PERF_RAPL_MAX)
@@ -764,7 +761,7 @@ static struct rapl_model model_spr = {
 			  BIT(PERF_RAPL_PSYS),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_msrs      = intel_rapl_spr_msrs,
 };
 
 static struct rapl_model model_amd_fam17h = {
-- 
2.17.1

