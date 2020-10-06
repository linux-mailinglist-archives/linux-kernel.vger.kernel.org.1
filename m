Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4567E284D04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgJFOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgJFOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2097B23731;
        Tue,  6 Oct 2020 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993035;
        bh=FAz68Gpz6mwGMLMcTnrOG5cmfJRovbY6MFVW9r+Stmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtfZTDg28xla0wewpUgBEpPXY87zAp6DTjb7gfz7x+5ERi9ZbtHG9b5+1Ehwwz1sK
         r1AiHH3eydJsp5SenkTIbJ79wCPnKWstE0Ev8eTW38OQbc88esAZ7Vh/WaEnOrH4uP
         HvUd4jSNjFQDNCpWSzrJruYMtYkxl5rsXlsqsz4o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZJ-0019Gu-8i; Tue, 06 Oct 2020 16:03:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 52/52] docs: conf.py: change the Sphinx 3.x+ text
Date:   Tue,  6 Oct 2020 16:03:49 +0200
Message-Id: <fe95c488a46154db9fbf843d1d428cbab188ce95.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the build fix patches, it is believed that the output
with Sphinx 3.x won't be a problem. Still, the C domain
support was re-written, and this can have caused hidden
issues.

So, let's keep the warning, changing it to a lighter
warning text.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index b402bd8f6f71..4f5d15abd047 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -47,8 +47,8 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
 #
 if major >= 3:
     sys.stderr.write('''WARNING: The kernel documentation build process
-        does not work correctly with Sphinx v3.0 and above.  Expect errors
-        in the generated output.
+        support for Sphinx v3.0 and above is brand new. Be prepared for
+        possible issues in the generated output.
         ''')
     if minor > 0 or patch >= 2:
         # Sphinx c function parser is more pedantic with regards to type
-- 
2.26.2

