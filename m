Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA2F2A11B8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgJ3Xny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJ3Xnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:43:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26EEC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s9so8148526wro.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7PoWxpHj9lcsas0MzwlL/XlGlfDoWtZtj4l25S2IlU=;
        b=smDQwR8aRkGOjzAG1FSUwMET+y4eJzIWYeSQeZggQnXc9+q2F/Y6nL8Qg9FDwwbj/x
         NkyEVQtVtbcj7y0aYiE/xNfihgF15Qar5cweukC9hYleBLiwS61Bob2Dz4LZVDw6dIIS
         tK7J1g44WWusL4tAk+mckFO0dVUeAnBdEsyGSD5Ti3AUgqbQ4rp6GPAWERvMaVJoeR5s
         4Z6EHdL8xc9JP8FbGqv5EOyBw24iC2vjYaBu190qTdslD1P3Hkpvhrg7gvYAd/6dScN1
         Y7o267XC23x/9DT/8AYgRKREJ65rYp1qdUY63HXp162BQ76sVhQ+Y6/iUKMWpqOu/g70
         R5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7PoWxpHj9lcsas0MzwlL/XlGlfDoWtZtj4l25S2IlU=;
        b=cIx9sFJd0TmfzZ3KLsEyx08WcQh4gMXyxe3YnA02hHFSYH2dNFKRaphCfprogpGqLp
         fUn6r0f0GP8OKhKDit4W3Lk0quzsB7JHgd4sKLlxLX1YYJYDEZAgeCqFZTWiWCJGG821
         BSOnVHQWpTGFoChjsHjZdx+VRC5OffmDhSCPpWHxJJmjRezlAiLPU6ISUacclq7Bd12u
         xdWJzR4k2xMH0SRzEQhwN3gb0Ml2BxODa8MrKTwePHNxb4YkzawAuMSgJsHXKaEMARBu
         rhmXwhJZfUK97enCcnwMOcfo6u4tXev+S/+qpz6NUVwprwd1tQXowGz3sWpKZOWI3ZAU
         9VDQ==
X-Gm-Message-State: AOAM531GnoEDibQNYIgclsTlSQZKNc1o2vk2oaU15aDmiJtfU6KPHlo1
        vrzlaxFj7WpaLSBx1GAyu2I=
X-Google-Smtp-Source: ABdhPJzvdFqRBDXodKk/iqSAxzfK33iuvKnANlAipkCDz2BqOkLXY5gDsKDJ74YDTsB+9bk+p1sVdg==
X-Received: by 2002:adf:f687:: with SMTP id v7mr6433464wrp.179.1604101428688;
        Fri, 30 Oct 2020 16:43:48 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z10sm4702381wrp.2.2020.10.30.16.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:43:47 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 2/6] ARM: dts: sun8i: V3/S3: Add UART1 pin definitions to the V3/S3 dtsi
Date:   Fri, 30 Oct 2020 23:43:21 +0000
Message-Id: <20201030234325.5865-3-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3 and S3 can use PG6/7 as RX/TX for UART1. Since no other
functions are assigned to those pins, they are a convenient choice for
a debugging or application UART.
This is specific to V3/S3 as the V3s's non-BGA package did not have
those pins.

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 arch/arm/boot/dts/sun8i-v3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
index ca4672ed2e02..c279e13583ba 100644
--- a/arch/arm/boot/dts/sun8i-v3.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -24,4 +24,9 @@
 
 &pio {
 	compatible = "allwinner,sun8i-v3-pinctrl";
+
+	uart1_pg_pins: uart1-pg-pins {
+		pins = "PG6", "PG7";
+		function = "uart1";
+	};
 };
-- 
2.20.1

