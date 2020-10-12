Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41128C4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgJLWV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388897AbgJLWVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:23 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0EDC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:22 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 9so13495439pfj.22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sDgp3qm/ugpnk+z4x4KeSqXwj6auWLovvv5/S95lj9Y=;
        b=Axk4HR416fA3as2M3/r8vuSuAGnjGbuBaZzegYEm/GTKv1tcPQr8q2WH8B2+LpC8BO
         qg2DOsdhHq6ud7scQepygkoKHbXbboap7Oq1Bh9w1d876C5PsiLTzo0RZe4RAAqUKx/u
         1wX9K4giNMW86G0q+du0mTTEQsu1JkdoBYpifVsxh0PuMo7mUFf6WX8QNsSS8KBtVSUL
         vyYcn10QQyRKQEIGun2X6fklJ3WJK0fhUSiVobhIs2H/DxM53feTvT9ZcOtCrU0UvVyk
         8rtvXCA/TtmAXsCbwJ4Dbe5dLCn/IXeBCIiyNJEY3J6G6LMpcC3Og9g7xBKVigQgtm8p
         6cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sDgp3qm/ugpnk+z4x4KeSqXwj6auWLovvv5/S95lj9Y=;
        b=m1gn8t1EdmgSghZlVrSfRMYmd7KrbSLx/l6mKAIkvuNH5KGuxHylTf/m1hdQ1cR8Fj
         mfNmIP3e32gGOU+WEPdNynF+RuFYW0GAV5qYJnJ7cnlWx4ibRawaowSkLbAiHVtz4aUd
         yyZrV+pATkzg0CDSHF92rHCTbOF9bNzW53juRcU7GXJmJ4X8NkMxIClsrd2bH25p3Bm7
         N9VfuBAo3pvu20uk4CWIBGbDt0bxdeA5BdD6bMpLkNxEcB9uafh13+o17bLIdK0a8xJE
         H1WUut2VRfH2upg7w/KWUNLGqp9ms4G3NLG+3zSnJGqA8bwYOnLxi8Rw8bX/hBSZ2Nxx
         BFJw==
X-Gm-Message-State: AOAM532ymFoH0ZizgQeHKL82mb6Yijk6zc2Zw0FHTA0QSAGDoAX16P6a
        YO51kMO3dMJo3bGgLNldeuMZMyzVnvqCnQ==
X-Google-Smtp-Source: ABdhPJy5Re8npscP33jZwoNk9byPUI4959EUf0fhcKlQrlm7ua/psQRY2kWt6pP/1eU4PO7HtGUOYK5rf5EyEg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a63:f744:: with SMTP id
 f4mr14710149pgk.34.1602541282218; Mon, 12 Oct 2020 15:21:22 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:41 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 03/12] kunit: test: add concept of post conditions
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

Add a way to specify that certain conditions must be met at the end of a
test case.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h |  6 ++++++
 lib/kunit/test.c     | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 687782fa44d9..0eb3abb00da4 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -190,6 +190,11 @@ struct kunit_suite {
 	char *log;
 };
 
+struct kunit_post_condition {
+	struct list_head node;
+	void (*validate)(struct kunit_post_condition *condition);
+};
+
 /**
  * struct kunit - represents a running instance of a test.
  *
@@ -223,6 +228,7 @@ struct kunit {
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+	struct list_head post_conditions;
 };
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 670d1cc9c105..4e8c74c89073 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -228,6 +228,7 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
+	INIT_LIST_HEAD(&test->post_conditions);
 	test->name = name;
 	test->log = log;
 	if (test->log)
@@ -269,6 +270,16 @@ static void kunit_case_internal_cleanup(struct kunit *test)
 static void kunit_run_case_cleanup(struct kunit *test,
 				   struct kunit_suite *suite)
 {
+	struct kunit_post_condition *condition, *condition_safe;
+
+	list_for_each_entry_safe(condition,
+				 condition_safe,
+				 &test->post_conditions,
+				 node) {
+		condition->validate(condition);
+		list_del(&condition->node);
+	}
+
 	if (suite->exit)
 		suite->exit(test);
 
-- 
2.28.0.1011.ga647a8990f-goog

