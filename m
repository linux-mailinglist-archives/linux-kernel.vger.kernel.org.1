Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2602A245591
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgHPDiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 23:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgHPDiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 23:38:21 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Aug 2020 20:38:17 PDT
Received: from forward101j.mail.yandex.net (forward101j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE158C061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 20:38:17 -0700 (PDT)
Received: from mxback6o.mail.yandex.net (mxback6o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::20])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id CFE6B1BE003C;
        Sun, 16 Aug 2020 06:31:53 +0300 (MSK)
Received: from iva8-6403930b9beb.qloud-c.yandex.net (iva8-6403930b9beb.qloud-c.yandex.net [2a02:6b8:c0c:2c9a:0:640:6403:930b])
        by mxback6o.mail.yandex.net (mxback/Yandex) with ESMTP id vFTEH2YZPl-VrKScNEq;
        Sun, 16 Aug 2020 06:31:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1597548713;
        bh=0loqlOGsxDcQrk/akZfLT0Bj74S91D/pplhQcXPb4mg=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=qJb6Hi/xceLkX0QyKru1hwTWjI4QCFMfHpBIIf4VbTVXxiLmos6S7qn3i0fl2pxqY
         AwrzmS6V/ZY5TGX7gKXE99NRzy5CFHwzrIjjuzfzZKmYHwZDfomuIRBNCPwVjranmc
         UUnPfLpUuhHw9BStUXmaycs9UOUYTf6gGmGY23To=
Authentication-Results: mxback6o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva8-6403930b9beb.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id mxU22iVblc-VqlSAlpM;
        Sun, 16 Aug 2020 06:31:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Asif Talybov <talybov.asif@yandex.ru>
To:     gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Asif Talybov <talybov.asif@yandex.ru>
Subject: [PATCH] staging: greybus: Add identifier name to function definition argument
Date:   Sun, 16 Aug 2020 10:31:09 +0700
Message-Id: <20200816033109.3930-1-talybov.asif@yandex.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: function definition argument 'struct gbphy_device *' should also
have an identifier name
+       int (*probe)(struct gbphy_device *,

WARNING: function definition argument 'struct gbphy_device *' should also
have an identifier name
+       void (*remove)(struct gbphy_device *);

Signed-off-by: Asif Talybov <talybov.asif@yandex.ru>
---
 drivers/staging/greybus/gbphy.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index 087928a586fb..d4a225b76338 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -36,9 +36,9 @@ struct gbphy_device_id {
 
 struct gbphy_driver {
 	const char *name;
-	int (*probe)(struct gbphy_device *,
+	int (*probe)(struct gbphy_device *device,
 		     const struct gbphy_device_id *id);
-	void (*remove)(struct gbphy_device *);
+	void (*remove)(struct gbphy_device *device);
 	const struct gbphy_device_id *id_table;
 
 	struct device_driver driver;
-- 
2.20.1

