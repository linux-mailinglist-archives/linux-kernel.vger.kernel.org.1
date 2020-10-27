Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0519F29AC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900208AbgJ0MmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:42:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40156 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900100AbgJ0MlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:41:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id 23so1568364ljv.7;
        Tue, 27 Oct 2020 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZlE8y81IS7pCFhqYuFCDF3LrzBymS6x7k4Q6CBmO9rI=;
        b=NFXCg+zsjIOZrdGi7v95xzt4Ur/C4WtTPpKDCrsAB6GFjx5WVo5AdeIIOva7txkQR6
         fHzAlnHmAANNRG4r0W0YfYV1wmI+lrxlmvG5+TicNZBd3ytkUY7S3Wbvd5LT+Y8vukgT
         EvH5LxV7hgp0lqmHDoTHD0fYfkcs8ljo+rB88cO2DtsnIOABgPwXJNRo3ysIJJ+sUw5o
         W7/sYNzugo8LpyIzInVx2Bp8CZENRUM5hu4+mdLTdOtQCJOXjZMLbEXRx89YbUMFUaZV
         mgHsN1PQOnY6RXpLYnjL1HmmTD9L3362ZEWRKk/xQXsY/HC0Wy+kqvRIvELyefdBnUTR
         V7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZlE8y81IS7pCFhqYuFCDF3LrzBymS6x7k4Q6CBmO9rI=;
        b=TtRdMb7/m7ZOFc4O4gnUtoZciCoilKG2OPcEHJrSsT/Ak9JGtlfMjUwEO1wDO9Vtop
         LwGRvblWNgLrsTYqBVKNi/aYJriDXwsqH/iApWx/JZn1ByuBy6xLsrM0A+NOeDSs7z8z
         dK1BEddJA2WgPV2n5umZmdWTOaCNaZTS//6rsC+/xZNwK1DsNK5+KJJPaDj5OjTmACcP
         RHVK4MpSxD9TLy9vZZdHUx7Rp/ZE9fI5jiwOkz7xE/aAfCGoQEDAvcNTrWWZD7KgPlNF
         i/rAvz4ZMa1SqFmekGX4hALQ0wfEqne3xvHPP8VNwCISuzKq8NtWCGWCRJmrxS0+815U
         64xw==
X-Gm-Message-State: AOAM530LhkRX92CzJHxiIuWgZf1Wv8hzwApdvc5+tnr1TBl8Nbe0Y6Za
        e/ZuP3zmRS6pzWL5BPOjwJRybCjPCrAr5bD3
X-Google-Smtp-Source: ABdhPJyAQtoQD4/oapmYyvgaUmbHlXvjVu2e0fO1sRFFnXAVlKXjbkmEP0S2eZ18/uUL8NTylkQ8VQ==
X-Received: by 2002:a2e:9dcd:: with SMTP id x13mr968561ljj.422.1603802473866;
        Tue, 27 Oct 2020 05:41:13 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-8-148.ip.moscow.rt.ru. [46.242.8.148])
        by smtp.gmail.com with ESMTPSA id e15sm49132ljj.60.2020.10.27.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:41:13 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: aspeed: amd-ethanolx: Enable KCS channel 3
Date:   Tue, 27 Oct 2020 15:37:21 +0300
Message-Id: <20201027123722.2935-2-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027123722.2935-1-aladyshev22@gmail.com>
References: <20201027123722.2935-1-aladyshev22@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KCS interface on the LPC channel 3 in the controller
is used for the in-band BMC<->BIOS IPMI communication.
0xCA2 is a default host CPU LPC IO address for this
interface.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 89ddc3847222..2a86bda8afd8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -147,6 +147,11 @@
 	aspeed,lpc-io-reg = <0x62>;
 };
 
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xCA2>;
+};
+
 &kcs4 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0x97DE>;
-- 
2.17.1

