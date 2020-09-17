Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60C526D410
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIQHBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:00:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:00:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so806694wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYO9vI1jssWFcgU0C4Kub0Gl3FwLz/cFiMnc7N/ZW8M=;
        b=wifFBUQy+ttQ5Td1dl7VKNfBfS1AhjM4edEBr+Q8ZvPNeGybfd68skZoMlLwAwzCSX
         B+QDjxln57NaBDmolZ1oCx7SocjTeiAQtD1oB+9nEzpZZd0cOZXeNJZEthygcKm9EuvT
         nrB1dQzYuhUPHy6+TGWhs/vyWQ46B/pXi2M3OUT/7JAnIkmjvp/EIEkZlWJ0sN4ymo/n
         dXYbGHzg2ou8am6oaD6a5FwA3mkN6e0DPLXYtJnF73U2hIkwBPjk8YGSoJDVvRN+kxgo
         El7B8mMDQMuBn7+eD7ogF6WajlCFtRgnXpAzrDj4BenoFMA4FzNFvH5JLpjf6THsji6b
         U+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYO9vI1jssWFcgU0C4Kub0Gl3FwLz/cFiMnc7N/ZW8M=;
        b=dIfJRNv5suQTA3LbTrUKUgAbpQOkwNVw8zsBFhMqGa/oIEJuEmAG+/90VEfaGEf5Tq
         Tub+AANzHNqcyqcBaJKZYO1H9TOFHqFl+DlXzmEefVWOAaQlrYG89a0hv9lvcSSSyKnp
         vF75gXpERIJ1cWA1PaOThaR9O4MV8ndoZPFfUCLapn9CAYYDWlcjxx/KBIxpXk2xiEdl
         8N8zsbRw/luzInSOD0gdnOSoZLGtlATqNT1x43ulqhMlCitd22bV4zJ7+a79r7a0N1ra
         qw2AzDL1nUGUR1nnKH6qBsLdTiLMBhvPFRsrEeD7KNVNumoI/uMSFaqREojHXT+zcBH3
         VSYw==
X-Gm-Message-State: AOAM533L2vX05jTkTc6iBQxQxhdG00lhqoHTLqFu0vj8wrWtlN/qtXbz
        3UOntFXd+jKjw6G1P0QkF4tteM6WCE9lhlVd
X-Google-Smtp-Source: ABdhPJz8bKW3OvFfUb/6QzuoM+0dCijwwS3cJjUsFtm6QbvCnlA4iVmILfLpLhYU5ZyBMa9zQTuP9w==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr30942832wrn.228.1600325998448;
        Wed, 16 Sep 2020 23:59:58 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm35709055wrh.14.2020.09.16.23.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:59:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, kishon@ti.com, balbi@kernel.org,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 0/5] usb: dwc-meson-g12a: Add support for USB on S400 board
Date:   Thu, 17 Sep 2020 08:59:44 +0200
Message-Id: <20200917065949.3476-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG is close to the GXL Glue but with a single OTG PHY.

It needs the same init sequence as GXL & GXM, but it seems it doesn't need
the host disconnect bit.

The Glue driver reuses the already implemented GXL & GXM work.

The USB2 PHY driver needs a slight tweak to keep the OTG detection working.

Changes since v1 at [1]:
- s/close from/close to/g
- collected review tags
- added small comment about phy management in patch 3
- removed status = "okay" in patch 4
- removed invalid phy-supply of phy1 in patch 5

[1] http://lore.kernel.org/r/20200909160409.8678-1-narmstrong@baylibre.com

Neil Armstrong (5):
  phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode
  dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG
    Families USB Glue Bindings
  usb: dwc-meson-g12a: Add support for USB on AXG SoCs
  arm64: dts: meson-axg: add USB nodes
  arm64: dts: meson-axg-s400: enable USB OTG

 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 +++++++-
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  6 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 50 +++++++++++++++++++
 drivers/phy/amlogic/phy-meson-gxl-usb2.c      |  3 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 18 +++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.22.0

