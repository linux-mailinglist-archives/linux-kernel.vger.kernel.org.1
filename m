Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33526A501
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIOMWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIOMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:19:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77EC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so3150130wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0xP//LC/JAnxfnl6E8AG6wYjP1bfMTZSmuoa8PLIdQ=;
        b=1GseTMFv3VBD+l/ZbJu70sdyna8HX7Q9Y3kd9CNWJfzpgmcxj50frrDrMlisuErsz+
         XZvKQDDLuVqe4Rr/4XizNQyWt150VGfmxP4tUAoX2BEGFilReRHbwPYgTmWbNcwe0d5z
         Un/x6V6eDqLFZf8/C7VnXiT/BgkcN3Q7WJCPikvDNr7EK59Gi/Wc+J6/10LTgzksvFV0
         ddlyn4S8++wymZGcymJ+DvypBpjPPGBRl9I9qAz5gHapBfPyw/No727HNejEKyj5qnCp
         ABnDEkFdHy9iZwrYcf+PQbhgBwfOgseEfitn5UJUtrJkUC6VSm79gUIPrRK3v4LumHqk
         saqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0xP//LC/JAnxfnl6E8AG6wYjP1bfMTZSmuoa8PLIdQ=;
        b=JebjmCxpwkiWRylBiB/k0o5r53xC5GhY+MNITvi7mncniiMJL+3XrS7Ve4afjL+dOi
         JCP+OHP5080V0ScTWbgCWiYqg+HmwVvZyoV0K7qAOornYrIGIWeJ88KE8waCo2QAg3NK
         CUZpOSrCtYXj9dnGkPt3IojggWgjz1a1/I24WM2McEj8jSp5sUFjesUlYlPF7MFDVN81
         vexdSQmqqCkyDYMG2ZQX7Q1H4I/sIO2EkpHOH3vd9/5QTtEEtKJKNzMi853ekN+a8+Oe
         I4JvTC/fs5uKispn8mwRq2B/iQ71Fl3WughJlSIIYZHflb3RAeMgfRSvqrYsftCFIgXP
         53Zw==
X-Gm-Message-State: AOAM532JxG3DOEb3ruX4qBdTofBeW2KiyMkwu0Q7coEn2AhFYVuQwsL/
        1fva4gLObLYGkMOtPVq3iOPahw==
X-Google-Smtp-Source: ABdhPJybSb0kYSEofFmaWgshAySRgZC//CUx/9p1zAMvIm0aMmbt7ZrLqp91l2b0uPGrWrXR6CHjUg==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr4474794wmb.170.1600172357860;
        Tue, 15 Sep 2020 05:19:17 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id 2sm18271411wmf.25.2020.09.15.05.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:19:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 1/4] dt-bindings: vendor-prefixes: Add Shanghai Top Display Optolelectronics vendor prefix
Date:   Tue, 15 Sep 2020 14:19:09 +0200
Message-Id: <20200915121912.4347-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915121912.4347-1-narmstrong@baylibre.com>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shanghai Top Display Optolelectronics Co., Ltd  is a display manufacturer
from Shanghai.
Web site of the company: http://www.shtdo.com/

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a1e4356cf522..fecdc7200b40 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1037,6 +1037,8 @@ patternProperties:
     description: Trusted Computing Group
   "^tcl,.*":
     description: Toby Churchill Ltd.
+  "^tdo,.*":
+    description: Shangai Top Display Optoelectronics Co., Ltd
   "^technexion,.*":
     description: TechNexion
   "^technologic,.*":
-- 
2.22.0

