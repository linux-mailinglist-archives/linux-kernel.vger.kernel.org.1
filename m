Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E827F554
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgI3Wma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgI3Wma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:42:30 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2942CC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:42:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so4324490iom.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=weXqoR5W7pMz/Wlact2MjKFoSWb9gtGm8NYhMTne0Q8=;
        b=VQAtApKtw+J+bOGAB2Gj+wwZD9R7fUMLw2yf62MxjMzL4gj8Fke7JTzZ0KPkYi0AWp
         PekMhLzMoNGufs16UQ6duvgRLBQRbFjE7tWb5RNEJtCTVsEExWOh3PRpedBMvdkQ89mZ
         Y8lz3aeibSPo4298ucrz0JWgm53AvevXqozHoLlVbeBkTCv0Ysj+/Tb2BcXc+1z5O9z8
         JaiXZ3tuzOl00t5EsIifnuU093RtR10+pbJDJnKH4eaLSUs/ynjWlDuY9OHU+QrZopgy
         Euc0BFhq7GEfn4Dau5owRNA70E9XB1K1/2YeHOSeshcDd//KMLVykIsv+2DhFd0dEi0I
         JzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=weXqoR5W7pMz/Wlact2MjKFoSWb9gtGm8NYhMTne0Q8=;
        b=SgRSXFtrsi76ZlsCT/ntz1Hrfwk8SNmtsa1LWVJnLZJtY4f+zkwancHWQV9CgwyTyU
         De+2T/J/hR5GNvWo/mUR7+gyycEzk72cBHoXuaSzP+Cdf7Kjf9XTegDv1dZqCdzUrJ8g
         qAHYYwh5QzHLaFbdcIgiXlxLFo3trGzXQPepfGRv1v965lRjmy+FwSDIHT+QlVBfE/dI
         OStRr1Mu88Yi4pE2k614fB8QxmSEc/oQzNl7duwR4q5CvATSf5I5oUq437/TyIwMErto
         9GPI518EZir/rqB8ZsO1JWt1ejlFHl1iPpQ+KwvCU9jthsMx/IGineQBlgP2A/IHJ1dn
         kh6w==
X-Gm-Message-State: AOAM5306+d2RvLAAMzWpTrSwB9k4UYc+9M3xpWtsuWOPu1Oumy2u90Xs
        4tawS9a1B7cLPBlo1QkyfdftOr5UG3P6KQk/bw19KA==
X-Google-Smtp-Source: ABdhPJyv1YGmG80gB4Wo4k/IiqYQGwjginXohHeUXbbMCtYivyoxkrASPmTKl+GKgfiJnYks1ERRGxjCA7yaWVoD9qc=
X-Received: by 2002:a02:c914:: with SMTP id t20mr3714423jao.117.1601505749184;
 Wed, 30 Sep 2020 15:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com> <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com>
In-Reply-To: <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 30 Sep 2020 15:42:17 -0700
Message-ID: <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 3:32 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> > mremap time can be optimized by moving entries at the PMD/PUD level if
> > the source and destination addresses are PMD/PUD-aligned and
> > PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> > x86. Other architectures where this type of move is supported and known to
> > be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> > and HAVE_MOVE_PUD.
> >
> > Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> > region on x86 and arm64:
> >
> >     - HAVE_MOVE_PMD is already enabled on x86 : N/A
> >     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> >
> >     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
> >     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> >
> >           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
> >           give a total of ~150x speed up on arm64.
>
> Is there a *real* workload that benefit from HAVE_MOVE_PUD?
>
We have a Java garbage collector under development which requires
moving physical pages of multi-gigabyte heap using mremap. During this
move, the application threads have to be paused for correctness. It is
critical to keep this pause as short as possible to avoid jitters
during user interaction. This is where HAVE_MOVE_PUD will greatly
help.
> --
>  Kirill A. Shutemov
