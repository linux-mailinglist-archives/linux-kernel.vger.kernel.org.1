Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED63012CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhAWDqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbhAWDqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:46:10 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E3EC06121F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:44:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n10so5139923pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAGPmP9BOJXhZhPf5GwqBeoScIfskZqY/J81LHEeHtk=;
        b=NZZ6yFVmNa7MxufUctRDhrA/2kE4i5M/O2laQqAIdRTg+v0WaUoejxIkipX2gg/JO8
         o4NiObGkeDm7IDiHhRPngZP9FP/mimImdZ6hYrEQoilLtad2G5wBGpPWs6AAojVqSYre
         SZkFzokfE9dqhMRMw1Z0pgZ/GD7gWAqAQIxs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAGPmP9BOJXhZhPf5GwqBeoScIfskZqY/J81LHEeHtk=;
        b=eSWtwC3QeFxBijBaNFcsr0wpHed5ZCb8F3lFZRi+V0VBhrCfcV21Si0hL+1viNgz3V
         rbmA7OXQTs/COv8aunkajPFC6OM6A0pyUQ+Nnu5uoV4O3RZUeyPzUFBmvhZ8N6+Wn2gJ
         2ANDeCeJbDfSd8JIup86l+a3y+8hYDcjeLZMVdl4saUmwrmbF9dIOUYcHVtyvOON1IAR
         w0xIezZRa0TFKtXPt3C91xv0xTTKGTcWKDnkT3U/ZTDunTmYgF+XQnGMkFtTPZ677sAp
         aYOACxoo3pFLtcRA46HIUWgizCZKklwSlh/P8qrbf1I/vogqPGuP5I4cxlz37nG6SWCY
         chVA==
X-Gm-Message-State: AOAM530dTMBGAag793RlFql0br3F6gNxTTI4KDMWmGpj9kJV5v+a+8nI
        0254RCJo86UXMTQuOJpfAYSMEw==
X-Google-Smtp-Source: ABdhPJzNLWbZDFfZmckPJlA5EOwk5QhhmGGjNE24UUnWdo/NgVHUBCoGkQOdXUeI7A/hJLgkWOm5nQ==
X-Received: by 2002:a05:6a00:1385:b029:1be:ac19:3a9d with SMTP id t5-20020a056a001385b02901beac193a9dmr1557962pfg.65.1611373478208;
        Fri, 22 Jan 2021 19:44:38 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id gf23sm10480343pjb.42.2021.01.22.19.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:44:37 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 4/6] usb: usb251xb: Use of_device_get_match_data()
Date:   Fri, 22 Jan 2021 19:44:26 -0800
Message-Id: <20210123034428.2841052-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123034428.2841052-1-swboyd@chromium.org>
References: <20210123034428.2841052-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more modern API here instead of using of_match_device() and
avoid casting away const from the returned pointer by pushing the const
type through to the users. This nicely avoids referencing the match
table when it is undefined with configurations where CONFIG_OF=n and
avoids const issues.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Leitner <richard.leitner@skidata.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-usb@vger.kernel.org>
---

Please ack so Rob can apply.

 drivers/usb/misc/usb251xb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 29fe5771c21b..507deef1f709 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -396,7 +396,7 @@ static void usb251xb_get_ports_field(struct usb251xb *hub,
 }
 
 static int usb251xb_get_ofdata(struct usb251xb *hub,
-			       struct usb251xb_data *data)
+			       const struct usb251xb_data *data)
 {
 	struct device *dev = hub->dev;
 	struct device_node *np = dev->of_node;
@@ -630,7 +630,7 @@ static const struct of_device_id usb251xb_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb251xb_of_match);
 #else /* CONFIG_OF */
 static int usb251xb_get_ofdata(struct usb251xb *hub,
-			       struct usb251xb_data *data)
+			       const struct usb251xb_data *data)
 {
 	return 0;
 }
@@ -647,13 +647,11 @@ static int usb251xb_probe(struct usb251xb *hub)
 {
 	struct device *dev = hub->dev;
 	struct device_node *np = dev->of_node;
-	const struct of_device_id *of_id = of_match_device(usb251xb_of_match,
-							   dev);
+	const struct usb251xb_data *usb_data = of_device_get_match_data(dev);
 	int err;
 
-	if (np && of_id) {
-		err = usb251xb_get_ofdata(hub,
-					  (struct usb251xb_data *)of_id->data);
+	if (np && usb_data) {
+		err = usb251xb_get_ofdata(hub, usb_data);
 		if (err) {
 			dev_err(dev, "failed to get ofdata: %d\n", err);
 			return err;
-- 
https://chromeos.dev

