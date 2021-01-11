Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33252F1BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbhAKRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:12:20 -0500
Received: from foss.arm.com ([217.140.110.172]:33204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbhAKRMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:12:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12D8F11B3;
        Mon, 11 Jan 2021 09:11:34 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DC3E3F70D;
        Mon, 11 Jan 2021 09:11:33 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 1/4] cpu/hotplug: Allowing to reset fail injection
Date:   Mon, 11 Jan 2021 17:10:44 +0000
Message-Id: <1610385047-92151-2-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Currently, the only way of resetting this file is to actually try to run
a hotplug, hotunplug or both. This is quite annoying for testing and, as
the default value for this file is -1, it seems quite natural to let a
user write it.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1b6302e..9121edf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2207,6 +2207,11 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fail == CPUHP_INVALID) {
+		st->fail = fail;
+		return count;
+	}
+
 	if (fail < CPUHP_OFFLINE || fail > CPUHP_ONLINE)
 		return -EINVAL;
 
-- 
2.7.4

