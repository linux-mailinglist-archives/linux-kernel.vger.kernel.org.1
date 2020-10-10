Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70E289CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 03:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgJJBOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 21:14:23 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgJJBEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:04:21 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHFwM-1keIa71mAC-00DCX7; Sat, 10 Oct 2020 02:47:51 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iodrag Dinic <miodrag.dinic@mips.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] tty: goldfish: use __raw_writel()/__raw_readl()
Date:   Sat, 10 Oct 2020 02:47:49 +0200
Message-Id: <20201010004749.1201695-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gNFiRYCaBQv2xEKenmq4Ysj9NIb+7hVQxHtpWwjy93rJizPcGBy
 eW5+DzCJqbdp61HtR0Ol7QBz/jTCSP3hm0417pnNnd2hkADMp8ySyfnj1qedqdjwa3T5uP4
 LsrRZBJeKlUzt0ABqVGB/LqN3pFoXfWyfgAiVDsZs1JZSRWkPhlV9BTjf0TaE7rnKdtI+kh
 sei8fnsnGlCG9+YzGIXrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LkwGeuBpmns=:/WkCJkjUME2xYvfYMBRXqT
 x56hVVbNrUf8I1FzxPMCOUhRA1xqkgS/IXmP3ia142j2CjVRWFRik4Alab7R6WEFcB+ikxokT
 ux8pQ7uUBqJSpLjaOlOMnIkyaxVXEr9l8oo/7aqNxw0VmG31aXEaoLT3OYOXXOzFa78ODSly5
 ZtvA0v4je/TIqMWfSV6ZQmXBHRssujHOwlb7jGwpmqbhz2MXyoADg1PT0blvjHLFlDP4gOAfB
 1SMrXZcmEEykCbSYU/A5jqyan1BPNMZ6p4jrq1Eu1ScgEx56kn+qQFnXsitnzdo8uRtXWZSeY
 ZAMAlNrO4l6pOVp59xmwz2iW0jO5VwsvVRlkNwt2ajP4L/fxtKZowzVr0Pra8209ZhWtjYels
 NBYRSoCVRO4ELpXTF3Bx0JFnDy7lWQQND46fzqXX28bgDYfCw4iXE/BrWwMXosm9c2SnSULTG
 2jqaM+b0j49IlHKEa+qS8uFnyR4a6jffD+FJjRuUr+wjmMIf2c4J9BNJ0CtB7hK8jLihx2Wq8
 CNsdCTHttYiJRT+xmA5gJPaGLHPEpm2Y8PNz5/Xzmy80fOD81mjbHNq8maKotDotLr2XqVuqe
 zsPnql9dZ5Yr3yjXPOvdktq96dIBYtoZvUIEWVq23ogo+Mm8McN3REH9ydqsFXb4BXiD2gyGu
 cZsnWLpKOTllV4sj3cHA6DU19ta90gd6BKJY7NfVMouCxgYu58Atru8lQjpvRccE8ZwWcqCmi
 Pke7OLSd+g43nkuGO/TijciHiZARFHxQJPG6rpAaEsxsw37N+Vxx/SJFI3cwctCMlvcs97xFq
 2dauQnW+35gdD8F9O2QuJ4qkNVLIEfBYqiC0nXctzeQe6AwMQAX9RPJmAY9qpcYb7qgLgqo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gf_early_console_putchar() uses __raw_writel() but the standard driver
uses writel()/readl(). This means we can't use both on the same machine
as the device is either big-endian, little-endian or native-endian.

As android implementation defines the endianness of the device is the one
of the architecture replace all writel()/readl() by
__raw_writel()/__raw_readl()

https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/char/goldfish_tty.c#222

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/tty/goldfish.c   | 18 +++++++++---------
 include/linux/goldfish.h |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index c8c5cdfc5e19..cd23a4b05c8f 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -61,13 +61,13 @@ static void do_rw_io(struct goldfish_tty *qtty,
 	spin_lock_irqsave(&qtty->lock, irq_flags);
 	gf_write_ptr((void *)address, base + GOLDFISH_TTY_REG_DATA_PTR,
 		     base + GOLDFISH_TTY_REG_DATA_PTR_HIGH);
-	writel(count, base + GOLDFISH_TTY_REG_DATA_LEN);
+	__raw_writel(count, base + GOLDFISH_TTY_REG_DATA_LEN);
 
 	if (is_write)
-		writel(GOLDFISH_TTY_CMD_WRITE_BUFFER,
+		__raw_writel(GOLDFISH_TTY_CMD_WRITE_BUFFER,
 		       base + GOLDFISH_TTY_REG_CMD);
 	else
-		writel(GOLDFISH_TTY_CMD_READ_BUFFER,
+		__raw_writel(GOLDFISH_TTY_CMD_READ_BUFFER,
 		       base + GOLDFISH_TTY_REG_CMD);
 
 	spin_unlock_irqrestore(&qtty->lock, irq_flags);
@@ -142,7 +142,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 	unsigned char *buf;
 	u32 count;
 
-	count = readl(base + GOLDFISH_TTY_REG_BYTES_READY);
+	count = __raw_readl(base + GOLDFISH_TTY_REG_BYTES_READY);
 	if (count == 0)
 		return IRQ_NONE;
 
@@ -159,7 +159,7 @@ static int goldfish_tty_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = container_of(port, struct goldfish_tty,
 									port);
-	writel(GOLDFISH_TTY_CMD_INT_ENABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
+	__raw_writel(GOLDFISH_TTY_CMD_INT_ENABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
 	return 0;
 }
 
@@ -167,7 +167,7 @@ static void goldfish_tty_shutdown(struct tty_port *port)
 {
 	struct goldfish_tty *qtty = container_of(port, struct goldfish_tty,
 									port);
-	writel(GOLDFISH_TTY_CMD_INT_DISABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
+	__raw_writel(GOLDFISH_TTY_CMD_INT_DISABLE, qtty->base + GOLDFISH_TTY_REG_CMD);
 }
 
 static int goldfish_tty_open(struct tty_struct *tty, struct file *filp)
@@ -202,7 +202,7 @@ static int goldfish_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
 	void __iomem *base = qtty->base;
-	return readl(base + GOLDFISH_TTY_REG_BYTES_READY);
+	return __raw_readl(base + GOLDFISH_TTY_REG_BYTES_READY);
 }
 
 static void goldfish_tty_console_write(struct console *co, const char *b,
@@ -357,7 +357,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	 * on Ranchu emulator (qemu2) returns 1 here and
 	 * driver will use physical addresses.
 	 */
-	qtty->version = readl(base + GOLDFISH_TTY_REG_VERSION);
+	qtty->version = __raw_readl(base + GOLDFISH_TTY_REG_VERSION);
 
 	/*
 	 * Goldfish TTY device on Ranchu emulator (qemu2)
@@ -376,7 +376,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 		}
 	}
 
-	writel(GOLDFISH_TTY_CMD_INT_DISABLE, base + GOLDFISH_TTY_REG_CMD);
+	__raw_writel(GOLDFISH_TTY_CMD_INT_DISABLE, base + GOLDFISH_TTY_REG_CMD);
 
 	ret = request_irq(irq, goldfish_tty_interrupt, IRQF_SHARED,
 			  "goldfish_tty", qtty);
diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index 265a099cd3b8..12be1601fd84 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -13,9 +13,9 @@ static inline void gf_write_ptr(const void *ptr, void __iomem *portl,
 {
 	const unsigned long addr = (unsigned long)ptr;
 
-	writel(lower_32_bits(addr), portl);
+	__raw_writel(lower_32_bits(addr), portl);
 #ifdef CONFIG_64BIT
-	writel(upper_32_bits(addr), porth);
+	__raw_writel(upper_32_bits(addr), porth);
 #endif
 }
 
@@ -23,9 +23,9 @@ static inline void gf_write_dma_addr(const dma_addr_t addr,
 				     void __iomem *portl,
 				     void __iomem *porth)
 {
-	writel(lower_32_bits(addr), portl);
+	__raw_writel(lower_32_bits(addr), portl);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	writel(upper_32_bits(addr), porth);
+	__raw_writel(upper_32_bits(addr), porth);
 #endif
 }
 
-- 
2.26.2

