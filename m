Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA06121A1B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgGIODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgGIODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ECAC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so2499800wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=G6q0CF1kORRNof0tQD5r5NoQptbBhuWv1c/fs/r9CwDbcexcB/5B+EpnFZAyC0xynB
         TLPEFz27dI9N6mnQizXEdM5Fx85hbntmmpaI+2qoJOrcf8faPX3GUOfc8IjsUwiW1+3b
         e7HPabKQZTToNaRmwvKoYF+kLUf8NXXQINYMJsMY3+UQspFvPotKsRqu+FG8QM3B0rVy
         k4BsagiLGMLuB2NrQwbIOJWhU0B3mQW+5c0kHq9934E0h1meOOVPiGsRPo2IoyKOke+y
         RtfRN6JZF6a/JdlP/S1xtQkycBz+oVpsx5KYQX5HNSW3NOXCjBlpLyejw1FpK2Wlq1Lg
         qAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=ZKEz4Wp8opB7jzrxBWemwo6I/X6mKqi9TMbReBh0/4u9JInvm/UCQyQUp/seBkXftM
         0BFK7Gx4nqpu1mRfRrHRarHfXfGFqnfzZNL0SBW/al/CoZxiCz3OymwnnrQtX5+HhatI
         iitU9/HmEELoKYGCoaDzRkQNHgEIWFfbASlso40NUNN49c+RecF9qDOGhjgHgfTTGIc1
         SWLwfOZSeRaqjxt3S7w+Jg5PrkKr+uBZlbw24y8pYpql45Tk2YdNwPjd88oabl6P3xOr
         RVbNa3Jt9LxP63niFilNcX4umuA67/1jcDDWiBcSeFtQNsltBU4C/SVhkBF8+mtuiXM3
         rQFw==
X-Gm-Message-State: AOAM532gZpSU5jRMg+swejlMo3aFELd1gvQ3mbypqoJpIBSXQyXRmCsD
        5wLIwEj6oE4UtlcpajU38NY=
X-Google-Smtp-Source: ABdhPJxKsJGmE1cXYIqvgGVcbqQhYNjKkdXWYq3nTtCEanj2piNLMs6tz3AQM8Wn4LqysoxPncAyVA==
X-Received: by 2002:adf:e884:: with SMTP id d4mr61159232wrm.176.1594303423483;
        Thu, 09 Jul 2020 07:03:43 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:42 -0700 (PDT)
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
Subject: [PATCH v3 14/14] [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
Date:   Thu,  9 Jul 2020 16:03:22 +0200
Message-Id: <20200709140322.131320-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
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
@@ -245,6 +245,7 @@ reg_dcdca: dcdca {
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-always-on;
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
-- 
2.25.1

