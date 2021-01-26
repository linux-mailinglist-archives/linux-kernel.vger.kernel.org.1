Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33F30314E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbhAZBc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbhAZBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:30:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0EFC061D7E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:18:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kx7so706276pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWbVQO5R0FpQjPeleTL5ZQxXMwOKE8gz64YVQB09gIE=;
        b=M8/QV0mlc2v2R8DUyzcSmv2ah8W3t/Zyct7N54o+QNG5dYc72k3Goi4nwckpZUxBKY
         OLzUjzQ069Xg0Mwox3AdKaNd2sH8efxb8MswfwAeVssIrhd+5npraQUBmohEdUUtPBi+
         tnkK7aKAGBIFCJRX+MW31GV68uGwQMAPlaYME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWbVQO5R0FpQjPeleTL5ZQxXMwOKE8gz64YVQB09gIE=;
        b=JctyLGLrSJInia/sVIraDbyPgL9IJ8h2seKekYrNKxhoIs9R12HlF68l2lJri3jQ+1
         6QmkDjuM4s2NS+mwWgkrq6x1qUPGQlN9l1vNEXPP2C5k4AiP832hMY1hkcPfcbD2FOxL
         ljWB6UGZ8EcPTW8zC32ppdTe4smDEQYJ7S0+t8NgdFnHICOP5WNYZOOAv3o2mth1WKbC
         tlb3QUeLxiYYupiS/Ncn+dh47BOubw2Q/tJzeUP5vRaQ4QL/MrtwcQil/1Z36O/fLpNo
         1ixjybo7v0Yp3RGzdiGDwYGgxGEnaBHzrVZkPZ5Hy0lRqKS7SyzsBH1vx8MmZH3v1/B+
         5tbQ==
X-Gm-Message-State: AOAM5335FhUewjRyxt32FdeCpdOVS6zLipc35b+eSxDlEjPh67eOlRu/
        krQiQxWl7/qS/25/I0FO5j4sGQ==
X-Google-Smtp-Source: ABdhPJyjPaSweKNxNtO2gkziAaXPMrY4Rp0Kuls26ijdkAvAyf1Ku0oC++DgRuy/WatKIEzuLxGMZA==
X-Received: by 2002:a17:90a:d255:: with SMTP id o21mr3117952pjw.151.1611623889956;
        Mon, 25 Jan 2021 17:18:09 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:50cc:9282:4fdd:3979])
        by smtp.gmail.com with ESMTPSA id k9sm522248pji.8.2021.01.25.17.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:18:09 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        hoegsberg@chromium.org, boris.brezillon@collabora.com,
        hsinyi@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v11 0/4] drm/panfrost: Add support for mt8183 GPU
Date:   Tue, 26 Jan 2021 09:17:55 +0800
Message-Id: <20210126011759.1605641-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
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

Changes in v11:
 - binding: power-domain-names not power-domainS-names
 - mt8183*.dts: remove incorrect supply-names

Changes in v10:
 - Fix the binding to make sure sram-supply property can be provided.

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
 - Add gpu regulators to kukui dtsi as well.
 - Power domains are now attached to spm, not scpsys
 - Drop R-B.
 - devfreq: New change
 - Context conflicts, reflow the code.
 - Use ARRAY_SIZE for power domains too.

Changes in v5:
 - Rename "2d" power domain to "core2"
 - Rename "2d" power domain to "core2" (keep R-B again).
 - Change power domain name from 2d to core2.

Changes in v4:
 - Add power-domain-names description
   (kept Alyssa's reviewed-by as the change is minor)
 - Add power-domain-names to describe the 3 domains.
   (kept Alyssa's reviewed-by as the change is minor)
 - Add power domain names.

Changes in v3:
 - Match mt8183-mali instead of bifrost, as we require special
   handling for the 2 regulators and 3 power domains.

Changes in v2:
 - Use sram instead of mali_sram as SRAM supply name.
 - Rename mali@ to gpu@.

Nicolas Boichat (4):
  dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
  arm64: dts: mt8183: Add node for the Mali GPU
  drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
  drm/panfrost: Add mt8183-mali compatible string

 .../bindings/gpu/arm,mali-bifrost.yaml        |  28 +++++
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   5 +
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   5 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |   9 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  10 ++
 6 files changed, 162 insertions(+)

-- 
2.30.0.280.ga3ce27912f-goog

