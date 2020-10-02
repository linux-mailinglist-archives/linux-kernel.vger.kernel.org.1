Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84C280F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgJBIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:37:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A038C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 01:37:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so842612wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwjcMdmTq96Xqd3GHnyCJp3ca/GopivNTI/Crp8LOuA=;
        b=O1bNQfPf9FYf8MkwuSAj21sPehzaTMnQw4U1k7zIwmtwuL3viB0AAwqHYgjcb7yjqv
         nabv4NgugcjnQL/XZoGWEV/fSnGr4rC4HeKcxYAVdFqsjXqKzJA5isDQ1rWImhIa39i+
         sb4rloLZkqxrYRqK01+Ku7NggAzekIs5An4ULBkpGt2d239LRG3LknPqx/S0ggyoEp3o
         H70j1YCfV9m+hURY6ZVKGRuGyds/F9OySY9NL54uA+oVQfwB3sol9Gs5JNa9bTork4LU
         78S4qjgdZP6VMT02sHY8L52wYfq7PqRfsSYGDqFCUna7rqqMLKhwOO/YWMTkzhbgo3LD
         MRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwjcMdmTq96Xqd3GHnyCJp3ca/GopivNTI/Crp8LOuA=;
        b=XrFytGekegdad99NHzcpacF11Dkd0zWX6nMilufmpCdJslLS58cU0wD2g9ZfYApTRp
         +jcogo6vKuPio3+FbdGdnjigMX/6XAp+YTM38fBjGHt6q0WjMQWfi/QeD05XAyDiw8Me
         zWskL+As7I0MRwpL8SJsao47m1OfDLBkK+VibymRWQM0f9w5ync3sgKRJMjQvTcytdnZ
         L3mLdBJDYIOucXUP/CH9Xw4i1ThFnkc94vu8S0LKalaSOvkS6PbVfYbpXqUzCDV5K6WH
         8yGYcj3s4Luxsx30dz3/chAo9rt8aUDSySrS8On7BIxhSw1q3i4J56KJeJqARrctEdm2
         hfRg==
X-Gm-Message-State: AOAM530pvw9MYkZqRGejkPYj6VTvWGEozclfJCGS9EnxJ5lJXhuCD6P4
        YiGvjj4BHPk7Nx1QrHLdgazsxg==
X-Google-Smtp-Source: ABdhPJwb4kffluMBzNW9jUtXTgdS15XCBC5lZqo+qXtd8VLjB5fecUj6ozK0ZaVMVlkQIU3OPC5v9w==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr1662515wrq.321.1601627826062;
        Fri, 02 Oct 2020 01:37:06 -0700 (PDT)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id u127sm1002753wmu.48.2020.10.02.01.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 01:37:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael.Brunner@kontron.com
Subject: [PATCH 1/1] mfd: kempld-core: Fix unused variable 'kempld_acpi_table' when !ACPI
Date:   Fri,  2 Oct 2020 09:36:54 +0100
Message-Id: <20201002083654.797146-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 drivers/mfd/kempld-core.c:556:36: warning: unused variable 'kempld_acpi_table' [-Wunused-const-variable]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/kempld-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 1dfe556df0385..2c9295953c11e 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -553,11 +553,13 @@ static int kempld_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id kempld_acpi_table[] = {
 	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, kempld_acpi_table);
+#endif
 
 static struct platform_driver kempld_driver = {
 	.driver		= {
-- 
2.25.1

