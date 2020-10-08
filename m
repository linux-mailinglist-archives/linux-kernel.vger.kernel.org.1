Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C92286CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgJHDAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgJHDAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:00:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C160C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:00:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j33so3023018pgj.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZY/GMzMDHF0gRhGbvoaK+NENk2AHXMrMJ0xXZkW2tkk=;
        b=ecu6wNzLxJ65q+F3vuTrV0mG0Yw7lF5lF755NBV6hrOfVYfkYY9tAXNuDO8EuVDaO0
         2nTDY0ZCd4OI93xe2OWmfQtStr7WmL/hFTFI/KqCLoRaEI1yUTWY5cHMuoifn3z73HbX
         XTiAsbVR/Ox68pVo8mbel6NjkXzxwSeNmocmyKQ5gqU+T4YqTEOlc42E/GiZGWt2mSp1
         C2+m59P2+Lbsx2f7ZoWbpvHq5rXRNbgm+tB3KpQxLkqpd/fdOP4J336U9uxbQsdWfe1U
         xpJrmh599aW3TUh3Yhu3n/DIlvyDUoXu9Jaaknf0I3UQdv/uchG5kIYXmNIOVkfDk7lX
         c3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZY/GMzMDHF0gRhGbvoaK+NENk2AHXMrMJ0xXZkW2tkk=;
        b=DGHa8855dAyYd+d5CMg7iJ+Qk3hLc9Tgikt1NioI0nm3W1TrPa736OwtKAQtjpKDC8
         xnnR4VNuc7AlBPVuysNSMRsj7siHkO1XwXRg/lwMLzPz8kDWo98s3JRbjzPclvKxtjoL
         1DiUawFaxr+zaT9BZSJoCsFadMXzwfgmmuY8J0gV2/BgMZ2NXtKD500PEnXeZ2Tj82nG
         kKQicW10eaZexe+EKnIQxfX8Uv1ZJs+jXo/gwZ87bhjRevPlV/INpOuZ/zz8xniICish
         ZOBNCJVU9OrQjnKkLZDbiAV9D7yrWaI80EruVfHbp5YQeJ1X/BXKpoC5zJk4KZZHM/6v
         /spA==
X-Gm-Message-State: AOAM532qDPUx6Jh9vfW0tQdR0xmJV56P0e5uiJ3hNPq1vHkZ3fltzZ//
        mveUyND2+8bsHqTt9XJO2qg=
X-Google-Smtp-Source: ABdhPJwmAl1pVsijgwwAqgwUQhghamHh/ZYi4LLhBkQxOOpBBTL6CQH4e3JV26UmoN2R+0LNAfb7KA==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr5910744pgq.325.1602126042889;
        Wed, 07 Oct 2020 20:00:42 -0700 (PDT)
Received: from localhost.localdomain ([154.223.142.197])
        by smtp.gmail.com with ESMTPSA id 16sm4256484pjl.27.2020.10.07.20.00.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 20:00:42 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] kprobes: Correct a type error in function kprobes_module_callback
Date:   Thu,  8 Oct 2020 02:59:25 +0000
Message-Id: <1602125965-31698-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a tiny type error in comment of function kprobes_module_callback.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/kprobes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e995541..9d2042b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2432,7 +2432,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 			     within_module_core((unsigned long)p->addr, mod))) {
 				/*
 				 * The vaddr this probe is installed will soon
-				 * be vfreed buy not synced to disk. Hence,
+				 * be vfreed but not synced to disk. Hence,
 				 * disarming the breakpoint isn't needed.
 				 *
 				 * Note, this will also move any optimized probes
-- 
1.7.1

