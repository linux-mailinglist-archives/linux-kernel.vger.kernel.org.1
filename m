Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364C52CB5FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgLBHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:55:22 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5210C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:54:41 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id j205so2630326lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3aAsZ2DvxQWqwAeuu3A9lbKYdi94zyNtdd9iOUDQD3M=;
        b=BUgnFnlajbu5Z8ZRJEBlJi7X3sqSo8Z7uhDcr1UPwRktUL1HZBSSv8j5trpgssUndY
         VR5Hwdh09NWnRYHclNkaVRWnFnqWMrW6KwGCKOBnY91w8wC9YJVV7SVBYWk3H/tbvdJh
         vCG3U7EmB4FqAQH/ffbP93dvTuzfmeto79Ui+/ot/QAVNoT5xSgx3OZJSnizwDtrE/bm
         2E8H6IdcHRck9KjG2w2vcwMVG77YJpFNbmJMNJBSfMMr3CUBxfrn3oIYRg8ul2DeU+3O
         c4qHBAMs9K8LXlSlOAe0/CkgrVDQA0Kr5ZyEO3uE9ebamnG5X3iqZXJpQzc03XDrp33h
         bMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3aAsZ2DvxQWqwAeuu3A9lbKYdi94zyNtdd9iOUDQD3M=;
        b=CRBOr1PhZBUAKMKcy1w7DqUNK8W67S5o6AdoJxmwiiH0vhLIycs0Hu8cslJEHNls+w
         /ZuXxFUvV1XvOEzll2TXo8sAK+qmZRveMLv+hpFJw/ygTMsybnmuH1K7N6SfFmhWg0Cg
         8l3VbFg0/iyuBdIzCpQrGSQKND012psOZuqRy+c6CiR57jIHm1KgM6Rtkr4fCQp0ukSH
         dhuuV82JsVJt9zB21MflgwYoNrbs2qXqxmOeYPWxMR62XQ87CGczs5d9sTDW6zzNs2vx
         +AR0Nz6iPIPgwWm6wyvww5g66xkkINS7/b91cmtC+lYjv9Qqc9tTQ8PsvIrGj+MfdkrF
         SYjA==
X-Gm-Message-State: AOAM531TeFfG8ah8DWk8qS4izltELk/+Vf8yNJ/lSG/tS6bXVyR3wFnR
        m8vgIk6kMDEShUektIr+AtKnnLyskf8=
X-Google-Smtp-Source: ABdhPJx49UJK0EO97EEvIZUaxhzQhYpuEvN+NvQZa4VmRvPiSfY6QTkbMxRzXV7MVvXAxdEKzVHj5w==
X-Received: by 2002:a19:be85:: with SMTP id o127mr663690lff.356.1606895679968;
        Tue, 01 Dec 2020 23:54:39 -0800 (PST)
Received: from spblnx124 ([185.204.20.3])
        by smtp.gmail.com with ESMTPSA id x24sm244113lfc.303.2020.12.01.23.54.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2020 23:54:39 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:54:38 +0300
From:   Andrew Klychkov <andrew.a.klychkov@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix typos found in process, dev-tools, and
 doc-guide subdirectories
Message-ID: <20201202075438.GA35516@spblnx124.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix four typos in kcov.rst, sphinx.rst, clang-format.rst, and embargoed-hardware-issues.rst

Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
---
 Documentation/dev-tools/kcov.rst                    | 2 +-
 Documentation/doc-guide/sphinx.rst                  | 2 +-
 Documentation/process/clang-format.rst              | 2 +-
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 8548b0b..d2c4c27e 100644
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
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 896478b..2fb2ff2 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -375,7 +375,7 @@ image format use SVG (:ref:`svg_image_example`)::
 
    SVG image example
 
-The kernel figure (and image) directive support **DOT** formated files, see
+The kernel figure (and image) directive support **DOT** formatted files, see
 
 * DOT: http://graphviz.org/pdf/dotguide.pdf
 * Graphviz: http://www.graphviz.org/content/dot-language
diff --git a/Documentation/process/clang-format.rst b/Documentation/process/clang-format.rst
index 82676e5..1d089a8 100644
--- a/Documentation/process/clang-format.rst
+++ b/Documentation/process/clang-format.rst
@@ -97,7 +97,7 @@ it can be very useful.
 
 There are integrations for many popular text editors. For some of them,
 like vim, emacs, BBEdit and Visual Studio you can find support built-in.
-For instructions, read the appropiate section at:
+For instructions, read the appropriate section at:
 
     https://clang.llvm.org/docs/ClangFormat.html
 
diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 43cdc67..6f8f36e 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -152,7 +152,7 @@ The disclosing party should provide a list of contacts for all other
 entities who have already been, or should be, informed about the issue.
 This serves several purposes:
 
- - The list of disclosed entities allows communication accross the
+ - The list of disclosed entities allows communication across the
    industry, e.g. other OS vendors, HW vendors, etc.
 
  - The disclosed entities can be contacted to name experts who should
-- 
1.8.3.1

