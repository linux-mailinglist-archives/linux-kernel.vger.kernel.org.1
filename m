Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591542CC278
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgLBQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgLBQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:35:45 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B59C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:35:04 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so4716932wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxQYQF1LD7VCcsXVOlfezCcp9MbvQ1IvqiGH/jVfncA=;
        b=AB7jwyDcIJ8WIoS9hG0XuOZSAJlwzKFGEGaHT7shjySdMSSlXXcg3EiM78CcGK/a7b
         skCQQkUQUHxW05+5hR3TtT2QahmRmE9XrwLAqCnRSm7hUJ5fHUhD6H04epaMkb3Kic0/
         589tMeIRGUZ2bw5yBOl5cnTxRubWR7IWwotD4FkULg60eNNncaiN6pZcSEL4/bdrbuGB
         8B6XqOTluSYei6beJn1gfnp01kREIPfrA3dZ5ZQ05KbTtgIjsXpiGEQw/SJuqvrqHHyV
         RO0YYAJcOF1uEIvmysCLW8d5ojbe/c2ClViOj7Wq6j3JpANGBcmY3hIor84BnM1uhU1J
         j4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxQYQF1LD7VCcsXVOlfezCcp9MbvQ1IvqiGH/jVfncA=;
        b=b5SiaHxkFYwbPiR3FdFODRS6nwcF32Z6HKnow5QgZloUqAzSsp4udi6wp+i4TNGOeC
         4Inu0yr3SrLtB9CZdXJEp4eJogErbz1PQ6saw47xm/oVvFdwQVSx5ymm8hebK7tLuLWR
         mzPowCdsc7KRK7By9xqQ7aZyI/xXA0qgLUQqFQJZlETdviqEgs1FBqh6AodhG83q5t0T
         PV0oMy3lqKKBBrYnAptSOFx6tQ0CU4NX3w+/F0EYxJBeXttV8WHh/bXHSdrJYMvapkQf
         dPHdqvBrb6ABBakl2N3lr4O8vqy9SplVIve2pKG3XUN6nNl2Hig9dn47VgeF0ua7Y7Nk
         sLpA==
X-Gm-Message-State: AOAM533uCCFobDS2JN4yt+vYJl0erv1K1pxa7Hjh4YX9OBPgbgp63Ka3
        Tqiv/P4GOHh0OyY8Dy72FsO/hw==
X-Google-Smtp-Source: ABdhPJwpdk3b38oDk8xBk5tqbfTHdTdnAQk8e139jw0HXO9hDe5sXz3SQ/nKogQzYb81HO4winiL1g==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr4378035wru.422.1606926903076;
        Wed, 02 Dec 2020 08:35:03 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a21sm2443104wmb.38.2020.12.02.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:35:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linus.walleij@linaro.org, bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH v6 0/2] pinctrl: qcom: Add sm8250 lpass lpi pinctrl support
Date:   Wed,  2 Dec 2020 16:34:41 +0000
Message-Id: <20201202163443.26499-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the Noise, Resending this as previous one did not include Linus W email id!!

This patch adds support for LPASS (Low Power Audio SubSystem)
LPI (Low Power Island) pinctrl on SM8250.

This patch has been tested on support to Qualcomm Robotics RB5 Development
Kit based on QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers
with onboard DMIC connected to internal LPASS codec via WSA  and VA macros
respectively.

Most of the work is derived from downstream Qualcomm kernels.
Credits to various Qualcomm authors from Patrick Lai's team who have
contributed to this code.

Am guessing existing qcom folder should cover maintining this driver too!
If not I can send additional patch to consolidate this along with other
Audio related drivers in Maintainer file!

Changes since v5:
	- moved to use FIELD_* or u32_replace/encode apis where possible
	- remove all the SHIFT constants
	- updated function groups as suggested by Bjorn
	- updated setting slew rate as suggested by Bjorn

Srinivas Kandagatla (2):
  dt-bindings: pinctrl: qcom: Add sm8250 lpass lpi pinctrl bindings
  pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver

 .../pinctrl/qcom,lpass-lpi-pinctrl.yaml       | 130 ++++
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c      | 695 ++++++++++++++++++
 4 files changed, 834 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c

-- 
2.21.0

