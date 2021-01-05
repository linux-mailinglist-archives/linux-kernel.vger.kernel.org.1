Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8E2EA155
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbhAEAMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhAEAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:12:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC088C061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:11:36 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w6so17385582pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/v77AqgrMzkwzQQTGKpTGxdqW9oGp5KYpVYy7kh1q4=;
        b=Sh2QNYnFVLm66LLE/NRrCsYm6K+V7cqxcLXJQdK0nbWRlyqnPhKNJCd+VP46gGIAew
         Z6SJrMwpH6av/bcG2c2k4AVBZnuOn3O8+pYRFTgPQMQYmNOqjvnq4zphPGnzWJTFNUv4
         QDDKcIKA5illa9p9/gBciNAIE4PQa1+a+IQ90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/v77AqgrMzkwzQQTGKpTGxdqW9oGp5KYpVYy7kh1q4=;
        b=io9T9dQXLlReXWVrH9rN56mUtzNP6+V9mvlxH6xmEcllu6r6c7O3Lctse80axJk+1L
         RZ+p1Q8yuzM17oAbXeukCnFnYpmqrMG9dE78Kt2bVnBvAflCMJimEe4n0EsyH0fKtDBK
         dBgOhBtrt7UQsL6S4FqQvDruulXvqfqnNktT/OQboAsI8nHI65+JU5UIrkjm2kEvJ50F
         YD+r6hAj/vYchBYhYSCQYljpc7F+GFGrJ19sLnbyy23VWUv8VVt1a6gE6hQM8FlDo3WZ
         ZF7sr21e8uXl9qTir7ZfnsGzBpsIWla1p7p8R/uDTGM7VJOwF8CW50USlM9zjVL4JhNe
         HLuA==
X-Gm-Message-State: AOAM5302jmQLuHXVGFoTDvixENdIL1PIlExrW7JbqZwQQblylyvQWuwb
        LOiQcJlqn7IyWUYiBGOhTrBcbA==
X-Google-Smtp-Source: ABdhPJxkNI6YhhXcss6CNMdwQnCEzvBGE+2IcCkAaUXDa0sz0L8xl9gQxdRMrsz7vQxZJMP+MP9oAA==
X-Received: by 2002:a05:6a00:212a:b029:1a8:6d7b:d62e with SMTP id n10-20020a056a00212ab02901a86d7bd62emr67292556pfj.23.1609805496547;
        Mon, 04 Jan 2021 16:11:36 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id bf3sm465620pjb.45.2021.01.04.16.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 16:11:35 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hsinyi@chromium.org, hoegsberg@chromium.org, fshao@chromium.org,
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
Subject: [PATCH v6 0/4] drm/panfrost: Add support for mt8183 GPU
Date:   Tue,  5 Jan 2021 08:11:15 +0800
Message-Id: <20210105001119.2129559-1-drinkcat@chromium.org>
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

