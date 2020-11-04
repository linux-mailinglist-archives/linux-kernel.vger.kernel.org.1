Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61A52A6E04
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgKDTgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgKDTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:35:59 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF815C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:35:58 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k18so3414038wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH+6ay3ML2IZuG2ItERyIkPsniEGNFXIQf0sfM9xhn4=;
        b=eDmsFAU7R/9xFhQgOZLSoSX4Ozyo7emaZvpoFzlYhKNIkMDz+wFqWLCCvpdbQvhFq8
         ru8XqVU6zE7B6/3rxJWElO0jg8aRU4ZGGMgcpUY/ybI4fJEJZtA5qHFG1/qPv3D5ao4l
         hvhhcYYE7pHbLhzxIlNiz78CcLLxGru7pDHJpWucJPZUkhA1yu5CK+VK047+eqUDGSCg
         zoLNP36tEymkyuyGc6kuetKvRHfnu1GgmFtvoZ6sIqj2pA3Hn171mu5/7KpEpFELkmDK
         OfeA39skAzWp4Kjb9IYniGlqNkpeZ310jPckyoU/haA5GL6VPZAAuQg1wr/tt5i+6xgW
         Qt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH+6ay3ML2IZuG2ItERyIkPsniEGNFXIQf0sfM9xhn4=;
        b=Wd2rzyLOsWh/XWZhD+Px7wATqu9dreXS2h9uSJEIG/IExPwNQqaEaaMNnOQMUXpiBv
         Vr0hnCkWj23C/XFV1GnDotTS+rGi+ljXFf2DAMD/kr5K6AUYY1mP8seovQ7lb5+alzT6
         IcXw3u7zASlt2gcngR7m4mh9PsQgwUJxuVt7BPBMczcnBL8jYqbs9bM91UAbH+vEATg6
         yUj0JMwZSPIxJwZVLY1UuqMn7q9LIpguue/6OjQuQcyIe2KhovPFRvoKKTGz3LWcJhHL
         K4TeZcQPtVzwpxvaIEWuvlbTXRpdOkWGUuHz2/Njy2sSi+07CMGc3y9R6nfIlkjCELuS
         EOFw==
X-Gm-Message-State: AOAM533+TBiRqPBxuV05aUB0P+KOv871laXQ1IuWXrNuU9A6K+GrdMzW
        Ta/DX2P3zAATih2QpTmGs8BFlA==
X-Google-Smtp-Source: ABdhPJwv9KaK3YsFPmWngapSaiAdWGp0IVoe9eZG7kU0Utng+LM5h3HswS/vwkbPrp46bn+qVqtzSg==
X-Received: by 2002:a1c:4b0c:: with SMTP id y12mr6696117wma.91.1604518557593;
        Wed, 04 Nov 2020 11:35:57 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:35:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 01/36] tty: serdev: core: Remove unused variable 'dummy'
Date:   Wed,  4 Nov 2020 19:35:14 +0000
Message-Id: <20201104193549.4026187-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to have a dummy variable here.

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serdev/core.c: In function ‘serdev_controller_remove’:
 drivers/tty/serdev/core.c:791:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serdev/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c5f0d936b003a..fecc28a73b3b2 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -788,13 +788,10 @@ static int serdev_remove_device(struct device *dev, void *data)
  */
 void serdev_controller_remove(struct serdev_controller *ctrl)
 {
-	int dummy;
-
 	if (!ctrl)
 		return;
 
-	dummy = device_for_each_child(&ctrl->dev, NULL,
-				      serdev_remove_device);
+	device_for_each_child(&ctrl->dev, NULL, serdev_remove_device);
 	pm_runtime_disable(&ctrl->dev);
 	device_del(&ctrl->dev);
 }
-- 
2.25.1

