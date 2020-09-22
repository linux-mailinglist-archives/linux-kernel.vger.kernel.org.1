Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E722739DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 06:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIVE2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 00:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgIVE2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 00:28:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DEC061755;
        Mon, 21 Sep 2020 21:28:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so15499913wrm.2;
        Mon, 21 Sep 2020 21:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/SAKpEChXy3CT9sJ0R5MO0RuMAcSDnDJ1mWKr2Nu7Y=;
        b=Jd5lf3rMucFwtzA/d7nG2Vou9f2ChiQQ08ncHTDmnB55EOHMnTQMl3jWEis4Pu837m
         WmP5GZ5JWOxXgdRuOJR987jDax4hNZDBjXAkJDSTQlztRW2GMmjPRqB9w7UjMF2h3TA2
         vNnfcMdZJBA5R6JYbpO4K0PUbqLyMrJ65wqvsNc13DdixOnw9rHIYQU1tZQxqOjaWlQU
         fvk//vcNkNX32IPKxhtzi9XcCFvBMuKsU0pDiYepGxa91M4xiF4YOAG2kYi5/6+JIm2j
         R1FQQq1Zle+3xQXGL+xW1R1Z25cmNgdzabViTE2r8hMLO/2Nij8k5cvNY/1ffPDEKVsp
         pqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/SAKpEChXy3CT9sJ0R5MO0RuMAcSDnDJ1mWKr2Nu7Y=;
        b=JeLFVJ6LtT2cw1T3frvYrdTVInj2N/lW/6tezpiPV47M2vpPQlG2O2CsK2/4YnEiGN
         dhWoXBnp4KK6yURnL5Ds9uaeG+13NZkeRQVDOQJUc+44947VFqggHfONFK/6bNqxI2Gk
         8GOr1F/ud1JgwQDmzp4RR68H/3m83Tz/9sh5270OuczpjJPDm0bFPnYG9uvSHdqMIzHD
         u2x2cJRsX0VeI/h7MrdUBCwyiPv8r6E03gbEo/AVvPPeJMOKDilhRlm2s8GTKLiSpFMQ
         qw6LrCeuSxsQPsF5RZta5qmCfiyNCYQW5iqc9fKUv/NKCoxFZ91uZA/cWOnMhMjCdo9T
         K1YQ==
X-Gm-Message-State: AOAM532Jzli4G5AgBesRQpYSsjvRDJGfzU3qpS/F3RAVlIAQVbLnGu5+
        iBfIH/5q69dMsmz2ORmWI4g=
X-Google-Smtp-Source: ABdhPJwVJVbFgz5EpNoeoSB9SR/nTQ8dxCWh+onWVCRwph4Sqvodsh5Fp9DUiOFmRqfiOAa6zdikAg==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr2898250wrr.44.1600748921729;
        Mon, 21 Sep 2020 21:28:41 -0700 (PDT)
Received: from mamamia.internal (a89-183-78-237.net-htp.de. [89.183.78.237])
        by smtp.gmail.com with ESMTPSA id x2sm24616397wrl.13.2020.09.21.21.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 21:28:41 -0700 (PDT)
From:   Andre Heider <a.heider@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: marvell: espressobin: Get rid of duplicate serial aliases
Date:   Tue, 22 Sep 2020 06:28:39 +0200
Message-Id: <20200922042839.1138546-1-a.heider@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921164830.499548-1-a.heider@gmail.com>
References: <20200921164830.499548-1-a.heider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The included armada-3xxx.dtsi already defines these two aliases.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Reviewed-by: Pali Rohár <pali@kernel.org>
---
v2: fix filename in commit message

This goes on top of Pali's patch:
"arm64: dts: marvell: espressobin: Add ethernet switch aliases"

The resulting .dtb files are the same.

 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 0775c16e0ec8..3169a820558f 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -17,8 +17,6 @@ aliases {
 		ethernet1 = &switch0port1;
 		ethernet2 = &switch0port2;
 		ethernet3 = &switch0port3;
-		serial0 = &uart0;
-		serial1 = &uart1;
 	};
 
 	chosen {
-- 
2.28.0

