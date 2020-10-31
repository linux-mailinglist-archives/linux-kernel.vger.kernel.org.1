Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEE82A141F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 09:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgJaISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 04:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgJaISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 04:18:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C54C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 01:18:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j18so7185887pfa.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVtuiJo8q6yyeH5yuakhl1fngL1phRVfiZKUAXBNH30=;
        b=Ojc3d1oBZVIDJla1t4UCrvdCtw9FHAcLutmr+qEfHqSYPN0xVC0I/FsOyovXyoFIVw
         qL+XqY36DIR/dB3FcoCWLgDBhiON+VmMDD0AOwfVV+CgQVEdz5ALOegOaNDx1ccPFabE
         ico2NhyZKns0jUmR9bjuoi5OIPiqJUfzfC0GbT2ow8ef76bNwlvsjiF6V9GKP1nxwTaj
         XJMFjsXC0VVDxP2IoFiTQjZ1+QnX0pwZmWkAFOTbtcNGny6qswqk+XLdnc1Fd+nSxDwk
         Y9Twj7rU9x+gw0A9D2VPePPZuDLt/i06e+chfUIn4kVOHYLm3hBWtoSSpwpB2vytI8Tq
         7UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVtuiJo8q6yyeH5yuakhl1fngL1phRVfiZKUAXBNH30=;
        b=LZKOqcnglpw/oFcram7TQz/cwsxB3od6JoQ5phnlNlFQjiVW61L2xXmmhDzB1qxB3j
         YziEsiKVwggQXORf+RpfaT1kussuEsjAOsF109E8YmhBOi6AYecdjkVtzr8lSPGcQ4t5
         MLR2CHOroORnLQ6cHg6Rlbjs+d7jiTpLRvUQrxOXimS8U5maiH1WfebJcllCmG3IdW9h
         Dpl4wW7NuECS0/W4xZ0CoC7ZEinrk0aO0xYQAn80q1r8kaR+ySb+15AEFpcc5RGoWwy2
         Bwqycj/Uml3tvoZv1brsABMl2AdOYomAQqMDXz5qNWNv+FTMVuaXD8YqjFvCEo+WI5PV
         prDQ==
X-Gm-Message-State: AOAM531x4SgquB6J4GlcyxvF3xg0QfDw5E2DbHDqiyYmylrF7ch9fESv
        3jespqM3y8HvI/F5j+fY8mw=
X-Google-Smtp-Source: ABdhPJxisclNv6GI5uPpRLsPIUNxituSzQzeBlOybksNUmxRyPL9s9zOfc2SQ+twfm3I4upLPr1I6Q==
X-Received: by 2002:a62:ee06:0:b029:164:20d:183b with SMTP id e6-20020a62ee060000b0290164020d183bmr12838431pfi.4.1604132291474;
        Sat, 31 Oct 2020 01:18:11 -0700 (PDT)
Received: from 119-18-5-146.771205.syd.nbn.aussiebb.net (119-18-5-146.771205.syd.nbn.aussiebb.net. [119.18.5.146])
        by smtp.gmail.com with ESMTPSA id lk13sm4990534pjb.43.2020.10.31.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 01:18:10 -0700 (PDT)
From:   Jonathan Liu <net147@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Liu Ying <victor.liu@nxp.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Fabio Estevam <fabio.estevam@freescale.com>,
        Jonathan Liu <net147@gmail.com>
Subject: [PATCH] drm: bridge: dw-hdmi: Avoid resetting force in the detect function
Date:   Sat, 31 Oct 2020 19:17:47 +1100
Message-Id: <20201031081747.372599-1-net147@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed that resetting force in the detect function can
result in the PHY being powered down in response to hot-plug detect
being asserted, even when the HDMI connector is forced on.

Enabling debug messages and adding a call to dump_stack() in
dw_hdmi_phy_power_off() shows the following in dmesg:
[  160.637413] dwhdmi-rockchip ff940000.hdmi: EVENT=plugin
[  160.637433] dwhdmi-rockchip ff940000.hdmi: PHY powered down in 0 iterations

Call trace:
dw_hdmi_phy_power_off
dw_hdmi_phy_disable
dw_hdmi_update_power
dw_hdmi_detect
dw_hdmi_connector_detect
drm_helper_probe_detect_ctx
drm_helper_hpd_irq_event
dw_hdmi_irq
irq_thread_fn
irq_thread
kthread
ret_from_fork

Fixes: 381f05a7a842 ("drm: bridge/dw_hdmi: add connector mode forcing")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 748df1cacd2b..0c79a9ba48bb 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2327,12 +2327,6 @@ static enum drm_connector_status dw_hdmi_detect(struct dw_hdmi *hdmi)
 {
 	enum drm_connector_status result;
 
-	mutex_lock(&hdmi->mutex);
-	hdmi->force = DRM_FORCE_UNSPECIFIED;
-	dw_hdmi_update_power(hdmi);
-	dw_hdmi_update_phy_mask(hdmi);
-	mutex_unlock(&hdmi->mutex);
-
 	result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
 
 	mutex_lock(&hdmi->mutex);
-- 
2.29.1

