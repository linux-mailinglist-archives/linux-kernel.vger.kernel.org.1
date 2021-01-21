Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7F2FE79E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbhAUK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbhAUK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:27:49 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E51C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:08 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 6so1860755ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSCVpYUnbF/iwkll9PDRzd42GEI1bF94/HSaocuDHZw=;
        b=1S5GqVPBdt8g6I9aOE9sWC2hzjK4PpwpsafOKYxQvfq/kNM1TGt6CvDHDpCr76QcY9
         0dLM3mArjI1BWMy8HALayN0HhPsEkc/gWd99lY5lkcL7Ql0odIk0jJSiBryaN+QLOETe
         Fc5dHdRgIlpVtRCN4J3rWxjBctd3W2dCEhoMZP9IWJYWyQgIhBPEVOc7i4BSNzWrCmOA
         /5Hd1CkHMBY73yTB3NkRJp/YjQ+PWqBvl1IphLhfXs+DT1kccPVg+bBwxeTbn8C1+z0Y
         U6eNrZ8raMUgRVvalJQN9w8rNkMfY5i4loxVVdYS6CUJ8W30bNQHdNSRm3zV0i+Mm9qR
         NVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LSCVpYUnbF/iwkll9PDRzd42GEI1bF94/HSaocuDHZw=;
        b=Bwu6iqkd216WGBQxYWfa+6fg/S8h+SKbgpEtjtoRcgyVo0zGw4b+iY6wWkODwGc0wR
         cB0q6vXUQlO1suz85jgsKinACsh6AK1E+VWors0md2woLaiam84hQYQ5Slohlhoot51D
         8QGog/IwEXh2uexYH5SzR3ZkEDSDeURXodP1Foweiuzo5YpT05a5jqNVgnZrjbdVhEOW
         /wfOEX8MstIXpgH1Y9JxcqxyKAhbAjoQlHywoS4zG4E/o6FOJ11vAGwnDr54hT4img5c
         PgvfI3zebWGB3NV8oXDeHPOXiuhrkm2quW3mcqIxhXU5g/nWM1JER3mk5qXAabC9Mdf+
         AnCQ==
X-Gm-Message-State: AOAM533ARYint6B/Rz4/c409izMU9beR96MimpOnzuXXGIUngVQqMhlO
        Ifq1eCQW6Dt6BoCHE5XWsuuQUn+H6WhzOWNj
X-Google-Smtp-Source: ABdhPJxUn2eGSg86H6sk9lDGPsuATsvqPZPN0+lhXDQUsO+oW74tiGDP/pAYHDbjBQ1jS0D+s/n6FQ==
X-Received: by 2002:a17:906:6087:: with SMTP id t7mr9016712ejj.90.1611224827450;
        Thu, 21 Jan 2021 02:27:07 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id cw21sm2438052edb.85.2021.01.21.02.27.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:06 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/12] arm64: dts: zynqmp: Fix u48 si5382 chip on zcu111
Date:   Thu, 21 Jan 2021 11:26:49 +0100
Message-Id: <cefda1a894fb54059aa1b018e4ecad0eb36fdc9d.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

u48 chip on zcu111 is si5382 not si5328.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

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
2.30.0

