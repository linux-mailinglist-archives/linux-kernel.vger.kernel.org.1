Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9362B743B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKRChe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgKRChe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:37:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D2620DD4;
        Wed, 18 Nov 2020 02:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605667053;
        bh=0UpUWF8p/cGqEfqME6JcKCNaOuacXTtP0GAwizE2ps4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=baGCU4yW4vJ/XXoYD1p/HkBzMlAdH2TF2WK9UufL2vSJDlpOzcVv/a47PfnXRoNKr
         JB41sPCX8aHIUGBD6oHji7d2YpLfXELYe9iM+USwNBOxDRTfXvaSFsm/o3S7TEqYxY
         +gvhH2WKiGJydFOI2BGrGGNFmxUnryGy6wMzZtPE=
Date:   Tue, 17 Nov 2020 18:37:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        John Hubbard <jhubbard@nvidia.com>, jarkko.sakkinen@iki.fi,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Marco Elver <elver@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Message-Id: <20201117183731.a3ee0b2d8e4cd81f8825d189@linux-foundation.org>
In-Reply-To: <20201118023118.GA1069826@ubuntu-m3-large-x86>
References: <20201104013447.GA21728@kapsi.fi>
        <20201117030427.61981-1-jhubbard@nvidia.com>
        <CAKwvOdkEFPYmH+JFC5a0+whb_1H84gS1WU5FVpV071Bc4mhiCQ@mail.gmail.com>
        <20201118023118.GA1069826@ubuntu-m3-large-x86>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 19:31:18 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:

> On Tue, Nov 17, 2020 at 10:46:29AM -0800, Nick Desaulniers wrote:
> > On Mon, Nov 16, 2020 at 7:04 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > >
> > > Hi,
> > >
> > > I just ran into this and it's a real pain to figure out, because even
> > > with the very latest Fedora 33 on my test machine, which provides clang
> > > version 11.0.0:
> > 
> > Hi John,
> > Thanks for the report.  The patch was picked up by AKPM and is in the -mm tree:
> > https://ozlabs.org/~akpm/mmots/broken-out/compiler-clang-remove-version-check-for-bpf-tracing.patch
> 
> This should probably go to Linus as a regression fix in the next wave,
> if that is possible.

Yes, I'll sent it along later this week.
