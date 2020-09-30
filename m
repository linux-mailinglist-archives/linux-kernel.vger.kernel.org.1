Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA027E979
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgI3NZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729767AbgI3NZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:20 -0400
Received: from mail.kernel.org (ip5f5ad5c4.dynamic.kabel-deutschland.de [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5936207FB;
        Wed, 30 Sep 2020 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472319;
        bh=nppqgRkE8NET8Mnmupu4lt6l5W2Mb0AlILegNl2tCpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6AJRS3pazKAZ6k1PD15locUkS+I2QNy9GN2VPKltnLHYdmALSI68rjvcN2CE4HTJ
         6zWyiiW8b5imxgzSkC/uPy/I551p3fblRzXJjxQrNQexvRAq7i7GAaIWOy/5RktB1B
         M1CcwnkJ5HkJIKeXSLM7F/bRMzsiexNLBz00Y9Pc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6f-001XIw-LQ; Wed, 30 Sep 2020 15:25:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/52] docs: conf.py: disable automarkup for Sphinx 3.x
Date:   Wed, 30 Sep 2020 15:24:26 +0200
Message-Id: <5d07d0f9cf3e354c28e9e83956121738a6e71280.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
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
 Documentation/conf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 0a102d57437d..3875401486de 100644
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
@@ -52,6 +52,7 @@ if major >= 3:
 	''')
 else:
     extensions.append('cdomain')
+    extensions.append('automarkup')
 
 # Ensure that autosectionlabel will produce unique names
 autosectionlabel_prefix_document = True
-- 
2.26.2

