Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A562F3E65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394303AbhALWHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393915AbhALWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:07:18 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:06:37 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w18so9313iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PAaIIToNfkh2YDvfiyNmhQxep4I10YuTfP4xkCJeuVc=;
        b=C6CHTBNXsozuvr5a6+hpZhybdguepzIRKjP2oHIzMIh7j6RCVItoLzalNl9Ty097J5
         ieCEb5FvuayKlDhw+Qf5wqiXWcZmln7OhWN1O2vFfc+7dzruCxHTILIXZMwfARSkumdP
         85wPwBLkbPGqUAd5R9X+28bc8mp/s9Hlq13ybr4zbZIqVWc1L/MQbH6LDF3vPTw8lxtU
         dSphNL8YTuoc/MgNhTYXV968o6t7eYzTNF9fxKbAKR7rv1eDmm/HoeNLR0OtFf7wbFxG
         D//qivkUGF425jrEDzEpyZKhtgbYJP/NP5ucYuJ8IcvP3bSBr7CGCi/a/vSxuKPhqUgn
         J+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PAaIIToNfkh2YDvfiyNmhQxep4I10YuTfP4xkCJeuVc=;
        b=XDR05H56zJOHl6w/9JeDZeoiGSYnKUg73vXT/PskXX/pHgpCXRgTTuYDFSHUURzQ5s
         QHwy9RMIM1h4DpJZ9jIfpsEUxSF4JpQuWcHS2W6fCF+hibGdYIqg+CXknF1pNJX9ZQX1
         /4YbD0x40xaib5y2YdkuG1587FVITYbq+2MRfm/RPZMW71lYuxNaRXAYMmwpZ3C6DWUr
         2UzOrYvlmfVSWuF9r91jSYbcCjijMM3LdOFsz9v3usa5DNSEY20crf+Ev6XfpAl26Jsg
         IE5HCiQMRkihECQwu9R/6occEBux7tQIHkXPxFJ+TM0y6k2rDlQE0VKxpHuxaJDblWrl
         f3vQ==
X-Gm-Message-State: AOAM530MVUZPCXUltLP+wyjx3HmmCtbOPFd7Kg15PDy3qDogekbiGIrC
        DgJxtrZjaZm++fseaL+g6OQ=
X-Google-Smtp-Source: ABdhPJxMgl5VdpCzJgvU9jekAYsMg5nOz673+rw7aLX2MZ2WJjHJOkxKck2uxC7SED11e2QB7hYFTg==
X-Received: by 2002:a6b:dd13:: with SMTP id f19mr1004530ioc.74.1610489197305;
        Tue, 12 Jan 2021 14:06:37 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id a17sm33570ilc.77.2021.01.12.14.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 14:06:36 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:06:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
Message-ID: <20210112220634.GA1377517@ubuntu-m3-large-x86>
References: <20210112205542.1375847-1-natechancellor@gmail.com>
 <CAKwvOd=yrVKBn9TN2cP8SiB7A8=c2g41PyodKGJu+xEQwAmnDA@mail.gmail.com>
 <20210112213703.GA1376568@ubuntu-m3-large-x86>
 <CAKwvOdkA5kmXhKFDFTApLyT5LcUX2-Xr6vJJ0b8wePunMpLu0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkA5kmXhKFDFTApLyT5LcUX2-Xr6vJJ0b8wePunMpLu0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 01:53:30PM -0800, Nick Desaulniers wrote:
> On Tue, Jan 12, 2021 at 1:37 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > > if real_ptr is an unsigned long, do we want to use `__ffs(real_ptr) +
> > > 1` here rather than ffs which takes an int?  It seems the kernel is
> > > missing a definition of ffsl. :(
> >
> > Why the + 1? I think if we use __ffs (which it seems like we should), I
> > think that needs to become
> 
> This came up recently in an internal code review; ffs and __ffs differ
> in output by one.  See also the definition of ffs for alpha in
> arch/alpha/include/asm/bitops.h.

Interesting, thanks for bringing it up! Looks like ffs returns 1-32 and
__ffs returns 0-31. I think that we want __ffs here because we are
shifting (1UL << 32 overflows on 32-bit architectures) and the code in
LLVM appears to agree. LeastSignificantSetBitIndex evaluates to
__builtin_ctzl, which is the asm-generic implementation of __ffs.

Cheers,
NAthan
