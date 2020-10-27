Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74FF29A842
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896085AbgJ0Jvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896015AbgJ0Jvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:41 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024552225C;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=OS6l3+DaRazsYL4JvsK0xdMWh/5vKAMAwn+T81nsndo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+woGwDh16qUp3bh5c430ahGHQeuHcJZ5IH7/TmEzxZggocehNQnPUGDq4eHg3v+t
         WwA4TVelkI45J0wQMdhTj/stSP798ViwLf16TVB9HfZtqDy83wEEmHalkMuHWxETIY
         WcXyI8f1AteWncZgGN1cYWfP6TtPn4/ZnYgSjUfM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdi-003FEX-VC; Tue, 27 Oct 2020 10:51:38 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/32] sphinx: conf.py: properly handle Sphinx 4.0
Date:   Tue, 27 Oct 2020 10:51:06 +0100
Message-Id: <d5abc30056dafeec0778a46263a45401bdc7f11e.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the checks for Sphinx 3+ is broken, causing some
C warnings to return back with Sphinx 4.0.x.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 376dd0ddf39c..7ee05fd4cb17 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -50,7 +50,7 @@ if major >= 3:
         support for Sphinx v3.0 and above is brand new. Be prepared for
         possible issues in the generated output.
         ''')
-    if minor > 0 or patch >= 2:
+    if (major > 3) or (minor > 0 or patch >= 2):
         # Sphinx c function parser is more pedantic with regards to type
         # checking. Due to that, having macros at c:function cause problems.
         # Those needed to be scaped by using c_id_attributes[] array
-- 
2.26.2

