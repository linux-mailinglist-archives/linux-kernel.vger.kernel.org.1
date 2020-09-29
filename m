Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4327B8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgI2ANZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbgI2ANY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:13:24 -0400
Received: from mail-pg1-x564.google.com (mail-pg1-x564.google.com [IPv6:2607:f8b0:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD5C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:24 -0700 (PDT)
Received: by mail-pg1-x564.google.com with SMTP id d13so2365808pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjqKX8Tpz+x5CJIuHogB2gYEP9bHrmFcpxb2113wLDk=;
        b=SiSE5v6TYBE/LLuHp8vffz3RiPljdJim6TLrnrJuiqd56jbMLWS3J1NABjLp0ddBTX
         KaQav19uy1BEKIkMz5hl7W7p+Tpv+jwq+O8VRtwRs67PV4nBlzYrVUeBEjr1+K3CR9gV
         qJFknoysUUK3Bvdiy6bpz8Zf4hoPneLOmzn7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjqKX8Tpz+x5CJIuHogB2gYEP9bHrmFcpxb2113wLDk=;
        b=PrxCvjhhdGOb5Ca74jubzxs1p1Z02dEWoZUpybel9pTRfdz3I0bnAQtqRHnbqKfWti
         OGM866nKZ/CICl7H8+uULPRmi6y1yKUuKrub6+V+wPAory4hKOPKRhTRkIunhPKFD7XU
         aHacr1vbOX7hQ55puU7XvVkr631VHCCZAVqScBEZKNUl6MTapNKUmNHBRzUMx2NWlLB1
         urRhP5ektSHABsFpTjUd9JLv7xbKKJqWy0/sSVz3dKxNi8FjW8eHjGTqbX36co2D9AY6
         U65AHU4/yroNtdEhAGMsx9JbCJdrxbnIunU/tZOh9L3T8yAN4RjUWiYA0wGv2sdongtm
         W4dg==
X-Gm-Message-State: AOAM533J1r3s4QmkMfsI08seWCZ7ZyL8UlPAie4ef5tLo0Sr1f4dcG1k
        a8TUeZjZkDXyHtGjBR66uX6vaEB2y1mKjPlmgkFQfCbSJ3br
X-Google-Smtp-Source: ABdhPJy50VznlVnsg2QUs7fQC+yHQm9aSBq44hzGvCLZZFpoAioOzbuSvC3RRXGMhi13vmEDoJhU7V+QQSKO
X-Received: by 2002:a63:4742:: with SMTP id w2mr1171313pgk.258.1601338403886;
        Mon, 28 Sep 2020 17:13:23 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:13:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 13/16] misc: bcm-vk: add tty irq handler
Date:   Mon, 28 Sep 2020 17:12:06 -0700
Message-Id: <20200929001209.16393-14-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929001209.16393-1-scott.branden@broadcom.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add irq handler for tty interfaces to VK.  If irq not enable
poll method will still be used.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/bcm_vk.h     |  2 ++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 084be53a9518..64894c77759e 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/firmware.h>
+#include <linux/irq.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
@@ -484,6 +485,7 @@ int bcm_vk_release(struct inode *inode, struct file *p_file);
 void bcm_vk_release_data(struct kref *kref);
 irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id);
 irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id);
+irqreturn_t bcm_vk_tty_irqhandler(int irq, void *dev_id);
 int bcm_vk_msg_init(struct bcm_vk *vk);
 void bcm_vk_msg_remove(struct bcm_vk *vk);
 void bcm_vk_drain_msg_on_reset(struct bcm_vk *vk);
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 76fe58fc98e2..18e11c8633fd 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1338,6 +1338,19 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	vk->num_irqs++;
 
+	for (i = 0;
+	     (i < VK_MSIX_TTY_MAX) && (vk->num_irqs < irq);
+	     i++, vk->num_irqs++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
+				       bcm_vk_tty_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, vk);
+		if (err) {
+			dev_err(dev, "failed request tty IRQ %d for MSIX %d\n",
+				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
+			goto err_irq;
+		}
+		vk->tty[i].irq_enabled = true;
+	}
 
 	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
-- 
2.17.1

