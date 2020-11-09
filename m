Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E532AC181
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgKIQ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:56:44 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2EC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:56:44 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r9so10491481ioo.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5NRbYsOo+mspumDtpUEM/+OEsVGUUWKaYNV+1cLmV4=;
        b=n2hLQ7PHR3cMzHVOFkT8wDfl5WJbEyE2GW1mdy0w/0zYQtDrGdHtRa5QQkWlZxb5Hr
         ZiWMQ4SWjn76IQEWW6bs+66vkbmPjrt3SckLb2CZHkW+p9Wak7QEf5bBuj4VzDJAYANR
         26uzhkzrwmiuiGFzwkT2T2MfSJkJlOlFCVp/kYBmRTh15+fi74ulQZ7XJvWatsnYDW0Y
         T2bG7COiMZqnbvoXO+dF9fb6msEE0blbS5ZJ5IFPkB5PVOHlp3sfiSmFSGsqhdje+l6q
         lV7Clecaxjr4+g+ck1g54xmyck3PQ7MnZd+oNon49VOoPdS5EzO3Xa5SMgMhdBJ2VOSm
         MYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5NRbYsOo+mspumDtpUEM/+OEsVGUUWKaYNV+1cLmV4=;
        b=JOG5vq/p5Hl3laCfZp5AzzcLCqT1U9CdwzfmX8PWBYcXXVkgFVyq43S62SI+0KLrht
         FAFrwcZTuHoMgGvW9i9SQ5BtbDv/96SoyCNjxQI8e4Wfb9xBuz3QvK6i4z1zw4nT7w6y
         rgGvU5qadLpIavNzZ/G9RmTqNs9hZPc3ieJ0GLFtUv0y1Xy3UyIcV3lyLVWM3F4WevhC
         TcFZOegYa9KGbxBvl8lShPpRILI7E57qFjROQ37Zbm1d/17CYN0/CNplf/skw3G/mnh5
         MjuA8q7LH7NnAgkjkJ+IQdo0NaO6fIgtDZHtrVo7j4M2UDozQtztD1U4i5HAjUxb9oQL
         nKww==
X-Gm-Message-State: AOAM533hpWA1/RVI2rQYJB01vnos0qhibXsdyR8jMId6FWGPZDk5a7Ad
        7RMaqOTbURoc6K/arW+eXlpznA==
X-Google-Smtp-Source: ABdhPJyvpQkup+PqYKcGOz1XWcaLrFZp3jPITkhcqvG5RUmPyI6LkmNKk9zVqFmftzPFPVRQpOtY+g==
X-Received: by 2002:a05:6602:21c2:: with SMTP id c2mr10882933ioc.184.1604941003739;
        Mon, 09 Nov 2020 08:56:43 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j85sm7576556ilg.82.2020.11.09.08.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:56:43 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: ipa: drop an error message
Date:   Mon,  9 Nov 2020 10:56:35 -0600
Message-Id: <20201109165635.5449-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109165635.5449-1-elder@linaro.org>
References: <20201109165635.5449-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for gsi_modem_channel_halt() to report an error,
because gsi_generic_command() will already have done that if the
command times out.  So get rid of the extra message.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 961a11d4fb270..3a5998a037dab 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1661,12 +1661,7 @@ static int gsi_modem_channel_alloc(struct gsi *gsi, u32 channel_id)
 
 static void gsi_modem_channel_halt(struct gsi *gsi, u32 channel_id)
 {
-	int ret;
-
-	ret = gsi_generic_command(gsi, channel_id, GSI_GENERIC_HALT_CHANNEL);
-	if (ret)
-		dev_err(gsi->dev, "error %d halting modem channel %u\n",
-			ret, channel_id);
+	(void)gsi_generic_command(gsi, channel_id, GSI_GENERIC_HALT_CHANNEL);
 }
 
 /* Setup function for channels */
-- 
2.20.1

