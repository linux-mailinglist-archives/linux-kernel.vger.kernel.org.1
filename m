Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A152CDF11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbgLCTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389423AbgLCTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:53 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A894C08C5F2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:34 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d3so3727582wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNyrFdysGwX1lZ4jvGNCJbtkaRTgJ5xOGF3Yu7MEPcI=;
        b=FJq9/qfyYUf8M5+iO/0KBLOcrbfKyo4j1c16rPAVTUwhdNApYrc7N5CgCRh1sWaZez
         XMe1HPFJljUADAK42LY9Hkw1D4YbraDt32oDnhdF9RzYxnY7ZYSHFHdow3ttfudlYA9f
         jYQXSlCGcXhI8FitaTnfXRZHKuM3/XQOY0mHqW/Ni+kmrM66QdXSkHy1nLgWrfAySS0c
         MZxean9e3PlPvvxZlir6vM0KI1hSSGq0VEm53IXmRgvpJayXGLEfolED555luOfZpN9F
         9lgg2yzevtC4BQh+KQ2X5nhZMsimJir2qGyiZvJlBtS+m2ank06rmtMBoTzhehbA1OpU
         Z+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNyrFdysGwX1lZ4jvGNCJbtkaRTgJ5xOGF3Yu7MEPcI=;
        b=Ps5hfAKYcr59dH3J0H7Ig+6CiIjUS7dRQIvrxDvktf3OneV5UV5u+Qx9gqYfX4xcNe
         8n+J9h3i2k+LKze+qZKQu7ZJ7fFD3wlc600BQdcDImlj40mspyhx7TOA5b4/oxy/fKiy
         c5QtGnHp+tPKJSRYfKgaNus7sPPkhvlB2nazzihbRp43CKwlVpRfm9I6oM6kxiO2d77e
         jFutifppkcYK39xrq9SwRv9WyjaYUnQ/eKWpUup3gHixhdc7eQ5sv6UVDKcd3/gs3vuZ
         3CsbWhxSGRcz++elEkjdKIwCLOSVhS8mc7yn3tXndRhSdH/hKfilAAtiSOht+71+nrYV
         xmHA==
X-Gm-Message-State: AOAM5333f5MHqSlFFDvG/yfrIFEawqJAJV4cFRe00kFlPOPo2gpbpzwr
        2tKUCX1qB+V5SP3jmgiRS9ysOMZkHYNHGA==
X-Google-Smtp-Source: ABdhPJyotsd/EWpg3JikHYk4VmznkvwIkA8ISXZIWQ+QDyLSd0ABARA161fJDlOyYJv/viAvuJCR+A==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr355877wmi.179.1607024012957;
        Thu, 03 Dec 2020 11:33:32 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
Date:   Thu,  3 Dec 2020 20:32:57 +0100
Message-Id: <20201203193301.2405835-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Document RZ/G2H (R8A774E1) SoC in the Renesas TMU bindings.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201110162014.3290109-2-geert+renesas@glider.be
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 29159f4e65ab..a36cd61e74fb 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,tmu-r8a774a1" for the r8a774A1 TMU
     - "renesas,tmu-r8a774b1" for the r8a774B1 TMU
     - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
+    - "renesas,tmu-r8a774e1" for the r8a774E1 TMU
     - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
     - "renesas,tmu-r8a77970" for the r8a77970 TMU
-- 
2.25.1

