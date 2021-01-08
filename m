Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D66D2EFAF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAHWQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAHWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:16:07 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE37C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 14:15:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 23so26475124lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMW/p/8PEXYrU6nObTLo2d7QCsPBAma0DHBzKcy6KPI=;
        b=at8kaYLi5EIu7SPD8rRzuVSanCQUEVzysVibFfnSo+PVMHluTO8w6Qn2BGOBBqDPD2
         jARZA/JgMLZOGFmVMzGONkW5U7Kc6fbAjAvts5zl+eYrqP4/6HoWTwTXJjXIQtCgr8V8
         JxVtHlKGqrkg37cpvjMyMl+QZTwDN2dMVgxJQjonIDLEPnpacQzrxyVkWM3C3uSgzSrv
         GUFoIXgk0nksx63eVpLdCxKiX/scztr7tkOOU1ErJpLSOECeUpoqvSTCTbxZcSJFtQut
         MuZRfLb3SnQjf2GjwOCF6WJo3cLt00sAPyAgMeP02D9bhxEPjG+dj/MuzPVPRUYklixJ
         YrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMW/p/8PEXYrU6nObTLo2d7QCsPBAma0DHBzKcy6KPI=;
        b=Eu6K5Fh/Ux66xAPpguNElNcs5yvetG2e5XQEBEIbW+2Ctr+UAd8+W9Cc4jQj9mOAOT
         tXsw+7QPL4XOm++Z2daSS+R2SqkCNfLrqNuwB3a+N6Ddr5A/Txbhdhaj8gUFbMP4ABQB
         wOS/bDzHqO3YzuUlJhRsVepYfqTPjCABK0S+pEeAKi+HN1dgqCPymx3uJ0U8mGTsIh5r
         rv307+iy5Dcdx5SRZ11Dg/YbcleRD8myz4ZvnSwbl3V5RXHXpgMFlHAxbHuLgXCXXjor
         CKoeBRIQYTEAZIq1dAQb3Bams1m7dMHWuW5eC1Y9T5AncsLMtTpnFZO98aUZW67NN5zQ
         9/2w==
X-Gm-Message-State: AOAM53021niA6SptUg0hkXPVzqVqOX8hNtzMfd+xAVZbvNQ4hJKieTpq
        3W/2OZRQRzTXzwH3WhtY4/M=
X-Google-Smtp-Source: ABdhPJw3GRrU/BB5zBF4t7VMzkHuRmS6jAQ33kMhwZLA2bnQGeTQ+1lvF/37F5hT/bsIRtRaLBtTwQ==
X-Received: by 2002:a2e:8297:: with SMTP id y23mr2250347ljg.177.1610144125013;
        Fri, 08 Jan 2021 14:15:25 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id y3sm2366411ljc.131.2021.01.08.14.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:15:24 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] most: core: Constify static attribute_group structs
Date:   Fri,  8 Jan 2021 23:15:12 +0100
Message-Id: <20210108221512.18811-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to put their addresses in arrays of pointers
to const attribute_groups. Make them const to allow the compiler to put
them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/most/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index 353ab277cbc6..e4412c7d25b0 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -379,7 +379,7 @@ static struct attribute *channel_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group channel_attr_group = {
+static const struct attribute_group channel_attr_group = {
 	.attrs = channel_attrs,
 	.is_visible = channel_attr_is_visible,
 };
@@ -436,7 +436,7 @@ static struct attribute *interface_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group interface_attr_group = {
+static const struct attribute_group interface_attr_group = {
 	.attrs = interface_attrs,
 };
 
@@ -718,7 +718,7 @@ static struct attribute *mc_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group mc_attr_group = {
+static const struct attribute_group mc_attr_group = {
 	.attrs = mc_attrs,
 };
 
-- 
2.30.0

