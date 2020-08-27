Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B257253C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 05:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgH0D0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgH0D0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:26:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E73C0612A3;
        Wed, 26 Aug 2020 20:26:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so2334023pgm.7;
        Wed, 26 Aug 2020 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rN37qI20ECUBatR6H4A3g3beWRHeq6Mi+Lp9BztZsHQ=;
        b=juyCGc0DIHQSjOjHsrh+qOzPev0piOd8Bz8V5NomMrKpRtgz1hEkev8rk95Rfosf++
         lnk73HOq4CZaRbiG0/oPUOppYKjNDDv+GrKz5yob2Q+JLlv/uQhRgO5ugFKMGUCEMAJO
         HQoMI3sVkJ+892Dgoc35biNla/wrHNjbvXHmSuHdtOgUlE6ARLsD4FsGP0TfpePwMpoS
         iinEOqJzEcZh3fQje53unSjcBpdNpYqMREd+jzPdufjB4ixU9P6StstghAsr9tlHzPMi
         ZDvtBdi9SR1ibwo1pQDX8rWLe4aSnHgcfYebs+L6FpQM1Vj5hvbYYY1mQ9Zx6ayBfHA4
         yl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rN37qI20ECUBatR6H4A3g3beWRHeq6Mi+Lp9BztZsHQ=;
        b=fjeqhFaeayR3UtWKt+IGyZTT1pyjQ/L9qFyDCyN3mGFeZ0T2Mzylh0rLIqC7tbIsjv
         /OWETPKn40DVUOsZhqaV0JjxvCvAu8vb0Ja3nOy26cBOTaNFwk+ZhrnL1X/zkwGQ9Ecv
         YipbCzOBBrvNzNiH1Vi6twPKVZQmsNU1kvOkPgs9Gg44TZzN4Hm+oDXa/up7ObmazDpk
         CpH8qQBU0O/muF/Yejfk0ulsLvh/mhdiNzrKPiOf9UNs/dddd1d6vnXwqfwaAJFOtrkM
         VCcN2icSWiJu8zOmDx9D9W2rDsxyVHHXD4S1MpAW+nQtCAo4tFI+DDpxvvmndFS1ZlCm
         bCFQ==
X-Gm-Message-State: AOAM5329bsLojoWti9X+/N9zMupw6QRfSrrmGE+S0sS9QZr8qNMB2GzC
        uuPJ67bx3XxFvoipBdhlJPE=
X-Google-Smtp-Source: ABdhPJxs3SdM7Lc3+cmlB678u24GpPwR5yvBajty/DF5b6W58gTKmaqbA8z69x1z9NNVbSOoHjIFhQ==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr14117797pls.98.1598498776792;
        Wed, 26 Aug 2020 20:26:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:57b:156e:1129:dc1b:b8d8:6430])
        by smtp.gmail.com with ESMTPSA id 70sm676982pfu.107.2020.08.26.20.26.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 20:26:16 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb typec: mt6360: Prevent the race condition during module remove
Date:   Thu, 27 Aug 2020 11:25:32 +0800
Message-Id: <1598498732-25194-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598498732-25194-1-git-send-email-u0084500@gmail.com>
References: <1598498732-25194-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Prevent the race condition from interrupt and tcpci port unregister
during module remove.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_mt6360.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 6a28193..a381b5d 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -164,6 +164,7 @@ static int mt6360_tcpc_remove(struct platform_device *pdev)
 {
 	struct mt6360_tcpc_info *mti = platform_get_drvdata(pdev);
 
+	disable_irq(mti->irq);
 	tcpci_unregister_port(mti->tcpci);
 	return 0;
 }
-- 
2.7.4

