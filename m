Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3092C4E28
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 06:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbgKZFEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 00:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgKZFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 00:04:48 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18EC0613D4;
        Wed, 25 Nov 2020 21:04:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so679652wrw.10;
        Wed, 25 Nov 2020 21:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DZ3C1e84Q51GI7F4JZus9ZaT3v1v7zEgkxNXr+KQkIE=;
        b=qRzUAnvibDyG1v45yf4awEtyY4M41A1MkQvjh3IiaHm+2w0hZLnJ406gnL9qRv2nwh
         dtXk4A419YSZPrmyX13LGf0PkqKD/YwSwKPhq9zFHUREGjcWW6eEtkqOozWWLlOKCz/b
         SZHJOPFySoJLdh2n9e67pnJVxx2uk1yia5p010gZjVvN2i7+qHv5OJqauT1m3iqL+kqM
         f47A7pcFyA6E/MqszVcNCjYfGWc+FeuCmWEm6dNWjNcDhJoo6QPpn7fC29253t7c/g+k
         IQPA9go7CL940ZApPEhwZfpA3WjHhfLRoJdXwXRjdSC3vNowmal/p+0aHMAb7CNl03re
         j0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DZ3C1e84Q51GI7F4JZus9ZaT3v1v7zEgkxNXr+KQkIE=;
        b=nbk7kMS8pww8zaLJhYRzF49+GkzuBEDWYzr7lm67PcCgG5pkb4H0nz4NCQJUFQqna6
         eBalFthpQWHS9qK94xS/a+7Nn+lsYzbHHYIGGwgh7jYezNWmtrsJlgzbmsmC4Pr7eZF+
         WArKb0pyyJA1pkWs2rwwZZS99DAezxnqViVpUOE1m8zUT/BrAhJrmP91a/0XHgOGL5qf
         quH2Vbyjz9u62h63W7Dp/8XSSNRoVifubgDm3WVv0D2Ye3WfTXgO3uePKH/a1mZ4fbGs
         +At2aEye1TVvW4HC49CpEyJoo1jG59/SQRrt0snKMa2pua0rZIXMvZUJG6b9yt4vhQZd
         KO4w==
X-Gm-Message-State: AOAM5300KhypFpp2JR3pvNXdRAY5/QIcy68yENpEcL6NIwTRJ6TIUOlQ
        v+g2+1Vi2gp286nlNJC4S1I=
X-Google-Smtp-Source: ABdhPJz5FV82f9hJOxdF8i2ckFRs3psGrGy50FNjKBTIMkp+fjjqtzNm8ST5kzQ7r7KGx185ANvUrQ==
X-Received: by 2002:adf:e444:: with SMTP id t4mr1493356wrm.152.1606367085211;
        Wed, 25 Nov 2020 21:04:45 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g186sm7625369wmf.2.2020.11.25.21.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 21:04:44 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add KHAMSIN IR remote node to SML5442TW
Date:   Thu, 26 Nov 2020 05:04:40 +0000
Message-Id: <20201126050440.6273-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the IR keymap to the KHAMSIN remote shipped with the SML5442TW.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
The rc-khamsin keymap is queued (or in the process of being picked) via the
media tree [0] so it would be nice to add this within the 5.11 cycle.

[0] https://patchwork.linuxtv.org/project/linux-media/patch/20201125161413.GA915@gofer.mess.org/

 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
index 0b95e9ecbef0..ad6d72254150 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
@@ -63,6 +63,10 @@
 	pinctrl-names = "default";
 };
 
+&ir {
+        linux,rc-map-name = "rc-khamsin";
+};
+
 /* This is connected to the Bluetooth module: */
 &uart_A {
 	status = "okay";
-- 
2.17.1

