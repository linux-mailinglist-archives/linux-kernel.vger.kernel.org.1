Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA902CBF07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgLBOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgLBOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:07:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20803C061A48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:24 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f23so4537590ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKmg2riOs3/P1+9y1NpehsFjW/uZkwxqjKJKyWG9gb8=;
        b=2POr50ZRWOmsHZX9VqYgVq1T+aXbCMdblYOLMODnTa6xG8oxEXtR316lhbP0++KSOW
         Ah1LNDm7GGRhZutn0ivUl5eLIPHtTRaeglXyz/e4oP691WA06OCfXAf8UTl3HpB4xdxE
         vpa+ywLuQcaCI8V9GRWIyv9goPGJY+gUtDDs6aCRs9+S80N81iFs27zXmIE7KHcKRipO
         gqc5x0T7EWlCi2mj90wt9NfJDVzyqM59am22QqdSgTpqcj5qDWbmOPpfbfqPm7VaTJgL
         soKsm5KygRbLDrFh2svySZcAflM7j1KT9OV5ZcP3JCi5eHsvV1OGrZoCbxB5wLyVP7p7
         lEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fKmg2riOs3/P1+9y1NpehsFjW/uZkwxqjKJKyWG9gb8=;
        b=Kcfx13bLyFYmyxKXBHLqtleSbpw4zFag0ChOOOrVflDTAN5z2B5mlJLmlNlOgXvXXi
         7AEqAtX1ZGmaGOUoTcblKKxSjKmQLYpVQ6a98tmHgNS1lYZ/RbtdvuQaCfOYwf6QnpIG
         /pjFaTN3nhGYzDrtVA46iNGpyZ6VhIQzi5U9tdVdPJeX/mp50LXZf7EGGVFmyUL5UiI0
         0Z5pR/VgPi3ZSciXPw+Lhn+PcRtn5GlkMjJCO0SzAY5hfeuQRUwX7kxpaZIo4V0ymSbB
         qpJpzh3a5c/NN4jOy70G8gKcISkiVgbjPntgbCaX2stpMez1JjXJkB95lgYHaJHweMDg
         fyCQ==
X-Gm-Message-State: AOAM532kcPhwCHmSRsZjQQOoEno88yx6w4w/4gI67ncXSProgUMNOXu0
        clQRjHL88YBBzBYpuxnYmobw4O5WrjzgZNXY
X-Google-Smtp-Source: ABdhPJwZXLaDTIx7lDAXfs9s+ASCrxdb7rVH8EmmNvXRLgNsrG3SZog2/M5rA+boxHpUF7RBsVOoCg==
X-Received: by 2002:a17:906:6b82:: with SMTP id l2mr2415324ejr.241.1606917976819;
        Wed, 02 Dec 2020 06:06:16 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e3sm1266290ejq.96.2020.12.02.06.06.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:15 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/12] arm64: dts: zynqmp: Fix u48 si5382 chip on zcu111
Date:   Wed,  2 Dec 2020 15:06:00 +0100
Message-Id: <aed1d6db42fd5a2a79f5b55d6c0baf863fc526f1.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

u48 chip on zcu111 is si5382 not si5328.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 2e92634c77f9..d9a8fdbbcae8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -410,7 +410,7 @@ i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			si5328: clock-generator@69 { /* SI5328 - u48 */
+			si5382: clock-generator@69 { /* SI5382 - u48 */
 				reg = <0x69>;
 			};
 		};
-- 
2.29.2

