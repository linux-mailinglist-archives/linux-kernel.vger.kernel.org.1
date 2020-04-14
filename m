Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881BE1A862E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbgDNQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440310AbgDNQtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B32821D7D;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=KYgrRzJZ+v2MtmRgRhrMiVbwLP4xnRRe17npBnjIDz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrw1GkKImF+CJjoYQO64+lyjCRGbzBnAJdiZJnXz3MLlaIEai9d5D+x61La8eui84
         Mn7afwUKcHvDhCveuOuX9GUTSPDb8de72sPmYQ48eWNMaCANeMG/8Bb9VC1LOFsTUy
         znXe0jBKMpDaxLZQt91H0eLYd9XsbHFnJGRqMxMs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068ma-84; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 21/33] docs: mm: userfaultfd.rst: use a cross-reference for a section
Date:   Tue, 14 Apr 2020 18:48:47 +0200
Message-Id: <f46b45f1aaec233217f2e0b0438bbd8cc16fe17b.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
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

