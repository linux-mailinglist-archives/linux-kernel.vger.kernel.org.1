Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC22FDC08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbhATVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388549AbhATVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:17:06 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D0C061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:16:25 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i30so11874063ota.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqJQj8k3vfWMQlZ/PSNAuaLZe+ukwJ9aG6srW46wlAI=;
        b=tuweO45nJgUG/JrL7B42/+1T6FCIv5MhnfmqVoQMbhbLADiuqqBMCz3UDZW0dbRIID
         tUJbW6u6rYIJ+9FOoXJah2ITElhVopukfgzwkh+iqHhoEQP8Hsa5jMoqy03pKwrO38PW
         BLiGRZSmRYwQcNdnVzjIlpgYe97ryWepD7AEQ3vuFtfxxfeBWXzVsSlhOf2igcJo5NJW
         Wd5qUdgTWH1csV2Bk0CdVofpBU7wO4vzxqHuBLjKjudOOEzKA2Agc3mDhHEOSJgBDOo9
         kNVOn28L/JLtHFNlxAG9uDrsGt9wr876K0HY8HkfJGyTqh54fkaiiGttKIRriCA25iAo
         7UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqJQj8k3vfWMQlZ/PSNAuaLZe+ukwJ9aG6srW46wlAI=;
        b=ozhQpz1uCuF/VjHkGT2CwHxgNbwO/p8N+vjRbMXMJtR7tS5F+I4qN8uKl4/7d8bcBZ
         SixBppVWmesh3cWFSqgFyCMQEkdQW6EWy7c39D5ORe4SU7VJjh4l8kGL+ADF7bnjI+qz
         UQGhEpJYQuv2EF1Abaz3Z9TOMB/QIqsXduP8cCllEllbKzktdKd2ywGOMk8e4FHW2LzC
         gZ18WJnDU8sWVpPVy5nm8k+XKZcQ29vyEeA9jjaegLUPP9yVp/FuODlF1+VoTdpK5ZfY
         Es61P0gDHYb1C5JYBJIjVVOD0LVDTrIBowLpDiZ8eP7QwqsOGF5Ej7qcRndrFo/laeoZ
         KIAg==
X-Gm-Message-State: AOAM531kFsw9sMOelI8h/yf8avkLzohfCXsXGzjWcPftTQyb+CWdaERk
        mduYBNN9+elUBUj8gp5fmTkcbWSsLYZU2r3lZBzjZg==
X-Google-Smtp-Source: ABdhPJyxD8xMNTy67Z87//Tx9+mIxtKk1Hn0gB417dL+U71Ysa7fbfor8j/1k0quFAXArSR7qzimz2qXZOMQD5v0iY8=
X-Received: by 2002:a05:6830:1da4:: with SMTP id z4mr8177761oti.295.1611177384908;
 Wed, 20 Jan 2021 13:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com> <20200710154811.418214-8-mgamal@redhat.com>
 <CALMp9eSbY6FjZAXt7ojQrX_SC_Lyg24dTGFZdKZK7fARGA=3hg@mail.gmail.com>
 <CALMp9eTFzQMpsrGhN4uJxyUHMKd5=yFwxLoBy==2BTHwmv_UGQ@mail.gmail.com>
 <20201023031433.GF23681@linux.intel.com> <498cfe12-f3e4-c4a2-f36b-159ccc10cdc4@redhat.com>
 <CALMp9eQ8C0pp5yP4tLsckVWq=j3Xb=e4M7UVZz67+pngaXJJUw@mail.gmail.com>
 <f40e5d23-88b6-01c0-60f9-5419dac703a2@redhat.com> <CALMp9eRGBiQDPr1wpAY34V=T6Jjij_iuHOX+_-QQPP=5SEw3GQ@mail.gmail.com>
 <4463f391-0a25-017e-f913-69c297e13c5e@redhat.com> <CALMp9eRnjdJtmU9bBosGNAxa2pvMzB8mHjtbYa-yb2uNoAkgdA@mail.gmail.com>
In-Reply-To: <CALMp9eRnjdJtmU9bBosGNAxa2pvMzB8mHjtbYa-yb2uNoAkgdA@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 20 Jan 2021 13:16:13 -0800
Message-ID: <CALMp9eR2ONSpz__H2+ZpM4qqT7FNowNwOfe4x9o-ocfhwRnEhw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] KVM: VMX: Add guest physical address check in EPT
 violation and misconfig
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:35 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Fri, Oct 23, 2020 at 10:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 23/10/20 19:23, Jim Mattson wrote:
> > >> The information that we need is _not_ that provided by the advanced
> > >> VM-exit information (or by a page walk).  If a page is neither writable
> > >> nor executable, the advanced information doesn't say if the injected #PF
> > >> should be a W=1 or a F=1 fault.  We need the information in bits 0..2 of
> > >> the exit qualification for the final access, which however is not
> > >> available for the paging-structure access.
> > >>
> > > Are you planning to extend the emulator, then, to support all
> > > instructions? I'm not sure where you are going with this.
> >
> > I'm going to fix the bit 8=1 case, but for bit 8=0 there's not much that
> > you can do.  In all likelihood the guest is buggy anyway.
>
> Did this drop off your radar? Are you still planning to fix the bit8=1
> case to use advanced EPT exit qualification information? Or did I just
> miss it?

Paolo,
If you're not working on this, do you mind if I ask Aaron to take a look at it?
