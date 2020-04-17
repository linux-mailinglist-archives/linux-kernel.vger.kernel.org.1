Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF30C1AE4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgDQSls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 14:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729136AbgDQSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:41:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900A9C061A0C;
        Fri, 17 Apr 2020 11:41:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so4167088wrv.10;
        Fri, 17 Apr 2020 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4RArEPtRb6yXEdgtQ3ovyy6FMchkA9pg/LkRnSfJR8=;
        b=LB3xbvk8qJejz7tCjtEyfb58WU6LIalruJuOoQB1Cneg3/jqPgHlbv12NNDaHlpzmV
         o4uu9ADrf4vAphiHiJGYnZeemkZ8JE8PszXtVht45LbV0jh+JbkeLCUgh+NQv3ew0EET
         5OiBadJ8IJ60jWXZcJ9Mh/m0VvlOUHi4cRATM4vw8O+eKPsyatKhe+icKhBA2UTl0dad
         OLrmY/o1wUQK/j6xSJ9Pka6ITAWn4HHjRddCbGUV2CsNveMOBp6rZIwhb03JPd0/FdGw
         erl8L7qmaKONyIRCGNvpUFl9zUFYxMecqk3JJryPWqoARSS8D+vPJJSMwceyE8a2smeE
         sQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4RArEPtRb6yXEdgtQ3ovyy6FMchkA9pg/LkRnSfJR8=;
        b=sVNVKiXQH6qrORXRmzEMDiGYzre2Ql2TUYXCSIaeHEEHnx5hs5cIAHxj23qxMlg3Ct
         IeRoBm0ja9IQ+XRajyenkDBdsORXjNIfKdE9g5xNeL96EnZzeH2MdmWDz5fD+9SwmLF8
         MawFfdjGYg/18utl2+qeYMF6lhLvESAQwS1K1/DqUBGKsJiaAej7d2Dfi03hburHqI/L
         cMq/Ib8Eiggu5GfIrMtzcR+Le745vDnKutdw7L7xXz0zSNj76HUeoZnGk78Nqebxu9Vi
         cAzfHcZRFcqUtYD/iNQ5d3IXL2K4+/RThpMJmnveCgtrhuye4LP6EYzTJIaI9mIEBTjA
         h8mQ==
X-Gm-Message-State: AGi0PuYpadrW3gWc2sE+Fj/9hJ1nmDbRHhW272b+f4rBmSdB51Yi22Pg
        IC7YQLSynLzueNpI+Asv5yM=
X-Google-Smtp-Source: APiQypLp5qHymcuJPKjzUtOnmkQmLSVUjfmU7kNQvo46lL7qlgyByinKLdOTrFJU3TOKc0KrRY21yw==
X-Received: by 2002:adf:f884:: with SMTP id u4mr5203954wrp.171.1587148903269;
        Fri, 17 Apr 2020 11:41:43 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c17sm33237391wrp.28.2020.04.17.11.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:41:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] clk: meson: meson8b: Make the CCF use the glitch-free VPU mux
Date:   Fri, 17 Apr 2020 20:41:27 +0200
Message-Id: <20200417184127.1319871-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
References: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "vpu_0" or "vpu_1" clock trees should not be updated while the
clock is running. Enforce this by setting CLK_SET_RATE_GATE on the
"vpu_0" and "vpu_1" gates. This makes the CCF switch to the "vpu_1"
tree when "vpu_0" is currently active and vice versa, which is exactly
what the vendor driver does when updating the frequency of the VPU
clock.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 6d1727e62b55..811af1c11456 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2063,7 +2063,7 @@ static struct clk_regmap meson8b_vpu_0 = {
 			&meson8b_vpu_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -2134,10 +2134,18 @@ static struct clk_regmap meson8b_vpu_1 = {
 			&meson8b_vpu_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
+/*
+ * The VPU clock has two two identical clock trees (vpu_0 and vpu_1)
+ * muxed by a glitch-free switch on Meson8b and Meson8m2. The CCF can
+ * actually manage this glitch-free mux because it does top-to-bottom
+ * updates the each clock tree and switches to the "inactive" one when
+ * CLK_SET_RATE_GATE is set.
+ * Meson8 only has vpu_0 and no glitch-free mux.
+ */
 static struct clk_regmap meson8b_vpu = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_VPU_CLK_CNTL,
@@ -2152,7 +2160,7 @@ static struct clk_regmap meson8b_vpu = {
 			&meson8b_vpu_1.hw,
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.26.1

