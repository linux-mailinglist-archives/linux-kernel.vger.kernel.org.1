Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5B247B63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 02:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHRAIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHRAIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:08:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D57C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:08:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h8so9279455lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PUubmKG0qCUbLC0lny1sEZMsh6oDctj94eQbjDTgwk=;
        b=Cc93yVMbx3RvLnq5PLotBg+roGGu69+/Dx9uDZdnFaQvTrkIzdLU5lhrEDOPiq2+fN
         5E+MIu8qQiaA07jjpGceLS5/FUXItwiiQf3jrnqL+6nxCyP1OYWmoOUBc1tR+82IoQ3t
         pB1HfO6+D8i21tTtZuIWUIjxWkjP3RCPMcq/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PUubmKG0qCUbLC0lny1sEZMsh6oDctj94eQbjDTgwk=;
        b=jIs1r9evR+44RAbAZ8/VyQYNpS6JutRgWqqx3Q7SwD4BUFmfFVH2yqRL9iGvLopPTX
         lwR45qlcpt+vFiafg3OqhT9BPgnN2AGfoX/8aPz6GlX5en4o4pRUlPQNeOIYbeL8hifp
         ULPix16z4WHNWOp4oksFqqpOcFOnB3hhiygT3MOl0AZ8YUZWHTILmwKV78PiXke6oI/s
         NguOz7QKfi9wVmzFDPKt9Jkb4Nc2CM7CVsAHAMCI82dzE0D+FvlOv1Akf7XMSvQ8a40N
         f8cbxL2bI5u+7nSvtr21P/kM3eW44j4AmcpooY8LES+au6ehkMfcVxiZiTBwsaTeOxxm
         4wig==
X-Gm-Message-State: AOAM530A7ODozDBko8TSNiSdkLOC/tmnEB5Y9TEfzgx5p3UTauGQYtVQ
        5xzrMOMxHxr6PnPM3mtejIBYtHa3uDKe6w==
X-Google-Smtp-Source: ABdhPJylLBiCu5wUtDB/iHx2DY1wEEcukgboW4GbKZwOPl4bdmV5o0/bOsjoZaCOt5DWeEqxZhx3Qg==
X-Received: by 2002:a19:c197:: with SMTP id r145mr8436276lff.41.1597709325512;
        Mon, 17 Aug 2020 17:08:45 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h23sm5153153lji.139.2020.08.17.17.08.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:08:44 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id v15so9259331lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:08:43 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr8518837lfp.10.1597709323252;
 Mon, 17 Aug 2020 17:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-12-ebiederm@xmission.com>
In-Reply-To: <20200817220425.9389-12-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 17:08:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com>
Message-ID: <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com>
Subject: Re: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use get_files_struct
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead hold task_lock for the duration that task->files needs to be
> stable in seq_show.  The task_lock was already taken in
> get_files_struct, and so skipping get_files_struct performs less work
> overall, and avoids the problems with the files_struct reference
> count.

Hmm. Do we even need that task_lock() at all? Couldn't we do this all
with just the RCU lock held for reading?

As far as I can tell, we don't really need the task lock. We don't
even need the get/pid_task_struct().

Can't we just do

        rcu_read_lock();
        task = pid_task(proc_pid(inode), PIDTYPE_PID);
        if (task) {
                unsigned int fd = proc_fd(m->private);
                struct file *file = fcheck_task(task, fd);
                if (file)
                        .. do the seq_printf ..

and do it all with no refcount games or task locking at all?

Anyway, I don't dislike your patch per se, I just get the feeling that
you could go a bit further in that cleanup..

And it's quite possible that I'm wrong, and you can't just use the RCU
lock, but as far as I can tell, both the task lookup and the file
lookup *already* really both depend on the RCU lock anyway, so the
other locking and reference counting games really do seem superfluous.

Please just send me a belittling email telling me what a nincompoop I
am if I have missed something.

             Linus
