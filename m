Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409302858B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgJGGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJGGbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:31:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FF5C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 23:31:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x1so964684eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 23:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC3PZSlkcJ0dFT0SKLSrvJ3nzCII9YDRrt3iNoXhzDA=;
        b=bQ9SYdOa3CZxR358nnaIyBpVeWAq8dWQLwY8bXMYb+QLUXbn4Z+cq1/NJgj87h8XlM
         Ppe8gPbnxBrkC3e9QcCZSmSbmsbDfszXvx7hlupUzv8ejtCe50yXx1hKUHKyo3OTAWjr
         +rWx0luG6oWF0Sq2iYtOA8ktsKXEm5NczU1PuEoh9e6cF8z2XBKOdB1F2cw3oywjHDpH
         aqh0S4HYqswYIL5q3EDrcWxYBITzMVtzP/ZLpBChw1+ZexMwjMdmXZLAJKoWfr45sM8c
         H9Xxs3j2Mm+lkLzcHZxP+LNJpm/jObhXnnZSuP0ShAc2hMMeTmrHrvDTJVO23/zbIKcK
         gmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC3PZSlkcJ0dFT0SKLSrvJ3nzCII9YDRrt3iNoXhzDA=;
        b=rxxL7XkgZjpS38NWg803rQAvwxXCP0SY5GIu/x0tQF8lJYkae4H5hcPePbFg5xlwWw
         Bc3r0n2cqC3vcAJHE/nUnUe3IEbxpeFfdMPAAC9AVlyyUYywOnmgQlt4L6tPmib9lGub
         VJU7D5wwZhwwXBGa3E2ikYTf4pKICKBvCJ8PHDRUObcuiDOnfbwuBuGSJYmcs99S8kUW
         /4rxYcXnA/irMmkT1m71lymCGXJMdM7zDygJfIZhX4eEnb1KRjtrmKPBQLBYBXUkEog6
         zCjaO7k1s5I8vqP3DYGd2hKzD56iwlXJkNKKpJcufi9cn4ClalIUi7IqeXnmWn5QurUn
         53QA==
X-Gm-Message-State: AOAM531UDF7hYhIHTWuPde8VhdJE1Lhd44DFyz43+HzUNgCV7jbEA4EW
        jWrEkjaEq42NmHiRn+Gf3bzO+p/kBVBtvZrlGv4NGA==
X-Google-Smtp-Source: ABdhPJyF8NfAjL1Cbi5pv/Pd1HHkioaL79QB5pL7lyeQNrVFB2Xx456ps1w6Z7PK3swGrITqTcVQRGonfrViPF0gjS8=
X-Received: by 2002:a05:6402:7d2:: with SMTP id u18mr1914452edy.69.1602052295019;
 Tue, 06 Oct 2020 23:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
 <0fb905cc-77a2-4beb-dc9c-0c2849a6f0ae@oracle.com> <CAG48ez3istGAOA=G8fvrQkbMs4MroT8bj=Z=Wmnj0k73K0AFRA@mail.gmail.com>
 <20201007061659.GA21685@infradead.org>
In-Reply-To: <20201007061659.GA21685@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 7 Oct 2020 08:31:08 +0200
Message-ID: <CAG48ez3pwkpoeHTSSuRHpmdn7X5AVuGjw5n3VhD88S1p0cjsUg@mail.gmail.com>
Subject: Re: SPARC version of arch_validate_prot() looks broken (UAF read)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 8:17 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Oct 07, 2020 at 02:45:39AM +0200, Jann Horn wrote:
> > > I think arch_validate_prot() is still the right hook to validate the
> > > protection bits. sparc_validate_prot() can iterate over VMAs with read
> > > lock. This will, of course, require range as well to be passed to
> > > arch_validate_prot().
> >
> > In that case, do you want to implement this?
>
> Any reason to not just call arch_validate_prot after taking the mmap
> lock?

Then the next easy steps are:

 - change the signature of arch_validate_prot() to also accept a
length or end parameter (because a start address without an end
address is completely useless)
 - add a loop over the VMAs in that range in SPARC's arch_validate_prot()

And then comes the annoying part: figure out what to do in that loop
if the range is not fully covered by VMAs. To fully avoid changing the
normal mprotect() ABI, you'd have to accept cases where parts of the
range are unmapped - but hopefully nobody relies on that particular
weirdness, so maybe you can just throw an error in that case? Even so,
the normal error code for that is -ENOMEM, but arch_validate_prot()
has a boolean return, so for that, you'd have to change the return
type, too. I guess the cleanest approach might be to just validate up
to the first gap and then return "everything's good" and rely on
mprotect() bailing out on its own?

Ah - at first I thought that you'd also have to deal with concurrent
stack VMA expansion from find_expand_vma() (which we really should get
rid of somehow sometime), but luckily that still at least holds the
mmap lock in read mode, and here we hold it in write mode, so we don't
have to worry about that. So I guess that'd be the way to go for this
approach?

Alright, I guess I'll send patches after all, hopefully after at least
compile-testing them...
