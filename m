Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D795218838
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 14:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgGHM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbgGHM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:57:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAEBC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:57:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so2962663wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UJ8vNcm1muCjeIL9jJSh2dOgxc35YSiS6mUucMfOFc=;
        b=kb/S5Cg1wIatV2LhM1iD4JFv6D2sAqfQf9Rm2ijGEaDelL3ShSznGpp9wYZyBumYuS
         0s3Lbqx09CjQSw4Msur6M6WO19QXm2F9KBhdb/9lJ+XM0A9cVAup4CTBrFNNHb7sL1Vz
         iLym7lJ2h/vD+wTMv6A5HgG0KWggb1tgJ//5xh9eYz+KFvHANrgtGnU1klxY0bxAku9f
         Ejv2s0iOHsyBtQXf2QBPkHOh15xZqAJ/lZJy8cRtMtdOdGgr+4++PxGXoVT8Tqp3B+U5
         mOaFV3GNCyCoJD8uupwB67n26wGnVA2Xhb9Uv3XEM0legVJd3HzKNWnUtigufV2y8R+K
         u00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UJ8vNcm1muCjeIL9jJSh2dOgxc35YSiS6mUucMfOFc=;
        b=XioQXeNTlwvP4ce9HZoMHX4L08yBQ1ml613ZMZHcaujU0Gb4lIaGjwA260Xj7jfSYO
         BpKTo4gnk8lOHD+jT9Y85BKPaMSPpvFxdfzh3giZymT9Qreq42VAe7+/811BH4DFxvbJ
         8DWqkSlcrxFuj+Uf5Kjn2H7A/T/u3Azufg9iV2y+JnztW3lYPTdSCpRuI+AMnO13ghcK
         7kIb9w06MNTb+agk7gHF433dQEFsJ+5yl7iKamlubsOlhZiMWLZFcBWczNJp2Qyhw/VZ
         pgwTLx0CyPdo4CnNG4TCAcxTJh7/n6SB5mx7wSbWYaDqnWQ6tiWtqscOSjwoHnbiqeu9
         5mSQ==
X-Gm-Message-State: AOAM532JeS0nCQXCI0nhOx1Gv+ttgprciXCCzGhgvzRGUuoMyHCypqsG
        fcP6WiFSXdfJDqQPqj/apy0POQ==
X-Google-Smtp-Source: ABdhPJzUWKqk10DXKwD3WaPIVEJKElMkZ9viUxbnPKGlINpln9ql0M//0OKJ9PZRXALwgiiiXX22KA==
X-Received: by 2002:a1c:6384:: with SMTP id x126mr9644207wmb.144.1594213035996;
        Wed, 08 Jul 2020 05:57:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v9sm6993885wri.3.2020.07.08.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:57:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] misc: eeprom: at24: Tell the compiler that ACPI functions may not be used
Date:   Wed,  8 Jul 2020 13:57:10 +0100
Message-Id: <20200708125711.3443569-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708125711.3443569-1-lee.jones@linaro.org>
References: <20200708125711.3443569-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... as is the case when !CONFIG_ACPI.

Fixes the following W=1 kernel build warning:

 drivers/misc/eeprom/at24.c:228:36: warning: ‘at24_acpi_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 9ff18d4961ceb..2591c21b2b5d8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -225,7 +225,7 @@ static const struct of_device_id at24_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at24_of_match);
 
-static const struct acpi_device_id at24_acpi_ids[] = {
+static const struct acpi_device_id __maybe_unused at24_acpi_ids[] = {
 	{ "INT3499",	(kernel_ulong_t)&at24_data_INT3499 },
 	{ "TPF0001",	(kernel_ulong_t)&at24_data_24c1024 },
 	{ /* END OF LIST */ }
-- 
2.25.1

