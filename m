Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0202EA9CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbhAELZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAELZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:25:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4CC0617A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 03:24:55 -0800 (PST)
Date:   Tue, 05 Jan 2021 11:24:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609845893;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAngtxAseARnohNG9p00L4Tx8e9UtMz4ufVnR0kzalM=;
        b=qQ8DpoDbWeACUQ6ZyhfpV59WmgiB844FYMMjbjudSZFvwslEXMaEHldajyATViRHJ0H5XU
        zx4+Yrvj03khkwp8E02b50vA5+2+27J9ivYy6zzZh2YQbFOKCjTXMTg6iMJZeXek/L3PZL
        qoGC8zd5ml2ESOQc0Xc5Z91sHZId/41JJIaHRm9BzZ+sjYRvrgTkItN4JfQSbY0SgEv3A+
        ZWzEEhJD+9SxE04G1GZxSkFuGr2p07y9RzsnaZE/UGkBRC7rlIX9i7liJH6iokTs6MpQF3
        tnqDuGn2D2W+KuTJwW7oqLwA9ytZ0c/atzuCJjwQPad1iAsKMO4Q3W1sml0oCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609845893;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAngtxAseARnohNG9p00L4Tx8e9UtMz4ufVnR0kzalM=;
        b=dJR6QEERttxbJ0OQPyDjoZet7AJn92zoabqoi/3oM4bTuVpYWby8nnb3rChiB3WputXZMD
        9yoTnA+MP7w2KDDQ==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-liointc: Fix build warnings
Cc:     kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210105025651.772024-1-chenhuacai@loongson.cn>
References: <20210105025651.772024-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <160984589306.414.930258184390011865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4cc99d03757df10a4064ba28bf6021406b04d6a9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4cc99d03757df10a4064ba28bf6021406b04d6a9
Author:        Huacai Chen <chenhuacai@kernel.org>
AuthorDate:    Tue, 05 Jan 2021 10:56:51 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 05 Jan 2021 10:51:14 

irqchip/loongson-liointc: Fix build warnings

Fix build warnings as below:

>> drivers/irqchip/irq-loongson-liointc.c:134:12: warning: no previous prototype for 'liointc_of_init' [-Wmissing-prototypes]
     134 | int __init liointc_of_init(struct device_node *node,
         |            ^~~~~~~~~~~~~~~

Fixes: dbb152267908c4b2c3639492a94 ("irqchip: Add driver for Loongson I/O Local Interrupt Controller")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210105025651.772024-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-liointc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 9ed1bc4..09b91b8 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -142,8 +142,8 @@ static void liointc_resume(struct irq_chip_generic *gc)
 
 static const char * const parent_names[] = {"int0", "int1", "int2", "int3"};
 
-int __init liointc_of_init(struct device_node *node,
-				struct device_node *parent)
+static int __init liointc_of_init(struct device_node *node,
+				  struct device_node *parent)
 {
 	struct irq_chip_generic *gc;
 	struct irq_domain *domain;
