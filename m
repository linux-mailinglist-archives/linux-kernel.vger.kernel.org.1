Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBA25E027
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIDQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgIDQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:48:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB53CC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qSjMS9ZCPt26N5Rnx9e6arn/zW5Cw1f8ReNOL+Oht4k=; b=NV+Jt2s/+31HkxNEHukRME3CeF
        F0izkTrz0uAc0mFQoYbMh+n4C//idEo5XRYSb5SQR4bMGXehfx6qwi1xrOiy35NxORZuMxMTu+6uq
        UGKZL1Ewr4xs1ryg/uKciyJjSAzEYlEb+KYHNJrp6BxouxvG6oJPl5NkGxl7yvfCiaBLElPAF6fny
        sumXD3H/lUij6bi03BfKRjxwVf+aaDapG61iCA8Hz8tjWC85z3FedkBW04g84SqBqWwRB2vBpqvXJ
        BBTxbUXtsP/Shj/Sk+OFonb32xSbHUvUPN5gYFfDrg7yXG72MM+xL91SXeFZ884GojzxsZYnrVzbz
        Tr9gbrrQ==;
Received: from [2001:4bb8:184:af1:704:22b1:700d:1395] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEEsg-0000nF-CO; Fri, 04 Sep 2020 16:48:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: wire up ->splice_read and ->splice_write
Date:   Fri,  4 Sep 2020 18:48:05 +0200
Message-Id: <20200904164805.1799256-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the kernel_write that the init code uses to apply sysctl
values from the kernel command line keeps working without set_fs().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

This could be folded into "sysctl: Convert to iter interfaces".

 fs/proc/proc_sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index a4a3122f8a584a..317899222d7fdf 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -853,6 +853,8 @@ static const struct file_operations proc_sys_file_operations = {
 	.poll		= proc_sys_poll,
 	.read_iter	= proc_sys_read,
 	.write_iter	= proc_sys_write,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.llseek		= default_llseek,
 };
 
-- 
2.28.0

