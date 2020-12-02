Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD972CC641
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbgLBTJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbgLBTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:09:42 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:09:02 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id x62so2171929qtd.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VgZZRtoNWqKAzcK9/aAfu4oisqmQ1m2yKtDTP72pRS8=;
        b=WHGSfdYRlSlhEGGMVMYPPPYzHlhiGDbLAp4lTztktEMvDDFZ351hKvDI6ak0IDYL0K
         4vM/yC7E+M7FoBCkjdIifeu6O2iRQRwaG7Ld/4krDfHMGst0omr4oMCLOoKTT2QPDP9D
         +0o1Fcbb8+cpQWpUlwzjWI/cYW5KuNTV0ctEy0h1YevLnm7UBz9LZlDVl4snGzEOiSTs
         5tTiv05ymTPVdI7WbWA3EsNbch6yz6KMHKj3V0Rc5F78ESCZ0WSFViwXxD5EOKDmo5TL
         DIS/JHw0zf2dE5rhT2kh+cGz1aSPm3i812q1sCnP1XU/D91aGBaWhTbSMMQbdrlU5L/M
         6EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VgZZRtoNWqKAzcK9/aAfu4oisqmQ1m2yKtDTP72pRS8=;
        b=jemwM1nGWYjf+c5KBtIi2mFzHtxYwK4VACyKBHyxadn1xtyROjMwvQHGbvPAcpmUZ8
         104WePpU28ZG6UJiHsKedf5GoxtI/2nx7jyChyMHo0W+uu0BtJLZDHodLXF2n0cD1fxa
         4WGOLzgvl8X6aGR1RWNdPSCLX4mtUCX21pHbDOy6nbwh9KSL7KpBTZwdzxVqPGbgFFyN
         DwwcRIi3t4A7gY+ZVEv2FcusPyOnHDXLx86jTh/JJ8TmAhWNFcW7qnYsHDXKBXfgKFjT
         lSowb/glpHhKFDB5kAS0BfiaYfmMFtW1jkj6Ka+S6MqttWcS3Vu2azm5MwfRUD4Urqiz
         uHiQ==
X-Gm-Message-State: AOAM530TpuJXfK4JLOH0NU7AzVIVVftB4HvdMBsC08ckeryPY+Ny4Vmx
        RjrZuhpPFgiurQ3hIilJwZHBch95ZbJPFA==
X-Google-Smtp-Source: ABdhPJzOiX4EKL0rcePoFns9dZ95KoLwyDkAgaSYDwB0MwIZJTO6Yn0TRQWFmbIj+I30lsMbuvMXWYpXAdxD1w==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:ad4:42d2:: with SMTP id
 f18mr4135893qvr.23.1606936141444; Wed, 02 Dec 2020 11:09:01 -0800 (PST)
Date:   Wed,  2 Dec 2020 11:08:21 -0800
Message-Id: <20201202190824.1309398-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2 1/4] kunit: tool: fix unit test cleanup handling
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stop leaking file objects.
* Use self.addCleanup() to ensure we call cleanup functions even if
setUp() fails.
* use mock.patch.stopall instead of more error-prone manual approach

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 497ab51bc170..3fbe1acd531a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -288,19 +288,17 @@ class StrContains(str):
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
 		path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
-		file = open(path)
-		all_passed_log = file.readlines()
-		self.print_patch = mock.patch('builtins.print')
-		self.print_mock = self.print_patch.start()
+		with open(path) as file:
+			all_passed_log = file.readlines()
+
+		self.print_mock = mock.patch('builtins.print').start()
+		self.addCleanup(mock.patch.stopall)
+
 		self.linux_source_mock = mock.Mock()
 		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
 		self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
 
-	def tearDown(self):
-		self.print_patch.stop()
-		pass
-
 	def test_config_passes_args_pass(self):
 		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1

base-commit: 509a15421674b9e1a3e1916939d0d0efd3e578da
-- 
2.29.2.576.ga3fc446d84-goog

