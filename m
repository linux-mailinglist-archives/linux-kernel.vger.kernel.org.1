Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A188267ED4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgIMImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgIMIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:41:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A33AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k25so15986378ljk.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWT0PNvChNJoD822qomw3626qEaEzPS9DPgrDNF58YA=;
        b=Zs8iRFBbkOZxI+QhIdgeW4jT1Yo/Yb3KjZX8ruLT4xu+QnQf5frH/1Akr1n8B2u9Rb
         KF3VDXTFwxgZ4rzhUEjDdnr9xptB0+IGmY6u3BgcCEWvqvFJ1QWsb9crnU15gWxvyyLy
         T+yUps7wcdzljJIUljB7f1N4IRWN+UgrZxnWlndUR4LTTIhv8BzGrJj8/Hnk60PTY4Is
         DAI35UP2PshIZG+hBSNmH9m5h83SgxNvicDr17nVWAPFdhjaqzp03GIlS5Hh7kcX722l
         FCvxX+4rPmd+N0hakutmTbknmVJ/WkWwXig2Omf0KBkdovusb/r/5xcXFKqARbiZy4D6
         sN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWT0PNvChNJoD822qomw3626qEaEzPS9DPgrDNF58YA=;
        b=IOi1x1rHTbCSBl1zGnOGjem5ddCPABJfbXDiINa0PA1OxLOprviUaizyTuzWB2VIs0
         Dudb5R51/XOZlDVtRHXQMbzhxtYeCXYbxXAGHaWOjyzH7mQBhuF0y3gCB7eVFCGs4T00
         SOOvOBIh5HpwbbwXlSDmPdh5j0U/Cocneh38mQKtUKE25Ko6GNEVWMrQjiv518fTl9Wp
         uHYxT3tfXMYqmrg+YWVcg+DU86x5y84NN5YO3MfBRT8Xn0XnVOIcF27CehaZ+4R/Uvr5
         DzE3+vbqfn9IWx6SISakzoejRH1TjhLjxN0X/+ZrNUSLyKgiTis+XIUbDsZtZFvnfnbz
         udrQ==
X-Gm-Message-State: AOAM531egdZRLtkgCRhcf6Zdc481umnUda6QuDU99xoavJGYfWzHYSHx
        2Kh4so9UnaMzsTNuRi2pwug=
X-Google-Smtp-Source: ABdhPJxrsTbidtxLjqv8U7a5L+ZTLRqRnpiOyX7TkXBR6sckzHXviviRDqlX5dYa1M7GQaNSAq3oMw==
X-Received: by 2002:a2e:b0d6:: with SMTP id g22mr3056467ljl.350.1599986507475;
        Sun, 13 Sep 2020 01:41:47 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id n9sm2081099lfd.215.2020.09.13.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 01:41:46 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/5] regulator: fixed: Constify static regulator_ops
Date:   Sun, 13 Sep 2020 10:41:11 +0200
Message-Id: <20200913084114.8851-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
References: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of fixed_voltage_ops and fixed_voltage_clkenabled_ops is
to assign their address the ops field in the regulator_desc struct,
which is a const pointer. Make them const to allow the compiler to put
them in read-only memory.
make them const to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/fixed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 5a03fd86ad0a..3de7709bdcd4 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -123,10 +123,10 @@ of_get_fixed_voltage_config(struct device *dev,
 	return config;
 }
 
-static struct regulator_ops fixed_voltage_ops = {
+static const struct regulator_ops fixed_voltage_ops = {
 };
 
-static struct regulator_ops fixed_voltage_clkenabled_ops = {
+static const struct regulator_ops fixed_voltage_clkenabled_ops = {
 	.enable = reg_clock_enable,
 	.disable = reg_clock_disable,
 	.is_enabled = reg_clock_is_enabled,
-- 
2.28.0

