Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9DB27E9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgI3N1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84BE23731;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=lFEzsRGazv6x3BF+7IzZhV96OJvEaoKXaQrpvpjxmPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2u6KUkg07hbdhx4TSO/whYXNl3vo0a9Kmrn6KIP2RUzrbNxB7qXM0nqoI7+vm9e/A
         S4K2CBYiYzgVE7bx1FST04LT1ddvmpn7DWJQftBVaW30QIGTLqs7KgEtfSyPVh1i+q
         Jy9K7EmU6GIZZA31KYEb4nrCszl5L5gh/oe4SaBM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6g-001XK8-Ud; Wed, 30 Sep 2020 15:25:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 29/52] docs: basics.rst: move kernel-doc workqueue markups to workqueue.rst
Date:   Wed, 30 Sep 2020 15:24:52 +0200
Message-Id: <913b26af73f87892de5b980a67a0b4aaaab7019b.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there's already a rst file with workqueue markups, containing
part of them, move the other definitions, in order to avoid
warnings with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/workqueue.rst | 2 ++
 Documentation/driver-api/basics.rst  | 9 ---------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 00a5ba51e63f..541d31de8926 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -396,3 +396,5 @@ Kernel Inline Documentations Reference
 ======================================
 
 .. kernel-doc:: include/linux/workqueue.h
+
+.. kernel-doc:: kernel/workqueue.c
diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 1ba88c7b3984..54f8d5ca7475 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -55,15 +55,6 @@ High-resolution timers
 .. kernel-doc:: kernel/time/hrtimer.c
    :export:
 
-Workqueues and Kevents
-----------------------
-
-.. kernel-doc:: include/linux/workqueue.h
-   :internal:
-
-.. kernel-doc:: kernel/workqueue.c
-   :export:
-
 Internal Functions
 ------------------
 
-- 
2.26.2

