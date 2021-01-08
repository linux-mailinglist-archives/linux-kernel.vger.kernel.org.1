Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1592EEABA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbhAHBK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbhAHBK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:10:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1B0C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:10:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p12so2752250pju.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rYVPFVXtXxwvNRbtCD49/nQPeoSTTbcvrlAIBfpayjY=;
        b=Vas4zMIdsNvM0u536DKqys62KF2xTfpQ0ZWY6fwnSuQw7fKhSWR1CI8VwUfSh8a2xf
         4S+xpJ6a+3l2mfJIeFOS8n0YOUme3v1Pi46O/BFdljtv5DjnTBvFTRSmXoJFKWSZZtb/
         najymQKiyfjs6S22oBZVuJfcoVijZPcdtb7io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rYVPFVXtXxwvNRbtCD49/nQPeoSTTbcvrlAIBfpayjY=;
        b=m1xn6Xk53/odK9udYJrhzqsRgdtjbVFgvTOtLxrStGJT3tfKRAM8P+/EF0mk+BRkCs
         aXLUUAOQnlUdm+lFWXNmwbg9+eMu8pfAtYjtsX0LZuSJXHN1oJJyFa51eDYhtivcEL6X
         1H5vKp4O8d8vyyLqmpfXtkHwa9aciw/cHdUCqXq16OFPnQ+HSnrp7Rf0gpv+zAidmpXL
         WJKlLaSmdEYGqhcp/uKhrhQu/u5ep/avM6b7eiTe8JCPnD5OVfcmI74fuwK72RAPvSzQ
         pjDuI0H2zVBHZe7Y1qK9YLx6YXGazgX87q114is1CSUtfypxXY3/pdunyaxzYDENk2a9
         XIGA==
X-Gm-Message-State: AOAM531Sae+AUF+aceo/9spYjucRxvKNE7Q6mBwXwFRCHl/OTL/HsPKZ
        CP/WKPy5lr3OklVGwPvVHDxTpw==
X-Google-Smtp-Source: ABdhPJywkmrUoz1GUuww7nlVAg7zrHLNiwitqiedS0hUNTEgnRVlRbzJl1+nrX5fUAnpxtQ9hvkRyA==
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr1139326pjz.73.1610068217903;
        Thu, 07 Jan 2021 17:10:17 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id s1sm6400083pfb.103.2021.01.07.17.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:10:17 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, hoegsberg@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v9 0/4] drm/panfrost: Add support for mt8183 GPU
Date:   Fri,  8 Jan 2021 09:10:07 +0800
Message-Id: <20210108011011.4061575-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Follow-up on the v5 [1], things have gotten significantly
better in the last 9 months, thanks to the efforts on Bifrost
support by the Collabora team (and probably others I'm not
aware of).

I've been testing this series on a MT8183/kukui device, with a
chromeos-5.10 kernel [2], and got basic Chromium OS UI up with
mesa 20.3.2 (lots of artifacts though).

devfreq is currently not supported, as we'll need:
 - Clock core support for switching the GPU core clock (see 2/4).
 - Platform-specific handling of the 2-regulator (see 3/4).

Since the latter is easy to detect, patch 3/4 just disables
devfreq if the more than one regulator is specified in the
compatible matching table.

[1] https://patchwork.kernel.org/project/linux-mediatek/cover/20200306041345.259332-1-drinkcat@chromium.org/
[2] https://crrev.com/c/2608070

Changes in v9:
 - Explain why devfreq needs to be disabled for GPUs with >1
   regulators.

Changes in v8:
 - Use DRM_DEV_INFO instead of ERROR

Changes in v7:
 - Fix GPU ID in commit message
 - Fix GPU ID in commit message

Changes in v6:
 - Rebased, actually tested with recent mesa driver.

Nicolas Boichat (4):
  dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
  arm64: dts: mt8183: Add node for the Mali GPU
  drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
  drm/panfrost: Add mt8183-mali compatible string

 .../bindings/gpu/arm,mali-bifrost.yaml        |  25 +++++
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   6 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   6 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   9 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  10 ++
 6 files changed, 161 insertions(+)

-- 
2.29.2.729.g45daf8777d-goog

