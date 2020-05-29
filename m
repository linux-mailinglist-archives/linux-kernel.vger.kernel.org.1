Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE89F1E7243
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 03:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404415AbgE2Bye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgE2Byc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:54:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815FDC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:54:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so637835ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbSSYfo2woqk0Vl6eANj/3pGpkwuVFMnZscpIkwWehg=;
        b=axMTKiUo678k9Kwfw1J+soo23q6RboVir0DjXK9tdCy9qsS6P1aqarOBokzRq9rSEk
         UHfvFLJaqw2xNmZW8Qd2EMSUoAuEUaO8Zk4nwGpOFFfDXcKfessean2qJ/JDrWWalGv9
         yonOOKFy0GMGZ1sk4IKljUY4pEq2rtjPx0Nto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbSSYfo2woqk0Vl6eANj/3pGpkwuVFMnZscpIkwWehg=;
        b=ZZDYuw7BAB5O8FTYshLs0mFPlKN1lryAmk6Hsk3J7nnL1IcuGLSpXF75aOsS54Bdji
         3kmBO6sMsAFvZkKW1uvNJXnldy1hxIecZOTBVg5zHfvnL+3h5GnekO9TEAJIjR91NTaO
         6sHWNQPbqSAaqDZV9ocZ5owtug9JISM1tp12YxTEsqJ4XtVanId2CMiCWTDKv0QB2fmR
         Bg7cWmBx9wXBVp3lTvpDTAS22O9GB8NQHC10JS9+eHBarypWlhUEl3PM7t+PRFuDTMXh
         nfcCEVJiZ9Hn7+PcmNJGGlWpTPB34JjLvtkiCZmDeS3N9dPtj7Heas7n1fJuBMy3U+YJ
         dsbw==
X-Gm-Message-State: AOAM533n2kvMPoTnslovjjYwDVujl0U2TzBKgjyLIpzNu9QfiI8jxwGY
        qjDYBn5MI0kY0hyNGP+Rt/Yi7HYDD0w=
X-Google-Smtp-Source: ABdhPJylcBPhR7525fLpwJseLeHNOp70lZUXt7rts7ZgS9ykOH4PFLcQKPus9py8sTqtlU0TGse01g==
X-Received: by 2002:a2e:8912:: with SMTP id d18mr2439136lji.419.1590717269521;
        Thu, 28 May 2020 18:54:29 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i26sm1951473lfc.21.2020.05.28.18.54.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 18:54:28 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 82so341884lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:54:28 -0700 (PDT)
X-Received: by 2002:ac2:504e:: with SMTP id a14mr3166908lfm.30.1590717268099;
 Thu, 28 May 2020 18:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk> <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529014753.GZ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 18:54:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
Message-ID: <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 6:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         case S_IFREG:
>                 inode->i_op = &dlmfs_file_inode_operations;
>                 inode->i_fop = &dlmfs_file_operations;
>
>                 i_size_write(inode,  DLM_LVB_LEN);
> is the only thing that does anything to size of that sucker.  IOW, that
> i_size_read() might as well had been an explicit 64.

Heh. Indeed. I did actually grep for i_size_write() use in ocfs2 and
saw several. But I didn't realize to limit it to just the dlmfs part.

So it does that crazy sequence number lock dance on 32-bit just to
read a constant value.

Oh well.

It would be nice to get those follow-up cleanups eventually, but I
guess the general user access cleanups are more important than this
very odd special case silliness.

             Linus
