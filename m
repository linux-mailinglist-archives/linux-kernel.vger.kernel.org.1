Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778932D7D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395415AbgLKRib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395334AbgLKRhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:37:15 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56CAC06179C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:35:58 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so7425831pfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIjdm7RPyoMXWeTdkfAgDbOhg46BNdgtvath0gXrNtk=;
        b=A4VWRCR99oW+Q926LNhHUI0cHEPkSO5hTvMMewPk5pmo59IwOp0gNW7DLYpWfmDMar
         +4HvJAEkzSzZGKyv7Nwrfx8ohqYAKifrURzr3b/Snq6gvMzP5nc0Wh1mjhCZHWVmS0IQ
         jpk69PqSqi1mL5T/Pg/7epaitLWE9nvdI1mfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIjdm7RPyoMXWeTdkfAgDbOhg46BNdgtvath0gXrNtk=;
        b=EnndUOdqZ8naqdtpNI517kPLYYZNm9AVNv0xgo7kZE9oSZCothW27qLl826O95FxKo
         8FMHNWyFxq+t6aDBRiFZbVIn23F57tum4h4/lujyCxziqHmRWfRI2ets6vhOf4OjJpOp
         tIkhYuL56isCOpe/jy/YMJ23YkIbwQb5GMu+kVUE00krHzaBcV0b2rL9JV/qffuchgLq
         sXYGSvkhEvJzerPFUVttUtoGnzSYeeDrLaRZU5V2eB0LED015j6sQqrFsD5kZCijyl8K
         Efy4slaIl308+rmrMHwYSznUu8O8KSuPfYPV+RrKgdjRgEX9Dj3+bUdilUQi/Tytx1Yz
         EcDw==
X-Gm-Message-State: AOAM533QDOs1Bch5MMmTZn5GPdXB5uHfT/otbOpVaOKjxeAkJjDnly7B
        sg5K19XMpE4MnsSoWfaINatLzg==
X-Google-Smtp-Source: ABdhPJySTi5tN5NXRkE/WY3OLhBrTO9Pp1LrjngnzXk7dxw8NCek/PlvV1Ag1seKmTgqCprMFfAwSA==
X-Received: by 2002:a63:d258:: with SMTP id t24mr6657853pgi.197.1607708158547;
        Fri, 11 Dec 2020 09:35:58 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id r185sm11402765pfc.53.2020.12.11.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 09:35:58 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     hdegoede@redhat.com, swboyd@chromium.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, andrea@borgia.bo.it,
        kai.heng.feng@canonical.com,
        Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Li Yang <leoyang.li@nxp.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] arm64: defconfig: Update config names for i2c-hid rejigger
Date:   Fri, 11 Dec 2020 09:35:24 -0800
Message-Id: <20201211092956.v7.2.Ic9788bdfc4cce7569f8d25e7fb52a208fb643eac@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201211173526.1516653-1-dianders@chromium.org>
References: <20201211173526.1516653-1-dianders@chromium.org>
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
2.29.2.576.ga3fc446d84-goog

