Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0102627E9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgI3N2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730211AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9749F22207;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472320;
        bh=gNXKJDeP/qXfRDHlgUC1JYNj3ZFfNLHk91vWce1l15I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvjqmYRpAdQFsVzxLwZLNhytbBtvSHRwk1iDJBdx0SkQdaiKFujDrDdohiGXB/1Rc
         EVq0U0KSDhwYND4vbQCQYqVW4F4V5Hr0L48zchKrgYeyIU5ivMRdb3DWF7y1i/YkHy
         OCG+Pzhe6ERLePuADL6e1Jo5uX2ASke5bpUsW6ms=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6g-001XJw-PZ; Wed, 30 Sep 2020 15:25:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/52] docs: it_IT: fix namespace collisions at locking.rst
Date:   Wed, 30 Sep 2020 15:24:47 +0200
Message-Id: <d5931981f4534075a044177811292fb182f7a468.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C domain functions there collide with the English ones,
due to namespace collision, generating lots of warnings with
Sphinx 3.x:

	./include/linux/mutex.h:121: WARNING: Duplicate C declaration, also defined in 'translations/it_IT/kernel-hacking/locking'.
	Declaration is 'mutex_init'.
	./include/linux/mutex.h:152: WARNING: Duplicate C declaration, also defined in 'translations/it_IT/kernel-hacking/locking'.
	Declaration is 'mutex_is_locked'.
	./include/linux/mutex.h:226: WARNING: Duplicate C declaration, also defined in 'translations/it_IT/kernel-hacking/locking'.
	Declaration is 'mutex_trylock_recursive'.
	./kernel/locking/mutex.c:281: WARNING: Duplicate C declaration, also defined in 'translations/it_IT/kernel-hacking/locking'.
	Declaration is 'mutex_lock'.
	...

Add a namespace tag there, in order to prevent that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 4615df5723fb..bf1acd6204ef 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1,5 +1,7 @@
 .. include:: ../disclaimer-ita.rst
 
+.. c:namespace:: it_IT
+
 :Original: :ref:`Documentation/kernel-hacking/locking.rst <kernel_hacking_lock>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
-- 
2.26.2

