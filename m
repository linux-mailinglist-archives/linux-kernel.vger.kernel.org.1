Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED42A6E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbgKDTg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731723AbgKDTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:52 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E72C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so12522780wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8ii/piGtCsE0rHMDmT3TlQ0FcYQRBL1VebkmVp+8h4=;
        b=hz0YA/mVTLOqO6wlKbHrqPR3ZKLWnSqjewlBdUPoYODGw/Q9OJR0KbQHy664a+jd65
         xGjvKYafldam97Bks32LwVj74JfnK3q0tWU6gf9l2DeF5TlUvXIDF5I5Z4zjZDySr6Pt
         gKRcMdF/VvtGUYyI9APJWZ7pzKFM47exVnW9wGARx5dfottR2z8MZWVYS++hPzXHbDyy
         UleGLbLOe2rFmW99vjvknvYZLeLm5284idceNsOCqB9LMfK9a7i6APDS8Cm4wfjFltK4
         HF8YlbcfaXNHUH98lObX0QEoNcVXqxz1TSmkdA8I1c7YbKg+5GjPy+4d8RIr2xIY0dEo
         PzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8ii/piGtCsE0rHMDmT3TlQ0FcYQRBL1VebkmVp+8h4=;
        b=Xi/Zm9F8JGABLRn84dMeQXfhgXN4eidEC3pz9myCKv6xdVThFrrlwGb6CVGJgqX/Nv
         GTOdTq6HygVy9PCUbyMU0HKdZJgR+zktjidy9pPTO3r9dd5JHRky/W0tb0ck87UufP0N
         wdOmS17IG1dt5IKUQe+Xawwn3KoanubQlvOulJKoPp3S092emx98jhTSAOrlfruq3xkT
         v4DVdSxdKtPu06pYt+w4Jwsq1TguErrrtBCoM/5ykDWXfhJ7If/TNhhGjkeOYFnO/8Wc
         a965PZOfajQrNVS2odWpgWwVmC1TVRu8T8TzWNBCuTVF1/vQqkX9rCm5RE8Z4Ybo/d9v
         cbaw==
X-Gm-Message-State: AOAM532tJ0/VTimB9uMwCCa/Rdb/WT/1744+s6F8OzucE2KvQ5K8u11e
        vg1E/wh4sRv8hTF1eP6QIIaN2GOHEH9yfoeV
X-Google-Smtp-Source: ABdhPJzmPsr7uF1ncNbUkuneU3Ek88Mdt9oJn+e+unEeFsLOx/sFNo6m1jIx/F/j1xQ0DPVQyV7WIw==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr33508817wrm.79.1604518610829;
        Wed, 04 Nov 2020 11:36:50 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, paulkf@microgate.com
Subject: [PATCH 36/36] tty: synclink: Provide missing description for 'hdlcdev_tx_timeout's 'txqueue' param
Date:   Wed,  4 Nov 2020 19:35:49 +0000
Message-Id: <20201104193549.4026187-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/synclink.c:7708: warning: Function parameter or member 'txqueue' not described in 'hdlcdev_tx_timeout'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: paulkf@microgate.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/synclink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 8ed64b1e7c378..cbe9ad0683fc9 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -7703,6 +7703,7 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
  * hdlcdev_tx_timeout - called by network layer when transmit timeout is detected
  *
  * @dev: pointer to network device structure
+ * @txqueue: unused
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
-- 
2.25.1

