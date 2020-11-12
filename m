Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54A2B025B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKLJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKLJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:22 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E12C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:21 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so4903943wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6ib08VylLIp887er2WbX87dWDQQ8h8dYFMZ3eQ9PN0=;
        b=HozFs56gVtlvUaDwoQA81mhz9YzNKLovfrSxS1XWtah2rX6VfmUp1ZUWTMRla3xD2i
         Pw+gxhVyl9GlrbPDxC8stpfmdY7uoFYVCm4L591Fd+IXg94+wgowahNcONoxko73NRHV
         D6BR89TsbqbJBhCGAzq0t5rAQcS8KWc8zO+x6EGhZbz9vdzcNG1d0Cl1EfODQ5i/+6I7
         kf8gIi3UYKhYCg6Ry+0Br9F4ej/cyswIMqHHYtfwI5CY4jdAvx0GgCrP3gXaiyZoOIWi
         bJ/JS80piWvCAGfgHlaNH6J7PmlnZyS+OKbZENwc0LyWMoIxlYDK4MIRt8rXhIZ522oM
         bjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6ib08VylLIp887er2WbX87dWDQQ8h8dYFMZ3eQ9PN0=;
        b=ZOjOtAVOPmhrSM9FwIm5xMdI3L42QDNJmLnzkT4ke3rWROrMtvf75soh0gWy2vIrql
         8MMps0bg/WMmezroiqUo++fuBlvjoj5GMLeuhenNea2kllkhSY0ccCP/ciQGqsAQKE/2
         3toXEqzN84BJp3RcT9xvKacD5ZAZJ9Qm1N2FaRzh2nLF5u3dRP1/A1ExlIi8aHw8/10n
         ybAmHc4lIQ/piUDF7kVv7rqGiB6nYUkpHa4ATiGLjwI+zorDx3U2Bcu0RHTgT4HjwMBm
         Y4GNyAQ5ZIGYUe1eCZ8PHtSBAYKDFaleTD3Jn3a88svXfgws183JhQLyfp50xNUwNVJ9
         xm5A==
X-Gm-Message-State: AOAM532NznkL40Hb4lUzI2DqVBugT8T/qm7Rece2pkIZUD//D3onkTQo
        k6sojXYfqXkUxJg2sXA3M9Cwm/zu1EGM/mR0
X-Google-Smtp-Source: ABdhPJwU2CNaJeLuqmB3l3aFxSictglV1OWNtzh7++8qhkJnEj9D7RaSDvUaMSjTCYQwifUc5RUDBg==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr8903096wme.153.1605175040398;
        Thu, 12 Nov 2020 01:57:20 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n15sm6138792wrq.48.2020.11.12.01.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:57:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/3] hwmon: ina3221: Demote seemingly unintentional kerneldoc header
Date:   Thu, 12 Nov 2020 09:57:14 +0000
Message-Id: <20201112095715.1993117-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112095715.1993117-1-lee.jones@linaro.org>
References: <20201112095715.1993117-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/hwmon/ina3221.c:152: warning: Function parameter or member 'ina' not described in 'ina3221_summation_shunt_resistor'

Cc: "Andrew F. Davis" <afd@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hwmon/ina3221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 41fb17e0d6416..72cfdc007e609 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -139,7 +139,7 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
 }
 
-/**
+/*
  * Helper function to return the resistor value for current summation.
  *
  * There is a condition to calculate current summation -- all the shunt
-- 
2.25.1

