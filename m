Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84C29DF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgJ1WNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbgJ1WMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:12:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED0C24805;
        Wed, 28 Oct 2020 18:34:33 +0000 (UTC)
Date:   Wed, 28 Oct 2020 19:35:25 +0100
From:   Greg Kroah-Hartman <gregkh@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] proc "single files": switch to ->read_iter
Message-ID: <20201028183525.GB2957431@kroah.com>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
 <20201027075541.GA24429@kroah.com>
 <20201027080745.GA31045@infradead.org>
 <20201027081420.GA30177@kroah.com>
 <20201027091725.GA42707@kroah.com>
 <20201027163213.GA25390@infradead.org>
 <20201028160011.GA2784447@kroah.com>
 <20201028183359.GA2957431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028183359.GA2957431@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ->read_iter for all proc "single files" so that more bionic
tests cases can pass when they call splice() on other fun files like
/proc/version

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 2f9fa179194d..f81327673f49 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -621,7 +621,7 @@ static int proc_single_open(struct inode *inode, struct file *file)
 static const struct proc_ops proc_single_ops = {
 	/* not permanent -- can call into arbitrary ->single_show */
 	.proc_open	= proc_single_open,
-	.proc_read	= seq_read,
+	.proc_read_iter = seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 };
-- 
2.29.1

