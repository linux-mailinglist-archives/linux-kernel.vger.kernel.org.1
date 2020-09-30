Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F74927E9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgI3N2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54F22220D;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472320;
        bh=4d7Y4VRJAT55TPn+Ta7Z8IsjnKYifaTuMxjzy7uI7jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVIy0uKA4JDxLe+HD+JZZEzn/+u+SMejhzHKOi5cz2Y8E60sbTI0MH9H6ECADbqGl
         XzjC9RhVmbzqoqeHjCwLIK6V7D30OeoeYhRKmTRxndbhb67yug2eGIodmx+tvXZs1J
         jRn20CtrPKL+aQzQNxwWofSXMRpUKH3vMmW23CHw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6g-001XK0-RB; Wed, 30 Sep 2020 15:25:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 26/52] docs: genericirq.rst: don't document chip.c functions twice
Date:   Wed, 30 Sep 2020 15:24:49 +0200
Message-Id: <d10161c8ffbab42429128b6356afea25f39e3ec8.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel/irq/chip.c is included twice, one for
export functions, and then for internal ones. However, as
the :export:  and :internal: tags are missing, they ended
being included twice.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/genericirq.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index 8f06d885c310..f959c9b53f61 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -419,6 +419,7 @@ functions which are exported.
 .. kernel-doc:: kernel/irq/manage.c
 
 .. kernel-doc:: kernel/irq/chip.c
+   :export:
 
 Internal Functions Provided
 ===========================
@@ -431,6 +432,7 @@ functions.
 .. kernel-doc:: kernel/irq/handle.c
 
 .. kernel-doc:: kernel/irq/chip.c
+   :internal:
 
 Credits
 =======
-- 
2.26.2

