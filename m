Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9084227024A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIRQeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgIRQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:33:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC392C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:33:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so7058644wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dzc1y+XruvXteJ+ZszRfXaRxdOqzqjOSkKvCoKF4QDw=;
        b=M+N+i1J1K3tEDtzPE4OAqYei8xUZb/I/GYcJUsTSztjdEgEGjeDZJQHuGOtSWp9zE9
         ORlHJSlQVxF3fkCfv8LIzXIcTiBYq9l5izQMtmxoPp956ADoqzMqODxXawpmkYtfYkp0
         FCq9YW7aL9aQz95UQqaOaY4ROIRboVIQml6aR9eniV3l8EKZ0bKRihhzlc48qypNYj0+
         g0343gnCTpTJalEutlco75+QPTy5WOtMd0tOVmMpYyg8SdMvu7XCDA/fuI2X3nX3EOYo
         QJhvo825WZaMPaHmcMJREhzeLihpnhx6LrkmqIy1vgOmuQhZ6IRzKgpWmZoEf/CDXhxz
         PTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dzc1y+XruvXteJ+ZszRfXaRxdOqzqjOSkKvCoKF4QDw=;
        b=KyWefIkf78FZKd58QBI7orApk0PDTLKhIWZo76X4ouFiSlsmOSZ8HnnSzXhJl9RDH2
         ot++DNUIT/eeI/mYic4ZjdVda0HyoZSCBcw7QnV3Y6L5U1CqX5nO1/RgFuK54MK32tQ8
         x2F98J395qtLvu2up4Ghh2XLtq3qR4Zvkf4iDECHH2PT+Ug47IYo5nbmeXEXavY3hACG
         ZYeyTvEmOPdhr/cNdp/tXYRb2c6bw1tBCZt0cMrCctzeNYHjgYlnIsXBunOYID2KwX/Y
         eHBRR8qq8mIVcf4DOuLRGOl1sQt8M4O4zdaDOWFinbWWqYa84PgqAjaZiRNROhcNBU5l
         Vmww==
X-Gm-Message-State: AOAM530XhdUfq5cE6pjgBx27ESod1q+Cxexhffa7f74nUGcXUlUZCANb
        2M12kC58mX8ugf96Mx77Xxq9sA==
X-Google-Smtp-Source: ABdhPJxQgQ6MIW+2Y2AK4QtJ199Xd9Oo/zz0C8X94maBJQ2HlYKZVHrADiT8pIx2qfMFqvzqssLd5Q==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr15708918wmy.51.1600446836736;
        Fri, 18 Sep 2020 09:33:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id 11sm5890604wmi.14.2020.09.18.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:33:56 -0700 (PDT)
Date:   Fri, 18 Sep 2020 17:33:54 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 1/3] fuse: Definitions and ioctl() for passthrough
Message-ID: <20200918163354.GB3385065@google.com>
References: <20200911163403.79505-1-balsini@android.com>
 <20200911163403.79505-2-balsini@android.com>
 <CAOQ4uxiWK5dNMkrriApMVZQi6apmnMijcCw5j4fa2thHFdnFcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiWK5dNMkrriApMVZQi6apmnMijcCw5j4fa2thHFdnFcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amir,

Thanks again for your feedback.

On Sat, Sep 12, 2020 at 02:06:02PM +0300, Amir Goldstein wrote:
> On Fri, Sep 11, 2020 at 7:34 PM Alessio Balsini <balsini@android.com> wrote:
> [...]
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index bba747520e9b..eb223130a917 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -965,6 +965,12 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
> >                                         min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> >                                         max_t(unsigned int, arg->max_pages, 1));
> >                         }
> > +                       if (arg->flags & FUSE_PASSTHROUGH) {
> > +                               fc->passthrough = 1;
> > +                               /* Prevent further stacking */
> > +                               fc->sb->s_stack_depth =
> > +                                       FILESYSTEM_MAX_STACK_DEPTH;
> > +                       }
> 
> That seems a bit limiting.
> I suppose what you really want to avoid is loops into FUSE fd.
> There may be a way to do this with forbidding overlay over FUSE passthrough
> or the other way around.
> 
> You can set fc->sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH - 1
> here and in passthrough ioctl you can check for looping into a fuse fs with
> passthrough enabled on the passed fd (see below) ...
>
> [...]
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > new file mode 100644
> > index 000000000000..86ab4eafa7bf
> > --- /dev/null
> > +++ b/fs/fuse/passthrough.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "fuse_i.h"
> > +
> > +int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
> > +{
> > +       int ret;
> > +       int fs_stack_depth;
> > +       struct file *passthrough_filp;
> > +       struct inode *passthrough_inode;
> > +       struct super_block *passthrough_sb;
> > +
> > +       /* Passthrough mode can only be enabled at file open/create time */
> > +       if (req->in.h.opcode != FUSE_OPEN && req->in.h.opcode != FUSE_CREATE) {
> > +               pr_err("FUSE: invalid OPCODE for request.\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       passthrough_filp = fget(fd);
> > +       if (!passthrough_filp) {
> > +               pr_err("FUSE: invalid file descriptor for passthrough.\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = -EINVAL;
> > +       if (!passthrough_filp->f_op->read_iter ||
> > +           !passthrough_filp->f_op->write_iter) {
> > +               pr_err("FUSE: passthrough file misses file operations.\n");
> > +               goto out;
> > +       }
> > +
> > +       passthrough_inode = file_inode(passthrough_filp);
> > +       passthrough_sb = passthrough_inode->i_sb;
> > +       fs_stack_depth = passthrough_sb->s_stack_depth + 1;
> 
> ... for example:
> 
>        if (fs_stack_depth && passthrough_sb->s_type == fuse_fs_type) {
>                pr_err("FUSE: stacked passthrough file\n");
>                goto out;
>        }
> 
> But maybe we want to ban passthrough to any lower FUSE at least for start.


Yes, what I proposed here is very conservative, and your solution sounds
good to me. Unfortunately I don't have a clear idea of what could go wrong
if we relax this constraint. I need some guidance from you experts here.

What do you think if we keep this overly strict rule for now to avoid
unintended behaviors and come back as we find affected use case?


> 
> > +       ret = -EEXIST;
> 
> Why EEXIST? Why not EINVAL?
> 


Reaching the stacking limit sounded like an error caused by the undesired
existence of something, thus EEXIST sounded like a good fit.
No problem in changing that to EINVAL.



> > +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> > +               pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> > +               goto out;
> > +       }
> > +
> > +       req->args->passthrough_filp = passthrough_filp;
> > +       return 0;
> > +out:
> > +       fput(passthrough_filp);
> > +       return ret;
> > +}
> > +
> 
> And speaking of overlayfs, I believe you may be able to test your code with
> fuse-overlayfs (passthrough to upper files).
> 
> This is a project with real users running real workloads who may be
> able to provide you with valuable feedback from testing.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/containers/fuse-overlayfs

This is indeed a project with several common elements to what we are doing
in Android, and that would probably benefit from this change. Will surely
involve them in the discussion.
Thanks for sharing!

Alessio
