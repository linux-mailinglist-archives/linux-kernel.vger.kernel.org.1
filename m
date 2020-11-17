Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594FC2B57EC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKQDdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:33:31 -0500
Received: from fralinode-sdnproxy-1.icoremail.net ([172.104.134.221]:53892
        "HELO fralinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725804AbgKQDdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:33:31 -0500
Received: from localhost (unknown [218.77.105.7])
        by c1app3 (Coremail) with SMTP id AwINCgCXee5wQbNfoxtjAA--.23132S3;
        Tue, 17 Nov 2020 11:20:16 +0800 (CST)
From:   Chen Baozi <cbz@baozis.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/exiu: Fix the index of fwspec for IRQ type
Date:   Tue, 17 Nov 2020 11:20:15 +0800
Message-Id: <20201117032015.11805-1-cbz@baozis.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AwINCgCXee5wQbNfoxtjAA--.23132S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8GFW5urW7Zw1DXFWkJFb_yoW3trc_ur
        17WF43Kr4FvF17t348Kw4YqryIva4DuFs7Wr1qka98Xayj9w4UAFn2g395JwnrAFWUAFWS
        yrWY9r1FvF43JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsxYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8GwCF04k2
        0xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x07b7CJPUUUUU=
X-Originating-IP: [218.77.105.7]
Sender: chenbaozi@phytium.com.cn
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiAQTfP17E3XxfYwAAsi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Baozi <chenbaozi@phytium.com.cn>

Since fwspec->param_count of ACPI node is two, the index of IRQ type
in fwspec->param[] should be 1 rather than 2.

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
---
 drivers/irqchip/irq-sni-exiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 1d027623c776..abd011fcecf4 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -136,7 +136,7 @@ static int exiu_domain_translate(struct irq_domain *domain,
 		if (fwspec->param_count != 2)
 			return -EINVAL;
 		*hwirq = fwspec->param[0];
-		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	}
 	return 0;
 }
-- 
2.28.0

