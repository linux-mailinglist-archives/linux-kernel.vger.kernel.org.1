Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6622A21FD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgGNT1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgGNT1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:27:09 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EE7225AB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594754829;
        bh=P5jNGMBlBX/QkkJRNB1+sQIGoUmYLPb4UbvcuiwyfXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D7ZxWEJC3oQ/TI0IJ+5dDrybFphlb1csCiK3XkuOwP5oqHfRRzbdSKZ8IeBpUScMP
         lCa2ypQlxbT2mEOffrh1BYDi8jYiyr0Ljl/I5PCQDiJITjiRfyH95Z52Rh+lMuxFk1
         vJFM3kQtm5MzPWXR3+A81e5kYbG75dRPjlYXeOLA=
Received: by mail-wm1-f47.google.com with SMTP id q15so8337733wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:27:08 -0700 (PDT)
X-Gm-Message-State: AOAM530Ed+yF41a94NnNzQyNioQ5Moth81TTryB0W5q+RBbH/ngmil79
        L1JZCaYehCMmKDGJIYBHO+DSL2KgwBZjsZdFMprYLw==
X-Google-Smtp-Source: ABdhPJxdA00P6WYL5aBprrtpWULRdP3PtUO6mZJTS1tjNWVBTfJxhDStj7KTroekfThk3dz/LDqSAqwPthtxEIwVRio=
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr4877690wml.36.1594748492474;
 Tue, 14 Jul 2020 10:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200616142315.375918-1-brgerst@gmail.com> <20200714064004.GA32655@lst.de>
 <CAMzpN2gg4H5qnU8Dk=bCaEm2WdRF-synfpf_yUaK8L6vyuo=zQ@mail.gmail.com>
In-Reply-To: <CAMzpN2gg4H5qnU8Dk=bCaEm2WdRF-synfpf_yUaK8L6vyuo=zQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 Jul 2020 10:41:18 -0700
X-Gmail-Original-Message-ID: <CALCETrWLac6LV_iJhbo86hqZ87oAY5L62S6L82PYZi2Y_5k1BQ@mail.gmail.com>
Message-ID: <CALCETrWLac6LV_iJhbo86hqZ87oAY5L62S6L82PYZi2Y_5k1BQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] X32 syscall cleanups
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:03 AM Brian Gerst <brgerst@gmail.com> wrote:>
> On Tue, Jul 14, 2020 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Jun 16, 2020 at 10:23:13AM -0400, Brian Gerst wrote:
> > > Christoph Hellwig uncovered an issue with how we currently handle X32
> > > syscalls.  Currently, we can only use COMPAT_SYS_DEFINEx() for X32
> > > specific syscalls.  These changes remove that restriction and allow
> > > native syscalls.
> >
> > Did this go anywhere?
>
> This approach wasn't well received, so I'd just go with this as the
> simplest solution:
> https://lore.kernel.org/lkml/CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com/
>

I'm okay with either approach, although I think the original approach
is nicer than the simplified #define approach.

In my mind, the __x64_omg_so_many_underscores prefixes really mean
"don't think too hard about these -- we just decided to make extra
long names", so whatever.  We can clean it up more some day.

> --
> Brian Gerst
