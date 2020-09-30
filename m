Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3485F27F5BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgI3XM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgI3XMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:12:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F42C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:12:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g128so4409631iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MR1J/wCcy9hPIA8a165EobJ1iSvsAYHQOKsxcC0t/ZM=;
        b=ZPx2WhLMEsL+yYluidhwYyEFpZN/TyaUEwO8sRM63oQOYIGVvUOWXjFMKP0VqrXwAq
         mzB5kdZF0W9dEZ8UBcur7v0adPsyrmNyZGl81iLAIwMxekR23Fd6wFB/yI1nzm9QmE+A
         8oK19FFbc4ooWqrN3POUzW22gnn2WQvXNPfXPsNINqv57TwhshXkrcRpT4Z6q58lGM+/
         jhBSSQGxxVLtbx+q0yRyaf1M0YsuPGLgIP19vuDKXZVs9DpsHzjN0ff08PYX6m3CKTKL
         QTSXdoPWQt7G7LDZLpPaKkyuJZK+MFEdwKRJEUoo7u9sFzMQV5bozmTnRk+uOzGJ/lqN
         S/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MR1J/wCcy9hPIA8a165EobJ1iSvsAYHQOKsxcC0t/ZM=;
        b=Iecj0pUktXYRAvDHe4mw3eobhX9YspLIkJSzRm5hDvH9iKg1tPfT6VaHRWqDWcBWBL
         prRRDp1/e8CmXPaHSmwdttFydA3kAiwlK83vJ00NfK5XSGYZD6otVHy5VLfnQcAR3jb+
         v8M6UTgFMe7UB6QIfKwPBrmJCjgaKfsdUOrIIq1F6zj7iaPabaEY8vohO5NpkfZnPN5N
         O8kncKsiGf0GbEXhlXRKRPsUkoJfK9Z4mLo/wvNFcMKMWbFlYafT/MHVa/1rxlj84PVt
         WNHTRiL8vmCqaJ0xnR40dNWUr1hkOrF5tDLCtJ74bPLf5b7ryRWuzbYlaIOlLYn6WTqu
         Em9w==
X-Gm-Message-State: AOAM532twsj0MMdQjf3A4a15cXEm1LYM+5gbwoHFeSlK6fALGCRDsiUV
        XhrBeUIu7swCbZJKY3+DaGU1nYR5O0zhCO2ELGnhFw==
X-Google-Smtp-Source: ABdhPJwshOH3BplNx3wbsv2/KZX/xMddVCbwS6IPwGnVnWVW23j4+xqef3UnuHpAOtbj9dRLiD6aYHBzOdklq0RIdQQ=
X-Received: by 2002:a6b:610d:: with SMTP id v13mr3313692iob.189.1601507530756;
 Wed, 30 Sep 2020 16:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com> <20200925212302.3979661-7-bgardon@google.com>
 <20200930061047.GB29659@linux.intel.com>
In-Reply-To: <20200930061047.GB29659@linux.intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 30 Sep 2020 16:11:59 -0700
Message-ID: <CANgfPd8EbGu8GAY++yHmURO_1i0OEO9QogoD3WpNUrysX5Ba5w@mail.gmail.com>
Subject: Re: [PATCH 06/22] kvm: mmu: Make address space ID a property of memslots
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:11 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Sep 25, 2020 at 02:22:46PM -0700, Ben Gardon wrote:
> > Save address space ID as a field in each memslot so that functions that
> > do not use rmaps (which implicitly encode the id) can handle multiple
> > address spaces correctly.
> >
> > Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
> > machine. This series introduced no new failures.
> >
> > This series can be viewed in Gerrit at:
> >       https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  include/linux/kvm_host.h | 1 +
> >  virt/kvm/kvm_main.c      | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 05e3c2fb3ef78..a460bc712a81c 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -345,6 +345,7 @@ struct kvm_memory_slot {
> >       struct kvm_arch_memory_slot arch;
> >       unsigned long userspace_addr;
> >       u32 flags;
> > +     int as_id;
>
> Ha!  Peter Xu's dirtly ring also added this.  This should be a u16, it'll
> save 8 bytes per memslot (oooooooh).  Any chance you want to include Peter's
> patch[*]?  It has some nitpicking from Peter and I regarding what to do
> with as_id on deletion.  That would also avoid silent merge conflicts on
> Peter's end.
>
> [*] https://lkml.kernel.org/r/20200708193408.242909-2-peterx@redhat.com

Oh that's great! Yes, let's use Peter's patch in place of this one.


>
> >       short id;
> >  };
> >
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index cf88233b819a0..f9c80351c9efd 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1318,6 +1318,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >       new.npages = mem->memory_size >> PAGE_SHIFT;
> >       new.flags = mem->flags;
> >       new.userspace_addr = mem->userspace_addr;
> > +     new.as_id = as_id;
> >
> >       if (new.npages > KVM_MEM_MAX_NR_PAGES)
> >               return -EINVAL;
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >
