Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22024272A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgIUP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:29:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46538 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgIUP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:29:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id b22so14456851lfs.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6tgcOAvkDKfi/2+T+2xL+Uc3W4IOMeRY4n7RmB/zy8=;
        b=iyuVePQEQSjz4teM3TGq8VDK7yiURMxbIuCB7FUwMokctWCsVMpNX6KuzjOq9Qa2zU
         3b8cOqQMQ1cfrgGS0K7eAtQxwIHqWKrbE8iZWgd/6IzwXKI9ZXwdpF8W5CFTu+O08q4P
         7fvKedOGOd6ndbTDz3UFNuWL1WWzfDEGCFgTOvFM95G/8p6Rf2M8sz1qjtFQXD4Nwh1c
         C+Oi9hSzo770wVzUDp6l+M7XJfQJyhF8h+AnYGbM+snxuVJ8VDnPPd1pIbSIAb/2c812
         sVhAgMuZ6WF/kRcJilN0yLbMS/QruWy8OSwgCIcgkgG3WlyPubGvLDzEi8tKXakIv7rc
         TTyw==
X-Gm-Message-State: AOAM532sTBcYXSJ7dVNt9fn32i/RnUMTJsQ6RQlPugPKOn0RhSC3W+Rv
        XuLGe63IbBG/pbpsiq61V5/SrwY/D7g=
X-Google-Smtp-Source: ABdhPJx5Zk00p9P5rnXFyIkIDMNgevgZ+WLQx7FkDDwOv1k1DmzMXbT+QzaYbuQ/B4beKo9mYRltgw==
X-Received: by 2002:a19:be86:: with SMTP id o128mr154937lff.220.1600702163141;
        Mon, 21 Sep 2020 08:29:23 -0700 (PDT)
Received: from green.intra.ispras.ru (winnie.ispras.ru. [83.149.199.91])
        by smtp.googlemail.com with ESMTPSA id w4sm2626579lff.231.2020.09.21.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 08:29:22 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: misc: add excluded_middle.cocci script
Date:   Mon, 21 Sep 2020 18:28:50 +0300
Message-Id: <20200921152850.59194-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902151859.403354-1-efremov@linux.com>
References: <20200902151859.403354-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for !A || A && B condition. It's equivalent to !A || B.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - spelling mistake fixed
 - position variable moved on the && operator
 - patch pattern changed to - (A && B)
 - word "condition" removed from warning message

 scripts/coccinelle/misc/excluded_middle.cocci | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 scripts/coccinelle/misc/excluded_middle.cocci

diff --git a/scripts/coccinelle/misc/excluded_middle.cocci b/scripts/coccinelle/misc/excluded_middle.cocci
new file mode 100644
index 000000000000..ab28393e4843
--- /dev/null
+++ b/scripts/coccinelle/misc/excluded_middle.cocci
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Condition !A || A && B is equivalent to !A || B.
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
+* !A || (A &&@p B)
+
+@depends on patch@
+expression A, B;
+@@
+
+  !A ||
+-       (A && B)
++       B
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING !A || A && B is equivalent to !A || B")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING !A || A && B is equivalent to !A || B")
-- 
2.26.2

