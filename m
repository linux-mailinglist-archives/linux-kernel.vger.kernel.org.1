Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5D1A3C66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 00:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDIW3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 18:29:10 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:33431 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDIW3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:29:10 -0400
Received: by mail-yb1-f202.google.com with SMTP id v46so669408ybi.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b/dOwLUQ4awW4wuKHSakVt1acQwI+Qy4HT+dV/1grog=;
        b=hfIVKWB9CrLwkogy2lQycBLjkgKykYZdXEoOucLUgnRzUanF+7JiWU8/NvmVGRVWLb
         +APd/xNaW/JS89RTqAYHh4LEWmIzgZrzaTo1B5PZlOZDnOljuapxKPZx5OwP4hUKqnoS
         I0smuTEqekWowtpi9u0JCFtSASGRFiWwnVzw+CV71ZIVQR/KcfLpIVyj70/Eteztc3iR
         td6cq8g7YsvT7FFJ1wHPbx6711Y7o5p194BZJGXNZ4OdHiVgdehvjB32k8H13eCPp882
         xAnwSpKo6bFo0TCtggzMAHtd6g2Fdc0/LCrmBhjFuz16MrcBUn9yp9Qr9BgFFJBl2FRa
         4eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b/dOwLUQ4awW4wuKHSakVt1acQwI+Qy4HT+dV/1grog=;
        b=Ora3KZzgjYYZ15jyZEAfopupfq//nAjb79nUZO3kdbSpvxUrzoZVROB1MItehNqe0P
         taRs48hMvKp0nxzwVpYgxIIJwtRwIjBGAJqOlN0gnfox05vC554YQKuVOcBMSxG8gHSG
         qjnHnZoEnjkYsDEFtPm1Q6lO3O1f2L2CIlg4sNwNdE6seTzJOTdIyXMOjA0yT3gf2jUz
         /v0yQitIEJVUV3FUSRjlDysqr4lvvlNtbStaFLSgsQDafuPYJhY9BDtQjdQA7YeDYRdP
         ymPbaSvveugnJ/FIoRMXKpIzEQlvvaV28xAdyM87X56seGI20eXvwUZWJ4PZiY8zx+Lb
         MD3A==
X-Gm-Message-State: AGi0Pub3KLDMlO57bkGb9KpDYLjD1+Q5cYEIWtA8INL/+1ptwpbv/Y5C
        rKu6TyGuMtumF+K9aKl9xQE/a5sRpTPEiTxrgJrLfA==
X-Google-Smtp-Source: APiQypL0JMSLASw3TiGOXOIT90FuwqpyH1o4LzS3LkTNHHKAR/YLE8LjcXI7t2Xw+OUppoTbkFA+zzYem8vjJZvmOz0WWA==
X-Received: by 2002:a05:6902:4c2:: with SMTP id v2mr3076158ybs.225.1586471349465;
 Thu, 09 Apr 2020 15:29:09 -0700 (PDT)
Date:   Thu,  9 Apr 2020 15:28:50 -0700
Message-Id: <20200409222850.238805-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v1] kunit: relax regex for .config entries to allow spaces
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Latypov <dlatypov@google.com>

kunit parses .config in the `build_reconfig()` of `run_tests()`.
Problematically, the current regex '^CONFIG_\w+=\S+$' does not allow for
spaces anywhere after the "=", even the option is a string.

So kunit will refuse to run if the existing .config has something like
  CONFIG_CMDLINE="something and_something_else"
even if kunit.py will drop this entry when it regenerates the .config!

So relax the regex to allow entries that match `CONFIG_\w+=".*"` as a
minimal change. The question remains as to whether we should do any
validation of the string after the "=", however.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index e75063d603b5..0733796b0e32 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -10,7 +10,7 @@ import collections
 import re
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
-CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+)$'
+CONFIG_PATTERN = r'^CONFIG_(\w+)=(".*"|\S+)$'
 
 KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
 

base-commit: c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d
-- 
2.26.0.110.g2183baf09c-goog

