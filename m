Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8902E2111
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 20:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgLWT67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 14:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgLWT66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:58:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22CC06179C;
        Wed, 23 Dec 2020 11:58:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t16so325421wra.3;
        Wed, 23 Dec 2020 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=UYTrlhxRpDP7C/fM+0iGVqqOo5KzXXHqm2tI4TNF3u8=;
        b=oz9SrDNKtxzgmntebx1acIXVwV7PIXZOjjcnJf3jZnhA19fqHSpJHnBFQ1ZWctHD3N
         yzFUOm3GX884ewA7ceAZTGrlnmc+XH/gtNK6B2LTfVHtENrMiKnoh93mupaorUmPc1zB
         6ukoUKmnONCuMnP3Hm0BrK60XwiyXVu9l/Iq6dSkIe1QHv4xWR7XJhX4ir396YvEacuC
         63a/7krmXByF6JBSr6IOmeCNQMAI8b+E/JRgF/uq0EixgfeRFxXqt1C1f5jPctHiAd19
         9XpU1/VhDNPV1HMnWX5f0kcQMDQVic4dvi+4Mbx+sJHPzCgyR1RUDFl9dE9RNgYoHpMz
         ah5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=UYTrlhxRpDP7C/fM+0iGVqqOo5KzXXHqm2tI4TNF3u8=;
        b=TpJlPCEGk13CXcrOJGQgDSxP3ERY+zNVatNgIGek3ICvhO1N5jCBPZ64l1EGibka2n
         SvPE4h5kOcrR9JDUNdRa8nJI3HweN54vSQLbxa7jKIy070LGdxW6NPXeXdQIwssW4mGz
         pC3HyjslfTHfPrzfRgnXNwZhHJaNa6q2XtBtk5GcNemI8KoW6VLQeOLSePnzEbneTI2j
         DzHK6MAkekIzgeuQwRZP4yiFAe91jJJ6EqDOzVAGoccTfZqgU2whNNWNb4GbJh9sKVuU
         ah6h+opcBcAeFhTHaRT2xUNX3Alxt82MrzBojMbJxVfzqjY2xk4jF2knunpO2/jM0FYz
         rflw==
X-Gm-Message-State: AOAM533BxGni+DZoCfteJ/uvpdSeXVkDLtJox0CBEvIYH9XlwHFW4HVO
        rHDRzbxsL5OnlilxTblELdwbmPLnzeS/njvD
X-Google-Smtp-Source: ABdhPJzsaEzo5NoWlF8N8uJHClf2lwXUd3bXBoWil9czOXJWvfsI6fcMdQYgvXR58i7TrGxXv55XzA==
X-Received: by 2002:adf:828b:: with SMTP id 11mr30185650wrc.180.1608753497079;
        Wed, 23 Dec 2020 11:58:17 -0800 (PST)
Received: from [192.168.1.113] (250.red-81-35-222.dynamicip.rima-tde.net. [81.35.222.250])
        by smtp.gmail.com with ESMTPSA id l8sm40050158wrb.73.2020.12.23.11.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 11:58:16 -0800 (PST)
From:   Sergio Sota <pikaslabs@gmail.com>
Subject: [PATCH] ARM: dts sunxi: add A10s/A13 display frontend support
 fallback
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pikaslabs@gmail.com
Message-ID: <0ab34d17-625b-aee1-b77e-c4a9cdb019d7@gmail.com>
Date:   Wed, 23 Dec 2020 20:58:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From d5fcc1d4aec82ffe6de78cc40a6f53910e2e88ba Mon Sep 17 00:00:00 2001
From: Sergio Sota <pikaslabs@gmail.com>
Date: Wed, 23 Dec 2020 20:03:55 +0100
Subject: [PATCH] ARM: dts sunxi: add A10s/A13 display frontend support
  fallback

The A10s/A13 display frontend driver is not implemented
The A10 has a compatible display frontend driver
Set A10 display frontend driver as a fallback for A10s/A13

Signed-off-by: Sergio Sota <pikaslabs@gmail.com>
---
  arch/arm/boot/dts/sun5i.dtsi | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index c2b4fbf552a3..4ef14a8695ef 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -734,7 +734,8 @@ timer@1c60000 {
          };

          fe0: display-frontend@1e00000 {
-            compatible = "allwinner,sun5i-a13-display-frontend";
+            compatible = "allwinner,sun5i-a13-display-frontend",
+                     "allwinner,sun4i-a10-display-frontend";
              reg = <0x01e00000 0x20000>;
              interrupts = <47>;
              clocks = <&ccu CLK_DE_FE>, <&ccu CLK_DE_FE>,
-- 
2.25.1

