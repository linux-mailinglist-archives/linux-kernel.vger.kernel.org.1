Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9328CD48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgJML63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgJMLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:45 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180C222456;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=Kd+fx8CbHguhYMmNMA2Nr1HCVZVx+nSlpZ3QUxJ09K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvVflqfwfW6P1T54egbs2nNHq/aA8vi5PtuxgzhC2wPFeRMiKYXMFcmXOwkgopblx
         5F4v1utGATJ46bkvRuIPjBcGnsIFcdVuxHQWaQETWMz9WGQTNKJP44SLQbey/bvNyC
         rWw2kwnPk0zBCRZrJwD9MnTzrTpuBJXNGK5LXOu8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CVT-48; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 50/80] docs: conf.py: change the Sphinx 3.x+ text
Date:   Tue, 13 Oct 2020 13:54:05 +0200
Message-Id: <ff13c211eb737277c72b917118435a1d5da40116.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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
index e1b16556e378..376dd0ddf39c 100644
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

