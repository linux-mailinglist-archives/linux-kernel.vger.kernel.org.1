Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA60B2CC642
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbgLBTJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389599AbgLBTJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:09:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26529C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:09:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 4so2989245ybv.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LaYOodOz6PHC9js4K1TKag05C3DcrBBHqvjyVy43Jqc=;
        b=fl3D1QpAZ+NCjnrqMzc2jrvICaUs7Q3ZnbRRtEbl1II19wv8qjw6tmbT9bM6CLqGRo
         dV9Lx2PqN7k8SlHh02T1m4GW2rlkvpWEydP/F4VNNZr/bBSa77yIh95ba+P7s1oSK89H
         bLu/aFyveBcpVYG47LS5s1pXg3axmlNheXuyyWAvaDnAWcsBTtPyIgpxptSZxWlO5ekC
         nFukXuJHMwaKQIfqjIKVOc+86P84V05o0VQmiGgicXDRdKuSXNIPF/U514ae3Tb0A4BX
         /Dd0od3QHy7/rCD1eUOnFN723t+Hvuf6lIhEwaFrBBDA0d1TVhawqZ06PlkibdEEXW/f
         JaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LaYOodOz6PHC9js4K1TKag05C3DcrBBHqvjyVy43Jqc=;
        b=bgujSG5eMAr9Yp5GgB56568lb0TSPUelUW+SuzMtNgX+VmFLNVu+Zi39y5+c8xXlQp
         u0yH0DnCrS92JzQZ4Oc4smggeRnfe8FxBq8LRl3JoihXBnboP/4iqxHTjLlX0Ur5Ywpx
         o5WYlZGFjaMRMCSF9VObv62i5v5YypxkF4Rx+6KyCPpUNGUhvH+GoInplnJD09MEttHc
         nGeJRwxocqwQWoVF8v3PipVqzQ7uOqenQR1NGKMfdMryttE5ioqxXwAtQw1ZZUV1KFwF
         6JXtfw4Plvwnl5MtjjjyabE6Lq7OyLu99V9BlYN8cj+l9uGFFol5SS5XJcKJz/KEZVPe
         O5TA==
X-Gm-Message-State: AOAM530c6yKWVQ8Qawk8A9wvFcxFHbEWepV75AZ5t8bUJRSDLXNh1LpU
        s6yaH8ySwiv2HYFmYCUWMXk1FlGeHS3t9Q==
X-Google-Smtp-Source: ABdhPJziALyfJnuN3AAJNi2ehoDUXGPN2+qhrVRgqdzwMctq3MSPF8RuvMv6/3jDJ7UQwl79wXiQJTHIbOVRTg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:aad3:: with SMTP id
 t77mr5567966ybi.180.1606936143384; Wed, 02 Dec 2020 11:09:03 -0800 (PST)
Date:   Wed,  2 Dec 2020 11:08:22 -0800
In-Reply-To: <20201202190824.1309398-1-dlatypov@google.com>
Message-Id: <20201202190824.1309398-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2 2/4] kunit: tool: stop using bare asserts in unit test
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use self.assertEqual/assertNotEqual() instead.
Besides being more appropriate in a unit test, it'll also give a better
error message by show the unexpected values.

Also
* Delete redundant check of exception types. self.assertRaises does this.
* s/kall/call. There's no reason to name it this way.
  * This is probably a misunderstanding from the docs which uses it
  since `mock.call` is in scope as `call`.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 50 +++++++++++++-------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 3fbe1acd531a..3a74e5612cf9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -301,26 +301,26 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_config_passes_args_pass(self):
 		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 0
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 0
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
-		assert self.linux_source_mock.run_kernel.call_count == 0
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
 		kunit.main(['exec'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 0
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
 		kunit.main(['run'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
@@ -329,35 +329,33 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
 			kunit.main(['exec'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
+		self.assertEqual(e.exception.code, 1)
 
 	def test_run_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
 			kunit.main(['run'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(e.exception.code, 1)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		kunit.main(['exec', '--raw_output'], self.linux_source_mock)
-		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		kunit.main(['run', '--raw_output'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
 	def test_exec_timeout(self):
 		timeout = 3453
@@ -368,7 +366,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_run_timeout(self):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			build_dir='.kunit', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
@@ -376,7 +374,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_run_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
@@ -384,7 +382,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_config_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
-- 
2.29.2.576.ga3fc446d84-goog

