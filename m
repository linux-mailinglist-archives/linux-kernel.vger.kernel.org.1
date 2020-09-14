Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC7269693
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgINU27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgINU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:28:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B558C061797;
        Mon, 14 Sep 2020 13:28:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so1325997wmm.2;
        Mon, 14 Sep 2020 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfJihMsMhRJ/+S5wdJVUFID0QqKRghvIoFnr9LgeHsI=;
        b=Ow+KrT1hJoCNp5PDVmlVjEkGtwFSY3Q+i8M57SEWD1JW8QM4rmmS2K5gJhCfTkkO2k
         rB2iBbS2O6iVQLocnzqa7vZebmeaXLfK7b4bHgil7YgjIi4/+7+/SXVl3gXIoqSUDazp
         M0uSVbN8medDnudRkqf8TwZdwSeKIp774InnBnfJjfuvs+oDzP6x4vi7z8bX2N5E4TX3
         0iDBAm/Sj8X3S9QFsy1cnzFaM3/Bz6IIHem3cWEpGdQPAb3SG5ct2tOW2mHaqRn2fYSY
         ttYoCsuGbj0zDqECbxv4V0NiKhnbShfwF436cWhOo5gDRpdiSxfFeh4pzsf2zMVjb76M
         AyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfJihMsMhRJ/+S5wdJVUFID0QqKRghvIoFnr9LgeHsI=;
        b=pgsbZU9/B5gB/orirrm6MStOO89jPTl48eOotynGhQbCbcKP1mtta6Ps8wEazIbB9R
         rqpOzaqeGwnE1LFyS/3DVymTD4zj9MRnlz7zWi3BarTCeYCUy7yTE8Cim9YnV7Ez6se4
         JAmmNAnVpIypsza2N3h/TC+gnskXG3A0dttgbzm0uHLR+P2tvCL63YEQnOB+CkQM4Ibp
         UFoULQFWDTQ1WYAKMRbZpoXWzRn1uvbVZlDWWXObkeHjxZZmtxvWNqZzoRgzh9QwH999
         FSlITf/juUD3CPHb+jEdcrs1O9ImlZfWiWqDDv86MJCiaXk94/SNTu3vnqOKWYn8K3wo
         +8hg==
X-Gm-Message-State: AOAM531/+8p5aLOOSBMfoFHfA0ScES9XQ0QPVTozTxCsrx2Ezs+LNUHJ
        pOF5Fm6cTsMXzRrnkKkB+DU=
X-Google-Smtp-Source: ABdhPJzcF41Qz2Eg0LtglB5VAz+lTAIxTvoWphE1MTNH/z14nj9t+eMEVyOzfQXZ+frpcQa2lb/y6A==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr1075224wmi.186.1600115297164;
        Mon, 14 Sep 2020 13:28:17 -0700 (PDT)
Received: from localhost.localdomain (oi48z9.static.otenet.gr. [79.129.51.141])
        by smtp.gmail.com with ESMTPSA id 92sm24201125wra.19.2020.09.14.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:28:16 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v7 3/3] MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
Date:   Mon, 14 Sep 2020 23:27:19 +0300
Message-Id: <174084658e46824a02edf41beae134214d858d46.1600114378.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
References: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for Actions Semi Owl SIRQ controller binding and driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9544eec4eff2..04c75815fac6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,6 +1525,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
@@ -1536,6 +1537,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/irqchip/irq-owl-sirq.c
 F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
-- 
2.28.0

