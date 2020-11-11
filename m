Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47C2AEACF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgKKIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgKKIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:05:37 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:05:36 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id 91so454530uar.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T52zolihXR5yVqpLPyKqfWvMWU33QxIhE3DUTqobAyk=;
        b=KdW1JirNzZixAW0y6k03W4n0oUx1mwgYHoRio7qxTLAW1sQch9eFg3FdNoi1F44WGb
         4AkF+mvvdOPJ70KxK4PyyiX26OuZGXP9KqvLg7dG2TAWats96jew/pbpzo7MCLUbTZPq
         1xzv974+79AmgYpqdDxT/LcxLdiwKZL43xtFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T52zolihXR5yVqpLPyKqfWvMWU33QxIhE3DUTqobAyk=;
        b=CKAHQOfkqft5Uhoewn2v0HYqhuSl/JjAxeb1uy/mx10RikXRmLtudN3dmL3ZiIRVdV
         5AygRZ2+Q6TXeG545LuAhoshdwJtxkHBnCmsk7Lnn9gk/w8DzkjcGECp6behNEvzNo20
         XZ408ggoxT0CI1XD7ug7lyI1B+chDPxE32KODRWWWjxuvqJ66B75kD9yqZKWDCiY79te
         v/ehc8BRF+3IInggOb78AuBv9XRqaRWC4zrt1rcrkOos18IcZwrsJCP9LRiSj6gBn9TF
         AZ1h9eZuG19UsZQSGWY7vFDz33JBkSUuJr8ZDzp67TTRSW6I5KCqVUZcLVZLtcj4c25l
         OwIA==
X-Gm-Message-State: AOAM532eNgbT5v9aWPTRE04qMKOnw8+YBUG5uZornwoKurDhsLnmwpCk
        d2Nj0r/f0WJGBlIo9usX5ULDD7H02YqLYKUH952ZEw==
X-Google-Smtp-Source: ABdhPJyVOGS5SgFT01Xc25kGbuYM8gjuJNx097W3WndVTFEeW06YEX0O0gClxTuu7GxCB3YblpehRMUpXUIJCHBBoc0=
X-Received: by 2002:ab0:6f54:: with SMTP id r20mr9470960uat.9.1605081935843;
 Wed, 11 Nov 2020 00:05:35 -0800 (PST)
MIME-Version: 1.0
References: <1e796f9e008fb78fb96358ff74f39bd4865a7c88.1604926010.git.gladkov.alexey@gmail.com>
 <CAJfpegua_ahmNa4p0me6R10wtcPpQVKNiKQOVKjuNW67RHFOOA@mail.gmail.com>
 <87v9ee2wer.fsf@x220.int.ebiederm.org> <CAJfpegugWh7r=h9T+fbb7FKrz2JpWtA==ck2iYq1DYJ25_-WyA@mail.gmail.com>
 <87d00ks5jg.fsf@x220.int.ebiederm.org>
In-Reply-To: <87d00ks5jg.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Nov 2020 09:05:24 +0100
Message-ID: <CAJfpeguyFLOKWgrU_7oUHgWkqUzBOf8zPRnL8aqGK3g0sghk=w@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] fuse: Abort waiting for a response if the
 daemon receives a fatal signal
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 8:42 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:

> > Okay, so the problem with making the wait_event() at the end of
> > request_wait_answer() killable is that it would allow compromising the
> > server's integrity by unlocking the VFS level lock (which protects the
> > fs) while the server hasn't yet finished the request.
> >
> > The way this would be solvable is to add a fuse level lock for each
> > VFS level lock.   That lock would be taken before the request is sent
> > to userspace and would be released when the answer is received.
> > Normally there would be zero contention on these shadow locks, but if
> > a request is forcibly killed, then the VFS lock is released and the
> > shadow lock now protects the filesystem.
> >
> > This wouldn't solve the case where a fuse fs is deadlocked on a VFS
> > lock (e.g. task B), but would allow tasks blocked directly on a fuse
> > filesystem to be killed (e.g. task A or C, both of which would unwind
> > the deadlock).
>
> Are we just talking the inode lock here?
>
> I am trying to figure out if this is a straight forward change.
> Or if it will take a fair amount of work.

Inode lock and cross directory rename lock should suffice, I think.

One issue is that we are losing normal ref on dentry+mount, so in case
the process is killed we need to take a ref on the inode.

Since multiple inode locks can be held for one op, we need to take
care of ordering the shadow locks as well.

It's not a trivial change, but I'd be much happier if we would take
this instead of the hackish one.

Thanks,
Miklos
