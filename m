Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA78727008B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgIRPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRPJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:09:18 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F422395C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600441758;
        bh=IkOqknM/pgGLyHstRYRh+yvQ8FdTpYzJtOj13eKOQoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wQ81rRBmz55lhQkw2ePr88cuYBKO/mwDLRArD0Dl8vrCF5JXRSXioBz0uBj1vbe70
         7ubHe+MaHqxq7vYXgkIa4718PY9E1caLN8k+OyQ/4Lw3jA7BY/kHAtCbuaiqUdqiDw
         K0rCTSxm+b5VRI6PUTZSoBTMiyAMIGCPrMWMoFt4=
Received: by mail-wr1-f52.google.com with SMTP id w5so5980591wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:09:17 -0700 (PDT)
X-Gm-Message-State: AOAM5334J84JhAvZGmN5yGcP42jLUaihLWFwROy1umeXOFpQ/DaLD9tV
        SFtaWhRIUSZtFizsJpHNeBr/3XUr97sUZ/fBnstBtw==
X-Google-Smtp-Source: ABdhPJxGmXBOztEznChCx1zDcy87QF70YtkyM1AXgQnapl+jEklF6uBqSKjj6yAkDzuf8mO6n3/eki81+OiGt2xlp30=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr37934142wrt.70.1600441756359;
 Fri, 18 Sep 2020 08:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com> <20200915112842.897265-11-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20200915112842.897265-11-jarkko.sakkinen@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 18 Sep 2020 08:09:04 -0700
X-Gmail-Original-Message-ID: <CALCETrX9T1ZUug=M5ba9g4H5B7kV=yL5RzuTaeAEdy3uAieN_A@mail.gmail.com>
Message-ID: <CALCETrX9T1ZUug=M5ba9g4H5B7kV=yL5RzuTaeAEdy3uAieN_A@mail.gmail.com>
Subject: Re: [PATCH v38 10/24] mm: Add vm_ops->mprotect()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        "Xing, Cedric" <cedric.xing@intel.com>, chenalexchen@google.com,
        Conrad Parker <conradparker@google.com>, cyhanish@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 4:28 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Add vm_ops()->mprotect() for additional constraints for a VMA.
>
> Intel Software Guard eXtensions (SGX) will use this callback to add two
> constraints:
>
> 1. Verify that the address range does not have holes: each page address
>    must be filled with an enclave page.
> 2. Verify that VMA permissions won't surpass the permissions of any enclave
>    page within the address range. Enclave cryptographically sealed
>    permissions for each page address that set the upper limit for possible
>    VMA permissions. Not respecting this can cause #GP's to be emitted.

It's been awhile since I looked at this.  Can you remind us: is this
just preventing userspace from shooting itself in the foot or is this
something more important?

--Andy
