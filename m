Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9762ECBB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAGI1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbhAGI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:27:44 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B2C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:27:04 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v19so4318389pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEpfUC6SSuCT9kZJdE2Ig06/CQbJ0RWivjJUsV8Lfw4=;
        b=keJrF5bJ/TAruJLytWQ5e4qbzCcZE4wqWogRJhz9KK6RehvGdGP37siDsg8IROV5ue
         GWOoANiKd1b7dVNcfN9sLFf6eJHhOe/SNYlei2d3rapZBNLYd3IBPZFeq3zf52VcYW8J
         AMiVHEC29PKd/bWG1EpaOPVzUURnMOPHKNj5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEpfUC6SSuCT9kZJdE2Ig06/CQbJ0RWivjJUsV8Lfw4=;
        b=LRg5h0PSy+AZRLteYSGnd9hVwXQIpaCbkFtU6NNybMidwpwNL8PmA75oArUFXUpZFY
         oizzhICNnKKJaG55RuzCFwUFfCaY9zCdoMQjuMPvk7Xh3dk7ganTlKmjDgbVt46G3LMY
         u4QlDUtS7uKGBj1IWnUpV91IO3r+8YniaVJJKEcTm1mZ00FMv9DkHiy4grpI/pw/MYNZ
         k8HbZzQN0ISSlmQkEV+NJGbsKUrzE8pTKSEPTvK1pWDHNDt6SGoVzESaYI0RwvUWXGfk
         nMLDyof0gR2TgnRVUQ2Q7MOUn9Tter1SBeAMMYXODpEOLj2EDWUh1U2Kd3hxgUzhPZYJ
         YIHw==
X-Gm-Message-State: AOAM5310k0S2KeYZcIGYQpUYIEWmLoMg5eq95XI+mcxi8LdZLyMicOyO
        H2F+FY/IQIzjXwrYIar2WuGfNQ==
X-Google-Smtp-Source: ABdhPJzJschmke2ee3zxGdTwh3Txk5dMJ25wnI3dFDHvLFWeRJtUCGcJ5Xt19DXHGfLKgciROYSl/A==
X-Received: by 2002:a63:e151:: with SMTP id h17mr775830pgk.120.1610008023863;
        Thu, 07 Jan 2021 00:27:03 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id o14sm5825580pgr.44.2021.01.07.00.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 00:27:03 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hoegsberg@chromium.org, fshao@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v7 0/4] drm/panfrost: Add support for mt8183 GPU
Date:   Thu,  7 Jan 2021 16:26:49 +0800
Message-Id: <20210107082653.3519337-1-drinkcat@chromium.org>
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

Changes in v7:
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

