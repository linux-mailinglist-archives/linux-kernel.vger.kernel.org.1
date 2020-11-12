Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA99C2AFF37
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgKLFdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgKLBnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:43:40 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28305C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:43:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z3so2991144pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7r8yua/nKCeK3vM5yetSQdGOYQSdaEZxJ+KcAFNDCGM=;
        b=TZVudu4Eom6x7eViMfrgwIEDTOwxuk2NwbzESK1osvd187h+LbGTwrmhIRjbga3l22
         KAR8+AStRi2/Tibs30YN0GLi7Pf862pd5ccdeLlUpB3Bp4BWCQPrlkdeMOUYOzn8oQdB
         Dgyky7EOJIFle0oRSOqIb9B0amhdlbHBFn9bpicdT/qN85/N2Gqx457Bxwip+etlgSNz
         32zuFh2WpV0C3UXX6SBQ+PReEDdctVNuOSgylG3X2iiHy3Y3rojlk0WUCOaJoLL22VxL
         lKxMn4BcJHF36botuq55UTLxM6JAJTfnp5klsBs4ATdtT47u/tKhX+M5DoG/UhBNr+S+
         oS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7r8yua/nKCeK3vM5yetSQdGOYQSdaEZxJ+KcAFNDCGM=;
        b=HetoiM87PuDfUByB+A82TEsviaNwSzCvlNvqWPfW7iw7ayAi3kn97VHKH9/le9M7OA
         j+lekhZ5UzKWkcA2XDBWawgIaKvTdbr6BM6TKGO+iH0/XCRtS0B+HZ2gYtidSX+/dPU3
         opfiqdHPLT4GhRD33j3Lpty/FATqGrA+o4Pv+lcEyqr8n/yQt87gqaITD/qs6CQqikUA
         oYKho/HnL1ROE1i09zoZdTd1epFXCqDwt4AiLTCvWv7I9N2G6wTB74dSkmLyDXms4JGq
         /XIw+Lk/EEAhrg9CWsYdbG3TEqYNChlibCOoT3NZqONR5Wu8nAI+y6x9yXdvQpqO80GA
         TWhA==
X-Gm-Message-State: AOAM533zHrNh52+Qy+v+VzuVy56AzkFPP/YkD9YZhRyfVQBjSx3axCz2
        8TaxgyjGahKTrnHYSp02dpwFO79YrnAtOQA=
X-Google-Smtp-Source: ABdhPJy0uKYvQY8jkl612KCh1Ww+d03+vAxg6dCvii/4V/9/OB17X7zWDzjpThierTZKqDWSxvuwCQ==
X-Received: by 2002:a17:90a:ca91:: with SMTP id y17mr6205555pjt.205.1605145419473;
        Wed, 11 Nov 2020 17:43:39 -0800 (PST)
Received: from xuyuqing-ZenBook-UX425JA-UX425JA.huaqin.com ([101.78.151.194])
        by smtp.gmail.com with ESMTPSA id m6sm4062413pfa.61.2020.11.11.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 17:43:38 -0800 (PST)
From:   xuyuqing <xuyuqing@huaqin.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org, cychiang@chromium.org,
        judyhsiao@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        zhouguohui@huaqin.corp-partner.google.com,
        xuyuqing@huaqin.corp-partner.google.com
Subject: [PATCH v2 0/2] Support SC7180 sound card variation without headset
Date:   Thu, 12 Nov 2020 09:43:26 +0800
Message-Id: <20201112014328.695232-1-xuyuqing@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use compatible string to let machine driver handle the case
where ALC5682 headset codec is replaced with ADAU7002 dmic codec

xuyuqing (2):
  ASoC: google: dt-bindings: add new compatible for sc7180-coachz
  ASoC: qcom: sc7180: Add machine driver for sound card

 .../bindings/sound/google,sc7180-trogdor.yaml |  4 +-
 sound/soc/qcom/Kconfig                        |  1 +
 sound/soc/qcom/sc7180.c                       | 86 ++++++++++++++++---
 3 files changed, 77 insertions(+), 14 deletions(-)

-- 
2.25.1

