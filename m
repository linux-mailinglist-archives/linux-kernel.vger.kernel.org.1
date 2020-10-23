Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2A2975B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbgJWRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461030AbgJWRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:23:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAB5C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:23:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s21so2674119oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAbg4EfbmYjF2J65vk3SVCLIQ7BEYi2tTAxcBpH2Xqg=;
        b=expmyRBGifdsnEwKlURsWKa6q/ZXCnRsFBqS+RtygktAu4c3Pwsw+jC2WXsUGmD7VZ
         VPlAINJxCnK4ZAHzFSwEBQNch5IDMvgH7MqRqtu3UQw7Osn5PrCjhJMMjesU/CGOtmTt
         nR9QJ1jCKHszz4aOTg9PBsEbhWwMGF6rlyUGEUKmtEXXHubCCEDNarEbKk8HMuUxrTDq
         0U4FRFH/vPI7Lzo5XJu7oqz1eyqLpAclqjc2lTye6HWFfBDWngpYb5pu0THQCA642kEs
         Xer0L5iPb4niAKRwgzn6KJ2BI6PApmPC8mIO+YP73IQhna81QszDuqFAoEGHJh6m0ZyL
         HzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAbg4EfbmYjF2J65vk3SVCLIQ7BEYi2tTAxcBpH2Xqg=;
        b=SWsz83eOVV7QAJodZlNDmcxdMyDhN067ZSRTH49H+bhnqw2LqfaHoDq5oK1RIEFQ5K
         zD+ppzADdE906xCBcZpVlxDqge+jl0ulIaXlzDtCHIA0xaxq3Eg162CSYudOIGcCn20y
         uwD54EK0NO//ahAAglH5FyLVda/BOHOFQuN3DHZyk/gz2nRpW2fHWaV5wN95Rb9j6V+k
         FbZDthVMstHzM3SxAxWlwgESM7ZSIgtmZsNS2LwTBbmlEFrkbyIIvwpeGd5zdOyW+mP8
         G5Rzm1N031M6F6nn0QLsi4VPPf+QpXsjtt2eElMXKuq285TQorWdMNZSP67HQEsQEzix
         1aBQ==
X-Gm-Message-State: AOAM530uuojlFk72SBEopRUzO92W5zTj5xS/EkjFOlWac/5VGb/23n/I
        UKsL23gXorP+v0gNt5OBa9X0LQ0Lje+0wPl+jr8z/A==
X-Google-Smtp-Source: ABdhPJzjq/q4AKy62VenrujOe/dE59sYQ1l63ygYk7oyFM1jCKbCmhJ/4XBOxOYG9wWZE6/z8SfvSbQ3AbTf2a8cRBM=
X-Received: by 2002:aca:f557:: with SMTP id t84mr1331276oih.13.1603473835263;
 Fri, 23 Oct 2020 10:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <20200710154811.418214-8-mgamal@redhat.com>
 <CALMp9eSbY6FjZAXt7ojQrX_SC_Lyg24dTGFZdKZK7fARGA=3hg@mail.gmail.com>
 <CALMp9eTFzQMpsrGhN4uJxyUHMKd5=yFwxLoBy==2BTHwmv_UGQ@mail.gmail.com>
 <20201023031433.GF23681@linux.intel.com> <498cfe12-f3e4-c4a2-f36b-159ccc10cdc4@redhat.com>
 <CALMp9eQ8C0pp5yP4tLsckVWq=j3Xb=e4M7UVZz67+pngaXJJUw@mail.gmail.com> <f40e5d23-88b6-01c0-60f9-5419dac703a2@redhat.com>
In-Reply-To: <f40e5d23-88b6-01c0-60f9-5419dac703a2@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 23 Oct 2020 10:23:43 -0700
Message-ID: <CALMp9eRGBiQDPr1wpAY34V=T6Jjij_iuHOX+_-QQPP=5SEw3GQ@mail.gmail.com>
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

On Fri, Oct 23, 2020 at 10:16 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/10/20 18:59, Jim Mattson wrote:
> >> The problem is that page fault error code bits cannot be reconstructed
> >> from bits 0..2 of the EPT violation exit qualification, if bit 8 is
> >> clear in the exit qualification (that is, if the access causing the EPT
> >> violation is to a paging-structure entry).  In that case bits 0..2 refer
> >> to the paging-structure access rather than to the final access.  In fact
> >> advanced information is not available at all for paging-structure access
> >> EPT violations.
> >
> > True, but the in-kernel emulator can only handle a very small subset
> > of the available instructions.
> >
> > If bit 8 is set in the exit qualification, we should use the advanced
> > VM-exit information. If it's clear, we should just do a software page
> > walk of the guest's x86 page tables.
>
> The information that we need is _not_ that provided by the advanced
> VM-exit information (or by a page walk).  If a page is neither writable
> nor executable, the advanced information doesn't say if the injected #PF
> should be a W=1 or a F=1 fault.  We need the information in bits 0..2 of
> the exit qualification for the final access, which however is not
> available for the paging-structure access.
>
Are you planning to extend the emulator, then, to support all
instructions? I'm not sure where you are going with this.
