Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4E2AA3E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgKGIen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKGIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:34:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA3C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 00:34:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x197so4535805ybg.18
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Z1peopUQ0CXJcnmm3Y1iXQw/XLE0Jshqm+lf7SqAfcA=;
        b=ljoBwQSYeuvhSAm05Tb8i9IjvzUi2f9jfINj73VmVc0oHO1K+tLPdjZfs/7fHxJ4Zg
         M4r7Y7HSH212OENIhVPZXNEZdCOhGxYuNm3F3hktzk1t64hSVnYEq72r1jbUYXQCigQZ
         FSHlH5bRWBwmHB7mM4WOK4FqSdiPP/l4x2SL+sGyMFNPuIEuuu1KtFpMoelEt96svhee
         q3OqD9B2RwumGf0HzoIJSID4KWqU8RZxG+Wb2TJ40/vyVlG4G3sNo/7FGU/wMlOWbvcA
         mQZk/looCHFKwfFM81fXiCVvxXSjBE8Dl82hNtH2o/Pk5QLkmWAmblmJYYM5HJgNJBfg
         4faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Z1peopUQ0CXJcnmm3Y1iXQw/XLE0Jshqm+lf7SqAfcA=;
        b=YV9rZwkdkBByuZn2GTzd+vdyRbCjQZjJ/pmWZqLNtJ4RwVuJJ+7Pof0THA6GdOIKkX
         Kr5dN0QIEK8lVrwIHOVaNAaNmCAwDv1doMqYC0CjphBllwCLg2fKb5ueV+ld2rtaHRr4
         TuVwwj06wq9cnA3bkrRt66FYqIoPoJI2MEy2Y+oXpsmvdb/nQukJNDbc6UjusMRxw+SL
         yvD281387b6MF0iOBo3LnH/Fg/ff1jFhKkVnd6Vm4tM7uyOW0oD/3EeoyDLAjmZlpem6
         8u32iKVSKX3uRBKkPlRUwrCVaGxRtpP6+DKowtdfbQW+3KHgRWJO5vEECfE3mRl2Euz3
         T5JQ==
X-Gm-Message-State: AOAM530tssZu4x7+Va37ZkwbjbPGp0hcS+A7nJCUcqy2PY2M3gEJn+X2
        de9d2DObtm1Y12ujeD38zQkFh/kvTFh/PbtC2Lo=
X-Google-Smtp-Source: ABdhPJzjQVKzDOUD8t863oyfAR/B79KgYVM6UYlPHGButDCCQosno5E9YKHuoNnqgIbwcIAXjWrI2nd0GbIGErKO4xE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:ca8e:: with SMTP id
 a136mr7465151ybg.101.1604738081544; Sat, 07 Nov 2020 00:34:41 -0800 (PST)
Date:   Sat,  7 Nov 2020 00:34:31 -0800
Message-Id: <20201107083432.3175710-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] ACPI: GED: fix -Wformat
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
Fixes: commit ea6f3af4c5e6 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
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

