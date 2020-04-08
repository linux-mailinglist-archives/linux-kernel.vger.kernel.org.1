Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2651A25E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgDHPrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9CE21D93;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=KYgrRzJZ+v2MtmRgRhrMiVbwLP4xnRRe17npBnjIDz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ZilhxvAS0aj2blU0fP644wq2Z4UixdRpri1yfv278n+yi5nPomW/rKtvas+IXE6x
         q7cq2qpe0xFq47U5qD0cHXf2HdhKHRGKTNG+I0Pb055dhMEYcC9VebO9QFrqCX6AzN
         iK1Nz05JZ7ngdB1YHZv5CwB74J+7XQSKV0Iq3qHc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cCK-18; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 26/35] docs: mm: userfaultfd.rst: use a cross-reference for a section
Date:   Wed,  8 Apr 2020 17:46:18 +0200
Message-Id: <99baaadbec459cd442e2da32d33d5045b7e34f24.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using "foo", let's use `foo`_, with is a ReST way of
saying that foo is a section of the document. With that, after
building the docs, an hyperlink is generated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 740d111faf1c..0bf49d7313ad 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -79,7 +79,7 @@ or shared memory need to set the corresponding flag in
 If the userland desires to receive notifications for events other than
 page faults, it has to verify that ``uffdio_api.features`` has appropriate
 ``UFFD_FEATURE_EVENT_*`` bits set. These events are described in more
-detail below in "Non-cooperative userfaultfd" section.
+detail below in `Non-cooperative userfaultfd`_ section.
 
 Once the ``userfaultfd`` has been enabled the ``UFFDIO_REGISTER`` ioctl should
 be invoked (if present in the returned ``uffdio_api.ioctls`` bitmask) to
-- 
2.25.2

