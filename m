Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD321F85C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgGNRkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 13:40:01 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:40701 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:40:01 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 06EHd5VO022065;
        Wed, 15 Jul 2020 02:39:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 06EHd5VO022065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594748346;
        bh=VSlrCdvfnyOvmg1z7jLB1HmUkH/aJAVl+cYuH7oRhd8=;
        h=From:To:Cc:Subject:Date:From;
        b=oUQKHpngLvTQI1Jaf8u0Rr53oK6ABUWQivPYf4GEOcK/nWwSLfSBjmbokIMGte55U
         j6zYSG4QlSp5BQOFimsdol8t1KDXBnJznVElB90zKxIr0M8DpyPrD1uYw/H6EPYfrw
         3W8qN8av79j3LWFu1f4nA9ntkU8eYrPwqLkdG4kk1+p/WOLdh2r4L6HHRwCBxJ3132
         x7W1n5nhPVriO1jcLQPuyqcwruE+6aulF7K4BscNY29SO0ZcQU+Whs4MY0q/lwyO8u
         O0jgkXieXZaQJRZS/N4gneHc/4t0MJ/1vVu28TMF+DYqbZuamXoi7nvZw6PKWFTLEi
         bnMfVmwwLyX+Q==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: ativic32: constify irq_domain_ops
Date:   Wed, 15 Jul 2020 02:38:57 +0900
Message-Id: <20200714173857.477422-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is passed to irq_domain_add_linear(), which accepts a pointer
to a const structure.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/irqchip/irq-ativic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
index 85cf6e0e0e52..476d6024aaf2 100644
--- a/drivers/irqchip/irq-ativic32.c
+++ b/drivers/irqchip/irq-ativic32.c
@@ -92,7 +92,7 @@ static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops ativic32_ops = {
+static const struct irq_domain_ops ativic32_ops = {
 	.map = ativic32_irq_domain_map,
 	.xlate = irq_domain_xlate_onecell
 };
-- 
2.25.1

