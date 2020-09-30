Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6B27F561
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgI3WrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbgI3WrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:47:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7565BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:47:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q5so3330868qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTCFS3cfNEjOOKerZt+01daLGyP2fALUEUrJKhPYQ6w=;
        b=Q60Wco9+qfTN9GN/1gnoYEIQQnEJVS2L83J5fgMwYnhnkv7Iv+r7c6Vgvp8vKtK8q9
         rEM+N2vD7SVboMi/LAS8n2Zi+bj/nEN/JUkRTbILPg4KptgS/sai/DwC/U+BaUsCAibi
         Iz8o1www1zeq5WMk+xVPn7qtQ5kkq14mC4HBugMazodVeXKe4YLW1pFY+APoOet0ttnU
         3M0aPOwOD9YdezoRsvacCrR+i5YHVPSpDjasMZPxu4qszz5MxkWLRmMxDqV4KqH0bN7U
         qmHzpDNrLbiB0ndVTWpRvW6+vtA0FVgaxwlLdLxhMOO7cs9+iaxRlVuPu+79VoLAnuUQ
         X1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTCFS3cfNEjOOKerZt+01daLGyP2fALUEUrJKhPYQ6w=;
        b=M6tiGxdFtil6Tq5eFVICEB1bDpELCqgz6yYaD927j2nEDB0E4YqkrdDmq2U05M1jVV
         YpvbYZFw5Q3H2f6IQk78vmMT5ccT3UVcA1C/HU+nJY184Zf6weNwROpX2ce2j/cUZYuQ
         GKm0RN7AJaU86gVh583bm4y7qbkz/fTKzBMj9tA0aE3tTW2zFmQ6qoXX16SUE/6Vtb2L
         aIUwXXjROKUA9AmboN3+dBoHuvlBAIspKPpwTdiXGoCqRMUx5ctqSQTQY7XI4bQVj+ok
         fv0ONVsoTA9sTcc9G8HbPuQ/NPuIVYti7iBFm3YwsYMigRMWrhhkpX+8MDoUDqCCBFWl
         oV4Q==
X-Gm-Message-State: AOAM533FTvePVkeXwbx3SBwKpafz/GGY18nIvBRpDuHI1F9Yg9AALTlg
        CqkRUarK5E/PwE47EMuRM/QlHDYV2vzduhqiVKc6ng==
X-Google-Smtp-Source: ABdhPJyjwVPl2fhViaAT3lHMvkqOwO/mNzNLjDWv6IL9TDeuZgJgld0fPPUBd37HpyVU3t+KqnNcAnOFdiMzfYOyhes=
X-Received: by 2002:a05:620a:1367:: with SMTP id d7mr4910010qkl.20.1601506025306;
 Wed, 30 Sep 2020 15:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com> <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
In-Reply-To: <CA+EESO5ABYANQuynOs57UGYMcOaMjKN9TQdv4T2PObY5ng_1nw@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 30 Sep 2020 18:46:54 -0400
Message-ID: <CAJWu+oo7R6qQWz0_TnrTk_tmCfK2LgvLM-3PvhHv1wq2EyD_qg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 6:42 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> On Wed, Sep 30, 2020 at 3:32 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> > > mremap time can be optimized by moving entries at the PMD/PUD level if
> > > the source and destination addresses are PMD/PUD-aligned and
> > > PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> > > x86. Other architectures where this type of move is supported and known to
> > > be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> > > and HAVE_MOVE_PUD.
> > >
> > > Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> > > region on x86 and arm64:
> > >
> > >     - HAVE_MOVE_PMD is already enabled on x86 : N/A
> > >     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> > >
> > >     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
> > >     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> > >
> > >           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
> > >           give a total of ~150x speed up on arm64.
> >
> > Is there a *real* workload that benefit from HAVE_MOVE_PUD?
> >
> We have a Java garbage collector under development which requires
> moving physical pages of multi-gigabyte heap using mremap. During this
> move, the application threads have to be paused for correctness. It is
> critical to keep this pause as short as possible to avoid jitters
> during user interaction. This is where HAVE_MOVE_PUD will greatly
> help.

And that detail should totally have gone into the commit message :-/

Thanks,

 - Joel
