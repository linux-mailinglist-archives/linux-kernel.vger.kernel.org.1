Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B471E2A7D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgKELhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKELfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:35:03 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46006C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:35:03 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so1352012wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvjCkKngYE2d+J4nil/WpI1yvSfXYpPNmzvk7VIM7Sw=;
        b=QX1pqLElgUOAMv3Vji4ojrlU2MCamjPnkC2TLxIw7ymKBnAlNQ2GiLy+ud3BYdAuAa
         ocf51mlfgPoZATNohh2GOiXRngkriA8NNct+tRuSrH1KL3Rd2Pn8v37gTg0Zx7fiRG+G
         Hoh+s7NpMQvxVcl2behW8dH5fOlbiiznqq7f/HfAXElR8LHIkgEnx4bCGRmKU+urIrum
         K7NFphwfZ5+k6xfjiaX6FPcpod+xFX+z/r8s4OHEWzTkEk5BIMUWdAZMD6xRgxHhN2bP
         IdgFW6t/l4AGlT76W9yj9ZpdpBpG+BaeK/6hNNbrZZd+/WNTZxQ28FT9v751Lqup53mq
         vu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvjCkKngYE2d+J4nil/WpI1yvSfXYpPNmzvk7VIM7Sw=;
        b=aXNUYpu6o8CkGf9F5jyGMJ2Bt5N6iWUUSKmXGuTN8bQafdN1QDRdOmnlEFIVWkuks2
         jC0HSR9PRPYEtSXti+CKPgZ5C3ZVpUUYbuJUk1xL+gkZwHlwvf+zufYlFPHQecn+tc35
         8UT6mvsHTW75win6T13WSRHxWykSczkjnTYOQe6Y8Q7lm7YSgDyyRmnTXK821T2Vaa0/
         otGjvNPhOa8NaTkvk0ujQcVo5ouQ398FtXMeU7azNq0yilHdnGqIWwFoUnzqZ6nH+o8h
         jaAHG7mNPoe+/ASZHHbLgaWRRm31zYDajra4ABS31GlzgA1ob7ATU+bOoKr74xqsjEZP
         586w==
X-Gm-Message-State: AOAM532H8QoclcV+8AOHQmZM4uRtcxpnIQZPtSj1i4I24DHKp290emFz
        NgsvESLZr+nEcyF14jTiDKZVqA==
X-Google-Smtp-Source: ABdhPJwAMtjK3f6sLO7RWDc74aAw55duLeGvZmuy2Y1/1dYh1n/xoa8FcVogHR4NqV8ZezLc5XT5Hw==
X-Received: by 2002:a5d:4148:: with SMTP id c8mr2339688wrq.261.1604576101950;
        Thu, 05 Nov 2020 03:35:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t199sm2096129wmt.46.2020.11.05.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:35:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/6] ASoC: codecs: add support for LPASS Codec macros
Date:   Thu,  5 Nov 2020 11:34:52 +0000
Message-Id: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for two Codec Macro blocks( WSA and VA) available in
Qualcomm LPASS (Low Power Audio SubSystem).

There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
has specific connectivity like WSA Macros are intended to connect
to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
and TX/RX for Analog codecs via SoundWire like other WCD Codecs to provide
headphone/ear/lineout etc ..

Most of the work is derived from downstream Qualcomm kernels.
Credits to various Qualcomm authors from Patrick Lai's team who have
contributed to this code.

This patchset has been tested on support to Qualcomm Robotics RB5 Development
Kit based on QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers
with onboard DMIC connected to internal LPASS codec via WSA  and VA macros
respectively.

Thanks,
srini

-Changes since v2:
 - various unnecessary variable intializations removed, suggested by Pierre
 - fixed a static checker error
 - collected reviews for dt-bindings.
 - fixed licence headers as suggested by Pierre.

Srinivas Kandagatla (6):
  ASoC: qcom: dt-bindings: add bindings for lpass wsa macro codec
  ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro
  ASoC: codecs: lpass-wsa-macro: add dapm widgets and route
  ASoC: qcom: dt-bindings: add bindings for lpass va macro codec
  ASoC: codecs: lpass-va-macro: Add support to VA Macro
  ASoC: codecs: lpass-va-macro: add dapm widgets and routes

 .../bindings/sound/qcom,lpass-va-macro.yaml   |   67 +
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  |   69 +
 sound/soc/codecs/Kconfig                      |    8 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/lpass-va-macro.c             | 1503 ++++++++++
 sound/soc/codecs/lpass-wsa-macro.c            | 2464 +++++++++++++++++
 sound/soc/codecs/lpass-wsa-macro.h            |   17 +
 7 files changed, 4132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-va-macro.c
 create mode 100644 sound/soc/codecs/lpass-wsa-macro.c
 create mode 100644 sound/soc/codecs/lpass-wsa-macro.h

-- 
2.21.0

