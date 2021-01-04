Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836C42E94DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhADM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhADM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:29:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B25C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 04:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aPOpPSwMVGvB0YgnVHYQLbIN4iJja9dP/akBIyla8Ds=; b=a7jfodKoGQgkSmFy+M5rC7N4f5
        HSTenOWSmTK6DCeA8D/1XAnp8AVhMgtVE3w9t8m8aMBw8IgvQmpHY2H7+UMrN6xkWsCemiM5I32gh
        8ulRMujciBGyI6RE2DxofOClbVO5j646EfbfZZB85LZ/A7DQW3vBiLFXSr5kgClNuPXnFY5/71948
        JSMJLUfJ/RjOsR62xZj9nLBBwJ0DuMkYp7c1mc47/MtsjdJ0Xwomsg+7gFHNqzF95ll/Oa0+t5ILg
        GjRqAxnbOcEwf7vjPz3Xor5Ndl43ZDiOxYkJHP3gnYzK7/Yss1HkybhixyebmKJuud3hM5dLmefWs
        qwbLVEqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwOyH-00052o-VW; Mon, 04 Jan 2021 12:28:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 856763010D2;
        Mon,  4 Jan 2021 13:28:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F7C020CBF479; Mon,  4 Jan 2021 13:28:25 +0100 (CET)
Date:   Mon, 4 Jan 2021 13:28:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] kdev_t: Always inline major/minor helper functions
Message-ID: <20210104122825.GM3021@hirez.programming.kicks-ass.net>
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 09:30:48AM -0600, Josh Poimboeuf wrote:
> Silly GCC doesn't always inline these trivial functions.
> 
> Fixes the following warning:
> 
>   arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

The alternative is something like:

diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
index 6cf65397d225..6ca3da08dbcb 100644
--- a/arch/x86/kernel/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -133,18 +133,23 @@ static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
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
