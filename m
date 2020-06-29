Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1520520D4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgF2TMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbgF2TK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:57 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD56C031413
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:10:56 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y18so9773591lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tSA8ywi78rUHFSpY/Nh0QOGhLyb0fCOpr5Vs4TKLX4I=;
        b=DdZYOk3C2gqHJgrApbFwYh4JVw30MMHLelRJPuRrFQHuCgzURGP0ySVe+bMXX7P0bc
         HdR5v5nmxQAKjBr/BJwcCjZ0q6O5mvmktqcNB4/IlzJBckOkjWLgl4r7Ec18e7wl7SnO
         SG0pnoDk7iVjw0PsWVE3QvC7A0cEGr6+qyrlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tSA8ywi78rUHFSpY/Nh0QOGhLyb0fCOpr5Vs4TKLX4I=;
        b=Z8JBLSno2SK06EBW2DTglcYHwW4comG3cEDI2fmDzx4BXoPIn27NkHIHIisveIRo6C
         1e5c/OvHMvFP43plBbx93aReQ9ltfByOsJuTBCZjtIkJ+CC3vJAAK9vmesDuHXRz5s+6
         +eE5LruPke7okCjCX0+jXEzZM/rLFWy3c42pSvncAspBliZEaEokg4Rvo0/MTfDF5otm
         6aeyxClHFYzElW0gWKK8NyJ8HVa7rZosVpJz1Xmh0wMLAArIV04X8FXKhUBmLXmeTjGs
         Jutx58+pkEbdRcLHnGVKAzqVmKIDmqilyE+jVRWJfLafKi6MU59OFq/GksKw11WVnMc7
         AgvA==
X-Gm-Message-State: AOAM530nW9IV8YsD/EGgoyozhBfOfMfIj17qcgOtXfBPVNgxHAKatPt+
        L5tekEsj/fx+AeMNcERGfq51hLCd7BE=
X-Google-Smtp-Source: ABdhPJwlEfQLP1LT2BtBsFK2LnbKxSxLZGSpFRx7AAnSvI0BgxMFKQIjIfWdvqN0UTp1JUXi1mGCzA==
X-Received: by 2002:a05:6512:682:: with SMTP id t2mr10004517lfe.101.1593457855048;
        Mon, 29 Jun 2020 12:10:55 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y188sm141083lfc.36.2020.06.29.12.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 12:10:54 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 9so19460790ljv.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:10:53 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr3408927lji.371.1593457853564;
 Mon, 29 Jun 2020 12:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
 <20200629152912.GA26172@lst.de> <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
 <20200629180730.GA4600@lst.de> <CAHk-=whzz81Cjfn+SNbLT8WvRxfQYbiAemKrQ5jpNAgxxDQhZA@mail.gmail.com>
 <20200629183636.GA6539@lst.de>
In-Reply-To: <20200629183636.GA6539@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Jun 2020 12:10:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE2_YcRRQhJ73s4kYqTNDkYqq2HHtieQ-R1J+Awgk=nA@mail.gmail.com>
Message-ID: <CAHk-=whE2_YcRRQhJ73s4kYqTNDkYqq2HHtieQ-R1J+Awgk=nA@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Having resurrect my work there really are tons of int cases.  Which
> makes me thing that splitting out a setsockopt_int method which gets
> passed value instead of a pointer, then converting all the simple cases
> to that first and then doing the real shit later sounds like a prom=D1=96=
sing
> idea.

Try my hacky patch first, and just change the code that does

                if (get_user(val, (int __user *)optval)) {
                        err =3D -EFAULT;

to do

                val =3D *(int *)optval;

In fact, that pattern seems to be so common that you can probably
almost do it with a sed-script or something.

                   Linus
