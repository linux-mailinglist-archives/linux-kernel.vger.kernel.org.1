Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D782D810E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405761AbgLKVTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405685AbgLKVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:18:53 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCEAC061793
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:18:12 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id h19so15193956lfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4jyCtqfsT6bFiaWz4C37nQaMqaYNh8RgdovwPFEFag=;
        b=L3C22yj6e7mZ1ae57EoqyLDdn2C7A5WvAmk6sNlRZpg6sSQUZHSCL8MDBYRH6RamIL
         9keusa18auHJbx1LOkaR/b2OUBPql7KMG/JZoaRdLcwZtOzSnvAZc1mAMaF736/50DcK
         C/3iRmO1bgVi5fvLa8QvITGzz+u7Mw1bIcTyx35XZgivj2DtZM7t2NLOi9brMjl/Prk8
         3vzl2qVg2x1voOpXo157jfVsnC0BhUZEV4T5sRqJCu1T49fx1r5WImUlTjShqpYJuL+V
         in9ZR9GOy/E0fQfIf5E1y446bJ6PffMqN9Ln65O0/zkDYghex69Ee5CzJeiQQ29cdax4
         6lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4jyCtqfsT6bFiaWz4C37nQaMqaYNh8RgdovwPFEFag=;
        b=sRigsiwUjauX2Z3E/avG24z5gfm3PdmDkxhMBktqJARdKKx5jH3xFU3vbQ2VboeYS2
         wfPH5LvRjcrrVNdyfq6xMIXD3k0zlLr0lM8ovitg0LJ+HNol+SYRCCALG0Uo1HyimOQJ
         DzqEI6CcYLf4RPGm0ZwTvpUYylMsAOe5o5vq9yR+P/vGftzdxKeUx4+x6AhCX3CYAvDN
         K9USv073iicuJ0cmcEYAWV4Ypo2TOHKcQBl4eekDC5bJoTUqDNfyPeSmLGR1GJy5i6Un
         wpQDH4J0DQc5PHbQoIY/bpPevvuaXkwDUffNUIRc0oJEa2ojjj40iND1zIjGGv4k90qo
         ra3w==
X-Gm-Message-State: AOAM532LprBL2GvCrDJYnyApVIGL4K1PjeE/kTkz4BWR+m63PFSVMcNO
        pDUZjamDSJJqZ2Eb6f30+5/1zQ==
X-Google-Smtp-Source: ABdhPJyRxtky3At4bdPpe8TSi8A5QyQyiqt6v8+Uu//6gJ5iv2ZUBFFXIOtHkhC7C8FtiMgLMeG/Mg==
X-Received: by 2002:a19:8c13:: with SMTP id o19mr5397732lfd.573.1607721491314;
        Fri, 11 Dec 2020 13:18:11 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z26sm808501lja.125.2020.12.11.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:18:10 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] usb: dwc3: drd: Avoid error when extcon is missing
Date:   Fri, 11 Dec 2020 23:19:15 +0200
Message-Id: <20201211211916.6259-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211211916.6259-1-semen.protsenko@linaro.org>
References: <20201211211916.6259-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "port" node is missing in PHY controller node, dwc3_get_extcon()
isn't able to find extcon device. This is perfectly fine in case when
"usb-role-switch" or OTG is used, but next misleading error message is
printed in that case, from of_graph_get_remote_node():

    OF: graph: no port node found in /phy@1234abcd

Avoid printing that message by checking if port node exists in PHY node
before calling of_graph_get_remote_node().

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v3:
  - Split patch into two patches: logic diff and style diff

 drivers/usb/dwc3/drd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 3e1c1aacf002..312a4d060e80 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -463,7 +463,10 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	}
 
 	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+	if (of_graph_is_present(np_phy))
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+	else
+		np_conn = NULL;
 
 	if (np_conn)
 		edev = extcon_find_edev_by_node(np_conn);
-- 
2.29.2

