Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE89E304A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbhAZFDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbhAYJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:27:44 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF106C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:27:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id l9so17000153ejx.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sBSJE/VQs+urDGRZoMN/fPwNsUAQG3TV8aFrYnnJyfs=;
        b=SP0RwF8OziTWkJh7GHLpDZWEi+ZwjKAlCiGsHzyuYHGeavvVO3SLzEefFPDqWJRbA3
         GiK9bN7MjJ1XOP1JjiX+LfpP3hBklqscZMt/MWpZ0w/D1+icbVmCN3Mlk90DyENww+wC
         RJkomSL/NNTSWomZaW9HcnVBpcqWX1KsqPl93VbohBrToiVGXL4efBIRo5btqkgcdgi9
         ZwgO7vIVewjKvOCqdfld5CNk44cP4nDfrre5NONZM3Y8Lf9/q9wHngisQhMME2TmmmoK
         bTzsD+74H0rwCdha7ipSBz8ovc7ri53AvNNz+wc17qvxrcE6o0ewYsov6r+0mB8Z+Iby
         NJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sBSJE/VQs+urDGRZoMN/fPwNsUAQG3TV8aFrYnnJyfs=;
        b=Z6hr94W/GSg6QN/j4UCMBoKXMHUNPN9ZyavM1P3wpfE/MP/+vqJwb90QD24mcl3mIn
         vHSYUi+vttNlz3EKa/CIR2coAVuKSauFLEb9w/2jIfC68/PDkrfPCtXNOtPDOVvF++f2
         E0a4Dfq5VZtgL6coy2aJybjD5bfNtDVKLz4bA7R4uKeS3h6nCwvVHzGLjz090dSA6AmH
         pkRsjXkoz88zPRF7FEyRxTBfwE1IUXIUbUQ31baQD2/UNLa0ro48wwnjXeLfAvxC0PmI
         6kLazxZb2m9/UBLgPqgmowem9pDMp2yvJeJil04xSiVT4dAcp61K3wkTA7oKAReHAos0
         KXHA==
X-Gm-Message-State: AOAM530I8NwMmLjRX3/sj/VD0Qfz/JK1D7m5eHb7EbKhKOe5QOAL72sh
        uAFCBe+Zp6XCj53cgh1NFWAagr6yqBDkGQ==
X-Google-Smtp-Source: ABdhPJyPhJFiO2hVE8X6EJHx99/oROIBk2JKEIMdnYOjDXwEqUt14UlensLuAkRozQr4pio67JhFcw==
X-Received: by 2002:a17:906:c793:: with SMTP id cw19mr1469795ejb.246.1611566821653;
        Mon, 25 Jan 2021 01:27:01 -0800 (PST)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:6139:400d:8db4:21a5])
        by smtp.gmail.com with ESMTPSA id u17sm10112218edr.0.2021.01.25.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 01:27:01 -0800 (PST)
Message-ID: <3753ba4c92fda75e646ccf629bb95e9d692ddbdb.camel@googlemail.com>
Subject: [PATCH] regulator: pf8x00: set ramp_delay for bucks
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jan 2021 10:27:00 +0100
In-Reply-To: <1611222152.1561.5.camel@googlemail.com>
References: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
         <1611222152.1561.5.camel@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets ramp_delay for bucks to the max value given by the
datasheet.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/regulator/pf8x00-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 1e5582d73405..edf5c88bf43e 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -351,6 +351,7 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.type = REGULATOR_VOLTAGE,		\
 			.id = PF8X00_BUCK ## _id,		\
 			.owner = THIS_MODULE,			\
+			.ramp_delay = 19000,			\
 			.linear_ranges = pf8x00_sw1_to_6_voltages, \
 			.n_linear_ranges = \
 				ARRAY_SIZE(pf8x00_sw1_to_6_voltages), \
@@ -381,6 +382,7 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.type = REGULATOR_VOLTAGE,		\
 			.id = PF8X00_BUCK7,		\
 			.owner = THIS_MODULE,			\
+			.ramp_delay = 19000,			\
 			.volt_table = voltages,			\
 			.vsel_reg = (base) + SW_RUN_VOLT,	\
 			.vsel_mask = 0xff,			\
-- 
2.29.2


