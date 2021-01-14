Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7A2F5BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbhANHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:55:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbhANHzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:55:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D903823A00;
        Thu, 14 Jan 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=Pn6XxcDQzrINBOzWfuCPjR6eVnKqMplBjnAtKpJQysM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liSg0ulZeuYiopEu9anfR0iY/egbm0973FapE/2LwyIjeykAwHVlyhe1pbNJF1YrX
         WzjYuoSBkud/1iGThG9i60PcYEKzkKnC7q/f5P33MpVm5IFULiqohyaS5xTAoCyvVe
         TIyslgcLu+Ivn2geGs0ySgUwkZ+drXHL81v9+qyd/bUA2b/db2sGnE4ANzOkPanSwT
         F8yV4+N/9hEYie9jpmoJMPfKgsVyxA2B64myuieWbLs0DJFtlAXI9Wo/5e3l9ePfjp
         g98Mi0XuIfGr1KUSUR2AONXyAZMbp71Xbd4efBd+8OP8vJ0bE+pBVFQHdJMgkai3Df
         2fIYA2J8zjLfw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPu3-3y; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Harry Wei <harryxiyou@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] doc/zh_CN: fix Sphinx errors
Date:   Thu, 14 Jan 2021 08:53:36 +0100
Message-Id: <ad0badc92b4cda71384951e1e501e1babb6d8d4f.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whitespacing with some translations are weird,
which causes errors like this one:

	devel/v4l/docs/Documentation/translations/zh_CN/mips/ingenic-tcu.rst:61: WARNING: Malformed table.
	Text in column margin in table line 6.

	===========         =====
	时钟                drivers/clk/ingenic/tcu.c
	中断                drivers/irqchip/irq-ingenic-tcu.c
	定时器              drivers/clocksource/ingenic-timer.c
	OST                 drivers/clocksource/ingenic-ost.c
	脉冲宽度调制器      drivers/pwm/pwm-jz4740.c
	看门狗              drivers/watchdog/jz4740_wdt.c
	===========         =====

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/translations/zh_CN/mips/ingenic-tcu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
index 72b5d409ed89..919ae1d4734e 100644
--- a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
+++ b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
@@ -53,14 +53,14 @@
 
 TCU硬件的功能分布在多个驱动程序：
 
-===========         =====
+==================  ===================================
 时钟                drivers/clk/ingenic/tcu.c
 中断                drivers/irqchip/irq-ingenic-tcu.c
 定时器              drivers/clocksource/ingenic-timer.c
 OST                 drivers/clocksource/ingenic-ost.c
 脉冲宽度调制器      drivers/pwm/pwm-jz4740.c
 看门狗              drivers/watchdog/jz4740_wdt.c
-===========         =====
+==================  ===================================
 
 因为可以从相同的寄存器控制属于不同驱动程序和框架的TCU的各种功能，所以
 所有这些驱动程序都通过相同的控制总线通用接口访问它们的寄存器。
-- 
2.29.2

