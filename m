Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36A28237D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 12:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJCKDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJCKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 06:03:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175EDC0613D0;
        Sat,  3 Oct 2020 03:03:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so4382366wrn.13;
        Sat, 03 Oct 2020 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgpkF28etaKQ0J2igjsOiDIjupmhgpQVJ1epnK66aAc=;
        b=J4PrM12sIgMTcBoaR+fYwd31zTy3mgEmuWvpvqrRHMtUzcdbLx8XdUxPt0RvlNuDaz
         HKmxhK5WT99yQL9R+8d8pCsFZ1r9+gGMpTXDQSsjy0TYmkPwT1n1Ss0u90AsQYZVaBpQ
         Whd+sal5+a6Z2u/xRz4pfK6YgbLWi0uwoa3VxUx0KI4jgPLgGC7+eKdcXWX97q1Hh5Ki
         NflIwc0WOproUwxvsI+c6egajZ0AV05D83w7Zvb9l12xkvWiCybcwjv0EO5uTKJCVNnM
         1aNl6SIcI4KlW1axFsXJQeSdlORaYNACa9Kw47SbyvVy8d2vsBwV+AiKaZiOlXMghvDj
         DdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgpkF28etaKQ0J2igjsOiDIjupmhgpQVJ1epnK66aAc=;
        b=S9H8LpDd9TpX1Of5MnOfOeMvOHSTg8z3i8+jCHtt7ESZ8iQ/VN+eqMPUDvpbbPz6bI
         GzEqZ1CUioRzOPZ/3Cjw5nV4x0iUo3xnW2zrQekjjbRGkrP1JEeeRlizSU1P0jCzfJky
         gC/CKoAldcYRBpJwGFILr+TZsayaEn6/bMLEJY8ih5b0G8uXdgw2aGNQGWU9vlAatyiF
         QGlSLATkJriB5TXBJzUnuDZ3wE4FAvgDrK4VYm0PYRAM4T5xGI1vjDxk9eWR0+hovHFG
         H9P644HeAkI0GX8DU69T5xtpchFjTviXsbXrwOO/tZ4JqgwiStjDm9V6HE8I+0wsgwJA
         YLaw==
X-Gm-Message-State: AOAM531sAnI6AVx0uMbuDFFCHh6lhyoxRRVgp9cpxaGJgkzL4JfuUM+1
        2Q4Khc0CbYIm0gEX9CAX9x0=
X-Google-Smtp-Source: ABdhPJyJGnit4g06Hq/dog0xk1OHhFyKXNvYd8zgb8PKTw3H5Mwu4T2Qvj/pZSkoEAJ3sISuKtZLKA==
X-Received: by 2002:adf:f586:: with SMTP id f6mr7459362wro.299.1601719420618;
        Sat, 03 Oct 2020 03:03:40 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id p67sm4954529wmp.11.2020.10.03.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 03:03:39 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun4i-a10: fix cpu_alert temperature
Date:   Sat,  3 Oct 2020 12:03:32 +0200
Message-Id: <20201003100332.431178-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running dtbs_check thermal_zone warn about the
temperature declared.

thermal-zones: cpu-thermal:trips:cpu-alert0:temperature:0:0: 850000 is greater than the maximum of 200000

It's indeed wrong the real value is 85°C and not 850°C.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 0f95a6ef8543..1c5a666c54b5 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -143,7 +143,7 @@ map0 {
 			trips {
 				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
-					temperature = <850000>;
+					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-- 
2.25.1

