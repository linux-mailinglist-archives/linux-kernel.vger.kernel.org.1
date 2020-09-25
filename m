Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664222786BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgIYMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYMMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:12:37 -0400
Received: from coco.lan (ip5f5ad5bf.dynamic.kabel-deutschland.de [95.90.213.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF23C2083B;
        Fri, 25 Sep 2020 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601035956;
        bh=Udqh9zJbGjoXTKRFQ3WtIOCD3+zSF38WyEqeUdncD1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=19BvTZfHOA73y4WfSL/F8Vglq4Aue21Of8hXdT9cVVYa/1i4KH7WRzmWy/WVjTL/R
         fEoJhlvjIQs0T8vv5B6FgIK80B2jo66AEu7aXhAK736OfiAWyTd1DDXeepFlUfl9eP
         WwaVvCA0z/NdP8STeLvEeCQlMrbJdydGkVc+96s0=
Date:   Fri, 25 Sep 2020 14:12:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3.1 2/8] docs: conf.py: disable automarkup for Sphinx 3.x
Message-ID: <20200925141231.65a9ec1e@coco.lan>
In-Reply-To: <753c15018d29e415106b2b02d7a6f6add2b88ddf.1601014299.git.mchehab+huawei@kernel.org>
References: <cover.1601014299.git.mchehab+huawei@kernel.org>
        <753c15018d29e415106b2b02d7a6f6add2b88ddf.1601014299.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The class types changed after the C domain rewrite on
Sphinx 3.x. Due to that, the automarkup extension is just
generating additional noise when trying to convert structs
and other markups into cross references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---

v3.1: Sphinx actually complains when append has more than one
item. So, let's call extensions.append() twice.

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
