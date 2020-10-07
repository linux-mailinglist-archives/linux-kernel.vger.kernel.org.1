Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626522862F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgJGQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgJGQAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:00:49 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21EA420789;
        Wed,  7 Oct 2020 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086448;
        bh=LwJT5MJ6duYm0ro1g4xBkPdvn9lQkfO3tdHBOo/wF0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PG4mxITCIs1TjqWOoIZ5d0N/0hxF7UdYsR8GKDpfuebKt3H84WGGruRliq/Y4zvJr
         buEwsX/nhSxlGBV52WvaZ3fU9u9Edkjwen1+mYPoUyxt4jAVT7/7dCib9V1ZjhClkq
         gRcBN9CWhQlMpuW5kYN1bBDduqorQOIxpXMEVW4g=
Date:   Wed, 7 Oct 2020 11:06:48 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 07/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_vce_clock_voltage_dependency_table
Message-ID: <7226be8f69e24e8084844c3e6fc0423c64a83d53.1602020074.git.gustavoars@kernel.org>
References: <cover.1602020074.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1602020074.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in
struct phm_vce_clock_voltage_dependency_table, instead of a one-element array,
and use the struct_size() helper to calculate the size for the allocation.

Also, save some heap space as the original code is multiplying
table->numEntries by sizeof(struct phm_vce_clock_voltage_dependency_table)
when it should have multiplied it by sizeof(struct phm_vce_clock_voltage_dependency_record)
instead.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c5d35.pJToGs3H9khZK6ws%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                    |  2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c  | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index ad614e32079e..b8e33325fac6 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -186,7 +186,7 @@ struct phm_acpclock_voltage_dependency_table {
 
 struct phm_vce_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_vce_clock_voltage_dependency_record entries[1];
+	struct phm_vce_clock_voltage_dependency_record entries[];
 };
 
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index b2ef76580c6a..7719f52e6d52 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1135,15 +1135,12 @@ static int get_vce_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
 		const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *table,
 		const VCEClockInfoArray    *array)
 {
-	unsigned long table_size, i;
+	unsigned long i;
 	struct phm_vce_clock_voltage_dependency_table *vce_table = NULL;
 
-	table_size = sizeof(unsigned long) +
-			sizeof(struct phm_vce_clock_voltage_dependency_table)
-			* table->numEntries;
-
-	vce_table = kzalloc(table_size, GFP_KERNEL);
-	if (NULL == vce_table)
+	vce_table = kzalloc(struct_size(vce_table, entries, table->numEntries),
+			    GFP_KERNEL);
+	if (!vce_table)
 		return -ENOMEM;
 
 	vce_table->count = table->numEntries;
-- 
2.27.0

