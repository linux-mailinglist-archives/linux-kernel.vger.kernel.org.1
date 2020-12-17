Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428242DCAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgLQBsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgLQBsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:48:03 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C1FC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 17:47:23 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m23so11186762ioy.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 17:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZ4JZTy9+IKB/FbonfM/ldsdg2nn5Yf2TNc8FXof9Fw=;
        b=UCKfAQeBD/lJG4xTZujpMykS46OkdwA9BPik0ZiiP21lmRgJi3/09ohZX9ainMiDKI
         zRxn1vaP+CfpIESFJS/QD4RnMwzU19wODWEC1xxljKq7id5AuvYG5Dhj6VKCiWpO2Bmu
         xepCxxs/nvgAXLsdCo2asTTHWcfi0AsBbedsUSJ6VQp8rpnwvC6QtDd2SbN9Spb44SUF
         VwSXJD16Eaw04aOWV7lxsiFWYQZtc8M40srQyPH6OUeMdOAFhkyMivfM99Y42ik6mm5N
         g+0+Fxj5swtGtbxryrmlwpv3/CKawNt0PwS4A8NM3EMTCg9KLXX30DBH0v5yRbhKLl3w
         dcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZ4JZTy9+IKB/FbonfM/ldsdg2nn5Yf2TNc8FXof9Fw=;
        b=qnlX/l/g78bhyuTcECkQ14Yey9y5pfwArnj8c3Q6vG83yzNmQj5HP8X7AxGxJpHTNz
         GDzYdS+jVdYH13brkKkPkyJuUH/p49L2FTopA8ObjRiXIJiUOMo/lkda3HKy5hc3lkFz
         IgRZcK889KabJfSeUC+Dr+NePMErIYzl1vNOlSOhCA5V0jP7LPCdj/mtmFxqcdbRpfgR
         K0XWvsMwap0WrlcrO37CsHZaThiLpukxCMh9SRgI5FlUbGMB8bzEVLGO1u998vzCrmME
         OYEvzrLdBIq3weJDr1wVItl4k2VvUo+Y/Pf469ceAiR0rwRetG0j1ur0fbB/L2990P84
         e42w==
X-Gm-Message-State: AOAM532+cKiXjm1wCdwPiGi0rQek4GTkq1QL6c/6LoiAdyT255Y6hVFQ
        umtzQKkFSRg61q2w8sF3zu/YBz+OumUcc4O+Q2Zk
X-Google-Smtp-Source: ABdhPJyjbWC+MxAHpU9U15X6j6tLnLYjUbu31cSB3o9cVK1vZQtR1OSioJ1js/51Pmr9o1T76zygxv5g3/iHHIbTXNs=
X-Received: by 2002:a5e:8e05:: with SMTP id a5mr44246697ion.133.1608169642340;
 Wed, 16 Dec 2020 17:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20201119153901.53705-1-steven.price@arm.com> <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com> <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com> <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com> <CAJc+Z1EzaUjbQ0o8BSF_+PQy_KnwPp1NqO+94RMphvaUu=dnug@mail.gmail.com>
 <29a7229d-a1ff-98a5-3007-1addcc85aa04@arm.com>
In-Reply-To: <29a7229d-a1ff-98a5-3007-1addcc85aa04@arm.com>
From:   Haibo Xu <haibo.xu@linaro.org>
Date:   Thu, 17 Dec 2020 09:47:10 +0800
Message-ID: <CAJc+Z1E0rdWcDD1N1R=d-v8FnWSWw=Yu7qypUjRFG_pXw1xybQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 at 18:23, Steven Price <steven.price@arm.com> wrote:
>
> On 16/12/2020 07:31, Haibo Xu wrote:
> [...]
> > Hi Steve,
>
> Hi Haibo
>
> > I have finished verifying the POC on a FVP setup, and the MTE test case can
> > be migrated from one VM to another successfully. Since the test case is very
> > simple which just maps one page with MTE enabled and does some memory
> > access, so I can't say it's OK for other cases.
>
> That's great progress.
>
> >
> > BTW, I noticed that you have sent out patch set v6 which mentions that mapping
> > all the guest memory with PROT_MTE was not feasible. So what's the plan for the
> > next step? Will new KVM APIs which can facilitate the tag store and recover be
> > available?
>
> I'm currently rebasing on top of the KASAN MTE patch series. My plan for
> now is to switch back to not requiring the VMM to supply PROT_MTE (so
> KVM 'upgrades' the pages as necessary) and I'll add an RFC patch on the
> end of the series to add an KVM API for doing bulk read/write of tags.
> That way the VMM can map guest memory without PROT_MTE (so device 'DMA'
> accesses will be unchecked), and use the new API for migration.
>

Great! Will have a try with the new API in my POC!

> Thanks,
>
> Steve
