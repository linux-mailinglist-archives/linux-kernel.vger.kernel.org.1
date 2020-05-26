Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1251B16F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgDTU02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgDTU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:26:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE104C061A0C;
        Mon, 20 Apr 2020 13:26:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u13so13849211wrp.3;
        Mon, 20 Apr 2020 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m86kfkguQyuXw4Padwd/5nB4RFgQInyY94SnHr1Z+AI=;
        b=MNaaf1hFhkSNGsG0/WejBweFAMVqbFBOqTAhKWVbiIqSizUOwh+IXdBtBdMQOCBokB
         vv+yP9h2nNbyp6aTAwifzxnJbGPVJqTGq4LRcyJUWDGhz9jUEuWFbBWpcaXRNRmd/YMf
         RCs6t56EELxuk4xEKs+aqdw0M8QA2xnRRU28HKvQf1dqgCP3rcnFbrALfZGdQjgadPMw
         Uq6PKbW3wtfYIzF3QHPHCuvePPApbnd0V+z2ZGc4HpJ2tCq3EA0oAn/deiaC8+9KEanT
         iVDYBcvbxNT142KA+Mrwyo2m3kkBUAJ8vdFRnEFZlHAcHmM1Yfs1FE53iFsveq6S5GyB
         my8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m86kfkguQyuXw4Padwd/5nB4RFgQInyY94SnHr1Z+AI=;
        b=kbZ2Gy/qLbltHZx4u711Wx1zLoSo8oP96cfE67fsr5EEVBLNbPrOAvAdJ0EefV6iOJ
         AdjQvghnVXgKH/8XeEJWTve24CPfNPwDedYu7xJsESisSHbAPZeJQDiKPkblXqY7oRrN
         7oMxeR/r/JUvqnM7Y79uKfHzT8bsp18UiFWLBxxDJCmhYoocUz54hWIq4X260ngeNEWb
         J2DssGJic95xq+qO4ADUzCeiXpxnGt48NUiZaFS1BPdQ0s/H4Zghc3SmVp4Mg7/ApoQk
         pJqdgb9u2bb0bgP0Fj29UiqzTU0KTVDO+DeDY7ceSYMF1YAvFHUSczAy+P8/wucF7JdK
         g+rw==
X-Gm-Message-State: AGi0PuZSotbhQlPAWr4nEnCO+qTPFmQxxcXpgsvXILK2DvDiytXU/BbS
        XY2amK7YwW9dzmKVJZp/E0BE5FoZxTA=
X-Google-Smtp-Source: APiQypKTMMF9oO9FvAFJ4xYhaXCar71+2ejW0w10+TOcqLClxYzLCLiWyqCAI3/BWVAKJrMuDVhxew==
X-Received: by 2002:adf:ea44:: with SMTP id j4mr22176574wrn.38.1587414383380;
        Mon, 20 Apr 2020 13:26:23 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id l19sm657846wmj.14.2020.04.20.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:26:22 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/4] meson-ee-pwrc: support for Meson8/8b/8m2 and GX
Date:   Mon, 20 Apr 2020 22:26:08 +0200
Message-Id: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for all "older" SoCs to the meson-ee-pwrc
driver. I wanted to compare as much as I could between my Meson8b EC-100
(Endless Mini) and the Le Potato board so I added support for GXBB, GXL
and GXM as well as for the SoCs that I'm actually working on. I will
send the ARM64 dts patches once all of this is reviewed and merged.

I successfully tested the Meson8b part on EC-100 where u-boot does not
initialize the VPU controller. So this the board where I have been
struggling most.


Changes since v2 at [1]:
- don't remove the "reset-names" property from the main description
  (only make it optional and switch from items to minItems) to fix
  a dt_binding_check found by Rob (or his bot) - thanks and sorry!

Changes since v1 at [0]:
- rename PWRC_GXBB_ETH_ID to PWRC_GXBB_ETHERNET_MEM_ID. Spotted by
  Neil, thanks!
- update cover-letter since Neil confirmed (thanks!) that the "dvin"
  reset really belongs to the VPU on GXBB, GXL and GXM
- removed RFC status


[0] https://patchwork.kernel.org/cover/11489163/
[1] https://patchwork.kernel.org/cover/11496013/


Martin Blumenstingl (4):
  dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
  dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
  soc: amlogic: meson-ee-pwrc: add support for Meson8/Meson8b/Meson8m2
  soc: amlogic: meson-ee-pwrc: add support for the Meson GX SoCs

 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 102 +++++++++++++++---
 drivers/soc/amlogic/meson-ee-pwrc.c           |  98 ++++++++++++++++-
 include/dt-bindings/power/meson-gxbb-power.h  |  13 +++
 include/dt-bindings/power/meson8-power.h      |  13 +++
 4 files changed, 206 insertions(+), 20 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
 create mode 100644 include/dt-bindings/power/meson8-power.h

-- 
2.26.1

