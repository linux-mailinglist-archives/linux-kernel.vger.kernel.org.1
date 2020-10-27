Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E89129AA20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898813AbgJ0K4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898806AbgJ0K43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:56:29 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 365602224E;
        Tue, 27 Oct 2020 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603796189;
        bh=qok04c1yw93ge0duivytYk/uZrYg8iX3aCLGN7vm3Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSH8iBLi9pxk9tm4fS/w/Li3II69RgoIx7gy6zp3qBHfT4d37vR+CNSwSg+cSdcO5
         tR6v2ws50ERPwhrvUbrrGUhsmysjwjNFBYcSPTcMtbHqZXAgv+4jplTfhfY2pOLoLq
         cZMi6pKzy3pVlcVdcFsrAEkRWlDc3EO+B2UTlZt0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXMeO-003GLJ-4U; Tue, 27 Oct 2020 11:56:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] docs: Makefile: honor V=0 for docs building
Date:   Tue, 27 Oct 2020 11:56:15 +0100
Message-Id: <478c114a2399b68a18de94ee5f98649304f3903b.1603796153.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016165504.3cc33889@canb.auug.org.au>
References: <20201016165504.3cc33889@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the number of displayed mesages when building the
docs with V=0.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6a59a13d3c53..61a7310b49e0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -26,6 +26,10 @@ BUILDDIR      = $(obj)/output
 PDFLATEX      = xelatex
 LATEXOPTS     = -interaction=batchmode
 
+ifeq ($(KBUILD_VERBOSE),0)
+SPHINXOPTS    += "-q"
+endif
+
 # User-friendly check for sphinx-build
 HAVE_SPHINX := $(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
-- 
2.26.2

