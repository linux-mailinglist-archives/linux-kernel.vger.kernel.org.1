Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0242EE9EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbhAGXtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAGXtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:49:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148DBC0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:48:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b131so13141954ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dn3H8b+dEueAIyMb2RVGjQZHU+d9OmjIpuh9w4CGHNo=;
        b=CyG+eDb1tY9Es+lhDqZWXGA9iQGhjpfvNzCM7r9M8ragFYZSQVJyZtmCSrNBa8fjcb
         w0x0XPQ0L/KqCZdWvPzdnzZUdmJRwZ+Z88kxcaTFJKRBWlKD0a8raCsKEopqxSNlA3I3
         nlalMrW6b1bP76Q7dI7YjLAQr7ka3jtH1Ei525um4yJc4Yl9vTKSAgQ7rIuc6R7iIQAX
         qy+qfTL7khu+3P5qy89nBSG+xiCx3HbXi/5+0DJl/jfGp0xNPAK7VT0l9prXQJ9U27hM
         sWsdmiDN91y/xHBWPdh2y1y4qVo05SCW0836qEcNapKZjFDWaGgnrz3eZqRDSZ7s4byA
         /vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dn3H8b+dEueAIyMb2RVGjQZHU+d9OmjIpuh9w4CGHNo=;
        b=nt1qYM4HEr0CqwNrFJ395NXbYu4e2mJ4h4NckMoSfWl60R8HggfJDRfU4Lt2N6G4Et
         kaWYTs8jbG/qcjXT3RApvV/z5lUT+e1Ass77+KIOf2+VDRBdpzwTUuo/Pxj6B4l2kvj4
         +FHBEAfrclv6SpXqLgnDKxJvlpv7J/59ej1NWDlPgNbLj0mWYIlyUZ+fCtk01puByzTN
         SNbwZ5E/c2j+ShzJrd+a2MLAIab8Iru/2jXm5hhWUHn++wHp8zN24ej3ob+AHOGHRvhQ
         mXPQC0ACghVoj7gJv8+0y2/Ug7BOKrZquxFX+gSDyFeY4Ts196taSfKWxsXkjVIfDlg1
         1xMw==
X-Gm-Message-State: AOAM532rAZp3cBg7NhdREnauapspmUZrBc3fUx0sCEW/yVY9y/BaRfr5
        iSxbrKR6ecuZ8H+So/55Ebrtw0lt0O+Pow==
X-Google-Smtp-Source: ABdhPJyF7FfHOkCPFcIsNF+7Fwb1cTlP2Pd/+mLjhKESCK007O+rDHEeIUnyk7rzcxozHTH7OgmpEvzR2v7n7A==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:743:: with SMTP id
 64mr1689790ybh.333.1610063309333; Thu, 07 Jan 2021 15:48:29 -0800 (PST)
Date:   Thu,  7 Jan 2021 15:48:02 -0800
In-Reply-To: <20210107234803.1096592-1-dlatypov@google.com>
Message-Id: <20210107234803.1096592-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210107234803.1096592-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 2/3] kunit: tool: fix minor typing issue with None status
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com, brendanhiggins@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to handle aggregating statuses didn't check that the status
actually got set to some non-None value.
Default the value to SUCCESS instead of adding a bunch of `is None`
checks.

This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
fail test suites if one of them is empty").

Also slightly simplify the code and add type annotations.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8b5eb9507765..2e4cb5206fa7 100644
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
 
@@ -224,12 +224,11 @@ def parse_ok_not_ok_test_suite(lines: List[str],
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
@@ -282,8 +281,8 @@ def parse_test_plan(lines: List[str]) -> Optional[int]:
 	else:
 		return None
 
-def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
-	return bubble_up_errors(lambda x: x.status, test_suite_list)
+def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
+	return bubble_up_errors(x.status for x in test_suites)
 
 def parse_test_result(lines: List[str]) -> TestResult:
 	consume_non_diagnositic(lines)
-- 
2.29.2.729.g45daf8777d-goog

