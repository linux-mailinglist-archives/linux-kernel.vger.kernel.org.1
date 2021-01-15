Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392532F83EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388660AbhAOSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387485AbhAOSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:18:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331FC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 91so10219959wrj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wypu520/ZqfvAXznwR+SiEUfHGdGNRczeGZtn7BjKuI=;
        b=uklAgr3xItoJKlJFKyo5xlUgWSX86AVAJKpBlIAUHTTmJjmZdSCU3C0YIEToX62mDd
         K/q2X8OFUobZ9apHOg5lG1GBQGolXMVympwlmVmG744dMCd2dWaaFzva7ZHAC2rxe8ZT
         UYd32/gVhlXs0lrLcNrxzeaton9E3NJF68/fCh8AO+k1rR8iZlnQyaRWUplWqAmXNr75
         R1hc5DJYvgH5jtjYE09AxYlUfEodnGMkrDo21uOE+kDFnsIPEEdGk6LB0CEApsChvvW6
         AiH2mwlhtlzZXrsmBq8HiKT9MWeMVzDIZMfAkqtqASnMz40a8PRSoSG+ZdGHw377wRBE
         CaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wypu520/ZqfvAXznwR+SiEUfHGdGNRczeGZtn7BjKuI=;
        b=pZkFDWb0vKj1GsC66ggStFA/4rXAVfbdA6h+TcutZJTD5AWIvrS21m/Qn5db8d92pS
         CcK52f+o+iVXZEblpxCLjwziStJFnOdR4+F1yI4MwGU8dDejiQsFvyd1MW3Q/6I1NCIW
         4Hv4VmIBK08RRqi61S1p1h8oURd3stkFP2kcUGOizOFAmkP/d3JmFSDi+O+xKxLDCbEc
         OMuLRj/HsZr574x2EJwhj5FMCo2oSjN0poXBLAOXt0/XVDUBXdpnDsK6nad26+LaBYjo
         xHUvuXSB1FBxZmGSjgV0pdfZrRG4+4LrkDhuJ7da8t9IokaHEiXY/eGL29mze5AkgyKS
         1Zsg==
X-Gm-Message-State: AOAM5326gL5E72qpJT2BIMfzT1azujbtls6/TB2xa/OfTXfNcYVh6Hym
        AhzjuJcP36t8AMVyEX7A6/bGyw==
X-Google-Smtp-Source: ABdhPJyFfHc9cpBrLJAjZ1f8AMeApx1fDCkuNGMJmPVlsbqk/HoTtgo+IczuMWa9mDl+g0zmExLmVg==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr14488386wru.10.1610734592374;
        Fri, 15 Jan 2021 10:16:32 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Jesse Barnes <jesse.barnes@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/29] drm/gma500/oaktrail_lvds: Demote one documentation header fix another
Date:   Fri, 15 Jan 2021 18:15:51 +0000
Message-Id: <20210115181601.3432599-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/oaktrail_lvds.c:38: warning: Function parameter or member 'dev' not described in 'oaktrail_lvds_set_power'
 drivers/gpu/drm/gma500/oaktrail_lvds.c:38: warning: Function parameter or member 'gma_encoder' not described in 'oaktrail_lvds_set_power'
 drivers/gpu/drm/gma500/oaktrail_lvds.c:38: warning: Function parameter or member 'on' not described in 'oaktrail_lvds_set_power'
 drivers/gpu/drm/gma500/oaktrail_lvds.c:291: warning: Function parameter or member 'mode_dev' not described in 'oaktrail_lvds_init'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: Jesse Barnes <jesse.barnes@intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/oaktrail_lvds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 3abaedb01afc1..432bdcc57ac9e 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -29,7 +29,7 @@
 #define MRST_BLC_MAX_PWM_REG_FREQ	    0xFFFF
 #define BRIGHTNESS_MAX_LEVEL 100
 
-/**
+/*
  * Sets the power state for the panel.
  */
 static void oaktrail_lvds_set_power(struct drm_device *dev,
@@ -282,6 +282,7 @@ static void oaktrail_lvds_get_configuration_mode(struct drm_device *dev,
 /**
  * oaktrail_lvds_init - setup LVDS connectors on this device
  * @dev: drm device
+ * @mode_dev: PSB mode device
  *
  * Create the connector, register the LVDS DDC bus, and try to figure out what
  * modes we can display on the LVDS panel (if present).
-- 
2.25.1

