Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A055827E9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgI3N17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE66423787;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=6FnAXTisJK9UFRAN8m9cKwYQmxfqAucBzkfFzqVowps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekgBkwqcfGP7rF4OSPes0LKDkULP2GuJ7JWXq9QFd+Oe24Nsyi8F4NZNRUaBAzrID
         u17TSyM/aFzmLp7SqJcFxY6uKrFuGbVBBGqaIHiNFnuRUYmMFski+8BlYDJRalLMEl
         A7I0ALeK0D0Iw7GIyfmvqaW1Sl083A9hMkd0tUHo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XKH-2e; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 32/52] docs: basics.rst: get rid of rcu kernel-doc macros
Date:   Wed, 30 Sep 2020 15:24:55 +0200
Message-Id: <31be2e0db89158d44e99c22b7752da313cc6a982.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are already defined at kernel-api.rst, as part of the
synchronization primitives chapter.

This solves several Sphinx 3 warnings, like:

	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'rcu_idle_enter'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'rcu_idle_exit'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'rcu_is_watching'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'call_rcu'.
	.../Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'synchronize_rcu'.
	...

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/basics.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 54f8d5ca7475..63bbe3ed5e76 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -103,12 +103,6 @@ Kernel utility functions
 .. kernel-doc:: kernel/panic.c
    :export:
 
-.. kernel-doc:: kernel/rcu/tree.c
-   :export:
-
-.. kernel-doc:: kernel/rcu/update.c
-   :export:
-
 .. kernel-doc:: include/linux/overflow.h
    :internal:
 
-- 
2.26.2

