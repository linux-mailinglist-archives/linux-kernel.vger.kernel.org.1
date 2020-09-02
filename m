Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB87825AF22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgIBPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:34:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33210 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgIBPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:19:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id r13so6404531ljm.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsbOuaSUjgAzeexavqDg8BNI1kBauuGj+WofnxN6QNY=;
        b=cc1AGaoj0OcvL/+WPcH7sDlbjvjHWZdYWW1q94LCOk1uxB5ZaU7zbhqsz7hhXLyUhP
         pvbozpU142DE3/zGjqQJqreV8zgFTE6wW+X4EqIimePc2UL+c9+QGlJb5GoV8e8YVlWK
         wFtKD0ZOp3a8EK0gbFPtNczcblx3/vk2MoJ7bSJ6RweAlvZQynpQbrNfPumR4jo/ykXN
         1BMu5zoDRM6EC4IUxo3oBjtPSO3ZWMRA0+WNYeS4G0SFoTlTNql73bcNYkf9oPeNR5hr
         CPtNWVagDNe9DsjdEoIBNzEot5eda77bdGtd5jVmpnss0HlNrhCYWThVvNl/9Acw63Wb
         prnQ==
X-Gm-Message-State: AOAM533BhfnqyxhAKDbs6FOZVTukleSdnLWyZQg6EP8YLZCX3qkPAQlE
        2FRkxjlfJpoq8gxC/EX+7Jw=
X-Google-Smtp-Source: ABdhPJzACUXTQXy8Xb64npDMdaJF3tKdaUBc6OWlHTbLKCrBuYLg4OLJRN9ayI7m+UELp0ovEVY3+w==
X-Received: by 2002:a05:651c:310:: with SMTP id a16mr3378753ljp.250.1599059947599;
        Wed, 02 Sep 2020 08:19:07 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id n8sm1036690ljj.69.2020.09.02.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:19:06 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: misc: add excluded_middle.cocci script
Date:   Wed,  2 Sep 2020 18:18:59 +0300
Message-Id: <20200902151859.403354-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for "!A || A && B" condition. It's equivalent to
"!A || B" condition.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/excluded_middle.cocci | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 scripts/coccinelle/misc/excluded_middle.cocci

diff --git a/scripts/coccinelle/misc/excluded_middle.cocci b/scripts/coccinelle/misc/excluded_middle.cocci
new file mode 100644
index 000000000000..1b8c20f13966
--- /dev/null
+++ b/scripts/coccinelle/misc/excluded_middle.cocci
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Condition "!A || A && B" is equalent to "!A || B".
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r depends on !patch@
+expression A, B;
+position p;
+@@
+
+* !A || (A && B)@p
+
+@depends on patch@
+expression A, B;
+@@
+
+  !A || 
+-      (A &&
+             B
+-      )
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING condition !A || A && B is equivalent to !A || B")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING condition !A || A && B is equivalent to !A || B")
-- 
2.26.2

