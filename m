Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F73128CDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgJMMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbgJMLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:41 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D18320E65;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=4d7Y4VRJAT55TPn+Ta7Z8IsjnKYifaTuMxjzy7uI7jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARJi3Uutsq5GzqjFATC/NaWhycZCBZh8Xsn9qQ4OuGL/Vi8WroghrkHVKOqTUogAL
         8bW/EECyxlAfk3jLz6CXeZZnFeIU6T3+Chu/2NQ+K7XdYGT1wFTxVmp7Lr8h080h6b
         /GDdSGRxSuoj36aUBI25RJ2dgxESYti2nJOILdus=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUO-Co; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 27/80] docs: genericirq.rst: don't document chip.c functions twice
Date:   Tue, 13 Oct 2020 13:53:42 +0200
Message-Id: <dc99199c32813914c021f3881c940c63a9c7b0cd.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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

