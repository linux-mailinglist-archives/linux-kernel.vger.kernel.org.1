Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6962A36CA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKBWyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:54:00 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82663C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 14:54:00 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c80so4894270oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxMXOaWOcX7RWi2XohG/kNHvSy7AhpsjgRQW4jBaDgc=;
        b=P6ng53EdpuHBLplB221LcjZTmll1OcBSb7Gf0ID8ii2ONguufw8ilLp97H3Cgzxq+s
         WaeE7NEBHU8CEqXAQeVIjCGxqBgw+EzNDwnpEiloncZJrkHQ3V/gPqRvyMcVLJXtaFqN
         cEGBZGuow+HoX77Q/NJTmWor7xIJJIy0mTpLHUmGWDCuCxd8mHge6SGZJIbEmtTntV0Z
         tJaFzQrCJ9su2MsqE66AIkQb37McPrsPDjMjpU9Nez+liy0XYHmuvEc7drt3ilOsDTG5
         2neXrfP+P9zYpBmkjez3Es+JgesMX93j8fo8GgKfRIDm3WTI9ziNayKZbsFuap5FOVlH
         ovCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxMXOaWOcX7RWi2XohG/kNHvSy7AhpsjgRQW4jBaDgc=;
        b=WFxp0t945kNCDvxkReWpxRxGYDuCA6/9XWbvz8sNUN1ZrUlYvsAoURMNNCfHbN3eCC
         3pb/EGi8wcFst1rQYRQ1EwvxvvtGkvSR5nKkqGm7XHJk1spVwrJbaKTLaqcWg+rmwiMw
         2zWMGfalTVeea3oUPiVjr5+y09AhJEAbfTA9p7wx9W0kqAJQR6w/3YqyyvauTzp4MDbF
         TbXtHxuq0TkEQ8MYuJ+1TkDS6diFoF9uLjeNCDCEBFChhXmbzsZZNrP2Ivb8aM82No4n
         Rt4mhP9ofxIW3cEIljs1tYd9v90QAl2GEsPWGJbhugw4u5044hhnzQJQA5EbA6hk9zFa
         ttwg==
X-Gm-Message-State: AOAM533hFynt5LsPzlCN0146D3eHAsKVgb642mLeeITmoEMk4N8taL6H
        wv19HzlXl1KXuY6vZ2EbtsrItj8dTFZ3M6r27jh4jg==
X-Google-Smtp-Source: ABdhPJwiBRkyEJmNyWELvRc7Bv1J3jMYpYigUmhylzmxppC6VnYz3LwIszJXigYZDmgDvhshF0EBhX0xnHRT2G218gw=
X-Received: by 2002:a54:4016:: with SMTP id x22mr283781oie.28.1604357639327;
 Mon, 02 Nov 2020 14:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20201102061445.191638-1-tao3.xu@intel.com>
In-Reply-To: <20201102061445.191638-1-tao3.xu@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 2 Nov 2020 14:53:48 -0800
Message-ID: <CALMp9eTrsz4fq19HXGjfQF3GmsQ7oqGW9GXVnMYXtwnPmJcsOA@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Enable Notify VM exit
To:     Tao Xu <tao3.xu@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 10:14 PM Tao Xu <tao3.xu@intel.com> wrote:
>
> There are some cases that malicious virtual machines can cause CPU stuck
> (event windows don't open up), e.g., infinite loop in microcode when
> nested #AC (CVE-2015-5307). No event window obviously means no events,
> e.g. NMIs, SMIs, and IRQs will all be blocked, may cause the related
> hardware CPU can't be used by host or other VM.
>
> To resolve those cases, it can enable a notify VM exit if no
> event window occur in VMX non-root mode for a specified amount of
> time (notify window).
>
> Expose a module param for setting notify window, default setting it to
> the time as 1/10 of periodic tick, and user can set it to 0 to disable
> this feature.
>
> TODO:
> 1. The appropriate value of notify window.
> 2. Another patch to disable interception of #DB and #AC when notify
> VM-Exiting is enabled.
>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Do you have test cases?
