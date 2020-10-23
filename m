Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D729756A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbgJWQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462951AbgJWQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:59:17 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:59:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o14so1975976otj.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSVr128pqOoBVgaQYWDeH7y0Q+csz3WwPIzOZPNEXDU=;
        b=Gm9gB8LfWqXjYNl+ezisHjcKPpuYsHthevYvIaDtlEB9d+b83tyLXhvxMbEAce2RCO
         CmF8L6JhFKT5CK4tQHjNkssG/iskl/etKY6pLS+99Ew2EqkVPbrprYCdRzwzkjudwoPf
         Dfkh6+Z5B7HoPwQvg1wb//RugPRsKW2CDOH9dKQLQ7WLbz4rR5u4HvTWlgz5rgBdDd+j
         3WTb3QYAXr7pej5bwi+5CdYDUZi9D4M5JopRMJee1TnfGVj3oVywjh7rApTeHq4nqZDp
         GTDkyqsJy2mwxZ/NVxcjG+ll2QChI1WzogLNWiZ8G0k6ung0cvBNwr8oZIExoq4nG1Yo
         0fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSVr128pqOoBVgaQYWDeH7y0Q+csz3WwPIzOZPNEXDU=;
        b=Rl5Eg2E5nb83wKIZFeIybnCustnzc38Y49pzjStu5TL92ZZWKG5d9WAaB2ST3uR4Lm
         gGnRJPvvLaNDn4hCapUtpxuOP3Bnuhwi1fIcIE9DjuTuc8W3Na3r9p7kxQI595kwrGeG
         NWMPTsRTD9ucCqTj7OpIMOD6sJZMCYkKCp92CSbh2ekAfsMLu0/LIW925zop+ws0qvxc
         jcjRqkDjH74JHY8OwX+kxlUNnnFnKBjcuTU7J3zoBxpVNgD9IxjyWNzKHVtSuUdPDwbh
         zos0cY/ezb2YpH/r1g9T3O6FLVi2fibJxQ6dbViMkrMQbmcaBOML50Tvw7q6ukEnBOEb
         Dsvw==
X-Gm-Message-State: AOAM5301eVdE7LR4D5FfTZsgjSbrHBt2RybyneaQmVHzwiEY57+KpX4n
        z9rxnLLbM5k6GWWNDElwgv+QoZO/Vz+Wc3uXx2DKqw==
X-Google-Smtp-Source: ABdhPJyeGWHQQDGVimyZ+QBAQPt7x+bmS1YILgkR+mEnGxuK2O6BoKn48ADm59edMi2szBv9/R+InVHL3y6rZeYy5GA=
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr2501059oto.295.1603472354961;
 Fri, 23 Oct 2020 09:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <20200710154811.418214-8-mgamal@redhat.com>
 <CALMp9eSbY6FjZAXt7ojQrX_SC_Lyg24dTGFZdKZK7fARGA=3hg@mail.gmail.com>
 <CALMp9eTFzQMpsrGhN4uJxyUHMKd5=yFwxLoBy==2BTHwmv_UGQ@mail.gmail.com>
 <20201023031433.GF23681@linux.intel.com> <498cfe12-f3e4-c4a2-f36b-159ccc10cdc4@redhat.com>
In-Reply-To: <498cfe12-f3e4-c4a2-f36b-159ccc10cdc4@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 23 Oct 2020 09:59:03 -0700
Message-ID: <CALMp9eQ8C0pp5yP4tLsckVWq=j3Xb=e4M7UVZz67+pngaXJJUw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] KVM: VMX: Add guest physical address check in EPT
 violation and misconfig
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 2:22 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/10/20 05:14, Sean Christopherson wrote:
> >>>> +
> >>>> +       /*
> >>>> +        * Check that the GPA doesn't exceed physical memory limits, as that is
> >>>> +        * a guest page fault.  We have to emulate the instruction here, because
> >>>> +        * if the illegal address is that of a paging structure, then
> >>>> +        * EPT_VIOLATION_ACC_WRITE bit is set.  Alternatively, if supported we
> >>>> +        * would also use advanced VM-exit information for EPT violations to
> >>>> +        * reconstruct the page fault error code.
> >>>> +        */
> >>>> +       if (unlikely(kvm_mmu_is_illegal_gpa(vcpu, gpa)))
> >>>> +               return kvm_emulate_instruction(vcpu, 0);
> >>>> +
> >>> Is kvm's in-kernel emulator up to the task? What if the instruction in
> >>> question is AVX-512, or one of the myriad instructions that the
> >>> in-kernel emulator can't handle? Ice Lake must support the advanced
> >>> VM-exit information for EPT violations, so that would seem like a
> >>> better choice.
> >>>
> >> Anyone?
> >
> > Using "advanced info" if it's supported seems like the way to go.  Outright
> > requiring it is probably overkill; if userspace wants to risk having to kill a
> > (likely broken) guest, so be it.
>
> Yeah, the instruction is expected to page-fault here.  However the
> comment is incorrect and advanced information does not help here.
>
> The problem is that page fault error code bits cannot be reconstructed
> from bits 0..2 of the EPT violation exit qualification, if bit 8 is
> clear in the exit qualification (that is, if the access causing the EPT
> violation is to a paging-structure entry).  In that case bits 0..2 refer
> to the paging-structure access rather than to the final access.  In fact
> advanced information is not available at all for paging-structure access
> EPT violations.

True, but the in-kernel emulator can only handle a very small subset
of the available instructions.

If bit 8 is set in the exit qualification, we should use the advanced
VM-exit information. If it's clear, we should just do a software page
walk of the guest's x86 page tables. The in-kernel emulator should
only be used as a last resort on hardware that doesn't support the
advanced VM-exit information for EPT violations.
