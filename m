Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6E81CCC7B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgEJQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729267AbgEJQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E523C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so7959146wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrpA01gh5f+4wCQVfiK/c2w8CUJsi/9aedeoRmkPm1A=;
        b=NVaFtRRUuIuJfOZ9VWEnsEcaHQLlxP0KjmHTYVaEol0TnaJzw14uuF0Ej7tBkZ/dXf
         q0cdIPbQ2ReTKQaZIx08FJyyfpQc46H2PP4lMAzaqienz9TjB71dMtXN47KrqWcqxFbO
         o1GK6lICcOVrfd0JUYo7eFmGGoXkfVH4g5DyGe4DFL2x74lhjkHAhAKErSB3hDhAXgYX
         bk95+Er61/m+x/X2LdsArOEZHganSOruTT+9efLroE+3vQu55tRQknbws3XuQKzD6QoT
         IhjlB0qHt90lQUSKTqPGVmIAJ1qjyAp27DajDztvQ0ZQsoWHXMxcgrFUIIdhtqbkj+dD
         UM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrpA01gh5f+4wCQVfiK/c2w8CUJsi/9aedeoRmkPm1A=;
        b=KrQiUUb/DOUQwjqwvLyDxzvwe31tLJ4add+X3ST4SSS93hxnC1H8kRU6L9LaRK5sdO
         g0RN4m6kLc2+IdvI/MAdvTSCjdoMQGz5u4qa5nC6eaHwAUrKSXPDUJJkjUEOabtZx8ob
         f9omXJyt8SA870wWSrejnwsLlpOJrgufFKWbl3XHmbUy9NNZofdxZmEC1e631C80nbK6
         Cs5qli8YDgd1FhAsmuj8mTH4Yc3peBV+2+teGPDeccWy1QfN1nSMiN706+23r2YpcgWZ
         aV7i58HaR6ZCu9PG1xFIESI65EATj/nWMun2G/+3hOmJKgEQflZLjknR0Lul3EajUj1T
         M+TA==
X-Gm-Message-State: AGi0PubzCEcqT6SbbBOZXCAT2QD/g5OjM8mZo+2N2OJt3KjB+NzFJcxp
        KH0JaKvNBjmL1x8wZZrqSC4=
X-Google-Smtp-Source: APiQypKucmou8UiKBQJLi/Cx8j6Ix30yatDbTUUMPyd8Dq8FziM9EgDPuGCXjSGiQ84ZMUcD+phxZA==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr14131363wrs.293.1589129757999;
        Sun, 10 May 2020 09:55:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:57 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 15/15] [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
Date:   Sun, 10 May 2020 18:55:38 +0200
Message-Id: <20200510165538.19720-16-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..14257f7476b8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -245,6 +245,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-always-on;
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
-- 
2.20.1

