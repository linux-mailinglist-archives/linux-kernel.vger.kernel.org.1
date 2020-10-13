Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE628CDB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgJMMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbgJMLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:40 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6A521775;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=LvfP0jOK13UuuLfelIbMUCsdO3bUxdpXbiy+j5C7Kks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14wg+HBTNtXYUb6esG9GOiA+5AeMI+FxUnwAQFy/9d7DBef+14mgqFbnxpkKWne7x
         4gdxrfTH5d4wlOESQ176lfkZb00a9LdjjSbK4GJetXamSbos3H/Miux9Mx4VXZWDtv
         bGLTvctj5XL30TwGoYx09awuT4A2wtAwqTtCFHx8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTi-Fs; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/80] docs: kerneldoc.py: append the name of the parsed doc file
Date:   Tue, 13 Oct 2020 13:53:29 +0200
Message-Id: <3d906b82312c9458145c64a73e8016a7ce26584b.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding where an error like this was generated:
	../lib/math/div64.c:73: WARNING: Duplicate C declaration, also defined in 'kernel-api'.

Can take some time, as there's no glue about what kernel-doc
tag generated it. It is a way better to display it as:

	.../Documentation/core-api/kernel-api:171: ../lib/math/div64.c:73: WARNING: Duplicate C declaration, also defined in 'kernel-api'.
	Declaration is 'div_s64_rem'.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kerneldoc.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 1a1b12242a45..a3a5427130da 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -141,7 +141,8 @@ class KernelDocDirective(Directive):
                     lineoffset = int(match.group(1)) - 1
                     # we must eat our comments since the upset the markup
                 else:
-                    result.append(line, filename, lineoffset)
+                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
+                    result.append(line, doc + ": " + filename, lineoffset)
                     lineoffset += 1
 
             node = nodes.section()
-- 
2.26.2

