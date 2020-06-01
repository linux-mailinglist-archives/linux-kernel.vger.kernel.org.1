Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79B51EB052
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 22:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFAUiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFAUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:38:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B972C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:38:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c11so9875965ljn.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nf7HBjwUzpI0BG3TK8UhCa6At+505mS9uRIJWAKfxDA=;
        b=F3VHsqXbNW9iFxvMXCLyx8+e6Yn/j8nLrZw8JFBwTIrgsVLldkPbQbhsl/lZXps0A2
         EarG5+MP31L8mWZOjBXjz22IHw2WJUH+KERSyEKnkLPypEZkwQm3gomp+coqwxQjSCJL
         zUEGU2BRDjR//KmVHhsHtCk5XODgrKESUBF58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nf7HBjwUzpI0BG3TK8UhCa6At+505mS9uRIJWAKfxDA=;
        b=IpZHbWbqckUK9S6AWP37ackaHjpC30jrGeExZJpJtZM9mAdX89qi91alghdqQPtatC
         GT+FnWrPOxiq39mToc8SNIP8QAnkkz78Uji99Yzwxzh0OJjXtzIfhnVIAezlvYnfLCLI
         wl1xyiCAmVrg6TDz3ufd6dOpKIkXiKyPJfwDL4xnlBrKDODrI6v5e+Yiu3Tajf22oCfK
         lnnxY9peGJ23xa6Sc8Nf8f0ekomQQC/cZFf8J7K/002dBPtejov9VzrRp0jKLWwYh89W
         M0CN6XhK/706zILKKMsVEnjECW8gj4g7qpr8XH4TiLfmH9zrzhUPGIbp6fEBNxWQmWKa
         CwFw==
X-Gm-Message-State: AOAM530EUMs1PsQ3Fi3G3lF1viUj/tZfmB3yoWV+TqKIuzc6t+Kzsxj8
        DuVZs9pYHOmoJe95X6+TEuAKMuK6kjM=
X-Google-Smtp-Source: ABdhPJyi1R+zNxQnwE7AzStpEBrwlhdzpJCTTMdgKV9YvXzlI5wuo89U+3ezk2z9MhLnwn0rJtedKg==
X-Received: by 2002:a2e:974a:: with SMTP id f10mr5761543ljj.283.1591043930771;
        Mon, 01 Jun 2020 13:38:50 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h25sm121890lji.105.2020.06.01.13.38.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 13:38:49 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a25so9880341ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:38:49 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr1167647lji.421.1591043929161;
 Mon, 01 Jun 2020 13:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200601132443.GA796373@gmail.com> <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
In-Reply-To: <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 13:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjt9O8JReJbSTLTSeZoD3X9KkQiMhQfgRyqjA1FyQXgRw@mail.gmail.com>
Message-ID: <CAHk-=wjt9O8JReJbSTLTSeZoD3X9KkQiMhQfgRyqjA1FyQXgRw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI changes for v5.8
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 7:42 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Please note that Stephen reported a conflict with the ARM32 tree, due
> to the replacement of all instances of pr_efi_err() with efi_err(),
> including a couple in some ARM code that is being modified.

Ok, I'll try to remember, but I probably won't. So it would be lovely
to be reminded when I get the arm pull.

That said, if it's just outright conflicts, that's not a big deal and
the resolution looks trivial. But if there are actual semantic
conflicts that don't show up during the merge like Ingo implies, I
would indeed not notice due to me not doing any cross-builds.

                    Linus
