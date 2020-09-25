Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB1278E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgIYQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:26:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:26:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so3659373pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR8tV2dJ/U11TWa0ogl2BlvkMdFOuXzEoZRJvGo7p6I=;
        b=HPl/Iy/WXJPfpgUtGMjYyt4aratJ1qBBtn1Z0w+zGlQEzXPIPiEvqgd8chlSk9bEKa
         UJuJTDdKx7j5323xHfo46Zhx/wlKRQ36ZmEeAEp4F24M+bWHS4O2EJPyTFKzCh3uc+ks
         d1wp6jjoktuY7cLfQn1UoeKfdsIbhLMpD3nb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR8tV2dJ/U11TWa0ogl2BlvkMdFOuXzEoZRJvGo7p6I=;
        b=PQpHvdd5BHAweWtfxWdiN5+V5Vk+FNGtNGY6sSjO6+f5XNGpEPqGfmu9ibBn4/oVBB
         pc7LiySQx155fYhDLhuu5hApKl15jcDXcUNpeosLa3TieTcKmab3mT/jFRYGblT3B1Fz
         /Zz83USrHKTVRwtW2WPiKE4GK6wodNzQsqbWt+mxHU5yJd2GdttIaS6aBY/nVeDfAM8k
         3CJcJflrKJfBEB64SIG52Ls0r7jd4xtudEYwMQWfiTGP1Tj8zLF271OHDxXpPs++GlVw
         gvk2mOA0oJvurJOKD+f88D1sVnTX3jJBbXRByV+FsrwgM/vxQlzIr4nCLLVpHwrdb95c
         lqDQ==
X-Gm-Message-State: AOAM533Z2bMLykMadDyTCygMMoQ5S60OfQJZjTCFsd/p8O8x8qdxKymC
        JfY9T9HxYVy7VZsPFnU8HH9sJw==
X-Google-Smtp-Source: ABdhPJzojrNphfsKZs+tcDxID5EAhu+3qnVwXwUFFj0qXQL6337a34yiur3o8McUXwfxcSgLAJc12g==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr708146pgp.45.1601051165748;
        Fri, 25 Sep 2020 09:26:05 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q5sm3076435pfb.184.2020.09.25.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:26:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] ARM: dts: cros-ec-keyboard: Add alternate keymap for KEY_LEFTMETA
Date:   Fri, 25 Sep 2020 09:26:04 -0700
Message-Id: <20200925162604.2311841-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer keyboards this key is in a different place. Add both options to
the keymap so that both new and old keyboards work.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/cros-ec-keyboard.dtsi b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
index 4a0c1037fbc0..165c5bcd510e 100644
--- a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
+++ b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
@@ -46,6 +46,7 @@ MATRIX_KEY(0x02, 0x08, KEY_LEFTBRACE)
 			MATRIX_KEY(0x02, 0x09, KEY_F8)
 			MATRIX_KEY(0x02, 0x0a, KEY_YEN)
 
+			MATRIX_KEY(0x03, 0x00, KEY_LEFTMETA)
 			MATRIX_KEY(0x03, 0x01, KEY_GRAVE)
 			MATRIX_KEY(0x03, 0x02, KEY_F2)
 			MATRIX_KEY(0x03, 0x03, KEY_5)
-- 
Sent by a computer, using git, on the internet

