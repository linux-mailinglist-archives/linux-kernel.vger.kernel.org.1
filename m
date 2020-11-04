Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF32A6E31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgKDThh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbgKDTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3FC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so2545913wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyvsnfUXA5wL3VS7284wUBGl33iwK2rOFX1sfrCau1o=;
        b=BcDz6Wv7qTDHhJWQD7Ml2oXJ6KRBgOZjSiA5UZa+voInnfCWKMg9ZlwFD6hGlaALlE
         hOsEV+jbJiTRQuEpWUA8wMBDhKAUuEFH8D2lnWmlJhS2lATs1QPO3jwVyfyzgap/xdaJ
         D2MEJGUttAjb5aIOumAmSmaB3pokrGGIyxa/VanSwgklfwflxLuRnMWXa8IumEssJ0XJ
         k3CrnVcOBo7LMeaSET3KVdy0kc4E0Mx5O+HUGfbPn+ZDZakrG8eeiaYd/Qxx8UYPZ4+k
         lb/cmfUbXZTOUK8W0gEkNv1BMuZ/YrgkNZhWCv52qs8KYThQWGA6CxAJpVmvCjgbl/vk
         XBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyvsnfUXA5wL3VS7284wUBGl33iwK2rOFX1sfrCau1o=;
        b=IONSR4j2sMqqVHchxy+Js0AJL9qNy+ty1t4z3BiBaqg71WqNzwk7RYbABHIF8oJZTl
         ZdsOMrpg5IOz4/d4bSgpUFL2EKds7ZTVjwFxamOcBoXE6eC4VfIKHnkBo7jXWUQ3I6Ag
         uvNl4KOSPAIQgmtUsh+l7sXZ98E/1AZ2HzlP9yqKcXIiel1s8rcr23Sx6T5p3kBD0ZgC
         2Knz+IQSrPfRfBbd6rfPTn03pY7i6QEb3UhQQ5OuUS8hWzE89iSwCjEOXhmUbjy3CQeU
         brIeQs/VzSufUaUg4b3VpUhqicViblP7yOrNthemHEKFVVelVlKkrC/ncoLMiTiwzDh+
         ZU2Q==
X-Gm-Message-State: AOAM532x/Xe03YA5wRhJD28JZRY/a94m53LLgLXTjdqWcXixiXfoP3Yc
        Ud2/1Tm5j/I3e9W4mkrUQ4kNgg==
X-Google-Smtp-Source: ABdhPJy9HUUwETfC+QPVZBpvrQ7UozvGpxaYg0iBy7t0mUkyuWoU1cqqDjuzcM44RmUMR9n+1LX2WQ==
X-Received: by 2002:a1c:103:: with SMTP id 3mr6130944wmb.81.1604518598136;
        Wed, 04 Nov 2020 11:36:38 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, paulkf@microgate.com
Subject: [PATCH 26/36] tty: synclinkmp: Add missing description for function param 'txqueue'
Date:   Wed,  4 Nov 2020 19:35:39 +0000
Message-Id: <20201104193549.4026187-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/synclinkmp.c:1808: warning: Function parameter or member 'txqueue' not described in 'hdlcdev_tx_timeout'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: paulkf@microgate.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/synclinkmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index ce08c5ec331cc..0ca738f61a35b 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -1803,6 +1803,7 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 /**
  * hdlcdev_tx_timeout - called by network layer when transmit timeout is detected
  * @dev: pointer to network device structure
+ * @txqueue: unused
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
-- 
2.25.1

