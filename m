Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659CC1CCC50
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 18:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEJQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgEJQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:43:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BCC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:43:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f7so3582596pfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aigOg5gQEpwZX6TVcV43BjngoPeN7YUDWqGIdn8mcQ8=;
        b=khq4y1hNRG8OhmyNn7NvMqv9a7mZw2wukaDANjvDD99BDCNpEudypJkqqNEHUAB8RG
         tVq0ec1g0LGQzn2y9MS13B/btoXqlmCWXwyjbuvMVOqWDFhejoRRaTx2O7TcN+gq+m9E
         shjUbvxOdHJ7ug6xffGiwt9LvJ1/CjWtB8NwcrcJhQlrKJoDpmbFOJQTp4AvowSzbaz7
         8+zjKTNhkA6rlMnF2l16/x1gYXDG46MUuq9TrpTL3XpWk4M1UQCcg8M26vrUZhqLFt3P
         lWmmPkce1BQmzH3W+hakWpNzdohOA1LKS6rV8Qr1UJ+grmkzU4c6H01MdEEggxv2r+pV
         2XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aigOg5gQEpwZX6TVcV43BjngoPeN7YUDWqGIdn8mcQ8=;
        b=BRO7dseyynuExdZe3MGqpQOpicxeo1a+uzyQakCtfF2D6Xdm1AaNv3qfU2ISFhMfj3
         ITBdpj2hrU6zMgod7OvgkVD5eDyQn412iF9vYBRQzoCKVe94CI59hIZiv01l4vazr1w2
         DuFs+6DGGPAEriSNrz6zYo7zDZABCCuI95UEfR13kEkC/PXMeh8XeM5W/Qx9++DYuNuL
         K6Sn+6O+FEr6JUVBXyHFIanWuJgI11aGXqjlzWjjYpXu2KHQ6+xnNqTMSequuR+7gWOO
         8bPP3bHZxB1G0qOFD8FGlgLzsI7D6zbSEN8OL7OtKI1pJawnxZ6I2E7tNdLXHNgCMqE/
         d1ag==
X-Gm-Message-State: AGi0PuYgp1iFIEud0D5PinAy3ir2Y+v3T/zHLnP8Y5rlO7suuXbAUWa7
        3HHdz3Q9/upbvpBxHcHOpnIxQk70wIcjwg==
X-Google-Smtp-Source: APiQypLMiEuEZZF4ah053NY5YQxO2V/O5GK9TcDNDi2axL6JLtXnF6naxJ2CzlC8oMNsa7cdRFgeEg==
X-Received: by 2002:a62:1bd0:: with SMTP id b199mr12327968pfb.283.1589129010366;
        Sun, 10 May 2020 09:43:30 -0700 (PDT)
Received: from localhost.localdomain ([150.242.175.127])
        by smtp.googlemail.com with ESMTPSA id q6sm7047745pfh.193.2020.05.10.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:43:29 -0700 (PDT)
From:   Harshal Chaudhari <harshalchau04@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, harshalchau04@gmail.com
Subject: [PATCH] misc: xilinx-sdfec: convert to module_platform_driver()
Date:   Sun, 10 May 2020 22:13:08 +0530
Message-Id: <20200510164308.31358-1-harshalchau04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver init and exit function don't do anything besides registering
and unregistering the platform driver, so the module_platform_driver()
macro could just be used instead of having separate functions.

Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 71bbaa56bdb5..db16a42c66f4 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1484,25 +1484,7 @@ static struct platform_driver xsdfec_driver = {
 	.remove =  xsdfec_remove,
 };
 
-static int __init xsdfec_init(void)
-{
-	int err;
-
-	err = platform_driver_register(&xsdfec_driver);
-	if (err < 0) {
-		pr_err("%s Unabled to register SDFEC driver", __func__);
-		return err;
-	}
-	return 0;
-}
-
-static void __exit xsdfec_exit(void)
-{
-	platform_driver_unregister(&xsdfec_driver);
-}
-
-module_init(xsdfec_init);
-module_exit(xsdfec_exit);
+module_platform_driver(xsdfec_driver);
 
 MODULE_AUTHOR("Xilinx, Inc");
 MODULE_DESCRIPTION("Xilinx SD-FEC16 Driver");
-- 
2.17.1

