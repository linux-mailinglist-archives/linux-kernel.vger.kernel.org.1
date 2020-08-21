Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9024CB29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 05:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHUDMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 23:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHUDMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:12:18 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A9C061385;
        Thu, 20 Aug 2020 20:12:17 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z17so410267ioi.6;
        Thu, 20 Aug 2020 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z24e9MTBcFw/wYogXzpZAl98eujY/DD/T14so9s//xk=;
        b=RwE38bqTRHq/mkoc6SEkAbqkA5cjvwAxQxuax8BbysUK+V5VWVGmmQMy6XpDZnMAKZ
         9rTs07At6fiyd2GQpl3xduqX/xKCr8XC+AEwJcgJ4UL4Yxpusgt0dOwAjy9Uw+7jMi7S
         Cj/zelKBa5CC+tIGkxD0kIJmRKW8VkIZ/k0gosfbkuEv0z21XJIafXWVtni8QK7xhwCs
         cJrEQVEEQvrrtTgCYd0iE/1Wfcdni3ALlrr4y6kRAkmnCVacQIIUxBiK/SFi6t5el/Tm
         cjcGIJQK0TOKJfAAY/Qk82UklbL1k6Mvz8dfvd/2fcrOTIApxO+uuNoUp8mVDz7BFUH/
         wcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z24e9MTBcFw/wYogXzpZAl98eujY/DD/T14so9s//xk=;
        b=jXD+lZqm2CJteVJO8wcUG8MWlwi6EFI9KHEy7TKHL/07XXNfm/20bySwAAY5D2e9fE
         +JWYG9Sg8Ai0c4yMInPHoAaeDx6qF36YOVsLRNR8jb+PQEEer1EPIIcmy8Fj+HbnJKRa
         MgghZYYIVCuetqcI3Xn++qMfdHMKu2cVb08IfO3LIGvU8onTqzfmi420pglbuAk63jtF
         wjAExTa2Mg0axOikhKosboOtxJKsAC7U2BG5OVx9gWDpFOt4WWvFxENzbAXY9tn6O0r1
         VDR4LnSEKRBpVKSv14IiSWJPjTRrkNMBwtGo6ffTt9uLTzNXWUBMPkNv5cVsREKBizkg
         TSHg==
X-Gm-Message-State: AOAM530lsjb9FmVFsetvWCXuq6fYPW0+3YDx+WlNA5W5ham+q06YXdBb
        asb7GYFvNhXfRpMvVWal6AY=
X-Google-Smtp-Source: ABdhPJw14Jl2G7Bp8vAMyHdgawhjyhj4+kYTA82rGwLI8PGW7p7LMS3YEGS90Z4Yln+dbenmUYgXXw==
X-Received: by 2002:a02:5a48:: with SMTP id v69mr802492jaa.51.1597979536328;
        Thu, 20 Aug 2020 20:12:16 -0700 (PDT)
Received: from localhost.localdomain (x-128-101-215-112.reshalls.umn.edu. [128.101.215.112])
        by smtp.gmail.com with ESMTPSA id s13sm338359iln.12.2020.08.20.20.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:12:15 -0700 (PDT)
From:   George Acosta <acostag.ubuntu@gmail.com>
To:     acostag.ubuntu@gmail.com
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Phani Kiran Hemadri <phemadri@marvell.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: cavium/nitrox: add an error message to explain the failure of pci_request_mem_regions
Date:   Thu, 20 Aug 2020 22:12:08 -0500
Message-Id: <20200821031209.21279-1-acostag.ubuntu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an error message for users when pci_request_mem_regions failed.

Signed-off-by: George Acosta <acostag.ubuntu@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index cee2a2713038..9d14be97e381 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -451,6 +451,7 @@ static int nitrox_probe(struct pci_dev *pdev,
 	err = pci_request_mem_regions(pdev, nitrox_driver_name);
 	if (err) {
 		pci_disable_device(pdev);
+		dev_err(&pdev->dev, "Failed to request mem regions!\n");
 		return err;
 	}
 	pci_set_master(pdev);
-- 
2.17.1

