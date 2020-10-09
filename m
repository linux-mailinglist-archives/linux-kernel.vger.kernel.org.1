Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC43289A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391166AbgJIVC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391149AbgJIVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:02:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2208FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 14:02:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so7885237pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSgTQ4Pc6Kxt/1hh+W4bhI8Y4UAz1RySlrYjHTB/Q6g=;
        b=TldjrPNHu3op8O3Smd/VV495GRLq/Pvi/HhrHepX6DWARPJiPdT+JSmZozhKa7wZAD
         krbuiFWqQqZAZwmoskHUqw7p/TZK0CiSomXtngbrLN7peaEMUSKDMj239EjeuNOHabPH
         Zfy/Fptt7BaEQjftWN/7VufBpAraFP6S6rZPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSgTQ4Pc6Kxt/1hh+W4bhI8Y4UAz1RySlrYjHTB/Q6g=;
        b=pmnknfuAMsmvfg7YyjNoIVCQ11C8rAY1MsLF2m/eRpGexxagBGQoM7YPlPducQ645L
         sm3TzP1D3HOuGjPyOwLGc2IyhNfJti32NU6OpJEo//wG/OVeKMKzWhvJfbq+v3Vhsg3V
         QW0UyKa5ABYW9dUp1lTMyvKAdLy/ME7ArkZV8TAX6iUjDW72Ci24+VctiLLtIhKKsFA+
         0j35Xr9KKXlnEXJKLYfA8Ocfr4opzunpitBrZRAMSOMZ4DeRc4v+1KXCDTbbcU9Z2m2n
         wChuc12d1YA52ghlT+pF01IDQyzMTYcFTgkuMpW+//FvyxKkrEoOAlnmOvP6kWSa169g
         0Dkg==
X-Gm-Message-State: AOAM531gg+W0uuOs6aIjFthOYhFKs+bQiBJrjLtD+hgdl/Tifu1qoAYF
        f6ajNWOyYVu/wbQtw0UcJsfLM/7wXHzernbR
X-Google-Smtp-Source: ABdhPJzGNSOJXqN50yb07YwZnVC2cP5SsfC99SXfdQo6vEd7yudKDXTm3pGqu7xoqaaFq+9k+rCviA==
X-Received: by 2002:a63:1e5a:: with SMTP id p26mr4927209pgm.85.1602277325263;
        Fri, 09 Oct 2020 14:02:05 -0700 (PDT)
Received: from bhanumaiya-glaptop.hsd1.ca.comcast.net ([2601:646:9500:590:250:b6ff:fe8e:b459])
        by smtp.gmail.com with ESMTPSA id g1sm11744573pfm.124.2020.10.09.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 14:02:04 -0700 (PDT)
From:   Bhanu Prakash Maiya <bhanumaiya@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul E Rangel <rrangel@chromium.org>, devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Peers <epeers@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/2] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
Date:   Fri,  9 Oct 2020 14:01:55 -0700
Message-Id: <20201009132732.v6.2.I8d7530d8372e4ef298ddaaaad612a2cdd24ed93e@changeid>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201009132732.v6.1.Ic98067cd92a0b7fed9cd3dfb7b4e736e76551cda@changeid>
References: <20201009132732.v6.1.Ic98067cd92a0b7fed9cd3dfb7b4e736e76551cda@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible string in
Documentation/devicetree/bindings/mfd/google,cros-ec.yaml

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v6:
- No change

Changes in v5:
- No change

Changes in v4:
- Changes in commit message.

Changes in v3:
- Rebased changes on google,cros-ec.yaml

Changes in v2:
- No change

 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 6a7279a85ec1c..552d1c9bf3de4 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -10,11 +10,12 @@ maintainers:
   - Benson Leung <bleung@chromium.org>
   - Enric Balletbo i Serra <enric.balletbo@collabora.com>
   - Guenter Roeck <groeck@chromium.org>
+  - Bhanu Prakash Maiya <bhanumaiya@chromium.org>
 
 description:
   Google's ChromeOS EC is a microcontroller which talks to the AP and
   implements various functions such as keyboard and battery charging.
-  The EC can be connected through various interfaces (I2C, SPI, and others)
+  The EC can be connected through various interfaces (I2C, SPI, UART and others)
   and the compatible string specifies which interface is being used.
 
 properties:
@@ -29,6 +30,9 @@ properties:
       - description:
           For implementations of the EC is connected through RPMSG.
         const: google,cros-ec-rpmsg
+      - description:
+          For implementations of the EC is connected through UART.
+        const: google,cros-ec-uart
 
   google,cros-ec-spi-pre-delay:
     description:
-- 
2.26.2

