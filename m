Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEAC2B736A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 02:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKRA7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKRA7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:59:08 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3667DC061A48
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:59:08 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so347310pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZiwxZqojFgPo5SsCHfj9x1Lcm6wX0ajQ1bLVVWx3jU=;
        b=ugCJDASvWGrjrU1UVd1kTuc8cB+gPeGsAKwTgHP8RzvZ0d6D/Pxx21h1wZ9Mp+0KsG
         +uWpI2aJ60/fEeEzI+J6ACWHKv2MbSBk8jalOWRY/q8erFFlS6t7zHdBkrLQqSxjJCzW
         +aOPdyQdKTLx3ry0J5m9p7c1Hb2If/PjwgPfdGCfbRJpREBw77df27MpbwuZWgjGYjIX
         I1WE5Aizi+Y5PSrmbANDMgyPT4JZAPKN65HApfP3EoAVN13k72QCGLAKFMyIgfW07Npf
         iAUfHAwR1boa5U8/DNAVA0dgBWGkdosCBjIdo4RjOrUovlQviOl2XLY+0xHLgRBf6Ffi
         RfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZiwxZqojFgPo5SsCHfj9x1Lcm6wX0ajQ1bLVVWx3jU=;
        b=md+m7dxsSS+Fg/IiJsOjrt7DM+EdrvJ8mBxajJlL4QJITrEtGuvs1WqWWtPx4HiC2k
         81yXGG7tGmQxjbVE7KrBGXl0U8akS5JWjD5NeejuTPtjSOUOFDHxNhV+US8mYk1flbYw
         H6ksAThVEVKlZLOFWCE3vot+FwEKlECBIhOfZPI88tpMCUvN5TgbOOZ2G3R5vPoHBHya
         2SRNw6CDTp3eH4JOeWG4BhnjIQ/HzloBtgRorqtbJgQLpf5XdWaxj8iXZJxOqPB1v9ev
         F9ocqgN4V3l/fHLRuTXzGKFZ++QUC7mLGNO7gtKNOI65rCV0JzEtTr01kMb70aSNbMaq
         iJUA==
X-Gm-Message-State: AOAM532Umu/iSAn16vArQntnBL9cum82QPbGpYAJiXg+UODcakvNukRt
        u80oslfu/gx8j+dZfF4oqWurw2h7kbYqLPA=
X-Google-Smtp-Source: ABdhPJxdQinxTZFO5n5EZ6IWDpmbfN2LzGmaJN6gn2i345FWRsV2HD3cz7OaPvnK63UNxoAFSui30Q==
X-Received: by 2002:a05:6a00:78d:b029:18b:f46:5262 with SMTP id g13-20020a056a00078db029018b0f465262mr2266304pfu.74.1605661147582;
        Tue, 17 Nov 2020 16:59:07 -0800 (PST)
Received: from xuyuqing-ZenBook-UX425JA-UX425JA.huaqin.com ([101.78.151.194])
        by smtp.gmail.com with ESMTPSA id y10sm307159pjm.34.2020.11.17.16.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 16:59:07 -0800 (PST)
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
Subject: [PATCH v1 0/1] Fix 32 bit format for adau7002
Date:   Wed, 18 Nov 2020 08:58:57 +0800
Message-Id: <20201118005858.123013-1-xuyuqing@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the microphone is attached to external codec(adau7002)
instead of rt5682.We need to always use 32 bit format on sc7180
to meet the clock requirement of adau7002:
The ADAU7002 requires a BCLK rate 
that is a minimum of 64× the LRCLK sample rate

xuyuqing (1):
  ASoC: qcom: sc7180: fix 32 bit format for adau7002

 sound/soc/qcom/sc7180.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1

