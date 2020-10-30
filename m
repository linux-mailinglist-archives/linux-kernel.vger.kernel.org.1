Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3871829FE93
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJ3HlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgJ3HlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:03 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842A022228;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043662;
        bh=zC6uotoZC5URus/Ygfz/qeT2QIvCXOIgT+5HOKI+wVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNMqq6Y3bPE2+GddyPIo/quZlO24OutVIEzP6QhnCKC61IMC0n3yzfzUYE1NGVsYz
         Wav66iHR0bn7V0IO5tuzIeEWCI3D8sWqoikb7ghr3hjRtRR1sKvEKyqutXyT8PvxfW
         4T8j79jkJFSe+9mVkXEY2PnU6w+LSsNZMFcqCLl4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004Off-Jb; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/39] docs: kernellog.py: add support for info()
Date:   Fri, 30 Oct 2020 08:40:30 +0100
Message-Id: <0ddebd8677605d789d53433c8a5344c68da82a73.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An extension may want to just inform about something. So, add
support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernellog.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kernellog.py b/Documentation/sphinx/kernellog.py
index af924f51a7dc..8ac7d274f542 100644
--- a/Documentation/sphinx/kernellog.py
+++ b/Documentation/sphinx/kernellog.py
@@ -25,4 +25,8 @@ def verbose(app, message):
     else:
         app.verbose(message)
 
-
+def info(app, message):
+    if UseLogging:
+        logger.info(message)
+    else:
+        app.info(message)
-- 
2.26.2

