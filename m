Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7567D2B8387
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgKRSBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:01:41 -0500
Received: from foss.arm.com ([217.140.110.172]:32862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgKRSBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:01:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1310811D4;
        Wed, 18 Nov 2020 10:01:40 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEC563F718;
        Wed, 18 Nov 2020 10:01:38 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, James Morse <James.Morse@arm.com>
Subject: [PATCH 0/2] x86/intel_rdt: task_work vs task_struct rmid/closid write race
Date:   Wed, 18 Nov 2020 18:00:28 +0000
Message-Id: <20201118180030.22764-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is a small cleanup + a fix for a race I stumbled upon while staring at
resctrl stuff.

Briefly tested on a Xeon Gold 5120 (m2.xlarge.x86 on Equinix) by bouncing a few
tasks around control groups.

Cheers,
Valentin

Valentin Schneider (2):
  x86/intel_rdt: Check monitor group vs control group membership earlier
  x86/intel_rdt: Plug task_work vs task_struct {rmid,closid} update race

 arch/x86/include/asm/resctrl.h         | 11 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 71 ++++++++++++++++----------
 2 files changed, 50 insertions(+), 32 deletions(-)

--
2.27.0

