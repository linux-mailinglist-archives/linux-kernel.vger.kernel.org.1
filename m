Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA2A284CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgJFOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgJFOD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:57 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E68C207EA;
        Tue,  6 Oct 2020 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993036;
        bh=d1bjmUUgu8K9DCmWtXmBa+B1jVi9vhMklrj4WEXoEiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeZDIaO7c7J9+LGj3ChLAst5vvsQ8uOHv9hrTGEs0JImPFYkXv53xfBU1MB+orZrG
         LbqKtR4Dq3vYJ1X+okviQ1mGnqoqb088a7LG/4jJRxp852Tgedyhj8N02K1a2vQrFk
         GZ641FMbaV5tsmHR+BRb6utrdoRsI94dN9F/rDZo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZJ-0019Gm-3f; Tue, 06 Oct 2020 16:03:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 49/52] workqueue: fix a kernel-doc warning
Date:   Tue,  6 Oct 2020 16:03:46 +0200
Message-Id: <e39099763ba5001c12b4da37331ceba518b1d00e.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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
index ac088ce6059b..437935e7a199 100644
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

