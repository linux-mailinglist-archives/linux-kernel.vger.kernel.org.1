Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14427284D46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgJFOHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 297202184D;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=0pyzte4nOruiOG+lT9yn7ghxCXfyNWzJBTAY2OTjNYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h69BQwwk/2XJO6ybKr+sOSwtJEH0nkPjKJUkS/shs3pwRMxhrhSShSynMpAZpZc5m
         YG/fFl9sCGAmLERIObOvKr1s6Dq9P2lZFXQKvK2HFj1w9+hr9Py7nEySo2oAb7oFFt
         LTJLBd2Fh85I0LhT34Dh0G67/08M7G6LO6iN5FHk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019FZ-5t; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 24/52] docs: it_IT: fix namespace collisions at locking.rst
Date:   Tue,  6 Oct 2020 16:03:21 +0200
Message-Id: <a37cec113fcbcb496570f1f4ae87da17e452875a.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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

