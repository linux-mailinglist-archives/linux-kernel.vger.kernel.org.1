Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213122E6BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgL1XNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbgL1XNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:13:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F2EC0613D6;
        Mon, 28 Dec 2020 15:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=AherMX5DOeanm9DMwd7IkHNjJCJeoIKSWFXXcaFh0gQ=; b=dxpNb/dwYdMG98h7mUAp21KE/M
        TcyGTUhSNYn3WKmTVISpQXqSMrFiae//tQlUJKBHocPjL5cAR3LrWK4Ko3fOI+ed6c0DwLv+CfXFz
        Tli2+Zv/VJvYM1ygkhtAdlen5thum/K1Z+i8AkacOT1Hw1aDsL6ty85/Pb6y5u7CX5ryc/nfQZCx5
        C2tzuLGR6gp//P+Hqwqj5RAq0nR1dEWyu1G9iKZRlcTV4CtVpsjdMepoqVnMnbNs5VkkonpKoq90u
        AXMpt8g9kABcpxFKQcXIG2fHtSE25EACTZ9sFNlebnFvaj8f6e9oZyBbiFFGAVs6AywLYgZKQiCdQ
        vWg6qHuA==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ku1gW-0000q4-IQ; Mon, 28 Dec 2020 23:12:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [RFC PATCH] Documentation: doc-guide: fixes to sphinx.rst
Date:   Mon, 28 Dec 2020 15:12:12 -0800
Message-Id: <20201228231212.22448-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various fixes to sphinx.rst:

- eliminate a double-space between 2 words
- grammar/wording
- punctuation
- call rows in a table 'rows' instead of 'columns' (or does Sphinx
  call everything a column?)
- It seems that "amdfonts" should be "amsfonts". I can't find any
  amdfonts.


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/doc-guide/sphinx.rst |   32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- lnx-511-rc1.orig/Documentation/doc-guide/sphinx.rst
+++ lnx-511-rc1/Documentation/doc-guide/sphinx.rst
@@ -48,12 +48,12 @@ or ``virtualenv``, depending on how your
       those versions, you should run ``pip install 'docutils==0.12'``.
 
    #) It is recommended to use the RTD theme for html output. Depending
-      on the Sphinx version, it should be installed  in separate,
+      on the Sphinx version, it should be installed separately,
       with ``pip install sphinx_rtd_theme``.
 
-   #) Some ReST pages contain math expressions. Due to the way Sphinx work,
+   #) Some ReST pages contain math expressions. Due to the way Sphinx works,
       those expressions are written using LaTeX notation. It needs texlive
-      installed with amdfonts and amsmath in order to evaluate them.
+      installed with amsfonts and amsmath in order to evaluate them.
 
 In summary, if you want to install Sphinx version 1.7.9, you should do::
 
@@ -128,7 +128,7 @@ Sphinx Build
 ============
 
 The usual way to generate the documentation is to run ``make htmldocs`` or
-``make pdfdocs``. There are also other formats available, see the documentation
+``make pdfdocs``. There are also other formats available: see the documentation
 section of ``make help``. The generated documentation is placed in
 format-specific subdirectories under ``Documentation/output``.
 
@@ -303,17 +303,17 @@ and *targets* (e.g. a ref to ``:ref:`las
         - head col 3
         - head col 4
 
-      * - column 1
+      * - row 1
         - field 1.1
         - field 1.2 with autospan
 
-      * - column 2
+      * - row 2
         - field 2.1
         - :rspan:`1` :cspan:`1` field 2.2 - 3.3
 
       * .. _`last row`:
 
-        - column 3
+        - row 3
 
 Rendered as:
 
@@ -325,17 +325,17 @@ Rendered as:
         - head col 3
         - head col 4
 
-      * - column 1
+      * - row 1
         - field 1.1
         - field 1.2 with autospan
 
-      * - column 2
+      * - row 2
         - field 2.1
         - :rspan:`1` :cspan:`1` field 2.2 - 3.3
 
       * .. _`last row`:
 
-        - column 3
+        - row 3
 
 Cross-referencing
 -----------------
@@ -361,7 +361,7 @@ Figures & Images
 
 If you want to add an image, you should use the ``kernel-figure`` and
 ``kernel-image`` directives. E.g. to insert a figure with a scalable
-image format use SVG (:ref:`svg_image_example`)::
+image format, use SVG (:ref:`svg_image_example`)::
 
     .. kernel-figure::  svg_image.svg
        :alt:    simple SVG image
@@ -375,7 +375,7 @@ image format use SVG (:ref:`svg_image_ex
 
    SVG image example
 
-The kernel figure (and image) directive support **DOT** formatted files, see
+The kernel figure (and image) directive supports **DOT** formatted files, see
 
 * DOT: http://graphviz.org/pdf/dotguide.pdf
 * Graphviz: http://www.graphviz.org/content/dot-language
@@ -394,7 +394,7 @@ A simple example (:ref:`hello_dot_file`)
 
    DOT's hello world example
 
-Embed *render* markups (or languages) like Graphviz's **DOT** is provided by the
+Embedded *render* markups (or languages) like Graphviz's **DOT** are provided by the
 ``kernel-render`` directives.::
 
   .. kernel-render:: DOT
@@ -406,7 +406,7 @@ Embed *render* markups (or languages) li
      }
 
 How this will be rendered depends on the installed tools. If Graphviz is
-installed, you will see an vector image. If not the raw markup is inserted as
+installed, you will see a vector image. If not, the raw markup is inserted as
 *literal-block* (:ref:`hello_dot_render`).
 
 .. _hello_dot_render:
@@ -421,8 +421,8 @@ installed, you will see an vector image.
 
 The *render* directive has all the options known from the *figure* directive,
 plus option ``caption``.  If ``caption`` has a value, a *figure* node is
-inserted. If not, a *image* node is inserted. A ``caption`` is also needed, if
-you want to refer it (:ref:`hello_svg_render`).
+inserted. If not, an *image* node is inserted. A ``caption`` is also needed, if
+you want to refer to it (:ref:`hello_svg_render`).
 
 Embedded **SVG**::
 
