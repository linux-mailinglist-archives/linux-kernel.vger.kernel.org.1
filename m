Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30DB267ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgIMIm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgIMIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:41:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so10213667lfn.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHzxISYOrTTsQlkvB+PZhx5U7LKF1lKX/1Y/MN5Ylgc=;
        b=Bhsku9S3UBP4DFta4XjyALkxrAwgkUKjvT1DRMYrw0a3pUlPtahjey00DWrWLisErY
         0g6PTN1lUzk+AwlH6Qxdk465gWIH98Tp4/3kGV/CngjcEh1qLyBUIlp7Nfr9dXLFQrlb
         KtKTTKHI+FHNalB9csu2N2U40Kh5SNc0voLWzcwQNzYYBu78+Gj+CTEWWpDPXKLJUMOG
         6+crkaXhbVrQ/njdhTosKLcDyzqE7Sbe3W7GEgAYt4VXWOp7cFeMqh01glTzjpv22aXP
         SUvMGDietGa4ET4qiYWJTQfge7UdV5TBWfHcGim14DYrIWbD6oeurmFwFG+jyHXPT6uM
         Luzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHzxISYOrTTsQlkvB+PZhx5U7LKF1lKX/1Y/MN5Ylgc=;
        b=mtH82uLT0xTgEHQQg20O0kJE4srCEurbpE/mTbpE/zvUd3Q80G+V6/tHIgPLiYduTH
         PwIcPirv2UgnpOojfYlYd1tGSG2XKkYX0KgMRNh0p/+7fB+omILUw5O+TCdPDphulZX8
         ouPahqeYTy2DkZUDDCSArdUYQeQl0EqbecIoyTk56tJujhVaRw+134TlOUWrGuHmjHW8
         NlZFqir9AQ4WGWHDOVTkM1+Xr8oHtnSJMNJwH6xl97uyLsMt3naUoUFOUyKbDuiirYMA
         OL2nAACAUuncZhrtXSgY25xYlbAWw+PT/0Lc0Hiuw62T15aFhLvEQWdaCbJqERVUr/qz
         I9CA==
X-Gm-Message-State: AOAM531bEfnPU38ZilWoC8B/9TAo4J+S/ONfcXgAwGkanUzVDCgLAXhp
        Hxf7eAx50NzijuyCnfurZNg=
X-Google-Smtp-Source: ABdhPJx9K1wDE/Mhw2qkYvAUI8F6me/iO+gs4VH5hdxKIoraLTQirhsFZtlCmhOg3IVS1wF6YiNRrA==
X-Received: by 2002:a19:8345:: with SMTP id f66mr2430816lfd.506.1599986510786;
        Sun, 13 Sep 2020 01:41:50 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id n9sm2081099lfd.215.2020.09.13.01.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 01:41:50 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 5/5] regulator: ti-abb: Constify ti_abb_reg_ops
Date:   Sun, 13 Sep 2020 10:41:14 +0200
Message-Id: <20200913084114.8851-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
References: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of ti_abb_reg_ops is to assign its address to the ops
field in the regulator_desc struct, which is a const pointer. Make it
const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/ti-abb-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index af9abcd9c166..3e60bff76194 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -619,7 +619,7 @@ static int ti_abb_init_table(struct device *dev, struct ti_abb *abb,
 	return 0;
 }
 
-static struct regulator_ops ti_abb_reg_ops = {
+static const struct regulator_ops ti_abb_reg_ops = {
 	.list_voltage = regulator_list_voltage_table,
 
 	.set_voltage_sel = ti_abb_set_voltage_sel,
-- 
2.28.0

