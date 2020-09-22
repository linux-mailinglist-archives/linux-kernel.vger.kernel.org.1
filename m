Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FDD274912
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVT1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgIVT1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so15116222ljd.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWBOpq0UkvWk4FWbtpDOqSYC9sVpVEgdziUpvPMeV90=;
        b=X5nqZI2YveTvjI1P9aihzxrPaO7idkcriq7Q3Fw9E5sIEuVBnN0tCZWxr/+xZQ6vab
         /AsqPVPT9S8tCYAppc6yafyaQVCnENKgTh4DBalrrlwhZrvmFrIKSxC3xAwhTwj2mgL8
         FIVpiBEUbW2Mp3NvHZgUfcRV2x3sPP/Vsd3EimQ/DWnrsQFP0HdgAukZ+1yEMD0PFIAl
         CEGEF8QVcZNokfI3ZyZbuLVlHYLmdnFMnpyrrOKFAe7u5AMZD+VvYBVcue75k4pr7iOe
         iwg6HJW0NVbrW1TKcHaPKDDwm+BaiyQl+c0ZSFU4tHmIaOYbq/1C6zSMJgZSF7Jlh7ZB
         JXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWBOpq0UkvWk4FWbtpDOqSYC9sVpVEgdziUpvPMeV90=;
        b=RS3t4WU9Tzi5+V72jQLRrKEYYcF+nfLePtyQVFjBeFYRKMxoslXSj146HbSM0z2CXC
         zHnoerF4/pcB1Y08Iz1pmfcFohK5ODKH8L5TwwwJpE2MwN9fUHtVGnTQEuomvBDcYfKR
         FfGNEtPePfQFtgsfrLgQfesvHfC+Z9jU4eqc1lRv+1Iv4wPW+8MduBGZvlfl4imq/t+6
         l6nEdZ24KJZquiy4RQ/zPy7qqQNv7b9hLbs3UU5iKVlsl7R/epdzRm6djm++KX5GPJwu
         vuwK9k1RqMHCay9wONRGLJ/Nj9MAb24q0wFXmVdvA7du/gpsMbFer/PylU0erJRJVmYU
         r0vw==
X-Gm-Message-State: AOAM530mffVxvQsmLUc3SNWmHxe49OdSycVCNrN3t0tVCRl+o0V8D8gE
        y9mAbBsInQ+Dirjr9njQ3E8=
X-Google-Smtp-Source: ABdhPJwQkesYT7pCpI4VaOYmlUf6IunWjE7IVXyowtAYLEmbr03p7XsYeHEorcJOd6c0Tmav90Nn1g==
X-Received: by 2002:a2e:8695:: with SMTP id l21mr1892135lji.106.1600802835960;
        Tue, 22 Sep 2020 12:27:15 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r132sm3770013lff.167.2020.09.22.12.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:27:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/8] mfd: stmpe: Constify static struct resource
Date:   Tue, 22 Sep 2020 21:26:57 +0200
Message-Id: <20200922192659.14535-7-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of static struct resource. The only usage of the
structs is to assign their address to the resources field in the
mfd_cell struct. This allows the compiler to put them in read-only
memory. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/stmpe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 1aee3b3253fc..90f3292230c9 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -312,7 +312,7 @@ EXPORT_SYMBOL_GPL(stmpe_set_altfunc);
  * GPIO (all variants)
  */
 
-static struct resource stmpe_gpio_resources[] = {
+static const struct resource stmpe_gpio_resources[] = {
 	/* Start and end filled dynamically */
 	{
 		.flags	= IORESOURCE_IRQ,
@@ -336,7 +336,7 @@ static const struct mfd_cell stmpe_gpio_cell_noirq = {
  * Keypad (1601, 2401, 2403)
  */
 
-static struct resource stmpe_keypad_resources[] = {
+static const struct resource stmpe_keypad_resources[] = {
 	{
 		.name	= "KEYPAD",
 		.flags	= IORESOURCE_IRQ,
@@ -357,7 +357,7 @@ static const struct mfd_cell stmpe_keypad_cell = {
 /*
  * PWM (1601, 2401, 2403)
  */
-static struct resource stmpe_pwm_resources[] = {
+static const struct resource stmpe_pwm_resources[] = {
 	{
 		.name	= "PWM0",
 		.flags	= IORESOURCE_IRQ,
@@ -445,7 +445,7 @@ static struct stmpe_variant_info stmpe801_noirq = {
  * Touchscreen (STMPE811 or STMPE610)
  */
 
-static struct resource stmpe_ts_resources[] = {
+static const struct resource stmpe_ts_resources[] = {
 	{
 		.name	= "TOUCH_DET",
 		.flags	= IORESOURCE_IRQ,
@@ -467,7 +467,7 @@ static const struct mfd_cell stmpe_ts_cell = {
  * ADC (STMPE811)
  */
 
-static struct resource stmpe_adc_resources[] = {
+static const struct resource stmpe_adc_resources[] = {
 	{
 		.name	= "STMPE_TEMP_SENS",
 		.flags	= IORESOURCE_IRQ,
-- 
2.28.0

