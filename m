Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490902D98B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407958AbgLNNZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407950AbgLNNYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:24:43 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19934C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 05:24:03 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id l187so3881552vki.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXF27qujJ2VqBKUjmJ8eURLL/NeptG+bztfHuQjY1oI=;
        b=hZFWeny4SmmmFgsIN/hVdNQwkTNWkl26Sd3otE4YIbYrLe6OsynbrRUWun1L4xQb5c
         LBJcwb2IxXaPgsLLDyucI7cNa5kpkTnH19eNkf7X2ap3Qr/eUQbgn79JwAYCVcz7FyUf
         QuHQfzNb72UT1pZBtLr+26j9206Qm4qUmcqEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXF27qujJ2VqBKUjmJ8eURLL/NeptG+bztfHuQjY1oI=;
        b=d/WwVlaDJxYEMnSxEfjvW857gCHkvhUdXyz28pJw5CobQ4IR/GpQPVpsehhBpC6OVp
         AE8tJ/hjrH7w50qLvobtnUjdGnTIkaEQ1lvLlFvDCG2LKzeQzRZdKwtPGpCy8+ZBCPin
         77HDuWBM+ofxCvKWGPUYMHjek6BEt4n/ygqUF7iaTWrhs4HNyCeTjXRRvca5DJMNZW9i
         2sXjmnwF0KQx3eWAHf4MSHP/my28YA+/nJ2+jo28SMyZLMFFhaK1DmUpXfkYyNZ+y3SL
         AId7GmE2X1R4RvHHhwE+BzqPA1O3hJHDg4RG/4dmIcFbpxKXhKZhb42MdILWl5vzcnwD
         d11w==
X-Gm-Message-State: AOAM532Fh/6SvUb6N55zPKXMHxJflf6g4bHwWeKRj3zSr69SHuVF58uU
        B+g5O2LON0NtmMcXoK/nbjxxgioyj7cu2WTCCKVoIw==
X-Google-Smtp-Source: ABdhPJzvUSTfUW3Xz5alxiJ7sFlX7KF4jeVhXMp6RTxvmF/3K2yu8V8fxwM6en5+0ouWA5dKH+Ugplct2E9eCxUY53g=
X-Received: by 2002:a1f:2c01:: with SMTP id s1mr24498538vks.11.1607952242187;
 Mon, 14 Dec 2020 05:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-5-mszeredi@redhat.com>
 <CAOQ4uxhv+33nVxNQmZtf-uzZN0gMXBaDoiJYm88cWwa1fRQTTg@mail.gmail.com>
 <CAJfpegsxku5D+08F6SUixQUfF6eDVm+o2pu6feLooq==ye0GDg@mail.gmail.com> <CAOQ4uxj6130FkTPQ0_83bBj2vJGaehdYk1dix6c8FgLStqN6qw@mail.gmail.com>
In-Reply-To: <CAOQ4uxj6130FkTPQ0_83bBj2vJGaehdYk1dix6c8FgLStqN6qw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Dec 2020 14:23:51 +0100
Message-ID: <CAJfpegvS3pD89GTfFTsAnRwQ+Oxuo+r7mP0JY1usDC3n3tT48Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ovl: make ioctl() safe
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 6:44 AM Amir Goldstein <amir73il@gmail.com> wrote:

> Perhaps, but there is a much bigger issue with this change IMO.
> Not because of dropping rule (b) of the permission model, but because
> of relaxing rule (a).
>
> Should overlayfs respect the conservative interpretation as it partly did
> until this commit, a lower file must not lose IMMUTABLE/APPEND_ONLY
> after copy up, but that is exactly what is going to happen if we first
> copy up and then fail permission check on setting the flags.

Yeah, it's a mess.   This will hopefully sort it out, as it will allow
easier copy up of flags:

https://lore.kernel.org/linux-fsdevel/20201123141207.GC327006@miu.piliscsaba.redhat.com/

In actual fact losing S_APPEND is not currently prevented by copy-up
triggered by anything other than FS_IOC_SETX*, and even that is prone
to races as indicated by the bug report that resulted in this patch.

Let's just fix the IMMUTABLE case:

  - if the file is already copied up with data (since the overlay
ioctl implementation currently uses the realdata), then we're fine to
copy up

  - if the file is not IMMUTABLE to start with, then also fine to copy
up; even if the op will fail after copy up we haven't done anything
that wouldn't be possible without this particular codepath

  - if task has CAP_LINUX_IMMUTABLE (can add/remove immutable) then
it's also fine to copy up since we can be fairly sure that the actual
setflags will succeed as well.  If not, that can be a problem, but as
I've said copying up IMMUTABLE and other flags should really be done
by the copy up code, otherwise it won't work properly.

Something like this incremental should be good,  I think:

@@ -576,6 +576,15 @@ static long ovl_ioctl_set_flags(struct f

  inode_lock(inode);

+ /*
+ * Prevent copy up if immutable and has no CAP_LINUX_IMMUTABLE
+ * capability.
+ */
+ ret = -EPERM;
+ if (!ovl_has_upperdata(inode) && IS_IMMUTABLE(inode) &&
+     !capable(CAP_LINUX_IMMUTABLE))
+ goto unlock;
+
  ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
  if (ret)
  goto unlock;

Thanks,
Miklos
