Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C7D28CE10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgJMMPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgJMMO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:57 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8258D22403;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=Ce+YwOX8NUyVQ34kqyNLtBwPsw6IDLQQTy4q/V/8GNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuM2oSDYiyUdACnWDGdaZvn/yr4CJ++YOQP7UXXQqSbuXa9tYAofcfgq1xw6e9bqX
         Nf1A/1t3zieP/I/ftT6jDjq1sE6oyQPz+QPvtNkkM/aSJnUmDNaQlzYd/zaxoNIdUw
         XdxeeM4HMnEqyXo4ZNNXq3fwfr+A3mGMak2SBAPo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCf-006Cos-DB; Tue, 13 Oct 2020 14:14:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/24] counters: docs: add a missing include
Date:   Tue, 13 Oct 2020 14:14:51 +0200
Message-Id: <74814cc3d2b2ac3fe7c10ff2045c77691bacf64b.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 37a0dbf631f6 ("counters: Introduce counter_atomic* counters")

Is causing two new warnings:

	.../Documentation/core-api/counters.rst:8: WARNING: Undefined substitution referenced: "copy".
	.../Documentation/core-api/counters.rst:9: WARNING: Undefined substitution referenced: "copy".

Because it forgot to include isonum.txt, which defines |copy|
macro.

While here, also add it to core-api index file, in order to
solve this warning:

	.../Documentation/core-api/counters.rst: WARNING: document isn't included in any toctree

Fixes: 37a0dbf631f6 ("counters: Introduce counter_atomic* counters")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/counters.rst | 1 +
 Documentation/core-api/index.rst    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/core-api/counters.rst b/Documentation/core-api/counters.rst
index 642d907f4d3a..2821aebf3f45 100644
--- a/Documentation/core-api/counters.rst
+++ b/Documentation/core-api/counters.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 ======================
 Simple atomic counters
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 69171b1799f2..cf9cd44c1191 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -43,6 +43,7 @@ Library functionality that is used throughout the kernel.
    this_cpu_ops
    timekeeping
    errseq
+   counters
 
 Concurrency primitives
 ======================
-- 
2.26.2

