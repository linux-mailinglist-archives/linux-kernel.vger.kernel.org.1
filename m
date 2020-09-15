Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D526AB56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIOR7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgIORpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:45:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD684C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:45:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z17so2379333pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWmHefW8oD5UwOaVyeB2keHFNLfqq9QyBDTK4aqQw9Q=;
        b=rOS4fWQ/eec36pGAL6KIEjm3xWtdeCgnbHlHrpZywpEQBxD9hdIlvInVF1rOCkaTq2
         eMzIvqp9EVyb81nk/Cu3qsrhdpRxHHx9aKXxwZdUcXuPQlhwI2b7vpM6FIDllzKfmw+0
         virnGLvfUKyt4LihFHHxeJesSMP3TRXTkjZxknhakftdZRDVkNgr4VnMUJGxSnSYtDWI
         QmP46XIC81oYOKPN7Ayml/Ogf5sXwpAzLV0lbHVBjpn2jRabHQLTsfXN4SeM9qWpQbsD
         nEW8GdYYg4BAcTrgyiwOef+Mpn80IFtDw6ICPUqZR5BGkXT2Wje6KXrdu7JOUyFQp/P4
         Yy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWmHefW8oD5UwOaVyeB2keHFNLfqq9QyBDTK4aqQw9Q=;
        b=CXitikzCcKzz57Ya/DDJwzqpVn+cxeZ4gggutzKCRS7drN3xWfZKoWwRUWJBrl3U/N
         F1M99G+Ip99CV8C+6NBEzARCgJg+ggbYDU+zlYidTYNR66xw41xZL6eD/VMTWi+eDOJR
         O0ycR2Si6AGrtuxYEuvEy7dbHwQyQDyK0uRrVywzHz4cWlVRanbIRnGlTp47W5+3dJM2
         EhVW5LxPctaRxyRi3QcJpC3gReE3mCHiDeWW448tiPP/0uL2bW7Pl6R8qx3xAbkia7Wo
         YDjI76lQrSysmRc6cm1W02SKnjbOi8iIq1TXUWpDXAPJe00SK87e5wEK34DKLr/irket
         iXjw==
X-Gm-Message-State: AOAM532hIbdXb9cWzcOGRqC1t0ZZhTD/c7C9Gi0kS+Cm5NMio3Q7Mtu7
        fkP/JCLbCymWxMwdF4nfhE9bUsKR0LtO1CePKx3hcw==
X-Google-Smtp-Source: ABdhPJywnVW1CX64Bi7b/2ui9se1TF2vMRktkPYJkAzl5RcChgeC11Uysbwoaat0prX78ZBBuYgquuwOXs0KG041b2c=
X-Received: by 2002:a65:5a4c:: with SMTP id z12mr15329368pgs.10.1600191902079;
 Tue, 15 Sep 2020 10:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic> <20200915170248.gcv54pvyckteyhk3@treble>
In-Reply-To: <20200915170248.gcv54pvyckteyhk3@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 10:44:51 -0700
Message-ID: <CAKwvOdncdq4nMN1dXv_+3rC84wGEJtmgiyNTHNhCQi+ouqaB7A@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:02 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Sep 15, 2020 at 06:05:54PM +0200, Borislav Petkov wrote:
> > On Tue, Sep 15, 2020 at 10:18:16PM +0800, Rong Chen wrote:
> > > On Tue, Sep 15, 2020 at 03:55:19PM +0200, Borislav Petkov wrote:
> > > > On Tue, Sep 15, 2020 at 09:42:56PM +0800, kernel test robot wrote:
> > > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  x86/seves
> > > > > branch HEAD: e6eb15c9ba3165698488ae5c34920eea20eaa38e  KVM: nSVM: Avoid freeing uninitialized pointers in svm_set_nested_state()
> > > > >
> > > > > Warning in current branch:
> > > > >
> > > > > arch/x86/kernel/sev-es.o: warning: objtool: ist_exc_vmm_communication()+0x12: unreachable instruction
> > > > >
> > > > > Warning ids grouped by kconfigs:
> > > > >
> > > > > clang_recent_errors
> > > > > `-- x86_64-randconfig-r001-20200913
> > > > >     `-- arch-x86-kernel-sev-es.o:warning:objtool:ist_exc_vmm_communication():unreachable-instruction
> >
> > Ok, I can't trigger this with gcc-9, gcc-10 and clang-10.
> >
> > .config below says clang-12 so it could be some experimental
> > bug^Wfeature :)
> >
> > peterz says this has been fixed by:
> >
> > 318af7b80b6a ("Revert "kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled"")
> >
> > but that was reportedly for gcc.
> >
> > Lemme Cc the people of interest and leave the rest in here for
> > reference. Note that CONFIG_LIVEPATCH is enabled in that .config.
>
> If somebody can share the .o file, I can take a look.

I'm cc'ed on and read every report from 0day bot from builds with
Clang.  I started noticing a few randconfigs getting this report from
objtool.  I had filed a bug to follow up on this:
https://github.com/ClangBuiltLinux/linux/issues/1148.  They all seem
to be coming from randconfigs.  I've not yet had the time to bisect
configs to isolate which config this is coming from, but I wouldn't be
surprised if it was UBSAN.

-- 
Thanks,
~Nick Desaulniers
