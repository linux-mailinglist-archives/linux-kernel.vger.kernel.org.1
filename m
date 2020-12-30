Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B476F2E7A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgL3PSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3PSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:18:02 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D6C061799;
        Wed, 30 Dec 2020 07:17:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c7so15690779edv.6;
        Wed, 30 Dec 2020 07:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6F4Zg0AAbgjy+qDMetOB0daFV2AtFKYYvkDE7/8PLE=;
        b=IPbbzPx0evlffLJRP03SP8Lyyzhf6lzq4LhAxGtzN57wnZ0tei6j5FbHY9fd3vh92k
         ztNtlDLAGOspyH9TkqpLklbl0w9Q+4Yc1ACAm+8PHaMJ8lwVhMqJ/5UWA2ykp4NH4ocE
         v0KPbeBQWuV3trUMt4MKyo3lkAR7RAi3TeIsuAsUXV9WGwv+t8NRt7Nvo2GQdT+J6KmP
         yFPW0H2MlOwQXeF0ojYUtlwNDCUTjEBSyURSABmetx9W82INlHebkBtmzbp52IEYOcnV
         JVde4AEwdYQb7OUfnfRnaOGfrwzeMetwbRaPdbIiUBylS1psOw2RSmgzkJe7a3ey4ULp
         jg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6F4Zg0AAbgjy+qDMetOB0daFV2AtFKYYvkDE7/8PLE=;
        b=tUVgRpuHqOZbMCTFWnGzwxCGPgrtQNTwkYbmr0ts9DrM1Sxesz6RbEQWOJXdTn/+A4
         kExChMFWHHqG8l94zJ7YYuWpJgGi8uGs+KbxkzMxs+bXTL9xxZRnCVSMtGZqLkShw7M5
         zzzjCauk/Su1pEgSu8iWhHk7pan6qt+0ZwOW0ux3pbN37A+dAgl4sZMou0fuaCY5yeWg
         pNT9bgoZZjGl/M8q3Eo7Ton52qNHYn+dSln5SO7IdZjTJyRVcrJJO0vuQia/88Hp39QM
         KDNMmAj2IL5UfdX+eT19Ko6JJXGK58MCUQQc7eQ/I1CDY0t6hOzAuktQMpBlbfnIAR+n
         vILg==
X-Gm-Message-State: AOAM533SdkYG2rgovkMNBDvBehJvUbeTZat3yODDANAbHJWEWieV7k5P
        6ZdQOjIN4eCcPsDB4da85g4=
X-Google-Smtp-Source: ABdhPJwZsLXL9muSLLlmTb/brbxSzdS84Zud1rKczrIpSAMrNq2ToCl8gPT/NO6AGN8Ys9EvwrpZ/g==
X-Received: by 2002:a05:6402:1caa:: with SMTP id cz10mr51326967edb.345.1609341440494;
        Wed, 30 Dec 2020 07:17:20 -0800 (PST)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id x20sm19112928ejv.66.2020.12.30.07.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 07:17:19 -0800 (PST)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH 1/2] dt-bindings: panel-simple: add samsung,s6e3fa2 panel
Date:   Wed, 30 Dec 2020 17:17:10 +0200
Message-Id: <20201230151711.3619846-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add samsung,s6e3fa2 in the allowed simple-panel compat strings.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 27fffafe5b5c0..52480ca230c7b 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -241,6 +241,8 @@ properties:
       - samsung,ltn101nt05
         # Samsung Electronics 14" WXGA (1366x768) TFT LCD panel
       - samsung,ltn140at29-301
+        # Samsung Electronics 5.1" (1920x1080) AMOLED cmd panel
+      - samsung,s6e3fa2
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
       - satoz,sat050at40h12r2
         # Sharp LQ035Q7DB03 3.5" QVGA TFT LCD panel

base-commit: d7a03a44a5e93f39ece70ec75d25c6088caa0fdb
-- 
2.29.2

