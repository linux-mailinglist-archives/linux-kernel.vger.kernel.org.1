Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C892284D45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgJFOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358CF21924;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=4d7Y4VRJAT55TPn+Ta7Z8IsjnKYifaTuMxjzy7uI7jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRvZnfSdIh2iEqHL61vTe8e5oZxq0D1GCVimDnv0eaXBns8fNZ8L84uBrJZOzcf9e
         3zzH+OIRxt0v2AwfzHm9t6xAHsVVIZIt4LoLuaHLwDCqID5Er+Gsy3bGU7FI+ekfFM
         ympiEP66cbnCdJ0B2GZxP4l9bhDHcjq2MgmVENc8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019Fg-87; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 26/52] docs: genericirq.rst: don't document chip.c functions twice
Date:   Tue,  6 Oct 2020 16:03:23 +0200
Message-Id: <429b7d6ccc777772e10bf65159a72a108d562770.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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

