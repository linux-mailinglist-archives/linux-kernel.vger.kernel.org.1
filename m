Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED02B6FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgKQULV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731741AbgKQULQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:11:16 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BFB420707;
        Tue, 17 Nov 2020 20:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605643876;
        bh=jt3COWZLzl9ve+Zx+BT2k5uQvogQhg+pYvxdJh0yaqQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u7ftQ6gxVw1+ovi5PpK7Yoa+JTjd/jIJ+gi6GTqrQP0lJSeizZz70/Ijt6P1nKxLJ
         10GL9ouSt/nXuagaUgEn2GSReFv7EBKnIeNhPR114mnQdl29VJH4UafbpXa2JNJPwk
         dhSQQgbVHAuwZxH1D7F6pIo0h5xpmozUK+VwZh9g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: s3c6410: correct SMDK6410 board compatible
Date:   Tue, 17 Nov 2020 21:11:06 +0100
Message-Id: <20201117201106.128813-4-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117201106.128813-1-krzk@kernel.org>
References: <20201117201106.128813-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMDK6410 DTS was incorrectly called mini6410, probably copy-paste
from FriendlyARM Mini6410 board.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c6410-smdk6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/s3c6410-smdk6410.dts
index 69c9ec4cf381..581309e7f15e 100644
--- a/arch/arm/boot/dts/s3c6410-smdk6410.dts
+++ b/arch/arm/boot/dts/s3c6410-smdk6410.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "Samsung SMDK6410 board based on S3C6410";
-	compatible = "samsung,mini6410", "samsung,s3c6410";
+	compatible = "samsung,smdk6410", "samsung,s3c6410";
 
 	memory@50000000 {
 		device_type = "memory";
-- 
2.25.1

