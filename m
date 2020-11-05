Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46392A74E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgKEBcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKEBcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:32:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4EFC0613D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:32:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b3so60250pfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 17:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5SfGlFWNsb9ADFXTTd5FC+rkmT/cTom2Bm7AcT+oF8=;
        b=buWs2k7kpsMviHovMKSpLCqDOs6SSspYr+POlCcZ7cQ0RLP2IcZQh/mchBoF1vIjqU
         XbH06BRnoY7cKLtxQlq8dSNJ4yD5PKQ+xklQQFL7fwTDAmlGFD7Pg4ta4/E6Sw7jOIru
         EgWTEGUlrtTVhQ9MZF/wxYJwD0hrKrVgr4NeKq86ZNSDFBkgvmCkxgYqL8pgk7wBigcZ
         De4Dw0XZupQqdecbHJ6kZIxKEoyEPfqJxQPBL25HtJ/1kT6LaFrvSx1p8oJkkFojkCpZ
         3N/udwjp1efpDw15cSw6FwxDBDucXtNpsunEx8pwKMpNkfCl/ifbG8nYaFsZAXAGr4T1
         zYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5SfGlFWNsb9ADFXTTd5FC+rkmT/cTom2Bm7AcT+oF8=;
        b=FDXYRZcHzeU/o3ogBcRZo9Z65xEYhWE6JXXqgr6B5a7GvOgk6pPylkfRNopEnbIQpV
         SNJdwxBv3MO8FeP1/yZ4R9o/+fdJbShzS1j0XmkkFBCuhrk/kjH4wnI5NBZ2rXptl8DV
         WsGd26atIg7RhElBl9WsUjvW5NESJZqmpYr/K8EDCOdYQx/Qq75QcXaPmC5+viDJGpUO
         x9fbwC7pKx3TgDJ4doQhKZjWc1PAiVkPplQ/AENrtlMTQyh8MHy1SWvdMSmQQRpSOlmz
         IWBKmNcQ9KX68XxrMIx4756eeGoGiyXaYiUvEWYkrb33n2ixADpkuIHszthCnGoon5Cq
         IlcA==
X-Gm-Message-State: AOAM5322RQYRbKFfdPkeRLhJURMe0wokKSxcKW/aIPJgvodOAdfCmxm9
        ZgPu3zxxQtj8EOaB+7EaFppXqHwLJ+TDJzg=
X-Google-Smtp-Source: ABdhPJza8noyKK8dODD04Wm7xD5PY/AiLk1LSjeB9UKja7NAOYA1NN7BFuSWOkkkkCN+pBQTw5XSfg==
X-Received: by 2002:a62:8847:0:b029:15b:51c6:6a10 with SMTP id l68-20020a6288470000b029015b51c66a10mr207919pfd.69.1604539972308;
        Wed, 04 Nov 2020 17:32:52 -0800 (PST)
Received: from xuyuqing-ZenBook-UX425JA-UX425JA.huaqin.com ([101.78.151.194])
        by smtp.gmail.com with ESMTPSA id m13sm127817pjr.30.2020.11.04.17.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 17:32:51 -0800 (PST)
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
Subject: [PATCH v1 0/2] Support SC7180 sound card variation without headset
Date:   Thu,  5 Nov 2020 09:32:40 +0800
Message-Id: <20201105013242.298518-1-xuyuqing@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on patch

[v5,2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic

Use compatible string to let machine driver handle the case
where ALC5682 headset codec is replaced with ADAU7002 dmic codec

xuyuqing (2):
  ASoC: google: dt-bindings: add new compatible for sc7180-coachz
  ASoC: qcom: sc7180: Modify machine driver for adau7002

 .../bindings/sound/google,sc7180-trogdor.yaml |   4 +-
 sound/soc/qcom/Kconfig                        |   1 +
 sound/soc/qcom/sc7180.c                       | 119 ++++++++++++++++--
 3 files changed, 112 insertions(+), 12 deletions(-)

-- 
2.25.1

