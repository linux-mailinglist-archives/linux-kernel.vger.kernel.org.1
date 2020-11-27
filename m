Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7A2C5F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 04:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392386AbgK0Dyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 22:54:36 -0500
Received: from mail.loongson.cn ([114.242.206.163]:51490 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726908AbgK0Dyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 22:54:35 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx79N3eMBflk8XAA--.47333S2;
        Fri, 27 Nov 2020 11:54:32 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: ptrace generic requests
Date:   Fri, 27 Nov 2020 11:54:31 +0800
Message-Id: <1606449271-13922-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx79N3eMBflk8XAA--.47333S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr15Kr43CF1DKr1DZr1xAFb_yoWftwc_XF
        yaqw1kGFy5GrsrC3WY9w1xXr4Yyas5WFyYgasFkrZrJ3y3XFy5XrZxArnxuF1UZa1FgFs5
        A34fGryUAF1SkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUs73vUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes duplicated code by calling the generic ptrace_request
function for the things they already handle.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/alpha/kernel/ptrace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 8c43212..eb4d566 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -301,12 +301,6 @@ long arch_ptrace(struct task_struct *child, long request,
 		DBG(DBG_MEM, ("peek $%lu->%#lx\n", addr, ret));
 		break;
 
-	/* When I and D space are separate, this will have to be fixed.  */
-	case PTRACE_POKETEXT: /* write the word at location addr. */
-	case PTRACE_POKEDATA:
-		ret = generic_ptrace_pokedata(child, addr, data);
-		break;
-
 	case PTRACE_POKEUSR: /* write the specified register */
 		DBG(DBG_MEM, ("poke $%lu<-%#lx\n", addr, data));
 		ret = put_reg(child, addr, data);
-- 
2.1.0

