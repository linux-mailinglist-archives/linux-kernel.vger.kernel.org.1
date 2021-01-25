Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB8302793
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbhAYQPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbhAYQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:14:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:13:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id n6so16023945edt.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=fPdV83ME/Qj+OnmIdr4VIxqsGn0gLEbcAaGrWcBkzFk=;
        b=O7Nk/kdOx7DVmVNOnHHHZOPiRyQJ5grXnPMaPZDIKrI5GISJCkxKJgdoC6xPBD0rcZ
         3YNQDr8UwIJwn36GGCCrv8KiWKXqIU6gZrwDfbV1y4WU4Cr6zohhRewNXCJVpX67upXO
         GG6vdYRRx+CD3WkZmN0fwLYibJAjtGGjAuhM2Z0SBymJ+WAfC/90A/0U/lbY0mGo5lQA
         CReMKaHW1cEkk1pZz0TaHncP4xOccvXEmLmtYEEZmvTDH+Fr/zZonP79gZZzAdURi0In
         bJzauR+yhWxUnEDY4Ke2gimgRgSYS20tJGZWEoQnHbj0fXkC7xDy2nSk2RcmVy4PCae4
         /Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=fPdV83ME/Qj+OnmIdr4VIxqsGn0gLEbcAaGrWcBkzFk=;
        b=syEO7F/urFVlaqXJmErtIc6J9NG8yJ7lTYrLfGqMSaIF+s0i3DIBKNhe3xhSQshqgq
         rSbj9fTbgOIS3bza99fEjUvA4kchw6SoROJ1V9Mb++/VRRTpm12TkFfTpVERE8PzQBEH
         C/JAvBGXjfSaac1HPy3WU8g+6TEfJrxoxKRKhwUW18aHc2TjvJHtQp8c3a7REheS9j1+
         04pB0gzBI09OqMDHYyRsz8pS9gNfBvNzVgEfSXMP5ZrTzvVVaho7YLN/fwgRnEJWBqTO
         GvGFmaCYn84m5+dNxN8b2+cjMSpeWB+8Ni5BM8GoQPscV44YEVM86ThvVstjJ5vga6bm
         2wGw==
X-Gm-Message-State: AOAM530Gdcie4rP1QSIKXBSqMBaCjmQaCbuGmD4rQzxLP5iy7qfc1GYR
        n7/O0Qx46T30pWmmop7ZLlw=
X-Google-Smtp-Source: ABdhPJxedUf0joedHuE4g29B+vLJkj1n2DM4Rz/3mBX0R4CChHzWYiP9Ep4McSWWn3REyMb6NzyFxQ==
X-Received: by 2002:aa7:d386:: with SMTP id x6mr1135848edq.194.1611591223382;
        Mon, 25 Jan 2021 08:13:43 -0800 (PST)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:6139:400d:8db4:21a5])
        by smtp.gmail.com with ESMTPSA id ah12sm3251248ejc.70.2021.01.25.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:13:42 -0800 (PST)
Message-ID: <60d8eb8feefd26380cc9c6503f835e569be90465.camel@googlemail.com>
Subject: [PATCH] regulator: pf8x00: set ramp_delay for bucks
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jan 2021 17:13:41 +0100
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
Reviewed-by: Adrien Grassein <adrien.grassein@gmail.com>
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


