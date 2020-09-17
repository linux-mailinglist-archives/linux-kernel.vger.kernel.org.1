Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804B726D423
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIQHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgIQHAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:00:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B99C061354
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:00:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so872309wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nh4GdIJJbybBRmBf+gZ13SWErJtKYoaJY9ok96suIOo=;
        b=028KlmU2+WuM/M/w6dvQvAw4gzelsPWlRz7bmqYfPpZX3WFwx431DJAvmmBtpDgZYj
         Q+LJ/9h99RBMQISoeUEKAJiy4EXP0SNcahPA1kbNDHAAKar3Tz44sc0X89XO4X2InKMZ
         Ee7ARd/zXqotYZwIpxHkmgjKfOUruIm4DfT6gyByi1jE3OoAPCKBqCJ+KYPDmrJCbkjB
         88kt9S2JioJwL3MFUDnrvb5hGomGHHu/erXlTQ3gjo+BnWqC8qTSPQGsilUNAKa5YurH
         Z1WMD/eH8xvjfdt6+g/FDGN3M1vTG+UNnkOwwnLY7C5+7c2yvE8xH///FhwNZw46htBs
         5oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nh4GdIJJbybBRmBf+gZ13SWErJtKYoaJY9ok96suIOo=;
        b=qMs8kCl0qkkjre2AJIkhLKum0EjzdsOwyzWrP46p71QnKYzsL6fUXiuRWk1fGTdiqg
         j7o7MvRiWx2NPiQ/kKY4HsIbLcyfmAXpov34OD/bZJosKPqLY4mfGLL7oNRcFoUgv9bB
         GcXis4raMc2AdPHjI3GVAdh0ic9MZGfmaS1Douv7My2jDd3qgarFdB8qK6b4RU8lH7cH
         haK7arzOtFE1VbiKycb2rOhmDV1FaL/IG5OfDHGkZW9vaPnY9rZ2q9dm/f8VYPSLkkhT
         0GAGyr/MQ6NmoWQSKktBJgvrLJBza4vjdXn3qZdvH8HQd1PkCGl0vxkWYyIUl/Db5U2z
         Wbkg==
X-Gm-Message-State: AOAM5310uGIWyiZ7VYbA4Sr4WZkYf9m8WM7FnPFgOEFw1gNcszf5rm7g
        Yh4OYKWSC9STJUNRR2icUtZlwg==
X-Google-Smtp-Source: ABdhPJyjeIXkATG0vP51yK2uo6XEBRO8bjCqeGDjxeohvfzbr3xkDk9Axc8TM3MAeWczPQ7AZqJEvw==
X-Received: by 2002:a1c:2e4b:: with SMTP id u72mr8469691wmu.69.1600326005809;
        Thu, 17 Sep 2020 00:00:05 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm35709055wrh.14.2020.09.17.00.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:00:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 5/5] arm64: dts: meson-axg-s400: enable USB OTG
Date:   Thu, 17 Sep 2020 08:59:49 +0200
Message-Id: <20200917065949.3476-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200917065949.3476-1-narmstrong@baylibre.com>
References: <20200917065949.3476-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables USB OTG on the S400 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index cb1360ae1211..7740f97c240f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -584,3 +584,9 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+	vbus-supply = <&usb_pwr>;
+};
-- 
2.22.0

