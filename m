Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D128C4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389590AbgJLWWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388871AbgJLWVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:53 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB2C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b7so5099905qkh.20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bC8bc00tDP9ynAbL7H/K4risArdoFSp41x3R2A78u04=;
        b=CHeTDQjDQWk5SugZGUsEbJWXZVoztLD39IQw73+TiXG0em9ZzdG1BuIpf9eRPn8aeB
         GWSfpQjI9D/ReFvjMd8JGGQYFg5mljDB2bxYZYBlvh69C34PGI5aIjareTWZZWn98pv0
         pD5UBgTeGviwXlBuhRisgLGdq1TrDgdN0vvKlJLl0OOZ6ApM7/BqE23f3QKGYcXfpY8d
         1ktSmP8kfEW5iDFzA3ft5RcHEiFrUn+ztBnloGP0yYuqDze4W7/wpz9cuxQWjx5rlItO
         iEQ68vik4Y7PeFGWY3T+QNrLihYxAPnTtd3qwzTo9iJcflq65ORB6N4CFX9oSHH8TBZA
         n2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bC8bc00tDP9ynAbL7H/K4risArdoFSp41x3R2A78u04=;
        b=rkt2nGqptHCr2Ah9KnyjxdXfVHSNYEROkV4ZxCRYauuhbn48ifL+wBxP5rFQdVJLGh
         8QJm6k5UxlVj+9dlnElKi4roCye47zr14yZdC7Bf+Q84TdLznO4YCKi78c37mcM9JSO2
         lk1CKnQzZSnGnWInnF5RA648c+pCpI8UMHHyYWfxJEZoHt+cT72Uyhr6vF6Jn0a4bHuO
         Gr0R3Bgjc7VwI1mlI1kLYbln91w3P4wk/qPhmZBOZr64jskMuEzE/wHuIERG1b8XWnAU
         vTyAYUeJB7ZIPFeEju85xWi/TfWlzQZs7Hj0mjdWqsD2gYDKhp/Wfk/wqWKhyGfky0ql
         7THA==
X-Gm-Message-State: AOAM531PZ7JnV5W5GTenwz/+pqUbObIaRrn108alyEG6+zRNDuV+J4i2
        iqTp5IuiqvHVOPkBwJGZnCKyOV0Ar2yJpw==
X-Google-Smtp-Source: ABdhPJyiX8+zF0fcLXehSLljEM5NsLHgQTcclOSA1APGR/J55WSVCeeSczEIyl0nWkmhxyfo2oWO7Oaffboong==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:ad4:5843:: with SMTP id
 de3mr27933829qvb.12.1602541297970; Mon, 12 Oct 2020 15:21:37 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:49 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-12-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 11/12] kunit: mock: add struct param matcher
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

Add parameter matcher builder for matching struct values.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/mock.h     |  58 +++++++++++++++++++
 lib/kunit/common-mocks.c | 117 +++++++++++++++++++++++++++++++++++++++
 lib/kunit/mock-test.c    |  40 +++++++++++++
 3 files changed, 215 insertions(+)

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 9252a0abd295..df99ae5ac721 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -758,8 +758,18 @@ struct mock_param_matcher *kunit_ptr_ge(struct kunit *test, void *expected);
 struct mock_param_matcher *kunit_memeq(struct kunit *test,
 				      const void *buf,
 				      size_t size);
+
 struct mock_param_matcher *kunit_streq(struct kunit *test, const char *str);
 
+struct mock_param_matcher *kunit_str_contains(struct kunit *test,
+					      const char *needle);
+
+/* Matches var-arg arguments. */
+struct mock_param_matcher *kunit_va_format_cmp(
+		struct kunit *test,
+		struct mock_param_matcher *fmt_matcher,
+		struct mock_param_matcher *va_matcher);
+
 struct mock_action *kunit_u8_return(struct kunit *test, u8 ret);
 struct mock_action *kunit_u16_return(struct kunit *test, u16 ret);
 struct mock_action *kunit_u32_return(struct kunit *test, u32 ret);
@@ -778,4 +788,52 @@ struct mock_action *kunit_ulonglong_return(struct kunit *test,
 					  unsigned long long ret);
 struct mock_action *kunit_ptr_return(struct kunit *test, void *ret);
 
+/**
+ * struct mock_struct_matcher_entry - composed with other &struct
+ *                                    mock_struct_matcher_entry to make a
+ *                                    &struct struct_matcher
+ * @member_offset: offset of this member
+ * @matcher: matcher for this particular member
+ *
+ * This is used for struct_cmp() matchers.
+ */
+struct mock_struct_matcher_entry {
+	size_t member_offset;
+	struct mock_param_matcher *matcher;
+};
+
+static inline void init_mock_struct_matcher_entry_internal(
+		struct mock_struct_matcher_entry *entry,
+		size_t offset,
+		struct mock_param_matcher *matcher)
+{
+	entry->member_offset = offset;
+	entry->matcher = matcher;
+}
+
+/**
+ * INIT_MOCK_STRUCT_MATCHER_ENTRY()
+ * @entry: the &struct mock_struct_matcher_entry to initialize
+ * @type: the struct being matched
+ * @member: the member of the struct being matched, used to calculate the offset
+ * @matcher: matcher to match that member
+ *
+ * Initializes ``entry`` to match ``type->member`` with ``matcher``.
+ */
+#define INIT_MOCK_STRUCT_MATCHER_ENTRY(entry, type, member, matcher)	       \
+		init_mock_struct_matcher_entry_internal(entry,		       \
+							offsetof(type, member),\
+							matcher)
+
+static inline void INIT_MOCK_STRUCT_MATCHER_ENTRY_LAST(
+		struct mock_struct_matcher_entry *entry)
+{
+	entry->matcher = NULL;
+}
+
+struct mock_param_matcher *kunit_struct_cmp(
+		struct kunit *test,
+		const char *struct_name,
+		struct mock_struct_matcher_entry *entries);
+
 #endif /* _KUNIT_MOCK_H */
diff --git a/lib/kunit/common-mocks.c b/lib/kunit/common-mocks.c
index ce8929157ded..6a4cc9c60427 100644
--- a/lib/kunit/common-mocks.c
+++ b/lib/kunit/common-mocks.c
@@ -228,6 +228,123 @@ struct mock_param_matcher *kunit_streq(struct kunit *test, const char *str)
 	return &matcher->matcher;
 }
 
+struct mock_str_contains_matcher {
+	struct mock_param_matcher matcher;
+	const char *needle;
+};
+
+static bool match_str_contains(struct mock_param_matcher *pmatcher,
+			       struct kunit_stream *stream,
+			       const void *phaystack)
+{
+	struct mock_str_contains_matcher *matcher =
+		container_of(pmatcher,
+			     struct mock_str_contains_matcher,
+			     matcher);
+	const char *haystack = CONVERT_TO_ACTUAL_TYPE(const char *, phaystack);
+	bool matches = strstr(haystack, matcher->needle);
+
+	if (matches)
+		kunit_stream_add(stream,
+				 "'%s' found in '%s'",
+				 matcher->needle,
+				 haystack);
+	else
+		kunit_stream_add(stream,
+				 "'%s' not found in '%s'",
+				 matcher->needle,
+				 haystack);
+	return matches;
+}
+
+struct mock_param_matcher *kunit_str_contains(struct kunit *test,
+					      const char *str)
+{
+	struct mock_str_contains_matcher *matcher;
+
+	matcher = kunit_kzalloc(test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	matcher->matcher.match = match_str_contains;
+	matcher->needle = str;
+
+	return &matcher->matcher;
+}
+
+struct mock_param_matcher *kunit_va_format_cmp(
+		struct kunit *test,
+		struct mock_param_matcher *fmt_matcher,
+		struct mock_param_matcher *va_matcher)
+{
+	struct mock_struct_matcher_entry *entries;
+
+	entries = kunit_kzalloc(test, sizeof(*entries) * 3, GFP_KERNEL);
+	if (!entries)
+		return NULL;
+
+	INIT_MOCK_STRUCT_MATCHER_ENTRY(&entries[0],
+				       struct va_format,
+				       fmt,
+				       fmt_matcher);
+	INIT_MOCK_STRUCT_MATCHER_ENTRY(&entries[1],
+				       struct va_format,
+				       va,
+				       va_matcher);
+	INIT_MOCK_STRUCT_MATCHER_ENTRY_LAST(&entries[2]);
+
+	return kunit_struct_cmp(test, "va_format", entries);
+}
+
+struct mock_struct_matcher {
+	struct mock_param_matcher matcher;
+	const char *struct_name;
+	struct mock_struct_matcher_entry *entries;
+};
+
+static bool match_struct(struct mock_param_matcher *pmatcher,
+			 struct kunit_stream *stream,
+			 const void *pactual)
+{
+	struct mock_struct_matcher *matcher =
+			container_of(pmatcher,
+				     struct mock_struct_matcher,
+				     matcher);
+	struct mock_struct_matcher_entry *entry;
+	const char *actual = CONVERT_TO_ACTUAL_TYPE(const char *, pactual);
+	const char *member_ptr;
+	bool matches = true, tmp;
+
+	kunit_stream_add(stream, "struct %s {", matcher->struct_name);
+	for (entry = matcher->entries; entry->matcher; entry++) {
+		member_ptr = actual + entry->member_offset;
+		tmp = entry->matcher->match(entry->matcher, stream, member_ptr);
+		matches = matches && tmp;
+		kunit_stream_add(stream, ", ");
+	}
+	kunit_stream_add(stream, "}");
+
+	return matches;
+}
+
+struct mock_param_matcher *kunit_struct_cmp(
+		struct kunit *test,
+		const char *struct_name,
+		struct mock_struct_matcher_entry *entries)
+{
+	struct mock_struct_matcher *matcher;
+
+	matcher = kunit_kzalloc(test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	matcher->matcher.match = match_struct;
+	matcher->struct_name = struct_name;
+	matcher->entries = entries;
+
+	return &matcher->matcher;
+}
+
 #define DEFINE_RETURN_ACTION_STRUCT(type_name, type)			       \
 		struct mock_##type_name##_action {			       \
 			struct mock_action action;			       \
diff --git a/lib/kunit/mock-test.c b/lib/kunit/mock-test.c
index 8a0fa33d087c..df0969b43ade 100644
--- a/lib/kunit/mock-test.c
+++ b/lib/kunit/mock-test.c
@@ -243,6 +243,45 @@ static void mock_test_do_expect_default_return(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
 }
 
+/*
+ * Method called on naggy mock with no expectations will not fail, but will show
+ * a warning message
+ */
+static void mock_test_naggy_no_expectations_no_fail(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+
+	int param0 = 5, param1 = -5;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+
+	mock_set_default_action(mock,
+				"add",
+				real_add,
+				kunit_int_return(failing_test, -4));
+
+
+	KUNIT_EXPECT_CALL(mock_add(
+			mock,
+			kunit_any(failing_test),
+			kunit_va_format_cmp(failing_test,
+					    kunit_str_contains(failing_test,
+							       "Method was called with no expectations declared"),
+					    kunit_any(failing_test))));
+
+	mock->do_expect(mock,
+			"add",
+			real_add,
+			two_param_types,
+			two_params,
+			ARRAY_SIZE(two_params));
+	mock_validate_expectations(mock);
+
+	KUNIT_EXPECT_FALSE(test, failing_test->success);
+}
+
 static void mock_test_mock_validate_expectations(struct kunit *test)
 {
 	struct mock_test_context *ctx = test->priv;
@@ -307,6 +346,7 @@ static struct kunit_case mock_test_cases[] = {
 	KUNIT_CASE(mock_test_failed_expect_call_fails_test),
 	KUNIT_CASE(mock_test_do_expect_default_return),
 	KUNIT_CASE(mock_test_mock_validate_expectations),
+	KUNIT_CASE(mock_test_naggy_no_expectations_no_fail),
 	{}
 };
 
-- 
2.28.0.1011.ga647a8990f-goog

