Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6F296023
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900248AbgJVNiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900226AbgJVNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:38:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0967C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:38:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d78so2138725wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuazTAVuWOaGAhXcYUEHC2fhzgfRLU0vFOZpMsy8TBQ=;
        b=nbgJkYp63m4rmIhHmUxnHZj+Urg/MRZxffOXk3O+VNQTx7AnbH5zQUO+LjDfiC+Tp4
         0GFB8MN7piN0yTl8NjYoY+R3Nm+YWKqdoMsvyqAoui0Tae8wwQz+GrCd/h9SYTeqyXsh
         b229ntFS+4rZoV8tVIw4IybIojU8U9PzrdkJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuazTAVuWOaGAhXcYUEHC2fhzgfRLU0vFOZpMsy8TBQ=;
        b=jYsYTCAGXXfhhv8Mwt3GuMijNGUP5+M3pxmIUGgmHCMlp2lOQLv6SkhCwccpBJQw1A
         ubKTgCHcNn1ywEJRXJ6gz26X8Zsbhn5SEiy+N/5c+T50juB3BuMdOi5fEKZVjnplxllN
         9mwGrVEwfJBu4geZ9JlUdyY5jVNN82Ps/J9mHDKgW9H8dNwqKKve+oHLR9OFIIJDbhfK
         UcgcqFS09gGh1VxVVXyn7mTeFbijWb1984rI6MrTHT+KbdF+IrZCeN+5Wl/p/sPVo1ca
         V0sPEBUtCxfkkEpFy76vPoWh9SknYU5tLy1ocLQqmZea7wBY07V8d8omvbiTadz6jjt0
         NH4g==
X-Gm-Message-State: AOAM533GOO+MaLkGQe5aAT4aIaJ1NenqaSecrpnEnegxw5Ru/aXZUB4e
        ii0kjHY8kKhF4u/W1ewWWnjV4A==
X-Google-Smtp-Source: ABdhPJyJdhp6mATJXrrc9AyS5uJUoaza7cixAKWOYcnAPxJWO5g8X1tkDeI83moKm80b8WSFXmVBnA==
X-Received: by 2002:a1c:7c09:: with SMTP id x9mr2683433wmc.181.1603373881466;
        Thu, 22 Oct 2020 06:38:01 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q10sm4094031wrp.83.2020.10.22.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:38:01 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tfiga@chromium.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 6/6] media: uvcvideo: Handle IRQs from the privacy_pin
Date:   Thu, 22 Oct 2020 15:37:53 +0200
Message-Id: <20201022133753.310506-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201022133753.310506-1-ribalda@chromium.org>
References: <20201022133753.310506-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the privacy pin produces an IRQ, read the gpio and notify userspace
via an event.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   |  3 +++
 drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3a49a1326a90..00c41cba0f68 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1346,6 +1346,9 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
 
 	mutex_unlock(&chain->ctrl_mutex);
 
+	if (!w->urb)
+		return;
+
 	/* Resubmit the URB. */
 	w->urb->interval = dev->int_ep->desc.bInterval;
 	ret = usb_submit_urb(w->urb, GFP_KERNEL);
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 180e503e900f..d1260d131bd8 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1460,6 +1460,25 @@ static int uvc_gpio_get_info(struct uvc_entity *entity, u8 cs, u8 *caps)
 	return 0;
 }
 
+static irqreturn_t uvc_privacy_gpio_irq(int irq, void *data)
+{
+	struct uvc_device *dev = data;
+	struct uvc_video_chain *chain;
+	struct uvc_entity *term;
+	u8 value;
+
+	list_for_each_entry(chain, &dev->chains, list) {
+		list_for_each_entry(term, &dev->entities, list) {
+			if (UVC_ENTITY_TYPE(term) == UVC_GPIO_UNIT) {
+				value = gpiod_get_value(term->gpio.gpio_privacy);
+				uvc_ctrl_status_event(NULL, chain, term->controls, &value);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int uvc_parse_gpio(struct uvc_device *dev)
 {
 	struct uvc_entity *unit;
@@ -1490,6 +1509,17 @@ static int uvc_parse_gpio(struct uvc_device *dev)
 
 	list_add_tail(&unit->list, &dev->entities);
 
+	irq = gpiod_to_irq(gpio_privacy);
+
+	if (irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (irq < 0)
+		return 0;
+
+	ret = devm_request_irq(&dev->udev->dev, irq, uvc_privacy_gpio_irq, IRQF_SHARED,
+			       "uvc_privacy_gpio", dev);
+
 	return 0;
 }
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

