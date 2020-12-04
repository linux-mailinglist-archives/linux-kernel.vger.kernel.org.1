Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2480A2CE969
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgLDIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgLDIUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:20:41 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C21C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:20:01 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so6220149wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qB2SYCS1v55sYBnoh6a9A5+nyB8wI9x+IMkUjRVdEyU=;
        b=ccMmR3vntuVwCLyqCesY4T0znkXgfHiXTnq0Gfqpmm9HTwG6ct0MAfHZMb2oDeCArn
         1nLK4Eu61t+NF96Gt0GPU7KyEBcyHU1FZ0ifBWS90HGCpl3nED5ZKBYU5kQOAlk7oNDZ
         uR9o1QAz+c6cPiNc26TuGW7uoCI6+fgmbwmB536uos4WiP9CvNQ3lMgaK7xiLyvhPNtB
         FnJXjPSSlKTYFmrhXPob9KQhIdISIvf3nam868Q9yq0UBc4aFgDcv2UUGLCCUxn4NEyW
         E0o/6e6uxmZziWhlajv4l6fH8jplyKEMp7BwBcnF/HKLVvlMux6bCwt620d2m2mM+kTd
         RB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qB2SYCS1v55sYBnoh6a9A5+nyB8wI9x+IMkUjRVdEyU=;
        b=PuhlNLjE4INawj603ik0RE04dy2s6TMy36n6ask7A9fqiqyJO2ThMok2oP0YYfa4UN
         yNSPnKRlpnGH1Z6jUc7r6oOjRBnyl5ssPgVDdCjBqFjt46acqWg834uLNokdCZUqVI+F
         soHK30nRKvPDj0ntCebOHq7ZIFfauvWq89NUfIWeQR/Wn5XgY39ViU29rGutXv+0J7vt
         XfAmv71/QAyXm4KSorZX0XPIKK9nSs021Egeyc47HujfXC+aPoGkfD0FhS8mQ/eJsq4d
         z3tttIEgwKqdHpWIapx+HRpS0PIrJcQZ7jeDnUQ4e5uEzXK1A+ZVfExc/i+ghWf9lfIz
         Un1A==
X-Gm-Message-State: AOAM532Z1MLEvMt82lH+FGqTneLOAZqOezDybmGwx9VeYSaa/hGjzeJt
        JYBZSZWxUcNpNrjGD/ax13GZGw==
X-Google-Smtp-Source: ABdhPJzrpFgeI141caO0N8Tzp+D9LOCP9wb+YCgmPCkrvEZHVVVGvZXPcNLDcIUBBkFD7Rirz4jVww==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr2852681wme.85.1607069999842;
        Fri, 04 Dec 2020 00:19:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:296a:40d9:d5a0:bbc5])
        by smtp.gmail.com with ESMTPSA id b17sm1691156wrv.10.2020.12.04.00.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 00:19:59 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sam@ravnborg.org, devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/2] dt-bindings: panel-simple-dsi: add Khadas TS050 panel bindings
Date:   Fri,  4 Dec 2020 09:19:48 +0100
Message-Id: <20201204081949.38418-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204081949.38418-1-narmstrong@baylibre.com>
References: <20201204081949.38418-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the bindings for the Khadas TS050 1080x1920 5" LCD DSI panel designed to work
with the Khadas Edge-V, Captain, VIM3 and VIM3L Single Board Computers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 72e4b6d4d5e1..fbd71669248f 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -35,6 +35,8 @@ properties:
       - boe,tv080wum-nl0
         # Innolux P079ZCA 7.85" 768x1024 TFT LCD panel
       - innolux,p079zca
+        # Khadas TS050 5" 1080x1920 LCD panel
+      - khadas,ts050
         # Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
       - kingdisplay,kd097d04
         # LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
-- 
2.25.1

