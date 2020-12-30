Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BD2E77C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgL3KiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgL3KiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:38:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C34C06179B;
        Wed, 30 Dec 2020 02:37:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d26so17030354wrb.12;
        Wed, 30 Dec 2020 02:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qhhYEI5h+gOOGXHuXn2NRaquvFc5DXohAEyTChn9mP0=;
        b=hIaBq+n0irK72XY/MMtnoo3if33zl5/AiOLYkcu4jcD6+2T+Iizb1jyUwuu6CDkcV4
         Y7H/t0/4ohbMlydpZ3t60JDWU08Qf/b2Vr6Na9gv94j66hcWVNIUVfWYLfvFOIB3VOwu
         seDFNNDzSCCQcZX9feg6t0HCRrNvxDCLGSv1YBXmuXz+p0JsqzoEH31b5+6eKO6DvxbP
         t9+LyE2cBCa7QOO8J/UKDK4aJVXy2cm5YcWB11tq58TYucJJWvoUoHs0TtTKOkJ00lIG
         QfcD2QBNGImEf+bbA6EXHzHtr+P6Zjfs2LyB9gc/CM1QpbUUjQ62Y6XljkTq7vjthFD9
         9llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qhhYEI5h+gOOGXHuXn2NRaquvFc5DXohAEyTChn9mP0=;
        b=oThDys2SIIeV24O+w2fT3Rc5YtBDHrFDVhgduvmaUrpXoVjsiKGHmG9GgFFsCOoj30
         kQilF+DLoipi9i7DBODge1piySeBhPno8fobkQpCYrfLy0z0/YBYrpoJLnROPGPHi7bo
         vOx10g0ofCTH4/Rne3KCW5Tg75RBC/9PO55yw6sNovpsKKFLCo5Uk/ySy/PtgqgXpvWt
         +uUU82+W5GnEwakSITFXF1+5kjDyyu4A/U0zdGk65LqjgdvLU7NXk1FZ+paHmgcoHWza
         mLOsEJ463zsNQoMHKqs87hI81TIQzivU5I/qfp8IETlnubDwINgQp8dnogilQ5sS7tcH
         NTfg==
X-Gm-Message-State: AOAM531N/7ZyPdV8qe0MntO2uQsgU5SYDV+3T3xM/g4Meo2SfuTQLnWf
        g4JEBl9FTJN97X96sw9BnJieBNDyxTrnYA==
X-Google-Smtp-Source: ABdhPJy7n+kS1h/AtPmiV94IkVphrIFQM8x34rmGP3avGly0n9lzcYNXvf6XMLYcYCjGff44wsF8IQ==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr57207289wrt.324.1609324656106;
        Wed, 30 Dec 2020 02:37:36 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j15sm66672156wrr.85.2020.12.30.02.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 02:37:35 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for the Beelink GS-King-X
Date:   Wed, 30 Dec 2020 10:37:28 +0000
Message-Id: <20201230103729.2272-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201230103729.2272-1-christianshewitt@gmail.com>
References: <20201230103729.2272-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
board with an S922X-H chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 3341788d1096..6bef60ddda64 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -151,6 +151,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
+              - azw,gsking-x
               - azw,gtking
               - azw,gtking-pro
               - hardkernel,odroid-n2
-- 
2.17.1

