Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E4288483
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgJIIAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbgJIIAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:00:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3602C0613D4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 01:00:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f21so8844407wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Sov6QI2+dcKEbVPti+S9VpTmMaMBnOoy8yisJjB3r+E=;
        b=aYFg78/GFVmwyp0O88wwQRi8LzAvXywNBqBhw5ZhdSfm1Rlfoo7Qwvj2WfTapFECcZ
         8c7i9NmjFUTG3m5wzuqylBVsjzfv4RV1k+YXM0DQEWew2uNbwMQB26ObL7Ki467w0IzO
         KjB51JPA8ptHslrGgzhvjZk5PwKeE+TA9j7skvwC8VIS/gXP+h+3+UhPe/NWwqMSBWdc
         pMoKlvBKa/YJ+oZm4gvGolfqGTUX1ViPqx+YAGvnr7Tf70MtgsBb79cVd8MiaJJJYdeY
         +IBGB2dj75sVq0OK9sjuunUYq0h2s+xb17uRnsD8zhjrmaklot24Qjbaf26LMGjPI+Ct
         YRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Sov6QI2+dcKEbVPti+S9VpTmMaMBnOoy8yisJjB3r+E=;
        b=PYpIyZTmIhL1RvgC3tFy09BkAf7SNY27U9uXBbtUOu70nwO5xjSxTd6tychIzBi+pp
         ZdDx/8Id0QmItvWSk8yEiBlfSU13KXcDkxfmEOaicnuaiSYXjADuluvP/V2Yc4O76Ln1
         rFVsPMpr8CPF6IiO1/7D7qHv/NjwPQs0m8ihbJyqrWNWzNjxJ805Wtv57s7Rt+Dp0QXt
         HIkRKZv34SDyD9+lfkIwp2+GebkjtHIX5UW3Xr2GxZXRv49bEPfnP1WQ7sRQApMYxQkH
         b2NzyFhDr7kKSjlz71jcnuIlw7j1Wv2CKLSc/vELED9dEwZk03bEBCy2rQwydwVPMAGj
         2bqA==
X-Gm-Message-State: AOAM532g6lZ48n0nZaHteoR07IdHQdXmsb/11CJqcICbkGpDrOUMftKR
        B+p/vxW3V0JjIVwpkPncBVAJL+UheVg1Uw==
X-Google-Smtp-Source: ABdhPJzKuuuLeI6WkvQydpAkoXWbpXAppaDybxqSUuOEeOtV1pWMQTJNGVG6ckFx0748HANWK2yEJA==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr5992125wme.153.1602230441418;
        Fri, 09 Oct 2020 01:00:41 -0700 (PDT)
Received: from tabot ([154.72.150.117])
        by smtp.gmail.com with ESMTPSA id g83sm10451717wmf.15.2020.10.09.01.00.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 09 Oct 2020 01:00:40 -0700 (PDT)
Date:   Fri, 9 Oct 2020 09:00:38 +0100
From:   Tabot Kevin <tabot.kevin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed coding style issues raised by checkpatch.
Message-ID: <20201009080038.GA1439@tabot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following:
- Made sure alignment matched open parenthesis.

Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
---
 drivers/staging/greybus/audio_module.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/audio_module.c b/drivers/staging/greybus/audio_module.c
index c52c4f3..a243d60 100644
--- a/drivers/staging/greybus/audio_module.c
+++ b/drivers/staging/greybus/audio_module.c
@@ -175,8 +175,8 @@ static int gbaudio_codec_request_handler(struct gb_operation *op)
 }
 
 static int gb_audio_add_mgmt_connection(struct gbaudio_module_info *gbmodule,
-				struct greybus_descriptor_cport *cport_desc,
-				struct gb_bundle *bundle)
+					struct greybus_descriptor_cport *cport_desc,
+					struct gb_bundle *bundle)
 {
 	struct gb_connection *connection;
 
@@ -199,8 +199,8 @@ static int gb_audio_add_mgmt_connection(struct gbaudio_module_info *gbmodule,
 }
 
 static int gb_audio_add_data_connection(struct gbaudio_module_info *gbmodule,
-				struct greybus_descriptor_cport *cport_desc,
-				struct gb_bundle *bundle)
+					struct greybus_descriptor_cport *cport_desc,
+					struct gb_bundle *bundle)
 {
 	struct gb_connection *connection;
 	struct gbaudio_data_connection *dai;
-- 
2.7.4

