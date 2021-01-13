Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8232F4DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAMOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbhAMOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B35C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y23so1856319wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGeTlHRvpAdPio9vRmuctbq8OFArXLtHb/g2TDArOrk=;
        b=s5iALxr3dobAkBUTpXGoBoDm/4QIM6hPqOgnFBeyOPMxE44pJLX408VkWwnjf9EKr7
         cV7kywVBFk+BvK0rYKNvHfyqBUdb5WnuXOYKKGcbdNXTqGP8wzzNaWscr3GVpl5L+3e9
         59GwpRAnSZw8YR3uzHvOELb7YNB+MK3VqThmnI/SPsJGojvBSlVXx9pEChrkKe/NOSnL
         ISS27W14Wk79/qU5wLB7QGSr1xGvvu+viv/ZtzaO16hfIiOOc82jkjWv9QBVdfjnSd7c
         DsTks38v32N1wxNwz0nDYPs9DmW7h7iY6aRdoTTFZx6zjR6CxixctRYRVpRPsYNSW6i4
         aExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGeTlHRvpAdPio9vRmuctbq8OFArXLtHb/g2TDArOrk=;
        b=OOCe0/jjgB3ypO90Ft4hFcirz6Sypukzvv0is1VN0stFq7QJDQjrjzbTteHipNBe2a
         mnNRHkMoEjNtd0tO0OBLwdVT8/66exxymtsygmvqKZfO8GX4yMQEHmuR+rR9cF7nt9X/
         aN1S7Hq57inMxqTJMbRIPdBJylCKpCPXaamSRO2bwYwJwau/OO8BwjYle13xMDryVg8e
         KEk7ajzHhjMmGOLHdV0wLXk2UnAwsQyg66xWT05lspHrGI8RKxWKS8uqQHCwFlBaxGRu
         gMvRp3TnmkkCgsY1PZOrhC7o18ogQavJjnkfFfQH1T9faDxO6krCPKIbv2gqMrZ9vFaC
         M3zA==
X-Gm-Message-State: AOAM531ViWwm0Fo+sWoOXPIXlsxykiekIVVvlGBlJGZa6+OgrR/jthjj
        8xtrnoTPgA6LZn6Oaaqj6ODpYQ==
X-Google-Smtp-Source: ABdhPJyCW0t+4fXJ5f+EqccH4bSmfQRogXuSLR0mXqIvzlFByErtr2znDphOj6bW9fU2Yx0Dp0rX9w==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr2579994wmb.124.1610549414900;
        Wed, 13 Jan 2021 06:50:14 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        James Simmons <jsimmons@users.sf.net>,
        Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>,
        John Fremlin <vii@users.sourceforge.net>,
        Ani Joshi <ajoshi@unixbox.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 01/31] video: fbdev: core: fbmon: Add missing description for 'specs'
Date:   Wed, 13 Jan 2021 14:49:39 +0000
Message-Id: <20210113145009.1272040-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also fix a formatting issue

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/core/fbmon.c:617: warning: Function parameter or member 'specs' not described in 'fb_create_modedb'
 drivers/video/fbdev/core/fbmon.c:1103: warning: bad line:

Cc: James Simmons <jsimmons@users.sf.net>
Cc: Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>
Cc: John Fremlin <vii@users.sourceforge.net>
Cc: Ani Joshi <ajoshi@unixbox.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/core/fbmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 1bf82dbc9e3cf..82f856fe3919f 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -605,6 +605,7 @@ static void get_detailed_timing(unsigned char *block,
  * fb_create_modedb - create video mode database
  * @edid: EDID data
  * @dbsize: database size
+ * @specs: framebuffer montior specifications
  *
  * RETURNS: struct fb_videomode, @dbsize contains length of database
  *
@@ -1100,7 +1101,6 @@ static u32 fb_get_hblank_by_hfreq(u32 hfreq, u32 xres)
  *                                    2 * M
  *        M = 300;
  *        C = 30;
-
  */
 static u32 fb_get_hblank_by_dclk(u32 dclk, u32 xres)
 {
-- 
2.25.1

