Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066621E3A19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgE0HP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 03:15:57 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60390 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728611AbgE0HP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:15:56 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr2ugE85eDIs5AA--.467S3;
        Wed, 27 May 2020 15:15:45 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v2 2/2] clk: Remove CONFIG_ARCH_HISI check for subdir hisilicon in Makefile
Date:   Wed, 27 May 2020 15:15:43 +0800
Message-Id: <1590563743-30707-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1590563743-30707-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590563743-30707-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr2ugE85eDIs5AA--.467S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw45JFWxJw45Ww4fWF45KFg_yoW8ZryDpa
        n5tr47JryqqF47KFZ7ArW2kFyYqan2qFWDKFyUZ345Zrn8JFWYvw4IgryxtF4xWr48GFW3
        W393u3yfCF1jk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4xMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjCPfJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARCH_HISI is not set but COMPILE_TEST is set, some files
in the subdir hisilicon can not be built due to CONFIG_ARCH_HISI
check in drivers/clk/Makefile.

Since the related configs in drivers/clk/hisilicon/Kconfig depend
on ARCH_HISI, so remove CONFIG_ARCH_HISI check for subdir hisilicon
in drivers/clk/Makefile.

At the same time, we should add CONFIG_ARCH_HISI check for the
common files in drivers/clk/hisilicon/Makefile, otherwise there
exists build failure about undefined reference function when both
CONFIG_ARCH_HISI and COMPILE_TEST are not set.

Link: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/AVXZQX33S7ZVVK7D5VKLTTH7MOBEEBNB/
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - Fix the build failure reported by kbuild test robot

 drivers/clk/Makefile           | 2 +-
 drivers/clk/hisilicon/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index b2441b9..4695d6c 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -3,7 +3,7 @@
 # Hisilicon Clock specific Makefile
 #
 
-obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o clk-hisi-phase.o
+obj-$(CONFIG_ARCH_HISI)	+= clk.o clkgate-separated.o clkdivider-hi6220.o clk-hisi-phase.o
 
 obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
 obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
-- 
2.1.0

