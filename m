Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BC2D7FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394411AbgLKU2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391739AbgLKU1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:27:32 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B9C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:26:52 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id l138so1154397qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jh1XqtLvDRZ9KtNn1sdW0UjgRFvNW446nZaOeAB7XEQ=;
        b=Rp/Ber1PazaD6CR8XIs+gMwGuJN1rXZW5X1bsMBA5PQqCEbuCDKXP+Btvit7hKijAj
         xuxbNTjkuAmn640BYLuKyPECpZxpqrXMM+bQyfleGj1UmUWa19QJm+qWjVARfFeyCgIm
         SZPGaXxngN0ToxT47SbQJStMbJlmyEWVJLptfycngB6fxxX28EeTjZuH2IBEXu5s87H2
         gJzCnQ+i64KxRjCO3rh/BuPndd4Udsfw1uHQUp0QaOD3ZJhmrlnNyeQRXzOFKRiYH9eJ
         sI9eQRwDMp6ChQNA79bfrBFowQpzuemFtNhitNprEg/2vVeUCWfQu6wvT+Zp+CLj2LVr
         W71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jh1XqtLvDRZ9KtNn1sdW0UjgRFvNW446nZaOeAB7XEQ=;
        b=nv+/mfs6P2wtrq99RTze1eah+b1P+sodHaPTdcxW/WbLXYwtoXOTEWLM+bcmfhTZYL
         hjyGMibN4X2qExOAsVm6ZHUVg/hIu6KKGcghxYH9j46Dcc//JG8DW4m4of5GaQ/FKomE
         l2n4FXoyL6FhOlGvXjSoZpkbf8KO80tYfao0yTFpSjMdnpTV8koDdIKDphimeHeczHiL
         MXteaRgNIW7SqmEhoPp5FnZE+iNVQ8cSOeT98hGm+xjoK8oinaSxYOpBtwQb9zHfAogn
         urVuXJccuxq5flKMrh8h/Xvt44Dmb/BBgM9LdjaPXEUO0cBpOjr+DV66pK40s9XyVgdm
         6N0g==
X-Gm-Message-State: AOAM533W22trsjJeIdt21Q0LWWOY8IDd0YabEx/dphRJVwKgGq1Lotqz
        ErQAiuJuCnLlQeotsFX0HDP/20/tbcsb/14=
X-Google-Smtp-Source: ABdhPJyeAVoTr4wNBWHCj4NIBHqSWcVqceHvJyWOTIsttVH+dT6tPZ/WHMHPM/k6VhxGIziibEIIhynyUEKyJKs=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a05:6214:14ef:: with SMTP id
 k15mr18232951qvw.45.1607718411313; Fri, 11 Dec 2020 12:26:51 -0800 (PST)
Date:   Fri, 11 Dec 2020 12:26:29 -0800
Message-Id: <20201211202629.2164655-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] ACPI: Use fwnode_init() to set up fwnode
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Qian Cai <qcai@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 01bb86b380a3 ("driver core: Add fwnode_init()") was supposed to
fix up all instances of fwnode creation to use fwnode_init(). But looks
like this instance was missed. This causes a NULL pointer dereference
during device_add() [1]. So, fix it.

[   60.792324][    T1] Call trace:
[   60.795495][    T1]  device_add+0xf60/0x16b0
__fw_devlink_link_to_consumers at drivers/base/core.c:1583
(inlined by) fw_devlink_link_device at drivers/base/core.c:1726
(inlined by) device_add at drivers/base/core.c:3088
[   60.799813][    T1]  platform_device_add+0x274/0x628
[   60.804833][    T1]  acpi_iort_init+0x9d8/0xc50
[   60.809415][    T1]  acpi_init+0x45c/0x4e8
[   60.813556][    T1]  do_one_initcall+0x170/0xb70
[   60.818224][    T1]  kernel_init_freeable+0x6a8/0x734
[   60.823332][    T1]  kernel_init+0x18/0x12c
[   60.827566][    T1]  ret_from_fork+0x10/0x1c
[   60.838756][    T1] ---[ end trace fa5c8ce17a226d83 ]---

[1] - https://lore.kernel.org/linux-arm-kernel/02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com/
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Reported-by: Qian Cai <qcai@redhat.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Greg,

Can you please pull this into driver-core-next since the commit that
causes this is only present in driver-core-next?

-Saravana

 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 39263c6b52e1..2630c2e953f7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -55,7 +55,7 @@ static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 	if (!fwnode)
 		return NULL;
 
-	fwnode->ops = &acpi_static_fwnode_ops;
+	fwnode_init(fwnode, &acpi_static_fwnode_ops);
 
 	return fwnode;
 }
-- 
2.29.2.576.ga3fc446d84-goog

