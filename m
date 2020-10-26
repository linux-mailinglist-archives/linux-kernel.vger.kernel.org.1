Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CAB298F16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781246AbgJZOT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:19:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53663 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781234AbgJZOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:19:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id d78so11834866wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=El9u2gx0cY8E5dk5vr+otYOVhv3UfwiT3Ot69QdQhlU=;
        b=Db3gnizCW/VQkOSs8aeOD0NxrO9VmMVr2LUbHAmPKG0/3Xfb3OHQncLEYrljyhDOzZ
         iCHX3oKR9WYHYWywsKkVDvZ2wtcJhk47cqz/rt9estyguD/HwYh5kGV8+pznNP4A50qy
         g8hz6ywjD185H5adqZW96eClNaNPs5uKeMpBPTP7TPTuql74VB8GZV6K4Vk7n2XfkeIh
         H8mOSjXNZ7NzziLbKHNzHTgEBRk9qvw7CxoMw2Qf1sjVgmnS0oYlX4CLBA5ry85MtWhU
         1jTcdFC425Z1VYdtqWnOsvujBiT1VtSydXbgmXx+BkbZCF8j+RPWGxJAEaRxi5gZ7TAl
         8UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=El9u2gx0cY8E5dk5vr+otYOVhv3UfwiT3Ot69QdQhlU=;
        b=nJ8ZZMNyHTl2hh9wl7olpME+xNBtjselUt9R/Mi/kJlmfsDMdKkVTTgimwqn9wj7ho
         uPw/gYykWu+XJ+IEDL22l2xg9JEiz+Fv5WQj9Jm/LpORKWQ6bDex37I5DLRkVsejWt9Z
         uP198lBJJtlg+BWrjagU09p4541a7a8ykykA+P7jC/zYJy0fWK6WUtP2ZCu2AIskOULp
         x7ygmezmVOLa8cuCHAAcZikJTUNlbLMXf+U+IL0FHzxDUgJMt6ifNKNWw1RNmmwyLd9j
         oKiC8kyTc+LARcklvOGW5HAobY0yItDysRwsgOwxXfbzZdk6SH09V9/YRCxX/S1A+bYE
         eIZg==
X-Gm-Message-State: AOAM532s+cYshu1AfAzTPygLL7SCZK4+LjUFAYVYbl6GYTm9dpmpWUuQ
        tdQ0SzdkY+Wq3Y+aHNaYsoBIoWyLp2Ubtg==
X-Google-Smtp-Source: ABdhPJzbH0P3E8eXb+xShrA9atwUMxNJnLkxwBqG4wEzCSmJ1lgdG1VKIKfuTvw93CNDLLlvgTS7RA==
X-Received: by 2002:a1c:3882:: with SMTP id f124mr15720521wma.184.1603721993120;
        Mon, 26 Oct 2020 07:19:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g4sm20253333wmh.13.2020.10.26.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:19:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 0/6] ASoC: codecs: add support for LPASS Codec macros
Date:   Mon, 26 Oct 2020 14:19:39 +0000
Message-Id: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
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

yaml bindings depend on gfm headers from "clk: qcom : add sm8250 LPASS GFM drivers"
patches posted at
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2352255.html

Thanks,
srini

Srinivas Kandagatla (6):
  ASoC: qcom: dt-bindings: add bindings for lpass wsa macro codec
  ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro
  ASoC: codecs: lpass-wsa-macro: add dapm widgets and route
  ASoC: qcom: dt-bindings: add bindings for lpass va macro codec
  ASoC: codecs: lpass-va-macro: Add support to VA Macro
  ASoC: codecs: lpass-va-macro: add dapm widgets and routes

 .../bindings/sound/qcom,lpass-va-macro.yaml   |   68 +
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  |   70 +
 sound/soc/codecs/Kconfig                      |    8 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/lpass-va-macro.c             | 1500 ++++++++++
 sound/soc/codecs/lpass-wsa-macro.c            | 2503 +++++++++++++++++
 sound/soc/codecs/lpass-wsa-macro.h            |   15 +
 7 files changed, 4168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
 create mode 100644 sound/soc/codecs/lpass-va-macro.c
 create mode 100644 sound/soc/codecs/lpass-wsa-macro.c
 create mode 100644 sound/soc/codecs/lpass-wsa-macro.h

-- 
2.21.0

