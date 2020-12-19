Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19812DEE0C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 10:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgLSJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 04:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgLSJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 04:50:13 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D23C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 01:49:02 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p14so4541667qke.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfNardcFFTptXcBQs9B/d1IxgE68hPVFHB9n1s3V5HY=;
        b=ZJKmlMQ+KBvBvIR2S6pxHucphJI2gDLnE1KT9zl9JoSJJXXugY1WqPOkONKs1CLnJC
         +NZwUIahibhfI4l+fhVtOU5OMEyPe9lnvagfKXhgFlqgDc0IFU/+peiwmvpTI8pdJo3G
         azn0YSU5qkoAlS+bS34NHRl6oHB3dhs2N59jTviw3QxMh3c6soePNjW3ffB2MnjJpPvp
         IYd/sgx+6o5XmuCkegc3v//UYzwy9EcAzGC73hsQMjedHI/BrBjJqVB7u4JNheifbnrJ
         oMrydVn6UW043jLfCiVCep4vU3wmTi/uhUAKqFBGCqeV9Yla8pXkM5qcltlA2pzmPKNV
         86xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfNardcFFTptXcBQs9B/d1IxgE68hPVFHB9n1s3V5HY=;
        b=qyWqP63dCKp7FBHRqErLODU8trgwo0Kld93/ox7M+QdLYDEewQA1zVERh9BQGGaf+a
         TLo9vPEr6BTbyzedWM6YR+P1O7z8ZZgDBNzBxJo8EC0m2vNMJSWwMqbIZaI7IXCHk6Mm
         WC7kEZuIdHwOhIMAY0AcKgk8P9VxnC8FBcdb3Ql1iL3Jj8aAJACxqd0dE52q5q94Tu6x
         5Hg4QoJe67OUCFsH6SsIFFWwiv3bDZURE6+4K9Xj17iEDPQUia/9c0nbJAHhCuaWdmtH
         I028hJTo2AS6AYCVgN1gt8Dg4UNAV/IltDJvpn+5RU3uSIod7jjUe2uzy3rmIXY5aRyt
         Txcg==
X-Gm-Message-State: AOAM533G+oWQne68zTon0SqvvVk5Iv6IVmET80KrTVn/n9BCcTZ6A1iy
        fGQJsZhuTmDTKa8viB2Az6hIgqqY4zZ6yhIKPHppSg==
X-Google-Smtp-Source: ABdhPJxRXGEFhp5OSJwC3Nq5BQzYmtZ2Sahh0W0+ANuVTu8qxiV3nOdQOpZlsCizr6ZhEd7KBZN7ec9yCVRNgz9lZyg=
X-Received: by 2002:a37:e10c:: with SMTP id c12mr9305497qkm.265.1608371341094;
 Sat, 19 Dec 2020 01:49:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b6cd8d05b6a640ae@google.com> <CACT4Y+a2itFzrrE63s0E0zEYzWRhg3eRy+zUishW2dqYrywsnw@mail.gmail.com>
 <202012181131.A231B861@keescook>
In-Reply-To: <202012181131.A231B861@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 19 Dec 2020 10:48:50 +0100
Message-ID: <CACT4Y+aE5q2aef=hP_HbZTwNtyh5kcCBr7Y7Zeh+iY3riPZBww@mail.gmail.com>
Subject: Re: upstream boot error: UBSAN: null-ptr-deref in corrupted
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot <syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 8:47 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Dec 17, 2020 at 11:38:30AM +0100, Dmitry Vyukov wrote:
> > On Thu, Dec 17, 2020 at 11:14 AM syzbot
> > <syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    accefff5 Merge tag 'arm-soc-omap-genpd-5.11' of git://git...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14567b7f500000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6efc730c219bd4
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=73d662376f16e2a7336d
> > > compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com
> >
> > +Kees
> >
> > Not sure if it's related to UBSAN or not, but we didn't used to get
> > empty stack traces.
> > Either way syzbot can't boot the upstream kernel anymore.
>
> _none_ of them? :(
>
> Are you able to see which UBSAN config is tweaking this?


It seems that so far this is triggered only only 1 instances and that
instance is the only one that uses clang:
https://syzkaller.appspot.com/upstream

There is some difference in config between clang/gcc instances, but I
don't see anything obvious that mentions null pointers:

failing clang instance:
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_SIGNED_OVERFLOW=y
# CONFIG_UBSAN_UNSIGNED_OVERFLOW is not set
CONFIG_UBSAN_OBJECT_SIZE=y
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set

working gcc instance:
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_SIGNED_OVERFLOW=y
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
