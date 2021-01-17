Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F902F9109
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 07:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbhAQGOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 01:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbhAQGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 01:14:10 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54918C061573
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 22:13:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id h10so8226833pfo.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=m92jllxp8ATkpeTP2orbA0iZRNx7dyUiOz/VlucA5Us=;
        b=U8bIZpKr6PsfokwDkelrYuom18ZGRS1lzMqCufLE0ls44uyIbrd6+OjHKafInye49z
         ahIe9zMdlyncNMK/tkc+PRiQB98jENYXObcb5uF8VWm4bbLGv1PhLwZ4DLSnFWg1DTai
         VsJQrkPuYBnKeL54XlP1V1JOvLBs41n4tDlye0nNw9o6GqGvkHaSI5iY88fspzbo3Xwn
         yzVWwXyRNmkhgz0xkLnong0Fx4F1K6diHLrhnSkOeJXWd/8XTpkEfhvt9vIAfcrpH/1D
         7BgOC0wf5OrAW+1E/zCGWoMTEgNe6eVGEVF8Pml9J/sjYlXY2hd8UMLdqeYQui5cmuL6
         wU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=m92jllxp8ATkpeTP2orbA0iZRNx7dyUiOz/VlucA5Us=;
        b=sethtiKh7ZEdOeeFotr7qGHBtxPaZelDiqVEpvdxFcavvjlN1oLCX+JlSgxkfK7IO4
         PeePJwfSkbocEkyEib8JkpoxM1cc3fzyyuKgPxhO1ysSNWeYY6PZ1qWV9K+1K9mx0jzE
         CeWxCu8u1kJjy9ThYudeA3pLipnldu/Lk3S8u0VY4Mci4SELATcSqY9OnqXUUlekEXNG
         yxbEnJ5yurA6lIhuvUjAOW14QoUgXGSuBlpXZmMowpPUbshrV+X/KAmCOfCm1McM0gtT
         WID26+cI16m7lutT5xjBDX6eQASH3jShDCPnbrcapnizJWx71OM01NHN1M+DQ/wjUJ+t
         xPaA==
X-Gm-Message-State: AOAM532Rvd2hzjhiOsO5ZylffGtaYe9Ea0cKTSKvswulM7hFgAN3BHPL
        uB6x4GxGcFky9a+LvAEOpeBHvwtPY58=
X-Google-Smtp-Source: ABdhPJx2GMTc6B3BMbzLoigDVcBpkOyeJlW1E5fzCn5AJCnUWBR4lThH/bpnTqtWECV/hIit5s2JWg==
X-Received: by 2002:a63:4504:: with SMTP id s4mr20479562pga.284.1610864009749;
        Sat, 16 Jan 2021 22:13:29 -0800 (PST)
Received: from localhost ([116.12.58.169])
        by smtp.gmail.com with ESMTPSA id fh15sm1534367pjb.32.2021.01.16.22.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 22:13:29 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: Splicing to/from a tty
From:   "Oliver Giles" <ohw.giles@gmail.com>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        <linux-kernel@vger.kernel.org>
Date:   Sun, 17 Jan 2021 19:12:17 +1300
Message-Id: <C8L7LWQDH7O9.1GHEPFD33W15X@oguc>
In-Reply-To: <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jan 17, 2021 at 5:46 AM NZDT, Johannes Berg wrote:
> On Sat, 2021-01-16 at 20:35 +1300, Oliver Giles wrote:
> > Commit 36e2c7421f02 (fs: don't allow splice read/write without
> > explicit ops) broke my userspace application which talks to an SSL VPN
> > by splice()ing between "openssl s_client" and "pppd". The latter
> > operates over a pty, and since that commit there is no fallback for
> > splice()ing between a pipe and a pty, or any tty for that matter.
> >=20
> > The above commit mentions switching them to the iter ops and using
> > generic_file_splice_read. IIUC, this would require implementing iter
> > ops also on the line disciplines, which sounds pretty disruptive.
> >=20
> > For my case, I attempted to instead implement splice_write and
> > splice_read in tty_fops; I managed to get splice_write working calling
> > ld->ops->write, but splice_read is not so simple because the
> > tty_ldisc_ops read method expects a userspace buffer. So I cannot see
> > how to implement this without either (a) using set_fs, or (b)
> > implementing iter ops on all line disciplines.
> >=20
> > Is splice()ing between a tty and a pipe worth supporting at all? Not a
> > big deal for my use case at least, but it used to work.
>
> Is it even strictly related to the tty?
>
> I was just now looking into why my cgit/fcgi/nginx setup no longer
> works, and the reason is getting -EINVAL from sendfile() when the input
> is a file and the output is a pipe().
>
> So I wrote a simple test program (below) and that errors out on kernel
> 5.10.4, while it works fine on the 5.9.16 I currently have. Haven't
> tried reverting anything yet, but now that I haev a test program it
> should be simple to even bisect.
>
> johannes
>
>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/sendfile.h>
> #include <stdio.h>
> #include <assert.h>
>
> int main(int argc, char **argv)
> {
> int in =3D open(argv[0], O_RDONLY);
> int p[2], out;
> off_t off =3D 0;
> int err;
>
> assert(in >=3D 0);
> assert(pipe(p) >=3D 0);
> out =3D p[1];
> err =3D sendfile(out, in, &off, 1024);
> if (err < 0)
> perror("sendfile");
> assert(err =3D=3D 1024);
>
> return 0;
> }

I can confirm the behaviour you see, and that it starts occurring from the =
same
commit 36e2c7421f02a22 (fs: don't allow splice read/write without explicit =
ops).

In my tty case, it is clear that removing the default fallback would cause =
this
to fail, but assuming the sendfile() source is on a regular filesystem, I a=
m
unsure why splice cannot find the appropriate splice_write method. Could be
connected to the fact that the message from warn_unsupported in fs/splice.c
outputs "splice write not supported for file  (pid: 983819 comm: test-sendf=
ile)",
i.e. the file path is blank. In my case of directly calling splice on a pty=
, I
do see a path such as /ptyp0 in that error before implementing splice_(read=
/write)
callbacks. Maybe splice is getting a bogus file pointer from sendfile?
