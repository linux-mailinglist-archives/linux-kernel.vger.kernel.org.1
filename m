Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8983026DE27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgIQOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgIQNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:54:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F847C061354;
        Thu, 17 Sep 2020 06:44:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so1373187pgm.11;
        Thu, 17 Sep 2020 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0fffCi1SMnNr+HUj3+gDyb2KPUiiYt5n+nlScEWZ2k=;
        b=pIBiH2Ynfmf0sUsWxAudRvC6Ica8ZMgHeCjvLLvQzl5XihplMOzmelHMdbcIIYon8p
         2qQgZaLT4ha8wo57MbqZ8GAaShD2gtiYZK2FV3HLWu8oS8ltzsSJnIh2tdcNs/46A9UU
         tkw4+hSqDOcA+qGRI6sKcAnl4+O9IP0P42czQdB6csgNFmZviwST//FkoMnrpHF2W9U6
         PmE7QZCXoviH4xl2MQjR6wATbZAxcHMsATGGo0ZMSaA7Vtqs1kXEq7/Byw6RPssX/gKP
         XDtCWj9cE04sQUUeSeiD+GBFiVaUHv0169WzHMK/tDGjSsn7NZTmFqdq7rY0C7QMjW5e
         SzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0fffCi1SMnNr+HUj3+gDyb2KPUiiYt5n+nlScEWZ2k=;
        b=A9MVioF2aXTlEhiV4i0I5QfY69rIrpQw+Jf7g3uEBxhjxLFyJyi183ah5uBqp/eOg9
         PVihbQrrLlotw6tWyRVjd8myl8UNjMY6iPNDhMstc6HTMtoC+kEdcTuqCNeF6DeMhwE6
         dCt1AW6e4qpiWlCqd8P+g3i7/DYINehwyl9ZpcDjM01OxHUZGxp7tXLQQP1WvYbXdVLE
         ayCiyxVb4An+3EwIzBxkZ1zy9D08b6OLs/R3m+htbGCQpt8HA+5yVLAQ4x3/8aixYPAO
         Uj/fZLKXJgEUaNOX8x8Z5TaA8eN+phpd+qv7lAn87wPBXqmp0hFzBruK0MCoL3zpjc51
         6GaQ==
X-Gm-Message-State: AOAM532RHTxelK5rRrhj71nU0lMJkykreNIeF9xpXoxU+BBdsskeFejL
        GZRQ288gEq0qpuUqi/PesVQ=
X-Google-Smtp-Source: ABdhPJz4bQ+UnL63L1lNm8jdeHcLxmxEj7pKavpOiDjibYwac+RnNqw5l/h9x0ZQxQ8ml1mp5p2BCw==
X-Received: by 2002:a65:418c:: with SMTP id a12mr23438677pgq.322.1600350254536;
        Thu, 17 Sep 2020 06:44:14 -0700 (PDT)
Received: from masabert (p8847031-ipngnfx01marunouchi.tokyo.ocn.ne.jp. [114.156.71.31])
        by smtp.gmail.com with ESMTPSA id s28sm21238859pfd.111.2020.09.17.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:44:13 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id DD53C236035E; Thu, 17 Sep 2020 22:44:09 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, catalin.marinas@arm.com,
        andreyknvl@google.com, rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH linux-next] docs:dev-tools: Fix typo in Documentation/dev-tools
Date:   Thu, 17 Sep 2020 22:44:07 +0900
Message-Id: <20200917134407.63487-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos found in
Documentation/dev-tools.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/dev-tools/kasan.rst    | 4 ++--
 Documentation/dev-tools/kcov.rst     | 2 +-
 Documentation/dev-tools/kmemleak.rst | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c09c9ca2ff1c..49ec0ab6cfc7 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -328,7 +328,7 @@ using something like insmod or modprobe. The module is called ``test_kasan``.
 ~~~~~~~~~~~~~
 
 With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
-on any architecure that supports KASAN. These and any other KUnit
+on any architecture that supports KASAN. These and any other KUnit
 tests enabled will run and print the results at boot as a late-init
 call.
 
@@ -349,5 +349,5 @@ converted to KUnit. These tests can be run only as a module with
 ``CONFIG_KASAN`` built-in. The type of error expected and the
 function being run is printed before the expression expected to give
 an error. Then the error is printed, if found, and that test
-should be interpretted to pass only if the error was the one expected
+should be interpreted to pass only if the error was the one expected
 by the test.
diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 8548b0b04e43..d2c4c27e1702 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -243,7 +243,7 @@ handles as they don't belong to a particular subsystem. The bytes 4-7 are
 currently reserved and must be zero. In the future the number of bytes
 used for the subsystem or handle ids might be increased.
 
-When a particular userspace proccess collects coverage via a common
+When a particular userspace process collects coverage via a common
 handle, kcov will collect coverage for each code section that is annotated
 to use the common handle obtained as kcov_handle from the current
 task_struct. However non common handles allow to collect coverage
diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index a41a2d238af2..1c935f41cd3a 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -229,7 +229,7 @@ Testing with kmemleak-test
 
 To check if you have all set up to use kmemleak, you can use the kmemleak-test
 module, a module that deliberately leaks memory. Set CONFIG_DEBUG_KMEMLEAK_TEST
-as module (it can't be used as bult-in) and boot the kernel with kmemleak
+as module (it can't be used as built-in) and boot the kernel with kmemleak
 enabled. Load the module and perform a scan with::
 
         # modprobe kmemleak-test
-- 
2.28.0.497.g54e85e7af1ac

