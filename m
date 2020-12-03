Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3702CDF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgLCTm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgLCTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:42:28 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D596C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:41:48 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id z129so2900883qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fRL+7v3rmlgRYZxPcocyMlLPIB8fUkWUtjpMKbwZgSs=;
        b=HR5JWJJPOZ7Ec7eWs3CmoQMKGyz+ZHe5RxCDZKihsi6pdIM81BYtBj5pcpuf27X2DR
         uoODWTf6jwt3AlbavidScxHO7gAOdtbByHvstAx1cvPkTcfwiZrS2xgHXtKEi11lM20m
         e5Sl+DeMdS80EgLt/wEfoIarKnxZCTDWO7fumHsgSXaItJQa0Hx8+uLsjNuyW2ikCGx0
         EOwpto55/a9OQ2JFK2gfKlppHLndQlD8Px53lTqQWe1lmOpFFdgOk4fKZWJ3Lt3cQm9Y
         N0bv7koYR5FgZ/4YkHL2+r0LXwY7yk+ZichmIhdDzHI29v6qAlXp0VNA5Yc9SqH0onAn
         Q4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fRL+7v3rmlgRYZxPcocyMlLPIB8fUkWUtjpMKbwZgSs=;
        b=RMFNitU1a2DQkKc980JNeuIr+WLRKoicwLlVffsgbDD44F41eF1JhtnIl0YWSo9Ewg
         FoS40JPZM9+trNo7EWWJNC72bmFjuf+KFtu9b9wuwNkh2EvSWJUrQhUk2n58oCQOQoc9
         co3D0z2ClV0l+CrmBMqCA9eMCTQf7Uzq8ukMGU2n/dcItARaQJKD3FT6G5FoZGUPwODe
         n6qp00DjkuZvG3H0E2ADhLpyIcD0MWOcU9654UwpvuoI27p2jGw2T87l80vFL6gBVBAj
         qJI55Q555K1sRlO7zdrdLzR8eW5E5yWRXNb+aeD+OgGbp1LS0G2gBUqe8PKO7UOMdBzC
         IeNA==
X-Gm-Message-State: AOAM531LVWx/lGsL7YP7vAb3hNI8IXrPd0zPUkRLmBeLM15eQVtiWU7w
        JHpPARoNfIVPUqdJtzrPm4ayyZktoDj7mA==
X-Google-Smtp-Source: ABdhPJyuGfTPThJsDE8zbQC4MiItyCEOXdcRuVuVXSlJ0XzOj926kN4Cs+HQ8D4jiZysdE+UN5lPxE0fFdiNCg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:ad4:4743:: with SMTP id
 c3mr720671qvx.62.1607024507741; Thu, 03 Dec 2020 11:41:47 -0800 (PST)
Date:   Thu,  3 Dec 2020 11:41:26 -0800
In-Reply-To: <20201203194127.1813731-1-dlatypov@google.com>
Message-Id: <20201203194127.1813731-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 2/3] kunit: tool: fix minor typing issue with None status
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to handle aggregating statuses didn't check that the status
actually got set.
Default the value to SUCCESS.

This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
fail test suites if one of them is empty").

Also slightly simplify the code and add type annotations.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 24954bbc9baf..97e070506c31 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,13 +12,13 @@ from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
-from typing import Iterator, List, Optional, Tuple
+from typing import Iterable, Iterator, List, Optional, Tuple
 
 TestResult = namedtuple('TestResult', ['status','suites','log'])
 
 class TestSuite(object):
 	def __init__(self) -> None:
-		self.status = None  # type: Optional[TestStatus]
+		self.status = TestStatus.SUCCESS
 		self.name = ''
 		self.cases = []  # type: List[TestCase]
 
@@ -30,7 +30,7 @@ class TestSuite(object):
 
 class TestCase(object):
 	def __init__(self) -> None:
-		self.status = None  # type: Optional[TestStatus]
+		self.status = TestStatus.SUCCESS
 		self.name = ''
 		self.log = []  # type: List[str]
 
@@ -223,12 +223,11 @@ def parse_ok_not_ok_test_suite(lines: List[str],
 	else:
 		return False
 
-def bubble_up_errors(to_status, status_container_list) -> TestStatus:
-	status_list = map(to_status, status_container_list)
-	return reduce(max_status, status_list, TestStatus.SUCCESS)
+def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
+	return reduce(max_status, statuses, TestStatus.SUCCESS)
 
 def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
-	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
+	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
 def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
@@ -281,8 +280,8 @@ def parse_test_plan(lines: List[str]) -> Optional[int]:
 	else:
 		return None
 
-def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
-	return bubble_up_errors(lambda x: x.status, test_suite_list)
+def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
+	return bubble_up_errors(x.status for x in test_suites)
 
 def parse_test_result(lines: List[str]) -> TestResult:
 	consume_non_diagnositic(lines)
-- 
2.29.2.576.ga3fc446d84-goog

