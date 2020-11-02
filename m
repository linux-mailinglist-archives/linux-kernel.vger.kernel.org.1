Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B852A2CE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKBO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgKBOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:22:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFCFC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:22:33 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c18so9570711wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DY02pbxbUd8TTZ6XbSiEOVkNrUXbPl/uqGVBC2qraA=;
        b=S/8i09D8BZsdmiZrniZM41ImGRmw7GajJOj5OnYaktbEfMlXquSDREak0AAHxC7MbS
         pVrxYyPVIYDvhngZmlTQCOkTujsCbakX8Cq5THlWY6UKOvMOvTl+qMqQSkUipCcBjNS2
         +b1cKwL3cJTsx/OAYndiqUpPfHLTc0IULfFpH/ldLfqq3d+ZIiw4/fw4aQ8oT5jqWbFP
         QAF0yeZReQx1e2Kqt9Chby9KGcsF2JHVn4VRmcaiH6nwxrPspnDcr35PvMY/OfP0gy/1
         xENDQ0DTBIIZzY5YlHem0QpQwSPWJ2+TM4L8tDM3uNXIyGn8uq6YDL9+plDVPdp5+1rB
         fiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DY02pbxbUd8TTZ6XbSiEOVkNrUXbPl/uqGVBC2qraA=;
        b=PaOxR8jkBQzkDQwzAQtijfqGo2P5YtFP5W4BiG+2bgUM99911crIL+QfX5w2Q865hw
         /SOrB1L1CxH0klhu6lze1bqo4rOVhb4g+OJcIdBeaQc4Glo440NvDVXtueZo2C1Hg+/O
         5B4h0XjoOVzT6N56nkdpJX2TMFcnYC8I7FNhbvgi03BQa4QgDLHPbQ5C9my/YbRYc37H
         IiMU1+v+kQ4CMaVY5xRRc0W1NVsu3uIE4oPjAwhbKGwEUYuIchzXH2W2GWqNdS1emMrT
         6l5aoPezqSkONutV8viGOEbVULfrNm5jz2cq2YfiBQ8+jtftnAXcOWThwEsIFX+pAdGL
         hpvw==
X-Gm-Message-State: AOAM532xaecUqLmJ9mhhG1EeBNbIgzRYAMnQfcaYa+//6QSBfBa1+m4v
        5mJa8nzKSKGA29CZpaORsS69/Q==
X-Google-Smtp-Source: ABdhPJxlETx+w1GM/1vayA/BxsPU2jI0wkCtTj4UVee9cZz/598V0qnBRE/Hg/mGXgavdS+piRgqbg==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr17608439wme.18.1604326952106;
        Mon, 02 Nov 2020 06:22:32 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 3sm16182987wmd.19.2020.11.02.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:22:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/4] iio: adc: xilinx: use even more devres
Date:   Mon,  2 Nov 2020 15:22:24 +0100
Message-Id: <20201102142228.14949-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc: use
devm_krealloc()"). I noticed we can use even more devres helpers and entirely
drop the remove() callback.

v1 -> v2:
- squash three patches adding more devres calls into one for easier review
- don't insist on the 80 characters limit
- add a new helper: devm_krealloc_array() and use it

Bartosz Golaszewski (4):
  device: provide devm_krealloc_array()
  iio: adc: xilinx: use helper variable for &pdev->dev
  iio: adc: xilinx: use devm_krealloc_array() instead of kfree() +
    kcalloc()
  iio: adc: xilinx: use more devres helpers and remove remove()

 drivers/iio/adc/xilinx-xadc-core.c | 151 +++++++++++++----------------
 include/linux/device.h             |  11 +++
 2 files changed, 80 insertions(+), 82 deletions(-)

-- 
2.29.1

