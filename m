Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7531B2A89DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgKEWdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbgKEWdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:33:03 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1CFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:33:01 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id l10so3270811lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkf+MRN9XePNXQPjQufkefpR5sElzsUbOnIrHmIP770=;
        b=dxIKfNfpEsAXmY/xWOqRrYkM9KlFylLD9rFoRLmTkO8jjuZkfPUeH0cTLVuRwfCvWw
         qaB2uzaQVJRgtANQv72cpW4iYK8to0dPByIUhVM1XpLoRsQnF6fn/QU8IZFB39U4CSh/
         QTVk/i2gdidGlBeNCjcofGE6FcM3VUzrU6R/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkf+MRN9XePNXQPjQufkefpR5sElzsUbOnIrHmIP770=;
        b=szh4+eujRF42rsZEqoyYwOTxBVhASFY+oREhF1bpbk0rIXeCiwafvmRP6bK5f/yqFd
         //p3yltDhDYp1vXHHt7JpLERlQbLwC+HWzoqVQdjFG/lf1HyErUDWK1e5AuRRC8Y05YQ
         5wBCQq1kx1S/Tgv2NI9VQxaOQyTEx03kToX3Not2/XG1wMLFbY34xmXZ1rv4+SJjkMA9
         FUcOYWGCyl9aGylaROIcul6bqQEPzAijYiW2+Ydz8RGz70uJGbagaR6bm2SUDmMO/xOV
         SjGyMN8nK9fKDZTONSykOGuSMNtfGB6V+fl2I13qO1RP8k6h2u8d1KnWuaV1fAWLa9QW
         JzEw==
X-Gm-Message-State: AOAM5335C74JhHzlIjRzcES+S9IWV1VG4AtrBbP9EfDl8QJDHUV5tdSS
        AZpxygCYTJnGaDWYwGBSFX2hrc+8caKFlk8uMkxfUw==
X-Google-Smtp-Source: ABdhPJzZTghwKY2TlTpaD9Gyq4u7DA0d8+dC+wDNWpMnhTTPrPUtIgXcNu8LgDgNWstlwwFF0idUGjoHJyQTVyKjv68=
X-Received: by 2002:a2e:7016:: with SMTP id l22mr1593857ljc.466.1604615580262;
 Thu, 05 Nov 2020 14:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20201105144755.214341-1-kpsingh@chromium.org> <20201105144755.214341-9-kpsingh@chromium.org>
 <20201105220250.uvm3unmbne36lsoz@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201105220250.uvm3unmbne36lsoz@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 5 Nov 2020 23:32:49 +0100
Message-ID: <CACYkzJ4sNH+PjrjzTYBQ-wcRqCN+b+v+qSk6otx-b3M-U-V3-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/9] bpf: Add tests for task_local_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 11:03 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Nov 05, 2020 at 03:47:54PM +0100, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > The test exercises the syscall based map operations by creating a pidfd
> > for the current process.
> >

[...]

> > +}
> > +
> > +unsigned int duration;
> static

Fixed.

>
> > +
> > +#define TEST_STORAGE_VALUE 0xbeefdead
> > +
> > +struct storage {
> > +     void *inode;
> > +     unsigned int value;
> > +     /* Lock ensures that spin locked versions of local stoage operations
> > +      * also work, most operations in this tests are still single threaded
> > +      */
> > +     struct bpf_spin_lock lock;
> > +};
> > +
> > +/* Copies an rm binary to a temp file. dest is a mkstemp template */
> > +int copy_rm(char *dest)
> static

FIxed.

[...]

> > +     ret = chmod(dest, 0100);
> > +     if (ret == -1)
> > +             return errno;
> > +
> > +     close(fd_in);
> > +     close(fd_out);
> fd_in and fd_out are not closed in error cases.

Fixed.

>
> >  {
> > -     char fname[PATH_MAX] = "/tmp/fileXXXXXX";
> > -     int fd;
> > +     int ret, fd_in, fd_out;
> > +     struct stat stat;
> >

[...]

> > + */
> > +int run_self_unlink(int *monitored_pid, const char *rm_path)
> static

Fixed.

>
> [ ... ]
>
> > +bool check_syscall_operations(int map_fd, int obj_fd)
> static

Fixed.

>
> [ ... ]
>
> >  void test_test_local_storage(void)
> >  {
> > +     char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
> > +     int err, serv_sk = -1, task_fd = -1;
> >       struct local_storage *skel = NULL;
> > -     int err, duration = 0, serv_sk = -1;
> >

[...]

> > +     err = unlink(tmp_exec_path);

> Will tmp_exec_path file be removed if there is error earlier?

No. Since I cannot move this unlink as inode_unlink LSM hook sets the
inode_storage
result, I added another label close_prog_unlink which cleans it up for
the errors
before this succeeds.


>
> > +     if (CHECK(err != 0, "unlink", "unable to unlink %s: %d", tmp_exec_path,
> > +               errno))
> >               goto close_prog;
> >
> >       CHECK(skel->data->inode_storage_result != 0, "inode_storage_result",
> > @@ -56,5 +200,6 @@ void test_test_local_storage(void)
> >       close(serv_sk);
> >
> >  close_prog:
> > +     close(task_fd);
> >       local_storage__destroy(skel);
> >  }
