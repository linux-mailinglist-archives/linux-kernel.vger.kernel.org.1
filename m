Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542A28A514
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 04:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgJKCs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 22:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbgJKCsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 22:48:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C8C0613D0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 19:48:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d1so1930079pfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJcvc1wxEFUx12YJeTHq7xa7YNZGOLOFOQF9lnDCs7w=;
        b=h46K4WPXZDrLBc0f4uQ+mmjJZ5oLyMHWw2JKRUg1blaUfMCt9h0Ave03cC6+h8g6Gz
         ksLUj7M44W9vl7kjzWMNQu5fppSJ3lifKsjMxJ/HrzVail3GpsPc3N8Cj8J7Qbz7KJjK
         83bBV47Za8daVYIHiIM/0ilci+a+vfxylKyTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJcvc1wxEFUx12YJeTHq7xa7YNZGOLOFOQF9lnDCs7w=;
        b=WoW9ZYY5TKHsntFBoT4liohBdNq/B1cR/tgxmbr9vc7Iyxri2mn+HV+3cDlANNU3Pf
         eLYl6fvWM+Dj0Xyxij76dHASunPUn7jyrU6BeWfUi2j3Uoz1QPJVLMkz25oE5K4tStbb
         fmtV8A9DtgAMZdk5wSsCifMW7I20P5+nthDU3RcStlv1ptzhSdnu28VA1FzuZ3g6a+NZ
         dSuEUXQRbS9jBg6d8utb47IXzXWPl1wBUbCGK++2HtX7rv/EK+bixmqMuOtW6gxRwi7G
         /nozgWu37I3F/QHMMypH834uyMaxqxJJv3vkkUeGHN84vtVdbrds7Q4u/ZF/fd5TAS/5
         eZPQ==
X-Gm-Message-State: AOAM531mexrDbobHmcee6f6WYcrgKQYY7uJLxl+IFD60pI++KFk1gVWj
        8zrZfQ4lbcSc9wJs0R/KUbWqHQ==
X-Google-Smtp-Source: ABdhPJwDWT9JEZDIZCweBSo+VTNNMrsopDB+y+M16Z8HnKrFD5Ky8LVSnfapNR1HAdV96CQa2biVIg==
X-Received: by 2002:a17:90a:f0d7:: with SMTP id fa23mr12050837pjb.108.1602384532897;
        Sat, 10 Oct 2020 19:48:52 -0700 (PDT)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id z25sm14832836pgl.6.2020.10.10.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 19:48:52 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 4/5] ARM: mstar: Add gpio controller to MStar base dtsi
Date:   Sun, 11 Oct 2020 11:48:30 +0900
Message-Id: <20201011024831.3868571-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201011024831.3868571-1-daniel@0x0f.com>
References: <20201011024831.3868571-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO controller is at the same address in all of the
currently known chips so create a node for it in the base
dtsi.

Some extra properties are needed to actually use it so
disable it by default.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index f07880561e11..669aada6f286 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -109,6 +109,13 @@ l3bridge: l3bridge@204400 {
 				reg = <0x204400 0x200>;
 			};
 
+			gpio: gpio@207800 {
+				#gpio-cells = <2>;
+				reg = <0x207800 0x200>;
+				gpio-controller;
+				status = "disabled";
+			};
+
 			pm_uart: uart@221000 {
 				compatible = "ns16550a";
 				reg = <0x221000 0x100>;
-- 
2.27.0

