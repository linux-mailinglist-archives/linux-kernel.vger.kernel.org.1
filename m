Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92EE27D49E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgI2Rkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2Rkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:40:46 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86E2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:40:46 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e5so2837182ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5s72Hf6M5ClxTjTHmlWEDSkkJVMo+6Qf2SmpOue9JI=;
        b=Hx/cfu9Pj+cJsYmTc7JTnOpYFycF/dUkbQgiRmC6UKdqPmZ3zXU5bY8i3a7X7SMwVj
         HM4ay3MfQoyrPOHVLEWMeQtEUGsGl0ROtJsmndmRzTyLq85EBk7rRP5OEq6+VwK66F4x
         4BbvvIvz5cNOqbWnAFfVb43BngQij3Wxs2hAeKgBAJDsykg496GbeBkl476LxDW6oaly
         lhVX92hui2oBXjs+ZcZt4mp7oGHokej4qWuZbGsxvVK/PG1ykW/rC2bK0QQO+5+762Fd
         RzjjIoX7bJo2dXtojH+p4dD35fI/UdV9Uc2K6Uj37jbWi1+qkTI3Eiskb63QFl+RJhl0
         9RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5s72Hf6M5ClxTjTHmlWEDSkkJVMo+6Qf2SmpOue9JI=;
        b=dUOG1GKFTQLjzHy9qkuo4zRHosrnrElUNdfuyp0UX/hvbmuRgarEVQZueOnwbXde6f
         V7vxeEYp8GSggBlF9x5ISZz1ICDiRUmcr4jTNJ4Kc2lEBa0yWnk+b13r4m4kBXABbUCf
         k2D6s9nDqKR4smDdYA8wdwR8Ggar38R5BWUHMbL6U7vLLMeL6KGQAfbWcwG/wychX6Da
         FxSF7klJhKpt513JWR0mCNGJuodMHr96tpve40RY7G6YtT3lmgcSnooP3pn0lE0ajSeq
         qg3NqjFp5jkzHBEVVJJJMbvkX8zqOdL5tjjeTH7tHlEcr+TI3NKaq0kG9ZOFCDDySGbe
         gMhg==
X-Gm-Message-State: AOAM532jCY/tQeQj6XlhWJi72wk5KYZsDt7WbEpbW+uZR7khS/JI4Wa2
        WHzhbvqrbSrJ42BA/HSYfK7gM2wEqBYnKsmsWvo/ag==
X-Google-Smtp-Source: ABdhPJxjPcf+NCE/Dzq0bpcTZChhxeRg6lrRMDM6ALhie/5Y42jWf2Fj7sT+bAbnzxcyaRgtla6ETmpdylcvXJaCGig=
X-Received: by 2002:a92:9a82:: with SMTP id c2mr3929435ill.285.1601401245834;
 Tue, 29 Sep 2020 10:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com> <425b098c-dbe0-d614-8e62-1f50b2f63272@redhat.com>
In-Reply-To: <425b098c-dbe0-d614-8e62-1f50b2f63272@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 29 Sep 2020 10:40:34 -0700
Message-ID: <CANgfPd-zgP8GD+yOwZ1V-S=r9W92hFSEBpmjLzaqZDg=O20Hnw@mail.gmail.com>
Subject: Re: [PATCH 00/22] Introduce the TDP MMU
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
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

On Mon, Sep 28, 2020 at 10:31 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/09/20 23:22, Ben Gardon wrote:
> > This series is the first of two. In this series we add a basic
> > implementation of the TDP MMU. In the next series we will improve the
> > performance of the TDP MMU and allow it to execute MMU operations
> > in parallel.
>
> I have finished rebasing and adding a few cleanups on top, but I don't
> have time to test it today.  I think the changes shouldn't get too much
> in the way of the second series, but I've also pushed your v1 unmodified
> to kvm/tdp-mmu for future convenience.  I'll await for your feedback in
> the meanwhile!

Awesome, thank you for the reviews and positive response! I'll get to
work responding to your comments and preparing a v2.

>
> One feature that I noticed is missing is the shrinker.  What are your
> plans (or opinions) around it?

I assume by the shrinker you mean the page table quota that controls
how many pages the MMU can use at a time to back guest memory?
I think the shrinker is less important for the TDP MMU as there is an
implicit limit on how much memory it will use to back guest memory.
You could set the limit smaller than the number of pages required to
fully map the guest's memory, but I'm not really sure why you would
want to in a practical scenario. I understand the quota's importance
for x86 shadow paging and nested TDP scenarios where the guest could
cause KVM to allocate an unbounded amount of memory for page tables,
but the guest does not have this power in the non-nested TDP scenario.
Really, I didn't include it in this series because we haven't needed
it at Google and so I never implemented the quota enforcement. It
shouldn't be difficult to implement if you think it's worth having,
and it'll be needed to support nested on the TDP MMU (without using
the shadow MMU) anyway. If you're okay with leaving it out of the
initial patch set though, I'm inclined to do that.

>
> Also, the code generally assume a 64-bit CPU (i.e. that writes to 64-bit
> PTEs are atomic).  That is not a big issue, it just needs a small change
> on top to make the TDP MMU conditional on CONFIG_X86_64.

Ah, that didn't occur to me. Thank you for pointing that out. I'll fix
that oversight in v2.

>
> Thanks,
>
> Paolo
>
