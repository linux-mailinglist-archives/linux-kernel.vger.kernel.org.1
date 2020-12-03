Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4E2CCB86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgLCBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgLCBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:17:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A90C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:16:52 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o9so177373pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hD9iy6y3twkRO/sasJ9OUkDNnBcrZtQW8hMDw++T9NI=;
        b=QBOhggJd+oxU3sS9QhXlTKlmR+l0VmhNxMFxIMAiF0jdc4fpGxkK21Y8tlPZBxn7qb
         fUTAtm/RvZ14Tr/zupt8FEdTRZMXXH2kTnAgauM9WXwmUAeLGabIMgh+0+ZOrDdWKraU
         eN2KaOXwW1WdhLUGY1WXFYbDhVgqy2HwwJmWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hD9iy6y3twkRO/sasJ9OUkDNnBcrZtQW8hMDw++T9NI=;
        b=JWpy51OJPQoOTYsFUd5nDY5l0gCcVKcQ90X8wnmLDnwluv15ziY4ZguDhlTW0gHFM3
         pnLfnwRc00J2wBx7T8f7Iux2O3h0QaqvtMuSHFkQFbToZL9Joh+jMpFugJxnFa3cvQAm
         AbP688Tlw4jL4RCPl1KHZnbHqo8sMHgoO2huz3u3s7uHmtdLzu7jPqjiuUu5Iueing6c
         /KxROSF5FVOSpBFneU88lTh4a1aFp2q9BGMxAkrHYL2N/Vb8/OpL7i3tb6e4zRideNhO
         iyaZ6lLI860iUiATOjpFKK6FkdxXJ4jEylNB4LMBj6QPdVrpYnOeJAiv+gd3hOHTyj0X
         h7dQ==
X-Gm-Message-State: AOAM531paHah0lwwZrv6DCNXHQeJ1x3PlZPePAgZg7v7qiREviM1qwt0
        vvfqykwWNeeebrXnnZlS8AVCZg==
X-Google-Smtp-Source: ABdhPJwBmtwlm08bc+Jq1f6tAyd5DQIuSCfFxq6JntQh7hzdZMrMhGKhHNGnniuxUpxy2G5jHQ25Wg==
X-Received: by 2002:a65:52c1:: with SMTP id z1mr920527pgp.46.1606958211920;
        Wed, 02 Dec 2020 17:16:51 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id d19sm123292pjs.0.2020.12.02.17.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 17:16:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_spi: Don't overwrite spi::mode
Date:   Wed,  2 Dec 2020 17:16:48 -0800
Message-Id: <20201203011649.1405292-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201203011649.1405292-1-swboyd@chromium.org>
References: <20201203011649.1405292-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't any need to overwrite the mode here in the driver with what
has been detected by the firmware, such as DT or ACPI. In fact, if we
use the SPI CS gpio descriptor feature we will overwrite the mode with
SPI_MODE_0 where it already contains SPI_MODE_0 and more importantly
SPI_CS_HIGH. Clearing the SPI_CS_HIGH bit causes the CS line to toggle
when the device is probed when it shouldn't change, confusing the driver
and making it fail to probe. Drop the assignment and let the spi core
take care of it.

Fixes: a17d94f0b6e1 ("mfd: Add ChromeOS EC SPI driver")
Cc: Simon Glass <sjg@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index dfa1f816a45f..f9df218fc2bb 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -742,7 +742,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	int err;
 
 	spi->bits_per_word = 8;
-	spi->mode = SPI_MODE_0;
 	spi->rt = true;
 	err = spi_setup(spi);
 	if (err < 0)
-- 
https://chromeos.dev

