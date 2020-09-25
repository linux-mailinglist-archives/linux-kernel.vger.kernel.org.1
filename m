Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18D2780AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgIYGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYGaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:30:52 -0400
Received: from mail.kernel.org (ip5f5ad5bf.dynamic.kabel-deutschland.de [95.90.213.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021A921D7F;
        Fri, 25 Sep 2020 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601015452;
        bh=z3uPJYikCas0x30M97MAs9Swt3BK/HCJNpDqXwsEhcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eB8T+6zAcC1/QS46XeVgNHDG2AhyY5iQvKVr/aVTt+yhsCUUYG+d+4QyDULogfcs5
         fksb+aTOKokQkyxJjWts/7FPaKMu+SbBAXc4XKfVut6RCAb6N8EquiZDBPm7J5I9V+
         IklAeA8bqEE7PmkyHdM2hub27E+wW+of/rF6dutU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kLhFn-000R4e-NK; Fri, 25 Sep 2020 08:30:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] docs: conf.py: disable automarkup for Sphinx 3.x
Date:   Fri, 25 Sep 2020 08:30:40 +0200
Message-Id: <753c15018d29e415106b2b02d7a6f6add2b88ddf.1601014299.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601014299.git.mchehab+huawei@kernel.org>
References: <cover.1601014299.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The class types changed after the C domain rewrite on
Sphinx 3.x. Due to that, the automarkup extension is just
generating additional noise when trying to convert structs
and other markups into cross references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 0a102d57437d..4bae94e756da 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -37,7 +37,7 @@ needs_sphinx = '1.3'
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
-              'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
+              'kfigure', 'sphinx.ext.ifconfig',
               'maintainers_include', 'sphinx.ext.autosectionlabel' ]
 
 #
@@ -51,7 +51,7 @@ if major >= 3:
 	in the generated output.
 	''')
 else:
-    extensions.append('cdomain')
+    extensions.append('cdomain', 'automarkup')
 
 # Ensure that autosectionlabel will produce unique names
 autosectionlabel_prefix_document = True
-- 
2.26.2

