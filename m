Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCE289CE7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 03:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgJJBLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 21:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgJJBEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:04:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A0C0613DB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 18:03:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so12521937lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7OwKgWi2gSxmEp/hYxtSzWSpApJcXjT+OdSqNt7VYU=;
        b=Wf1q2lnubIrbXjk14tkrYxXcbBXmzq9qYbXL1Q2p8EB+0CvkKSqF+3HlgfvaB+X8S6
         SG17cHHpnVFX880L11ZWENbR0ebhET03jaC+x724GDZbfQvjLR0+JYp1fVD8FDqLvksZ
         kRBaHY97weaJ2iFk9krv7PVK7ymwvLjzNkwFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7OwKgWi2gSxmEp/hYxtSzWSpApJcXjT+OdSqNt7VYU=;
        b=J3Uu3sVX6pFAzNXghglpC6e/i/A/EdAHS5L8PidcCaB2ulBYC3F5RMLuSRn02Lf2LY
         RWi+wHOenkTg+PaQrkfTu5oM2vQz55LXMdmuZ30mk5rYbJcnmgAlml4Y4W2K3+DCFMDz
         6VNBRTTYq8y8c/2cqryoD2qFRTLlOFhiB110IEGVoIHI1+ssZoMQ2sJNkVjHapQ4HO8B
         SbHk1p9Y5R6t8McaE7CpscJaMEDmcnIK+3bz3SnG0vTIgPfb/S6rgyGCEoR9WJ3zFEjl
         y8zyD/RCXhePkuwS3GyhOUVdBtDmNIYpQzuiIve5hzfZknmzlbqQw57gRULnLW64isrF
         DXlA==
X-Gm-Message-State: AOAM531NS7wO2YKqAyJzhJJ9Pn03wlr0dq1iTYtiQ0b1JFLAED+IllWE
        KVkh4mfof7A8jt3GVbW+HMmKb1bQkznIZQ==
X-Google-Smtp-Source: ABdhPJydUqk+CQQmS+dRpV0jefY7K+AW5e6BtJzRAXz2JVkDTR+0lIicyB63eeLwaOMs1c2FVt9PNQ==
X-Received: by 2002:a19:2291:: with SMTP id i139mr4871459lfi.387.1602291829782;
        Fri, 09 Oct 2020 18:03:49 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j20sm1832666lfe.181.2020.10.09.18.03.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 18:03:48 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y16so10103387ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 18:03:47 -0700 (PDT)
X-Received: by 2002:a2e:2202:: with SMTP id i2mr5735571lji.70.1602291827290;
 Fri, 09 Oct 2020 18:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain> <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com> <20201009220633.GA1122@sol.localdomain>
In-Reply-To: <20201009220633.GA1122@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Oct 2020 18:03:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
Message-ID: <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 3:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> It's a bit unintuitive that ppos=NULL means "use pos 0", not "use file->f_pos".

That's not at all what it means.

A NULL ppos means "this has no position at all", and is what we use
for FMODE_STREAM file descriptors (ie sockets, pipes, etc).

It also means that we don't do the locking for position updates.

The fact that "ki_pos" gets set to zero is just because it needs to be
_something_. It shouldn't actually ever be used for stream devices.

                  Linus
