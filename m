Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6880A1E052D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 05:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgEYDcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 23:32:05 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48336 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388793AbgEYDcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 23:32:04 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD94sPMte3cI4AA--.386S3;
        Mon, 25 May 2020 11:31:57 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 2/2] clk: Remove CONFIG_ARCH_HISI check for subdir hisilicon
Date:   Mon, 25 May 2020 11:31:56 +0800
Message-Id: <1590377516-32117-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1590377516-32117-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590377516-32117-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxD94sPMte3cI4AA--.386S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF43Ar1DWw48JryxZr45trb_yoWfAFbEkr
        WDGr1xXw15CrykuF47WF92vryq9Fs8Zrn5uF4ayry3J34UZr43JF4qqr4UAF15GrW8uFyY
        va1SqFy3ZryIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbh8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU80edUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARCH_HISI is not set but COMPILE_TEST is set, the file
in the subdir hisilicon can not be built due to CONFIG_ARCH_HISI
check in drivers/clk/Makefile.

Since the related configs in drivers/clk/hisilicon/Kconfig depend
on ARCH_HISI, so remove CONFIG_ARCH_HISI check for subdir hisilicon
in drivers/clk/Makefile.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f4169cc..81045ec 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -79,7 +79,7 @@ obj-y					+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
 obj-$(CONFIG_H8300)			+= h8300/
-obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
+obj-y					+= hisilicon/
 obj-y					+= imgtec/
 obj-y					+= imx/
 obj-y					+= ingenic/
-- 
2.1.0

