Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD826A4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIOMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgIOMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:19:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C2C061797
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so3247078wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=un3Gh2gweDlAUsvqGdAT6fJ9irEjsQvOrf4xpheQKFc=;
        b=Lq9x8PS6ikykudXTzqmiSjlkw1Mv5Fjj4FKyQyXpGeeAWDF9A9ovPyTjb3Da4qoZun
         0Qo8bZXk2A2lRtM0JArOOu82jnPkup70fFXg/EEeL7/tGd/sSGimI8b8CSJ6Epc8heO/
         dW0IioLCpj/OBwmHmNCYc1TXGLCqSD/6EomeJWbxHNdQNcf0QWyxXRG/UfSnTIS9REVD
         yXDRxOzEUYAIpyaO4xRjQxrFnS+f11Gin6cKWKlip0nSwAXkI4tIdX9PcL3AgppY8tmR
         aKdTsPcHucEfk28DnxBE+2jvIqN7Nzx+Ti8b1c1mjBtsjgDQPZns2rU9G9yALoi1dnnt
         pLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=un3Gh2gweDlAUsvqGdAT6fJ9irEjsQvOrf4xpheQKFc=;
        b=HJsgTrtx9g7X2mgz+NCfHTg6AIBiUN0TcTzzs7lofwRBESxeHcIOCthcFJKIPbhRpc
         UqBXvpNn5lY/KTCnDBgo8GKjVDcttbaK6OdSnPTJl1cj8zWGuwj4mm+7g0JRGembMHzx
         uTvegO7eo1TSs/+Wll65jumyXOGUR8Mw4ViRDXYKs7ov7xnWViBEa/sOSz/iXfeNnkuI
         ZeTbUpDKsqZxn8eg9ZXfpRN5XBGDaCkiTLKgsRBuqal+x5JDKsU6IbP/ApbFfqI2yxVr
         VrG9Htm73hWiMa2MFkmjSoyl5rRX5laQNo0jZDUf9U7FaZqK0S5ZV7Jhl7HaE/b4iMY1
         4Vqg==
X-Gm-Message-State: AOAM532oIE3tiUmekESorbeEDLq3Ysfi2zti2fL/9qvfOXSyfUspeGOe
        ird5+qKNZU/0vxMGj6NUqoLZBg==
X-Google-Smtp-Source: ABdhPJzfh8abje87LbHn4Yy3eXAdcq+orthOqFQV/rOJWuOe4E/5vFnXxQuTIYJlbMLLAVPJWsKNWQ==
X-Received: by 2002:a7b:c5cf:: with SMTP id n15mr4395014wmk.93.1600172360770;
        Tue, 15 Sep 2020 05:19:20 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id 2sm18271411wmf.25.2020.09.15.05.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:19:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 3/4] dt-bindings: display: panel-simple-dsi: add TDO TL070WSH30 DSI panel bindings
Date:   Tue, 15 Sep 2020 14:19:11 +0200
Message-Id: <20200915121912.4347-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915121912.4347-1-narmstrong@baylibre.com>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the bindings for the 1024x600 TFT LCD TL070WSH30 DSI panel to panel-simple-dsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 4d08e746cb21..a29ab65507f0 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -47,6 +47,8 @@ properties:
       - panasonic,vvx10f004b00
         # Panasonic 10" WUXGA TFT LCD panel
       - panasonic,vvx10f034n00
+        # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
+      - tdo,tl070wsh30
 
   reg:
     maxItems: 1
-- 
2.22.0

