Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0562C27E9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgI3N0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730270AbgI3NZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:22 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87D423A8B;
        Wed, 30 Sep 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=WjAErSinh3LCU2cyrsPuXTAB9dQw/nctDKJlUq9y1yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibA2bI3nOwDT+lt0wCMC/1YzEu4Xcz/gcvT2ZVN1wQTcfjSAD5/WAGf6mRyUKrtq0
         TrBBJ5N/eYBJbt34yZNu//6s7DdOvX/nJcPogNE+OMJjbInydwR/YlVTSaC54woTwX
         VgjHKHy/efAx5DDSUXCxKmXIg4EwrFeH0lMUOp0o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XLE-Sz; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 49/52] workqueue: fix a kernel-doc warning
Date:   Wed, 30 Sep 2020 15:25:12 +0200
Message-Id: <1d025719a6f6a55fcb5f8a9c382ed846cec9a4d9.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
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

