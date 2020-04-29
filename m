Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55661BE547
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgD2Rbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Rbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:31:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580CCC03C1AE;
        Wed, 29 Apr 2020 10:31:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so3545221wrt.5;
        Wed, 29 Apr 2020 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=fp7tzS1ege8TEIXp3sxQeN/AA4eyLe6DeCJjyrJ8peIFf2ViCjzTDKtvTiLo9rckjB
         bWMJw3IZxOK6hInW0ote2hvJKyKjbAD93mTYtKrB5TEJiKfFamzc3FTsadbc5/ssSOuC
         8rDfbJgnXxXecRfvQem8iGSfVU36ZULDzvFED8pNF/5BpbFln1JF/W3Rr/0ea3jXJMsC
         tqyPWUHKMZA85+kpcexixQpiI6ZhrP57FcMYAK23oFM/4/HExUxKGuQUW2FOaDt190tw
         /eqAj8acGVDT7GKO1vFGKxumnRs8dg2dxejo2/CViTqufBhxMn/qDjAHsdrKljXisA2j
         rvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=S+0D6DRq0Wi+AuAx7IvPCc6iksUGVe32sLToqiV1IEbzXbTJNzuL4DhePWfEiIg4/6
         AXbpqZZDLfVzg/kt8fwRkdbmmrPgIJNGK/61YZsW89ZVTOAreQ0SYe1gfUzLz1eWcYtm
         Oq+pG5Z3CQeUx60w0OYyOR38hxCXLge2It0gDuLteDFIbdIcGoMdDmWGGtfVvgKjdjte
         /dAL7KVAox4b75+i9vUeluLrimMVyabPUt/DjvZWy2K9flpOATCseUsObOnILkWXQntg
         8oKD7b3ngV/XXomJinikiyMBmVZbewN+iF3u5YhowtEAxwYzwEU7KdiMip2AeczIWiSL
         Ynag==
X-Gm-Message-State: AGi0PuZeVzeaTPDTlziYnxXxN3xw2MkWvKNdsUKd5gp4BP2rVrvhhzlf
        bBryWfffCCT2Kb5CyBajIifHgBAGww8=
X-Google-Smtp-Source: APiQypLt2LUmDoOaSoNkbDvsiSQvUo7WW6tWdwgxgNXSoRRT47yrfneK9/wa4tVhCUp6nFnxmaUrBg==
X-Received: by 2002:adf:ed0e:: with SMTP id a14mr40073744wro.400.1588181496636;
        Wed, 29 Apr 2020 10:31:36 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j11sm31177182wrr.62.2020.04.29.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:31:36 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/4] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Wed, 29 Apr 2020 13:31:10 -0400
Message-Id: <20200429173112.38366-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429173112.38366-1-alcooperx@gmail.com>
References: <20200429173112.38366-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-plat.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 1d4f6f85f0fe..44406d0eb317 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -112,6 +112,10 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
 };
 
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.quirks = XHCI_RESET_ON_RESUME,
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -147,6 +151,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "renesas,rcar-gen3-xhci",
 		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "brcm,xhci-brcm-v2",
+		.data = &xhci_plat_brcm,
+	}, {
+		.compatible = "brcm,bcm7445-xhci",
+		.data = &xhci_plat_brcm,
 	},
 	{},
 };
-- 
2.17.1

