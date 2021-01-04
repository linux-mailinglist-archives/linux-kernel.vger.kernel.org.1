Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF82E9941
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbhADPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbhADPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:54:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C06CC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E6tJSOtvDffaUDL1xmQVKXT+V3cMniQ+kR2jdfSu0pk=; b=mrHI7Vd2GFPanp9ux4UrcquCRy
        ZWOA7d81UyULk6JApql3PlxJS8ddcyBdIPRy+mrVs3kofTIxkKX0RrOe8TxtSgtfVPCnRYf0bVBnM
        AumbbSOMju5NSp5HpHOf4Sxoxx045lBtWHxiM8adoREt4LMlYWYBd+4uPG02OkGfwTKxrPmn8aiza
        8bYMQeqIwu/7NQyYPbI3hQlRFz6hGBl9Fv7WKe9t9GB0vWuYKrb4g1bXUMufKOmhAxOZJUlJVacsH
        BvNLW3dtRTu/8qWmp2gIrvYAS+8XW9gxtobRTHbhz8vBWY3rUdlZTdAfFe4XhEtKchENeOcKxSw5C
        sl7IHnEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwSB4-000291-KH; Mon, 04 Jan 2021 15:53:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 769FD301CC4;
        Mon,  4 Jan 2021 16:53:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62A2F2C539E92; Mon,  4 Jan 2021 16:53:47 +0100 (CET)
Date:   Mon, 4 Jan 2021 16:53:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org
Subject: [PATCH] x86/compat: Pull huge_encode_dev() outside of UACCESS
Message-ID: <20210104155347.GC3040@hirez.programming.kicks-ass.net>
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
 <20210104122825.GM3021@hirez.programming.kicks-ass.net>
 <20210104153127.e44uchjhlgg3hq2g@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104153127.e44uchjhlgg3hq2g@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 09:31:27AM -0600, Josh Poimboeuf wrote:
> Peter, care to submit a proper patch?

Here goes..

---
Subject: x86/compat: Pull huge_encode_dev() outside of UACCESS
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 4 Jan 2021 13:28:25 +0100

Fixes the following warning:

  arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/sys_ia32.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -133,18 +133,23 @@ static int cp_stat64(struct stat64 __use
 {
 	typeof(ubuf->st_uid) uid = 0;
 	typeof(ubuf->st_gid) gid = 0;
+	u64 dev, rdev;
+
 	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
 	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
+	dev = huge_encode_dev(stat->dev);
+	rdev = huge_encode_dev(stat->rdev);
+
 	if (!user_write_access_begin(ubuf, sizeof(struct stat64)))
 		return -EFAULT;
-	unsafe_put_user(huge_encode_dev(stat->dev), &ubuf->st_dev, Efault);
+	unsafe_put_user(dev, &ubuf->st_dev, Efault);
 	unsafe_put_user(stat->ino, &ubuf->__st_ino, Efault);
 	unsafe_put_user(stat->ino, &ubuf->st_ino, Efault);
 	unsafe_put_user(stat->mode, &ubuf->st_mode, Efault);
 	unsafe_put_user(stat->nlink, &ubuf->st_nlink, Efault);
 	unsafe_put_user(uid, &ubuf->st_uid, Efault);
 	unsafe_put_user(gid, &ubuf->st_gid, Efault);
-	unsafe_put_user(huge_encode_dev(stat->rdev), &ubuf->st_rdev, Efault);
+	unsafe_put_user(rdev, &ubuf->st_rdev, Efault);
 	unsafe_put_user(stat->size, &ubuf->st_size, Efault);
 	unsafe_put_user(stat->atime.tv_sec, &ubuf->st_atime, Efault);
 	unsafe_put_user(stat->atime.tv_nsec, &ubuf->st_atime_nsec, Efault);
