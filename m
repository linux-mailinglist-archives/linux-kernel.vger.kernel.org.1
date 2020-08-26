Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3C1252BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHZKsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 06:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbgHZKrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:40 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0127C206EB;
        Wed, 26 Aug 2020 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438860;
        bh=sA+LLjFnYe1xhNIVyej80xZ8cWbaGG48uMqipjGVTpU=;
        h=From:To:Cc:Subject:Date:From;
        b=drWgVtUjlEW193ffUizq1GNP3tFx9uVKivX3rGSl6VWuI78HtADFWYXo98v02hF4q
         1JC4JutOnopRaXGjcqMnsQD6WfYnq2nGhDuo6lOEQD+p+0Ty/US+ctdZw78f4SVqZ8
         raQ7+JhnCdtupkqYDssg+YxisODHD3YbIX3h9Ky4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxt-002EMx-VS; Wed, 26 Aug 2020 12:47:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] drivers: net: hamradio: fix document location
Date:   Wed, 26 Aug 2020 12:47:37 +0200
Message-Id: <20200826104737.531851-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hamradio docs were moved to a different dir.
Update its location accordingly.

Fixes: 14474950252c ("docs: networking: move z8530 to the hw driver section")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/net/hamradio/scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index 1e915871baa7..36eeb80406f2 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -7,7 +7,7 @@
  *            ------------------
  *
  * You can find a subset of the documentation in 
- * Documentation/networking/device_drivers/wan/z8530drv.rst.
+ * Documentation/networking/device_drivers/hamradio/z8530drv.rst.
  */
 
 /*
-- 
2.26.2

