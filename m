Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBB2AA3F6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgKGItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgKGItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:49:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F3BC0613D2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 00:49:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7so4526448ybm.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 00:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6WU5XJ/qlfBh5YZsFPkg9rhMeyoErIKJCIfbV8EW5YE=;
        b=dD9J/n8G7DJiDwk4rEqBIeBWf32Gb+p1BKwuSv6yg96ucvQmYVFCsRDdSlkwibS1sE
         vPyCIx1hZ0qWhZV5w52bbGcZkVGWm/SUddyRyVZ/oi1ttKt6h9pRHwkIzrgqDjbV+Ad6
         lbc3ZNGMQrH/srcf1Z+e4ajxyJTsdIMB/b5Ify3Riowa+xpccCWmS8jmsdvSNeLNUysU
         HtkF6iq2a06S9t/IEgfNd4wUvQLOEvSPYL61vslWy2sFYZYH3NBKoeFoM07Xf31CIg4J
         igW5BREAIj2RF32EduPaw4ARttk2oBAtxDR0Hjg5wp7nOtTpCf1f052oAmsMMCJoYae9
         ahug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6WU5XJ/qlfBh5YZsFPkg9rhMeyoErIKJCIfbV8EW5YE=;
        b=CrlANZZXq9nlUlMG8DkrNARHNkLLwV1DXdqHiBHkXh4sTZTBhIeyAfwm6bja6mbs8a
         TykOh2KTK/zx1vMCICFqDn+XLngSenyx9woON2KDoY7ShTbBISlY8BuUKECN5hJnmmvK
         85HWM0exSVv10Ja54nTx6fsClu88ZnOHaEIIsLHjXBwfjKozRHNsSPLPggabu8aRm30m
         3CqGZbjCzLo/udK0+pXrLwlM7LxzkAwkbqB/8WXQN2FZB59ifqJeWzvIunq5s5lUlad5
         oi9m18aLopfkppkfEh8v/NqQGjkLvYqP1EU9qIL9GoHcBLaRbE2HDo7x7Yii737i65Ss
         fchQ==
X-Gm-Message-State: AOAM533Tv4EMIQeJBCJng8CdMdX+HV8Tzh3gqRLt0o6/gAwITxteFpDa
        D32cxmUPUyFqW7CjIqZPt70gE9FYB0G5QrM43V0=
X-Google-Smtp-Source: ABdhPJxIjWsegcqOUyZ9K1yAMY6YrV/UBt+/dKSQPXQWzEHDzYKRIIWBi8IWSXTzOPIWQwR9aNMbAqGiXCApsn9sJbs=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:8404:: with SMTP id
 u4mr3292320ybk.48.1604738988042; Sat, 07 Nov 2020 00:49:48 -0800 (PST)
Date:   Sat,  7 Nov 2020 00:49:39 -0800
In-Reply-To: <CAMj1kXE=V96pJ7xK=9xMh-1Eph4FH7S4WDXDyJUH+82_Zn5DXA@mail.gmail.com>
Message-Id: <20201107084939.3512560-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAMj1kXE=V96pJ7xK=9xMh-1Eph4FH7S4WDXDyJUH+82_Zn5DXA@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2] ACPI: GED: fix -Wformat
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang is more aggressive about -Wformat warnings when the format flag
specifies a type smaller than the parameter. It turns out that gsi is an
int. Fixes:

drivers/acpi/evged.c:105:48: warning: format specifies type 'unsigned
char' but the argument has type 'unsigned int' [-Wformat]
trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
                                            ^~~

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Fixes: ea6f3af4c5e6 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/acpi/evged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index b1a7f8d6965e..fe6b6792c8bb 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -101,7 +101,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 
 	switch (gsi) {
 	case 0 ... 255:
-		sprintf(ev_name, "_%c%02hhX",
+		sprintf(ev_name, "_%c%02X",
 			trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
 
 		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
-- 
2.29.2.222.g5d2a92d10f8-goog

