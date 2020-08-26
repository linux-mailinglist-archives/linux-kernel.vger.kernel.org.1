Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F38253926
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHZUif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 16:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZUie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:38:34 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:38:33 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n128so2746272oif.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RDmTeskOQgqjH7Bwa9ilUHRa8YVRzYGClEJYJQLJEs=;
        b=Ncib95Z0vslOOUIyFxuviDs0j+tBfe5FDoorlEI4kUHJBZv+l7A+C1TbJPzR25/WjW
         AVFG/Ml7nQJFKgucAJce4V7Yd/QfZZI3tKY9DdcDLrvUQxBHXTAExIg5vRU36ClMmfQv
         UiDSu5XzVvJFOjf4XmcYqS5uf185wpBop6AjhfzUtSl7XKHDK8/f+OlFhtik6whAojDK
         3xYlxMTP/2aMJ05MjhL8C5iU4SfPsbZGZ5aRnNwnNLsRxD81hi+tFe7vjbpbEKJ6bPrs
         Y1UCLVyOj6NK9naOKWU+opF0FdOBrQSlQ8rG2jJEqn945yuYMOw6ZANhCMGmHAQbMCMD
         GsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RDmTeskOQgqjH7Bwa9ilUHRa8YVRzYGClEJYJQLJEs=;
        b=JRdtqZgSPu+Pyotl3V92nusj4sSfOqAzY04vXP+rC1cTqpqNdDJGueCU3WVW8lS0fM
         flW2opDBZ5tPdh5Ex3TtJ7gX4Lzv/cPpAwekYcTDyizmgG1sEc+JF2rXQ5PNFkOLno+9
         4vya93P1NDdC5hV0QAUmRV0XGDPkUURDVHGPFxeRuIKfaxsa4jb0txoi8XDl6AfL37ff
         gcz24fmTGDXDhzaKC0HFbhC8kAu6ahP0E6NvRA080PiacK2SQ6Ocq+X87lVGddaRMlex
         RgnnCQzswJovCy1MyCezC4YK/kRgA5AIKxdMwKlynZZzOCABfrV5/ZveAY6/j6o+PIDQ
         LddA==
X-Gm-Message-State: AOAM531uN5UEC2AmuF3RCoa1pvqYnUsS0fDNm2CG8oJBh/5afSPX6R5F
        F6vQdi6ne4zArR7cU5wCvRrqiCW9s6eUhrCYeTrQ+Q==
X-Google-Smtp-Source: ABdhPJy6hwY95r78yIoeS5ram8XOf7QjXY5PDWluJU3+L70Px0lQMsNtKZKlaCwQW/hQeMV41R65lk9NEeH70RX44Vc=
X-Received: by 2002:a54:4795:: with SMTP id o21mr5056157oic.13.1598474312866;
 Wed, 26 Aug 2020 13:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <159846887637.18873.14677728679411578606.stgit@bmoger-ubuntu> <159846923918.18873.8521340533771523718.stgit@bmoger-ubuntu>
In-Reply-To: <159846923918.18873.8521340533771523718.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 26 Aug 2020 13:38:21 -0700
Message-ID: <CALMp9eSM6joAKAHPeJWZB8srCxJPJyTxgpwjAzpJuCLm0LmvyA@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] KVM: SVM: Change intercept_cr to generic intercepts
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:14 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Change intercept_cr to generic intercepts in vmcb_control_area.
> Use the new vmcb_set_intercept, vmcb_clr_intercept and vmcb_is_intercept
> where applicable.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
