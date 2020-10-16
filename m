Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD7290DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408113AbgJPXJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407671AbgJPXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:09:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3055C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so4901300wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LL5NRC0cRVJNqBZIY3Vnesfk3vz5g8to7dyxws6//g=;
        b=eL+60koMwsyvcjNqBBva4am3HrD7R0Mk/MAMKX69iwE+8LKoVLd4bFn6bE0eHTD1a8
         pybTDkHu2I9373x1/HctrF7ICCgGyBGldp0utHtZt+nXoOsQEo0B7ZloQyzhDGnUi4QI
         ESstpz23vYvfc2rFDn4MEgP6Hs/2gW6xF5W2MdSUjV6bCcE4jebP7DXYCIF3J8wXtaKC
         vXtM1KDeouCuOfGrPBB6gFrI8L2gf5FYi+HFxNI4B8rJfX+rewKEHzdqvozoItNZgA1O
         RtR4xP9dXBCq1SDJmnNNeZblxAotKmTItqDdHcoBnlkFHGGlbmlydFNtu3UYZ8gyHQJa
         IJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LL5NRC0cRVJNqBZIY3Vnesfk3vz5g8to7dyxws6//g=;
        b=njDZQse8/9iC1RVSQkolTiOQAbw3CcH2VsDXhe6n5K1KF5Ufw10p+MKfyZWpOhALz7
         OoeoUeW9xYBRvour3+K2WwMHN9ahr4GFQajXvTwU6PG7jmZiFZwLNAawJIk1KiF7vmfY
         H5w5PLiLTLlRSQrirtIzvFUFqima1MXcm9BKsfZ+8ibENVuYG41jolXmQ22c+nO48OdO
         PP1eYCTQk01ed0XWPdE97447UvUMZNWRrJloHPBAXjpM6CWlbEQwqQM36MUXxiohUptB
         h5sCcY1I0xUerEt7AytCjhXsWLB7KTHMjsTLQowO+oIB/5F038JwUAmlNvZq7u0O4AqL
         vNDg==
X-Gm-Message-State: AOAM5319n598DykvjtnwM0JqnGCpLpDojywgzvFQvmbLYe9Y3lxxqljM
        Z4SvR/8bx0S7qJoqAbYvZRxRGpJ3dKnFQg==
X-Google-Smtp-Source: ABdhPJwutZJE8aiWvcNxtLTRLki2GRNZHZiM+YTPOkZuGIVpCqNB5rDOXOX33qg++t0t+HfIIggPyQ==
X-Received: by 2002:adf:f88a:: with SMTP id u10mr6663411wrp.1.1602889778384;
        Fri, 16 Oct 2020 16:09:38 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id n9sm5754512wrq.72.2020.10.16.16.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:09:37 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH resend 2/6] refcount: Move refcount_t definition into linux/types.h
Date:   Sat, 17 Oct 2020 01:09:11 +0200
Message-Id: <20201016230915.1972840-3-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016230915.1972840-1-jannh@google.com>
References: <20201016230915.1972840-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use refcount_t in mm_struct, but if refcount_t is defined in
linux/refcount.h, that header would have to be included in
linux/mm_types.h; that would be wasteful.

Let's move refcount_t over into linux/types.h so that includes can be
written less wastefully.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/refcount.h | 13 +------------
 include/linux/types.h    | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0e3ee25eb156..fd8cf65e4e2f 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -96,22 +96,11 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/limits.h>
+#include <linux/types.h> /* refcount_t is defined here */
 #include <linux/spinlock_types.h>
=20
 struct mutex;
=20
-/**
- * struct refcount_t - variant of atomic_t specialized for reference counts
- * @refs: atomic_t counter field
- *
- * The counter saturates at REFCOUNT_SATURATED and will not move once
- * there. This avoids wrapping the counter and causing 'spurious'
- * use-after-free bugs.
- */
-typedef struct refcount_struct {
-	atomic_t refs;
-} refcount_t;
-
 #define REFCOUNT_INIT(n)	{ .refs =3D ATOMIC_INIT(n), }
 #define REFCOUNT_MAX		INT_MAX
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
diff --git a/include/linux/types.h b/include/linux/types.h
index a147977602b5..34e4e779e767 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -175,6 +175,18 @@ typedef struct {
 } atomic64_t;
 #endif
=20
+/**
+ * struct refcount_t - variant of atomic_t specialized for reference counts
+ * @refs: atomic_t counter field
+ *
+ * The counter saturates at REFCOUNT_SATURATED and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free bugs.
+ */
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
 struct list_head {
 	struct list_head *next, *prev;
 };
--=20
2.29.0.rc1.297.gfa9743e501-goog

