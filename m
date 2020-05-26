Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513781CDAF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgEKNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729279AbgEKNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:14:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE8DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:14:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w20so9431950ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSSALeybJON0vdo6J8wFop6P10hjXeJOgeHK6FMq2ec=;
        b=ShZCN8aQt2lDeT7IBRUe0XPp++Ppjd3Wf+JazE2uSWM+DGYMvzTnOuNYhfhjwYcrYo
         pNK5eF1MN/SeH6/xg1hI+0q9NIX9nRh3Yj+im62KmRrvalPpub1k3+w9IiaAgsufKNGC
         mht3gSfrZcbae2YVfcV3fLypaZ1V1mFYClMmTcH0v+uDo35eAbGgwPcJBmTybFehIroT
         b0LipaBWKRAB4gY3Mf1Pk9SWeGX/M6zgeExJp+E4EEKl3QP6vPFIq34n3/AngqsMJ+ZU
         unHO5L3MWOTw09NWFiVj0IjgyL5IquM8Jt817RP80kHYKi6ttzOr/5Pww6WzAvU5vv2a
         +wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSSALeybJON0vdo6J8wFop6P10hjXeJOgeHK6FMq2ec=;
        b=G96VyQn0Zo4HXN+VJseYZLpV9x80Gm6xF1iC/lBTd+Mq7+FtcG2mSzd3J6EVfBWm9d
         8CAvvqqp6hu7nSdK9FFg/8wGe1q1Hh2URBhtiQYF4Bd2r+rk7/UOR3slaxXab7Xk9PMK
         BH5lLc2iISNLfVuh6hwvoYvytILjSvIYOFziUeJ4EcJwP97YT/cpQUe/BMdvGqRNx3nc
         5+PdfNtC+p8iAOhM4s3WaPw95VYECWOM+h415+DcO8uw/lON5SJotmubw3XCwKg/DthI
         SBIJZdpNuluX1DybfIc2JmTIjz8l1I/M2RWXBQC19U638i7ZJW+mfPsA0xxIt2qyX8sY
         KRQA==
X-Gm-Message-State: AOAM533LT5F31fOOfxQBb4H04sjRlMSpCRzUStXnHXyESRo1M3HbYSk4
        nCq0KAtn+cWxYvvBrioufk5mPA==
X-Google-Smtp-Source: ABdhPJyhzpIMLamxyIU5PPcM4PrHEKVYAkzZntlZA60vssYAUXAMW4ONcVmO796LO9RIZw+wNK47qQ==
X-Received: by 2002:a2e:8108:: with SMTP id d8mr9840244ljg.184.1589202869384;
        Mon, 11 May 2020 06:14:29 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id a11sm10031361lji.62.2020.05.11.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:28 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 2/6] kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
Date:   Mon, 11 May 2020 15:14:25 +0200
Message-Id: <20200511131425.29808-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_ALL_TESTS' so individual tests can not be turned off.
Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
menuconfig.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/kunit/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index bdeee7639005..00909e6a2443 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,7 +15,8 @@ menuconfig KUNIT
 if KUNIT
 
 config KUNIT_DEBUGFS
-	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	help
 	  Enable debugfs representation for kunit.  Currently this consists
 	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
@@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
 	  run that occurred.
 
 config KUNIT_TEST
-	tristate "KUnit test for KUnit"
+	tristate "KUnit test for KUnit" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	help
 	  Enables the unit tests for the KUnit test framework. These tests test
 	  the KUnit test framework itself; the tests are both written using
@@ -32,7 +34,8 @@ config KUNIT_TEST
 	  expected.
 
 config KUNIT_EXAMPLE_TEST
-	tristate "Example test for KUnit"
+	tristate "Example test for KUnit" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	help
 	  Enables an example unit test that illustrates some of the basic
 	  features of KUnit. This test only exists to help new users understand
-- 
2.20.1

