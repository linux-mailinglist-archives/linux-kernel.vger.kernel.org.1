Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1129C2974B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbgJWQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbgJWQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:48 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186C72465D;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=qvrL+WJvA1J1w+eeTkECSvPpdjf9tJvNl8jNov5K+O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1bC9+Rh+LLz9s/n6NW6Yk/vFR2c8wvMJBIn3FTNvShvhSuZmn7bvt6aOYO5EstMJ
         mEK5l53kWheP3QbCDqmLK5by7uxOUp1pkZbkjB8xXlryWhb5pgHdN479aIynWqYfJj
         ZuwwQghzozReULeIAVvdXCyDOQ15XxTZs6iNc71k=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002Avs-4W; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/56] HSI: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:00 +0200
Message-Id: <3413b262be902163f9daed8f0ca4c32d6ed73c98.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/hsi/hsi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index 47f0208aa7c3..c3fb5beb846e 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -352,7 +352,7 @@ static void hsi_port_release(struct device *dev)
 }
 
 /**
- * hsi_unregister_port - Unregister an HSI port
+ * hsi_port_unregister_clients - Unregister an HSI port
  * @port: The HSI port to unregister
  */
 void hsi_port_unregister_clients(struct hsi_port *port)
-- 
2.26.2

