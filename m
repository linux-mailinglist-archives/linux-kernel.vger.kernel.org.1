Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4B62A5BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgKDBaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgKDB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:29:57 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B6C040203
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 17:29:57 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b19so9495364pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 17:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgDlplmO0Msbik3z5vTVjN1E4quCfRMMBpL+KTr25PE=;
        b=Zt9MbPmsEHVHV6S7xiURQ05j6H6oZb9t4va0Hl18IRw48r2ZXQyhm2myXnG+NiUjin
         GftKKcw8CCNex98Rle/3l2S+URN7TLWgz9fw4gOiueL8lcCGuykF2uhNBrJ8on74v8JX
         75gLRCnaGa9JzLc0ANtBd936iSCM8DRrsPEsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgDlplmO0Msbik3z5vTVjN1E4quCfRMMBpL+KTr25PE=;
        b=X982cwUhvPjIMjQmRlc7Hbio7QV8fYrEMHltopMltDuEPv4zNtBTCH8y5Q+YLXl+Pk
         XWwa0fKt5DfaIF1zOskTj1HJ86x6etBVjQeWA143R7hcjj37iiq9D44Ycdm9ynVXGDgf
         iSdem2rSp/3zF0Zq/I+gU6lNe4xFHk8nyWI7RrVx46VV1RWgp4Xu7fd6y857FifM+ywm
         Bze1fjxQoA54DTTjuTfaRkr2CSgtiKxstEGTjMJNM9F3h1pdZ7Y0In/BIJ6EUYrzqUFB
         vsCOvB+fqlelDyVmpha//w2auglBhXyurkdSlztoKRQdJpYjHtdxrveVOW5qSMEHqBMS
         dyvg==
X-Gm-Message-State: AOAM530cyHFYCpmw2xy7eD/Z/AatRCb75Wr4u/20GvfPSMmKncDly6nK
        smqrZJ+myQz2xMliGtviVJ1Npw==
X-Google-Smtp-Source: ABdhPJw0uW6TH0eF/XsK/zaRgUECd0eDpdpxV/5ZKgCN6JZE4Ho0SvtQIibzu/oSTtDUMnCFmTdZtw==
X-Received: by 2002:a17:902:fe18:b029:d6:991c:6379 with SMTP id g24-20020a170902fe18b02900d6991c6379mr23556067plj.20.1604453397380;
        Tue, 03 Nov 2020 17:29:57 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m3sm347424pjv.52.2020.11.03.17.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 17:29:56 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, swboyd@chromium.org,
        andrea@borgia.bo.it, kai.heng.feng@canonical.com,
        hdegoede@redhat.com, robh+dt@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] arm64: defconfig: Update config names for i2c-hid rejigger
Date:   Tue,  3 Nov 2020 17:29:27 -0800
Message-Id: <20201103172824.v4.2.Ic9788bdfc4cce7569f8d25e7fb52a208fb643eac@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104012929.3850691-1-dianders@chromium.org>
References: <20201104012929.3850691-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-hid driver has been split in two.  Let's enable both halves.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("arm64: defconfig: Update config names for i2c-hid rejigger") new for v4.

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf6f2ac..9258d623331e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -725,7 +725,8 @@ CONFIG_SND_SOC_WM8904=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
-CONFIG_I2C_HID=m
+CONFIG_I2C_HID_ACPI=m
+CONFIG_I2C_HID_OF=m
 CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-- 
2.29.1.341.ge80a0c044ae-goog

