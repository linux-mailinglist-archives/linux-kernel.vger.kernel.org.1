Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CFC20537A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbgFWNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 09:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732632AbgFWNbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:31:44 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8051D207BB;
        Tue, 23 Jun 2020 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592919103;
        bh=km1TTFWf9AKbBi+av9lc+XYXFzm3Utc9eo+duYioHqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaQg+Cl+ziyIeJaT/ZDvBMckGqm+Pyu6qOuPCrD9OXD8tAxJL5f1rndIwfXUq01JK
         qOpcZPXStPwVQDo0yOuLZzFwkxsKrih4A18Bp6lB97FoeBk3pqKrccLlWQtOwc4FdQ
         QJeEwN1/iwBh8h/T7orF37EjNy22gCDsT2SDbffY=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnj1Z-007VJl-Em; Tue, 23 Jun 2020 15:31:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Harald Seiler <hws@denx.de>
Subject: [PATCH v3 4/7] docs: move mailbox.txt to driver-api and rename it
Date:   Tue, 23 Jun 2020 15:31:37 +0200
Message-Id: <03e40c31b86c1f4fd3597bf4bfb8346901286bab.1592918949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592918949.git.mchehab+huawei@kernel.org>
References: <cover.1592918949.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is already at the ReST format. Move it to
driver-api and rename it.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/index.rst                    | 1 +
 Documentation/{mailbox.txt => driver-api/mailbox.rst} | 0
 2 files changed, 1 insertion(+)
 rename Documentation/{mailbox.txt => driver-api/mailbox.rst} (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6567187e7687..3eb0085d5e42 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -48,6 +48,7 @@ available subsections can be seen below.
    scsi
    libata
    target
+   mailbox
    mtdnand
    miscellaneous
    mei/index
diff --git a/Documentation/mailbox.txt b/Documentation/driver-api/mailbox.rst
similarity index 100%
rename from Documentation/mailbox.txt
rename to Documentation/driver-api/mailbox.rst
-- 
2.26.2

