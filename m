Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C642F1BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbhAKRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:12:19 -0500
Received: from foss.arm.com ([217.140.110.172]:33198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbhAKRMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:12:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ADC1101E;
        Mon, 11 Jan 2021 09:11:33 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37CB43F70D;
        Mon, 11 Jan 2021 09:11:32 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 0/4] cpu/hotplug: rollback and "fail" interface fixes
Date:   Mon, 11 Jan 2021 17:10:43 +0000
Message-Id: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

This patch-set intends mainly to fix HP rollback, which is currently broken,
due to an inconsistent "state" usage and an issue with CPUHP_AP_ONLINE_IDLE.

It also improves the "fail" interface, which can now be reset and will reject
CPUHP_BRINGUP_CPU, a step that can't always fail.

Vincent Donnefort (4):
  cpu/hotplug: Allowing to reset fail injection
  cpu/hotplug: CPUHP_BRINGUP_CPU exception in fail injection
  cpu/hotplug: Add cpuhp_invoke_callback_range()
  cpu/hotplug: Fix CPU down rollback

 kernel/cpu.c | 173 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 110 insertions(+), 63 deletions(-)

-- 
2.7.4

