Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0D224E70
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgGSAcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgGSAcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:32:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D43C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ti1yf0IJvGWu/NgMq8i9V7IajAX4x4lywIexARBwC+A=; b=hKeREWNIvM68c6YYNXEVmgMduY
        ExldPVqPqyZJNzxPeGWbHYmr6oTem7idlcp7nJzwDqoTRoYkr3c9v9wYwnlEN/vJZ6gBlwT1Psh1/
        WIl+dwfA3DylVu8XHgmXHft0d/YtXMnCNiWWJJdK6VFEBpdyz/eugFh1riZujJy9wd+mpHIHOetM4
        SQoHiPa77ZKQyyfl8hABnURNSCuqhvigMJiqfNNAgYSf/+ZhiVGDBI3UML+AakKwIvwXrLr0HFzR/
        xEXZ2rFT4gqiGvsBt7EbG9tq0S9ZfPDfpRCrXEj/6yAB1hrmbTEbYQulNCImWfVGUwRNLImUpPzcG
        04HtPThg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxFU-0002zR-MC; Sun, 19 Jul 2020 00:32:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] MTD: mtd-abi.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:32:08 -0700
Message-Id: <20200719003208.21200-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "mode" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 include/uapi/mtd/mtd-abi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/uapi/mtd/mtd-abi.h
+++ linux-next-20200717/include/uapi/mtd/mtd-abi.h
@@ -262,7 +262,7 @@ struct mtd_ecc_stats {
  * @MTD_FILE_MODE_OTP_USER:	OTP enabled in user mode
  * @MTD_FILE_MODE_RAW:		OTP disabled, ECC disabled
  *
- * These modes can be set via ioctl(MTDFILEMODE). The mode mode will be retained
+ * These modes can be set via ioctl(MTDFILEMODE). The mode will be retained
  * separately for each open file descriptor.
  *
  * Note: %MTD_FILE_MODE_RAW provides the same functionality as %MTD_OPS_RAW -
