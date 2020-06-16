Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223381FBE06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgFPSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFPSZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:25:31 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8716E208D5;
        Tue, 16 Jun 2020 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592331931;
        bh=L6sqfSgBmHN66ThR9qZuIm62kdJIyo1PoHR5cx2mp0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=eI5ha4zAruoT/Y0qoOY1+oRtaQhwhz101rJzQqnQRbw/6vp2GT74yCrUyjlXt64L2
         AHe49xwkrQwD8R8B94fluOqsraWpgSaAa3YOxPoyD10ndvZggNtpvxWWJuEN1aJeuk
         pjFtVwwAxRjQyzyP0ASgHq3pcpADDSp79MzgVKaI=
Date:   Tue, 16 Jun 2020 13:30:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] rapidio/rio_mport_cdev: Use array_size() helper in
 copy_{from,to}_user()
Message-ID: <20200616183050.GA31840@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size() helper instead of the open-coded version in
copy_{from,to}_user(). These sorts of multiplication factors
need to be wrapped in array_size().

This issue was found with the help of Coccinelle and, audited
and fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 451608e960a1..6943459f8ac2 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -981,7 +981,7 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 
 	if (unlikely(copy_from_user(transfer,
 				    (void __user *)(uintptr_t)transaction.block,
-				    transaction.count * sizeof(*transfer)))) {
+				    array_size(sizeof(*transfer), transaction.count)))) {
 		ret = -EFAULT;
 		goto out_free;
 	}
@@ -994,7 +994,7 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 
 	if (unlikely(copy_to_user((void __user *)(uintptr_t)transaction.block,
 				  transfer,
-				  transaction.count * sizeof(*transfer))))
+				  array_size(sizeof(*transfer), transaction.count))))
 		ret = -EFAULT;
 
 out_free:
-- 
2.27.0

