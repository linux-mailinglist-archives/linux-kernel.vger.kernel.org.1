Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD1224E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 04:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGSCOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgGSCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:14:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6073CC0619D2;
        Sat, 18 Jul 2020 19:14:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w3so21894379wmi.4;
        Sat, 18 Jul 2020 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EfRpQHmTESiZa6dhnw2iqpiFLGjitNFlRILsGoZarsc=;
        b=shJGdMFSrIFx2UkV3EqrEmoYnfAE0XXaMRbOkQJumHnk1GOebQDX58vtRnxNlPzAj+
         GXoI2yffkLZ8QVeGvMCoWtWwdPp1gOVxG7p4+Y65bCztkhNJpNA0+y2Nu4hL32LhI2CH
         dkqZR3UG3IJWShZKVD/41HMY8fR1ao/Kn4MYQ/PWkUCOuR1lKc0N0bQ8wQBvHtl8ZEr3
         rjP3QQN8TXokfi5uFsNngkjHGXh/pxZNzHXPjraVZS4o5QFar3tRMOkQDVqrH4pdFpho
         rnsmLwcClk2dUo3SwiLIPlXkEHgQsAaeneRs3VDzgjCgKD5/4y8WeaM+erM2hYcMbsML
         yD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EfRpQHmTESiZa6dhnw2iqpiFLGjitNFlRILsGoZarsc=;
        b=lDjeVgBN03IAuAx6n9amLZQuEpiGMl5bR6cG7Fta7bB97M9Y0nErYt+Xdz9HVgLw7a
         9dLeyMzN4ND52B/DhM56L1wkMi/M9Ns3uzOCdbY3togTf/N3BBCLxYBkmK1ht1xLXkyg
         4PfbzQiu/CbLc9YJ1SM0iMBwQr7ErTZVAjIBUwAJkGZd0H1rr3SdOsF9BQiFuoRR1e0h
         ymLVJxx4t/zyF1TYKpbEwzX6ynfHifV+/0F9Lk3qO3acqfdYC+a+Qgh1JbWMZbsL+o7c
         Ro/mV5UVswlFiSMwEiamNZJOzKegyQS5IdWfkOP3tPinH3V2bh2MZkxdghtfU5/7mq6m
         an/w==
X-Gm-Message-State: AOAM532zQPO3BKUv0eTLiUwK9iVY2nC375jgOwBDnzU0so+6vY371v6t
        6m8danxIbvTdanwipEYV5oU=
X-Google-Smtp-Source: ABdhPJwbx7zQAyjjmZbD7WUHvgisDzdZUs/ei6PvMfz/Lj+pHUKEG43rF9MZT7hZxXK/oQbf7Fhv0g==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr14656801wmj.80.1595124868889;
        Sat, 18 Jul 2020 19:14:28 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id v15sm22078103wmh.24.2020.07.18.19.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 19:14:28 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: add support for the WeTek Core 2
Date:   Sun, 19 Jul 2020 02:14:20 +0000
Message-Id: <20200719021421.7959-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719021421.7959-1-christianshewitt@gmail.com>
References: <20200719021421.7959-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WeTek Core 2 is a commercial Android device based on the Amlogic Q200
reference design using the S912-H chipset. Specs:

3GB DDR3 RAM
32GB eMMC storage
10/100 Ethernet using Realtek RTL8152 (internal USB)
802.11 a/b/g/n/ac + BT 4.1 sdio wireless module (AP6356S)
2x single colour LEDs to indicate power
1x power button
1x reset button on the underside of the box
HDMI 2.0 (4k@60p) video
Composite video + 2-channel audio output on 3.5mm jack
S/PDIF audio output
2x USB 2.0 ports
1x USB OTG port (internal)
1x micro SD card slot
UART pins (internal)
IR Sensor

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 378229fa8310..5eba9f48823e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -121,6 +121,7 @@ properties:
               - libretech,aml-s912-pc
               - nexbox,a1
               - tronsmart,vega-s96
+              - wetek,core2
           - const: amlogic,s912
           - const: amlogic,meson-gxm
 
-- 
2.17.1

