Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E52E98DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbhADPdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbhADPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609774299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSCqeJdUyZnrfJN1i9nmVPHfyO93Ly+vZYo4afEpdxQ=;
        b=Xw9+intKKbzR7K9bFtEUAEbQTu4SbrJm/ldDUkOJJf2fueAglW26SwiXQR2TVc6gZqUbzX
        OMGjdhI/xD90hyIgvgX45En2MOhs+CPinpPEqwjE3TZAhweNbjWgKl6DeYM4eV3PRmJ4Yd
        F3QYA3tQy4lrysjH8dAajJxgvZTrb5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-65a-NbCROUKNFbED5tiBTQ-1; Mon, 04 Jan 2021 10:31:37 -0500
X-MC-Unique: 65a-NbCROUKNFbED5tiBTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5872F801817;
        Mon,  4 Jan 2021 15:31:35 +0000 (UTC)
Received: from treble (ovpn-113-48.rdu2.redhat.com [10.10.113.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C026D1001281;
        Mon,  4 Jan 2021 15:31:34 +0000 (UTC)
Date:   Mon, 4 Jan 2021 09:31:27 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] kdev_t: Always inline major/minor helper functions
Message-ID: <20210104153127.e44uchjhlgg3hq2g@treble>
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
 <20210104122825.GM3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104122825.GM3021@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 01:28:25PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 23, 2020 at 09:30:48AM -0600, Josh Poimboeuf wrote:
> > Silly GCC doesn't always inline these trivial functions.
> > 
> > Fixes the following warning:
> > 
> >   arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> The alternative is something like:

I like your approach better, it avoids __always_inline sprawl.

Peter, care to submit a proper patch?

Andrew, can you drop mine?

> 
> diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
> index 6cf65397d225..6ca3da08dbcb 100644
> --- a/arch/x86/kernel/sys_ia32.c
> +++ b/arch/x86/kernel/sys_ia32.c
> @@ -133,18 +133,23 @@ static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
>  {
>  	typeof(ubuf->st_uid) uid = 0;
>  	typeof(ubuf->st_gid) gid = 0;
> +	u64 dev, rdev;
> +
>  	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
>  	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
> +	dev = huge_encode_dev(stat->dev);
> +	rdev = huge_encode_dev(stat->rdev);
> +
>  	if (!user_write_access_begin(ubuf, sizeof(struct stat64)))
>  		return -EFAULT;
> -	unsafe_put_user(huge_encode_dev(stat->dev), &ubuf->st_dev, Efault);
> +	unsafe_put_user(dev, &ubuf->st_dev, Efault);
>  	unsafe_put_user(stat->ino, &ubuf->__st_ino, Efault);
>  	unsafe_put_user(stat->ino, &ubuf->st_ino, Efault);
>  	unsafe_put_user(stat->mode, &ubuf->st_mode, Efault);
>  	unsafe_put_user(stat->nlink, &ubuf->st_nlink, Efault);
>  	unsafe_put_user(uid, &ubuf->st_uid, Efault);
>  	unsafe_put_user(gid, &ubuf->st_gid, Efault);
> -	unsafe_put_user(huge_encode_dev(stat->rdev), &ubuf->st_rdev, Efault);
> +	unsafe_put_user(rdev, &ubuf->st_rdev, Efault);
>  	unsafe_put_user(stat->size, &ubuf->st_size, Efault);
>  	unsafe_put_user(stat->atime.tv_sec, &ubuf->st_atime, Efault);
>  	unsafe_put_user(stat->atime.tv_nsec, &ubuf->st_atime_nsec, Efault);
> 

-- 
Josh

