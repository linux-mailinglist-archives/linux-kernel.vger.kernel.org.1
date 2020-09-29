Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045AC27D6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgI2TZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2TZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:25:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A82C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:25:54 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m203so3413384qke.16
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rYftVaj976XAVBBPD1tw6YKpSPevzCd8/SePPlUAJ1M=;
        b=siCtqrfjEEMVi2yF63FhGYeZSPJGGgIFsjp02OHmUhBAgvg7nXnxYs0u3Jij+pDOi/
         aaUOWyxYPvHQwt3ucdhvmboX4cgQ7hu4gbFQ2HpdMx6Is0NFW5ycThzrgub3jJ0Ahb6B
         0F48VrKa40b1yLeHahn+d8Ym3XS/8/dS4MskZFES19vpRlIa95obeoTN/m13RVVTJEDB
         fSwqrbc+fQM7+IHe01GrNe09AdxszY23Vc04EF3+xerJYFdHY7rjIqf0qtN8/uoHuYXU
         xkieDcS2BVxCMzqGonbSb9HE18kY2ttjOYwJx6WH3mIln/0djUiI+YLbBYRODu4QU+7B
         Ze2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rYftVaj976XAVBBPD1tw6YKpSPevzCd8/SePPlUAJ1M=;
        b=ZO2mco5AdqIHS/0hFw7gnzGwCv3OFGoY/RYvO4PXWqP2ZJKldU0PIv3XXllN+uXKay
         lBYSxEvYOffq5uJPPf8xaAjFZ8uNoUtap45pd4i5KISomKrqYRFi62w2Tf1piXpq95lv
         jtmAHGTZe9sfo4VSe8sGtR+LquWy20HJQjCSv2wfvCA6r/ZcTJNXOO8l9tjcCzJtbM+O
         s6dtCqPJE5kSsBVRS//khGyK+TeBZsA7RanQElRwQJ5l1VZBV2jsrd1N2QPwr/HzlmXj
         gJ+4UCjJc9pKirHBT20xv2ES9zHt4tF0G/I1O3mXMOupVKicvq5pxk1FBTj5O6omZGMP
         Gb3g==
X-Gm-Message-State: AOAM531bFy3hDb9USeYq0BlHiXHKfMZbpHkIp+XCDyvAHo966WteEvfk
        /vSybRyxwsuHPa/Pa1WcI3LddPvY81qdaNLPMYo=
X-Google-Smtp-Source: ABdhPJwco412wUhwx4p0sbTHmoj7w2c8QO+QNegOV++VsHPsuzZEEydgm6hxQuBFySTARFLRC7RbAziWW5Y0bUifTwA=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:ee6a:: with SMTP id
 n10mr5625188qvs.45.1601407553788; Tue, 29 Sep 2020 12:25:53 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:25:49 -0700
In-Reply-To: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
Message-Id: <20200929192549.501516-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v2] srcu: avoid escaped section names
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stringification operator, `#`, in the preprocessor escapes strings.
For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
they treat section names that contain \".

The portable solution is to not use a string literal with the
preprocessor stringification operator.

Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1->V2:
* drop unrelated Kconfig changes accidentally committed in v1.

 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..9de652f4e1bd 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -124,7 +124,7 @@ struct srcu_struct {
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
 	struct srcu_struct * const __srcu_struct_##name			\
-		__section("___srcu_struct_ptrs") = &name
+		__section(___srcu_struct_ptrs) = &name
 #else
 # define __DEFINE_SRCU(name, is_static)					\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
-- 
2.28.0.709.gb0816b6eb0-goog

