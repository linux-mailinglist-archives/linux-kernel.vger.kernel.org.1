Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A162FB1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbhASGk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbhASFi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:38:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 21:38:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 6so11185126wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 21:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XX+GcnJWFNmw4pPkSAczCPMjkjBOlKlFbVbcSZZHlMo=;
        b=e8Azb0b3752U0MGs0NMvksUADjPzjs95CAThdERibGogl72NUxHvz2693VBAgUVWkz
         nSb+Q2A6pcQhfF5qoHRvH3LkYtfC+v72kS1aYxfDt07HXcoia6xHtC+tFgLmCYetC+xs
         TAQs2SDH48MX5FdtMrKScjnujdGdUee3xHh5fKtQWnPw4lJNF+OceQaQGOttvAUz7ix6
         PB8X1T2s5ANiCFzuu//1EtHhwxkVkdiiH4E0bSYhZ4o8JQrnd9dgBIwABAmAusAi6mh1
         ysFGNXqUjeSeyWRJ46HQ1POdsmvI++Fbu0kJzuJM5R4ZgbJCVoHPjFyfdsHAhKbYqOtO
         wpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XX+GcnJWFNmw4pPkSAczCPMjkjBOlKlFbVbcSZZHlMo=;
        b=DthnGS1oUOnZrPe5v2Q/gt1yIL4tIsmfYTlNaSLRWAAgAKkB9u6iuaGEJ+QZpuON9E
         P8Emn7dstnXDfaxMM1OcgBZMdn3W9GCGdyI/40cllg5XV2n6mSemTzXQynlKlNrJtSMD
         O7vZs9z4kjxEIhkdCghBnRmQYWR+vIUrV0M+/SpcAw7G4jm8VGEIGY9bDNk0gzRf+eH/
         P29Xk/bT2LMX64HS9B9P9gDSOK50468wjx7nHdbMenn3PrN1r1FaC+uHZauTQVZQ50we
         TMCXtGPo1NAtNTWj/cKJYA5WkBDhmf6bzLV+w8uSlgf/YpnqKDuvzIRYxaF3nfepplOl
         sM8w==
X-Gm-Message-State: AOAM530SoY5I/0KBV37cvFBenYLNe7Qgxb1pLKdp9otU2s7xM3gSR6Jt
        FYSQGOtk/qWPFLUlNT1rq3o=
X-Google-Smtp-Source: ABdhPJxHj6fbLbORiCd6frpNM6z80UEInPe44op3po+f8X6D4XAuJGqUxLxsZTHV+2XhtPyFnBPqLg==
X-Received: by 2002:a05:6000:368:: with SMTP id f8mr2533464wrf.150.1611034691277;
        Mon, 18 Jan 2021 21:38:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:222:220b::2])
        by smtp.gmail.com with ESMTPSA id q9sm2641181wme.18.2021.01.18.21.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 21:38:10 -0800 (PST)
From:   Isaac Chen <tingyi364@gmail.com>
To:     TonyWWang-oc@zhaoxin.com
Cc:     linux-kernel@vger.kernel.org, Isaac Chen <tingyi364@gmail.com>
Subject: [PATCH] x86/cpu/zhaoxin: Fix wrong lowercase naming
Date:   Tue, 19 Jan 2021 13:37:53 +0800
Message-Id: <20210119053753.23937-1-tingyi364@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <a0fe603b-098c-65d7-9d60-f0365b7302ce@zhaoxin.com>
References: <a0fe603b-098c-65d7-9d60-f0365b7302ce@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is printed during kernel boot, match it with other supported x86 cpus.
    [    0.000000] KERNEL supported cpus:
    [    0.000000]   Intel GenuineIntel
    [    0.000000]   AMD AuthenticAMD
    [    0.000000]   Hygon HygonGenuine
    [    0.000000]   Centaur CentaurHauls
    [    0.000000]   zhaoxin   Shanghai
Keep identification string match with CPUID.

Signed-off-by: Isaac Chen <tingyi364@gmail.com>
---
 arch/x86/kernel/cpu/zhaoxin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 05fa4ef63490..77c33ed80a67 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -120,7 +120,7 @@ zhaoxin_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 #endif
 
 static const struct cpu_dev zhaoxin_cpu_dev = {
-	.c_vendor	= "zhaoxin",
+	.c_vendor	= "Zhaoxin",
 	.c_ident	= { "  Shanghai  " },
 	.c_early_init	= early_init_zhaoxin,
 	.c_init		= init_zhaoxin,
-- 
2.27.0

