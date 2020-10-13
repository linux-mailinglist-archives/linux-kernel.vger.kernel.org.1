Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0913A28CDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgJMMBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgJMLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:41 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4692722265;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=0pyzte4nOruiOG+lT9yn7ghxCXfyNWzJBTAY2OTjNYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtdGYCM6lYDW4R01e5Y/uCVkYXUPSsN9UAMNIhqoAZOLC09XRPUs3kdhIXE8+4dKx
         4fTvynonB6VYLvw4hRew20LErue0nj12awrFfHflVIQ+naxlNO4mFzDxOrCp99Lvax
         hsbZRI9s0Ph7UDFGiyWzkRDUkl6VbebE1UxrronY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUJ-Ay; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 25/80] docs: it_IT: fix namespace collisions at locking.rst
Date:   Tue, 13 Oct 2020 13:53:40 +0200
Message-Id: <0c2498def8932b0d75df2bdde7811d62b499ef10.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>
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

