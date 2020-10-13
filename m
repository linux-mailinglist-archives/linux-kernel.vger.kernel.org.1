Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D428CD50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgJML6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbgJMLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:45 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4DE22461;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=MPQs8W30JflCTFiIlGtFFfrL+4ZW++K+/1kdKgyWGus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6iOpzueKlramfN4m7NN8m55x/cH1zpNhCb0QNZ8Xs/+9fAf3wJeq3pd2PH8Pmib9
         KRAgtEfispO1LdcRHa18JD9TYHGfyB2fpRHEFEBhWZhe8QM5vAo7iWvoUojpgu9z2P
         r7GVjFQ3ti/WNGK6JP2uscbV/EGxU+mHzd1PAv1c=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt6-006CWw-2Z; Tue, 13 Oct 2020 13:54:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 77/80] workqueue: fix a kernel-doc warning
Date:   Tue, 13 Oct 2020 13:54:32 +0200
Message-Id: <eb001e880f786e225bbc4d5a2a4a1a3d95962036.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by Sphinx:

	./Documentation/core-api/workqueue:400: ./kernel/workqueue.c:1218: WARNING: Unexpected indentation.

the return code table is currently not recognized, as it lacks
markups.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c17b86a..e07d37396dfe 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1212,11 +1212,14 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
  * stable state - idle, on timer or on worklist.
  *
  * Return:
+ *
+ *  ========	================================================================
  *  1		if @work was pending and we successfully stole PENDING
  *  0		if @work was idle and we claimed PENDING
  *  -EAGAIN	if PENDING couldn't be grabbed at the moment, safe to busy-retry
  *  -ENOENT	if someone else is canceling @work, this state may persist
  *		for arbitrarily long
+ *  ========	================================================================
  *
  * Note:
  * On >= 0 return, the caller owns @work's PENDING bit.  To avoid getting
-- 
2.26.2

