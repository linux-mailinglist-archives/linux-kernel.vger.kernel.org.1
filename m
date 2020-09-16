Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4D726C878
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgIPSuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgIPStl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:49:41 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D283F2222D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600282180;
        bh=16sTH0SegakzZKBjY8U3FsytaAxRFzwi1y28PIc8vKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A8v0KRNufPmq2ID94lvuAYBLHSHS5ug/gBN4O948j2OLRL/yNp7TGrcaoMc8dhzbO
         gakR5PNyJc34jx5b5aXJZqOG+ECqvTX6r+JpS79zCVia6YDkI+sbXhF5mFPtKxxwmH
         lKt5qdjIMkNtCN34jJEvfHrZYNfN+/RBAbfSnBT8=
Received: by mail-ed1-f49.google.com with SMTP id w1so7538370edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:49:39 -0700 (PDT)
X-Gm-Message-State: AOAM532Oyw4DjdO3r3R9JADCQvkvm0b+GkHIErra65tScYurHcWCGbic
        8bMT8FWNU9ZHBsQ/XY9w8CjNLefQoDk754xRIk6NSg==
X-Google-Smtp-Source: ABdhPJwUX3bHQLCL84qG4wIC/JlN+nYNkgmXwAB8lo/1k8NF8oo4sGXt7L/6GSwGvTFkR4oICcgx71syaFhCR+ehMOk=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr28001448wrt.70.1600282177590;
 Wed, 16 Sep 2020 11:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200916072842.3502-1-rppt@kernel.org>
In-Reply-To: <20200916072842.3502-1-rppt@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 16 Sep 2020 11:49:25 -0700
X-Gmail-Original-Message-ID: <CALCETrV6nFQ4tzhxKPSnK+Ec=U8ojY0k_-G2EqEG-WMGT4TkUw@mail.gmail.com>
Message-ID: <CALCETrV6nFQ4tzhxKPSnK+Ec=U8ojY0k_-G2EqEG-WMGT4TkUw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:28 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> This is an implementation of "secret" mappings backed by a file descriptor.
> I've dropped the boot time reservation patch for now as it is not strictly
> required for the basic usage and can be easily added later either with or
> without CMA.
>
> v5 changes:
> * rebase on v5.9-rc5
> * drop boot time memory reservation patch
>
> v4 changes:
> * rebase on v5.9-rc1
> * Do not redefine PMD_PAGE_ORDER in fs/dax.c, thanks Kirill
> * Make secret mappings exclusive by default and only require flags to
>   memfd_secret() system call for uncached mappings, thanks again Kirill :)
>
> v3 changes:
> * Squash kernel-parameters.txt update into the commit that added the
>   command line option.
> * Make uncached mode explicitly selectable by architectures. For now enable
>   it only on x86.
>
> v2 changes:
> * Follow Michael's suggestion and name the new system call 'memfd_secret'
> * Add kernel-parameters documentation about the boot option
> * Fix i386-tinyconfig regression reported by the kbuild bot.
>   CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
>   from one side and still make it available unconditionally on
>   architectures that support SET_DIRECT_MAP.
>
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will have desired protection bits set in the user page
> table. For instance, current implementation allows uncached mappings.

I still have serious concerns with uncached mappings.  I'm not saying
I can't be convinced, but I'm not currently convinced that we should
allow user code to create UC mappings on x86.

--Andy
