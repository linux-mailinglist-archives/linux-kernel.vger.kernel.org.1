Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB67C28ACA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 05:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgJLDug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:50:36 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40178 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727396AbgJLDug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:50:36 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxiMWB0oNf_LQcAA--.4045S2;
        Mon, 12 Oct 2020 11:50:25 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro
Date:   Mon, 12 Oct 2020 11:50:24 +0800
Message-Id: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxiMWB0oNf_LQcAA--.4045S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYn7k0a2IF6w1UM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
        6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY
        62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7V
        C2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkI
        ecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUIHGQDUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 	e1cc9d8d596e ("sh: switch to copy_thread_tls()")
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/sh/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d209271..165f291 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -30,7 +30,6 @@ config SUPERH
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
-- 
2.1.0

