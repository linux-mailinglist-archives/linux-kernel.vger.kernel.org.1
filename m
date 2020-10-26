Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B4298E43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780390AbgJZNlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:41:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43109 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775654AbgJZNlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:41:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so12593565wrp.10;
        Mon, 26 Oct 2020 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6ig/zuFGYK5p0hWRfkZP0StQyYJ9vBPAEaTb1VFLW0k=;
        b=mZ4vQMuOl9Sj2HHJt80Aan9NNJGvQuC0Dn7XBsEHgkdwXjDyOL80+aAze1WU16smab
         8FB+1aQHFm+NMARBSVpdGVa+rSIlFqqQE/YqJ0Fdfu/seO8GzF8kwQzSUOf7qZ9aXa5l
         v75AZcbl8fj3dNxPpc4hUex0JnX7bOWsKzNL+kVUw+3n8eCJgh2ECxgGWcGtemIbFl7r
         D/aOwCKSZ/maXWvzLFcre6K9vc72i0kUaRQM9NOq1q60//6iYL8YMT3nSLSe5tPjv259
         l5uSpUcflouEE8n40hJipsWufHhSb6ZC/T8xtZ/aBrH0lWi8HyqN0j6O8zTExZ3rEh1m
         dS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ig/zuFGYK5p0hWRfkZP0StQyYJ9vBPAEaTb1VFLW0k=;
        b=MJtz3AKGRZV7259jcfxgFVNSAVj8pvn51Pui/EtwnjHChIo30qb0dtt+yP6kNOzX8a
         e2ozzjlrFG0pecOUYesrgl+wQhLFMJ1gX/AWKN3AJnMnwJ88RT1HdFEwk+lRiIReoe4f
         UvwEQrs7+b+jet4lQQoRAXyzDDYCVd0K31DspZX+UQuzJtl1yKv9O6vbK+kpOJzbv/6j
         Cirr4P7yNIUvn5BNvTsXeLwNnQGt5yO+qwoXsoaXx4kEmSMurp5/eGoqv5lIoFPR+Tgq
         u6lSg6C4l6e35TI2vyNUJRfZnX1wbUZZpGBv7S+oH0sqT8Jmy1jcw5CITg5WU/fJhmeh
         ZG/g==
X-Gm-Message-State: AOAM5328rsq/UsxNBdeSevv1qEg7AcdtvWeocOqrYrchW4zIBu2WjfWc
        O3gDXQj8Ea5tU6l7sdm+NR0=
X-Google-Smtp-Source: ABdhPJyRAlNz7XRHfwdZyf/ZfYQ4mRtUc2hnTBcKVfMsne3We7JPpO++HsDFqyafwJokZO2KDhAZ/Q==
X-Received: by 2002:adf:f986:: with SMTP id f6mr19097577wrr.38.1603719666637;
        Mon, 26 Oct 2020 06:41:06 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id q2sm22780129wrw.40.2020.10.26.06.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:41:05 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: remove empty lines from aml-s905x-cc v2 dts
Date:   Mon, 26 Oct 2020 13:41:01 +0000
Message-Id: <20201026134101.10594-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 63fafc5a046b ("arm64: dts: meson: initial support for aml-s905x-cc v2")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts      | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 675eaa87963e..9a3c08e6e6cc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -84,7 +84,6 @@
 		regulator-always-on;
 	};
 
-
 	vcck: regulator-vcck {
 		compatible = "regulator-fixed";
 		regulator-name = "VCCK";
@@ -124,7 +123,6 @@
 		regulator-always-on;
 	};
 
-
 	vddio_card: regulator-vddio-card {
 		compatible = "regulator-gpio";
 		regulator-name = "VDDIO_CARD";
@@ -195,7 +193,6 @@
 	};
 };
 
-
 &aiu {
 	status = "okay";
 };
@@ -207,7 +204,6 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-
 &ethmac {
 	status = "okay";
 };
-- 
2.17.1

