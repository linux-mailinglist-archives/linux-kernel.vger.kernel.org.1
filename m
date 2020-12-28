Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789D22E6A73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgL1T0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgL1T0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:26:35 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ADDC061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:25:55 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y5so10262797iow.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nOHULSFy60FT+2em7J7OYQMxQyHIY7jUtPb874hlfY=;
        b=X44sptDyBjDo7Fmfh69zd2cXOO3bKdRIJm8eh0l8IIcytCkAv80h2Gz0xw56kaQVbG
         3qB4LlWGBBDdk2vj+xhlj/qjSLyNi6ZZsWrh9bp1+qXoh5vYWZYmtrSYe01KB9X64N6g
         VM63QPWOHcxIfrnutXwU4sUo1dNjYZYjlCuI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nOHULSFy60FT+2em7J7OYQMxQyHIY7jUtPb874hlfY=;
        b=a9zGNBfMfuNQDwllUJ4uIG216N1YWR+dgt3pKY9UV5yylkv09L8jp+1q7UIdfmJJVQ
         4T57agjhyXD44uDYyi/MN7MI0jCJxbQWcxHuEWAB0WFuW14slQk2fIwpgCxe75Bpst1T
         J42Uh3lTzulMfYt89rj9VsdgNnsSVltVTdbQ33MO2Vo1JGjj+UEyNvsRgm0gF8tj2M70
         XhABxAokv+aXwpRLi8H4HYtDNmQn1OUuRcXDtLJy8sHfUMF6c2OQ4jMss+uooVGzM3jZ
         5c9xlx8NNDW8JxrxvxwioQltRY7T18dUgzOKM4HPMI6EHMviCU408ScP4IssWsvj+r3z
         QdGw==
X-Gm-Message-State: AOAM531FOCYt41qOtBsIlowTBuCIwiqmZepnYJW//CmM6MwAL9YkpgSa
        H5PLYwFaqn9D9l1w/SWmXo5oLlUujsO+NildzYGAMQ==
X-Google-Smtp-Source: ABdhPJxSDFz9qtx2zDzz0V4rwDXS3Bqf+8r+uF6knARBRLYg2CSyYUclaw5Kvp2mKllpYfrz4WigvFxj3FEwByAFghE=
X-Received: by 2002:a6b:e704:: with SMTP id b4mr14476477ioh.114.1609183554526;
 Mon, 28 Dec 2020 11:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org> <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org> <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org> <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20201224121352.GT874@casper.infradead.org> <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
 <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
 <20201228155618.GA6211@casper.infradead.org> <5bc11eb2e02893e7976f89a888221c902c11a2b4.camel@kernel.org>
In-Reply-To: <5bc11eb2e02893e7976f89a888221c902c11a2b4.camel@kernel.org>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 28 Dec 2020 11:25:18 -0800
Message-ID: <CAMp4zn92-WLFkDPVCUX=e+oyHb--7thDDwFEqyvBTGm64biyDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 9:26 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2020-12-28 at 15:56 +0000, Matthew Wilcox wrote:
> > On Mon, Dec 28, 2020 at 08:25:50AM -0500, Jeff Layton wrote:
> > > To be clear, the main thing you'll lose with the method above is the
> > > ability to see an unseen error on a newly opened fd, if there was an
> > > overlayfs mount using the same upper sb before your open occurred.
> > >
> > > IOW, consider two overlayfs mounts using the same upper layer sb:
> > >
> > > ovlfs1                              ovlfs2
> > > ----------------------------------------------------------------------
> > > mount
> > > open fd1
> > > write to fd1
> > > <writeback fails>
> > >                             mount (upper errseq_t SEEN flag marked)
> > > open fd2
> > > syncfs(fd2)
> > > syncfs(fd1)
> > >
> > >
> > > On a "normal" (non-overlay) fs, you'd get an error back on both syncfs
> > > calls. The first one has a sample from before the error occurred, and
> > > the second one has a sample of 0, due to the fact that the error was
> > > unseen at open time.
> > >
> > > On overlayfs, with the intervening mount of ovlfs2, syncfs(fd1) will
> > > return an error and syncfs(fd2) will not. If we split the SEEN flag into
> > > two, then we can ensure that they both still get an error in this
> > > situation.
> >
> > But do we need to?  If the inode has been evicted we also lose the errno.
> > The guarantee we provide is that a fd that was open before the error
> > occurred will see the error.  An fd that's opened after the error occurred
> > may or may not see the error.
> >
>
> In principle, you can lose errors this way (which was the justification
> for making errseq_sample return 0 when there are unseen errors). E.g.,
> if you close fd1 instead of doing a syncfs on it, that error will be
> lost forever.
>
> As to whether that's OK, it's hard to say. It is a deviation from how
> this works in a non-containerized situation, and I'd argue that it's
> less than ideal. You may or may not see the error on fd2, but it's
> dependent on events that take place outside the container and that
> aren't observable from within it. That effectively makes the results
> non-deterministic, which is usually a bad thing in computing...
>
> --
> Jeff Layton <jlayton@kernel.org>
>

I agree that predictable behaviour outweighs any benefit of complexity
cutting we might do here.
