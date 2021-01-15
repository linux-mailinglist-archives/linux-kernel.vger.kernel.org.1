Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719FA2F81A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbhAORI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbhAORIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:08:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75415C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:07:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q20so5871570pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce9A9/dLv0m6Zp/SyWS0p9guPfLPVRj4uQgZkwowJ1A=;
        b=Ate+i82+F+imnngQ4V7Y09Yeu8atYGV6ifCMsBp6Nm2KnSIu+W739IS42Hs6ehTQPI
         ehbs/wzbg2plOmg2hXIhq1yOC+y8heOC5f1i50AlyoAkLwjYED/YgSz3NVaUjxKczEJi
         e86j9DF5TA/a36SvsqtPAyjsoWAV/RJTF/UdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce9A9/dLv0m6Zp/SyWS0p9guPfLPVRj4uQgZkwowJ1A=;
        b=JTHXvaV4ekj+ao6dmy8IPFxLsWJeGo8TYFKamvJ/LrCLdpmkPcuyziAGi1aIo2IPeQ
         fDyhTQAJ8j7ZN97td250GRJzeBsy5Ianj+MLuVaGNCZqja15om+CRH2hR+Y1vtlkUjXz
         lQ24sh6x14ZAIQBIQLOq2wE1uXPFcQ8WjyDUbJfMjz+YI5Mmxyfh+eL9UJk8aVW3x4Lu
         nzKrQWLVBBCmOtbKdGkQE9G16PMsXcqNncPmY6sy/sLg088YDzdB5biSnIUJkwucBoGt
         XA4zvETS24Ce3z3NQRBbb3/jQ6y4u1SoUnnE9OGgMnm8IyhAwmR4xQ/DsWOV9nmr8MiM
         rxdg==
X-Gm-Message-State: AOAM532Qy0fygo5ooljMeLE2b/PqzQwrdjW/SJzrN4WuF+MS5sfpYsFe
        Gi6pe1pBBOt8k79M2J4PPTCFJg==
X-Google-Smtp-Source: ABdhPJxJc+7oHOnHjGS+7suuP+m/EdlkanS22qwCz2ATpSKmRNsaKN6r7dCHCQFE2jlA8SRYnOu8NA==
X-Received: by 2002:a65:4549:: with SMTP id x9mr13680927pgr.6.1610730429026;
        Fri, 15 Jan 2021 09:07:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id t23sm8813329pfc.0.2021.01.15.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:07:08 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     swboyd@chromium.org, linux-input@vger.kernel.org,
        hdegoede@redhat.com, andrea@borgia.bo.it,
        kai.heng.feng@canonical.com, robh+dt@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Li Yang <leoyang.li@nxp.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/4] arm64: defconfig: Update config names for i2c-hid rejigger
Date:   Fri, 15 Jan 2021 09:06:38 -0800
Message-Id: <20210115090518.v9.2.Ic9788bdfc4cce7569f8d25e7fb52a208fb643eac@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115170641.903392-1-dianders@chromium.org>
References: <20210115170641.903392-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-hid driver has been split in two.  Let's enable both halves.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---

(no changes since v4)

Changes in v4:
- ("arm64: defconfig: Update config names for i2c-hid rejigger") new for v4.

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 838301650a79..326198305beb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -749,7 +749,8 @@ CONFIG_SND_SOC_WM8904=m
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
2.30.0.284.gd98b1dd5eaa7-goog

