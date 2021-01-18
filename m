Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552EE2FAA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394102AbhARTj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437577AbhARThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:37:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:37:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h205so25653831lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QTFPvVJsdaq8myZNLGBCmtXEnl0pShtcKa4g8Hw5SLU=;
        b=WngOSQMXIqiFtdnVsJIw5xpTqba4LINpa4aQyhdaZG6Ty5UPit1sNHHVXuL3OZ6fac
         rqUwCF7uUAr1yKE1QVz+R2Jt9KjtIxibLsPTddbKpDYtvZK0ABm+S5Gtvif2XaA0FSxP
         zjuOue47Ue1Xo6lk2na9Hi93aOMZDq7xbwSuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QTFPvVJsdaq8myZNLGBCmtXEnl0pShtcKa4g8Hw5SLU=;
        b=L1yss2q0JKCas4SgT78m2HLS1IasZ1dkVWlw7t+5QSYA8JxpI73qqaJSgUbUkz10+l
         WlZwtvm3FaOU4OoC2rRGIWkc0U4LUHFpSdJJTvFKdyb/pN8XL8Rf8PoWr4DAfrN/xSWw
         BtlX8Fc0b/nyOOof0UDJA5ElV3hB/3Fe6j8TgQIREv3/zle3qKtm9ITCP7yPFZDkYNv4
         9lMpwYIlcQrERlhyPaiJP80Au5X8gH88FukshFZ2K2nG49gR3JOcTtkjSrIBNPO0A3c2
         QB3qh450mTc1auHTbBZsV81MkedlRA42dj8p5guVUff8fSfFfOl9Un7gupGhINjPS2t9
         6dBg==
X-Gm-Message-State: AOAM5327xzSRmE6rTE3SOEdb6DzBIDmlZ2EsK2brzTBQAqhX60GxwcWe
        DQDx3pKhNve0RHziXfuij/tz16DqXnMBog==
X-Google-Smtp-Source: ABdhPJyORMJOXlU5ygmPgVX1diGQPOnM88wPFGPcSkfLrKUZGhtCYyF7GcgFAePBmDU3hnLyRt6b6w==
X-Received: by 2002:ac2:4e6d:: with SMTP id y13mr265456lfs.648.1610998624282;
        Mon, 18 Jan 2021 11:37:04 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y3sm1998593lfy.73.2021.01.18.11.37.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:37:03 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b26so25707751lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:37:03 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr260382lfh.377.1610998623038;
 Mon, 18 Jan 2021 11:37:03 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <20210118081615.GA1397@lst.de>
In-Reply-To: <20210118081615.GA1397@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 11:36:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
Message-ID: <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Christoph Hellwig <hch@lst.de>
Cc:     Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:16 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Jan 16, 2021 at 08:35:41PM +1300, Oliver Giles wrote:
> > For my case, I attempted to instead implement splice_write and splice_r=
ead in tty_fops; I managed to get splice_write working calling ld->ops->wri=
te, but splice_read is not so simple because the tty_ldisc_ops read method =
expects a userspace buffer. So I cannot see how to implement this without e=
ither (a) using set_fs, or (b) implementing iter ops on all line discipline=
s.
>
> set_fs is gone for all the important platforms.  So yes, you basically
> need to convert to iov_iter or have a huge splice_write parallel
> infrastucture.

It might ok to try to limit it to just the pty cases and ldisc ops
that need it, apparently in this case pty (and presumably just one or
two line disciplines)

Of course, it probably would be really nice to try to convert
tty_read() to use the same model that we have for tty_write(), and
then make the ld->ops->read() function actually take a kernel buffer
instead.

I wonder how painful that would be.

             Linus
