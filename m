Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0928AAA4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 23:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgJKVPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbgJKVPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 17:15:20 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F4FC0613CE;
        Sun, 11 Oct 2020 14:15:20 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t20so7535202qvv.8;
        Sun, 11 Oct 2020 14:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KK+gbmrPjMAsykJDPuKd1IbU0bhX6bbdgu1ougohE4Q=;
        b=TsrwuuH73tKylQhfnyT5gC8YKYGWqgDpxxdx1gD89B9nWNsvL5VJ3EA/bZsXyev9nJ
         pYvXE088k/5LGk6M7WPDTX27KVyicdxMRMwMRiR4ZLnMJp2ioh0KNQvjIc/0AhwOylEE
         mUKU74njjXiljLa71bq+1WEAi3wTsSkxftGgbqTcOu8ezOTRk+g/0esDjW3B99S3Vx7x
         clLqzxThy3bCFhDjFc33wndgGfyNMqpZNJj5h7lsJ/vXj3bcPXJFPcD1XF3/RAw6Ul0n
         uW2bs5lIS2IFwsxsLWxzdbwME60AaYRfdkoTLJoGNwqHJoi6V2C2hpbCzx++5MExGnRN
         oj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KK+gbmrPjMAsykJDPuKd1IbU0bhX6bbdgu1ougohE4Q=;
        b=jxOP0T9suWLsPIWN637tkU6jTlj9D/osiDBxQSDQfsX1i/Oixa03qO1nCaBU3FPcSM
         A8arjhE2JI7rOT6xKCbhrhSEM51d0jjDF+CznRFUH6EXvw42G0TR6AtPA7l0NtGPILPy
         tWqmY3gYA5xtlhiXbVRSn7wRmBf9f2gEQdhNQMbj80exVYeT7jKqtw4ay/WEifCwjU3Y
         EsBo+Z+nBw52Q2qCadbVUDx6EQpGNPpoRGvzxMbHgbShCo7n/1xayziQULuNtxYnERkC
         ZgR0hYFoxMTFL87cFeKQBXSeH3NCfNfyhdaBcJaglHCwOqIDtjcxHZjfn37yYy4qhGG7
         nrfw==
X-Gm-Message-State: AOAM532kyYpBq5AJ58+UenarP1JFJ5gAisB4N0YGgulEsuGzPvRzB05T
        zRiYcMTg+wl1OCnPmkjpeiK+AJ/ujjcynQ==
X-Google-Smtp-Source: ABdhPJwXN0hmh/jcqvx2GaHhWxa3BvM+uklZSkQvHLxoBrJVBT86IfR166TELCOQgrPjxtTQoCqQ4A==
X-Received: by 2002:ad4:50c9:: with SMTP id e9mr13293592qvq.52.1602450919330;
        Sun, 11 Oct 2020 14:15:19 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g5sm3029955qto.39.2020.10.11.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 14:15:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: pinetab: Drop unnecessary address/size-cells information
Date:   Sun, 11 Oct 2020 23:15:14 +0200
Message-Id: <20201011211514.155266-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make dtbs_check warm about unknown address/size-cells property in the
pinetab device-tree.

This is because these information are not necessary.

Drop them.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 3ab0f0347bc9..0494bfaf2ffa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -122,9 +122,6 @@ &csi {
 	status = "okay";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		csi_ep: endpoint {
 			remote-endpoint = <&ov5640_ep>;
 			bus-width = <8>;
-- 
2.25.1

