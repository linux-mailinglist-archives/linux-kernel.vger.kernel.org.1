Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481DA3011EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAWBQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbhAWBQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:16:10 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:15:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rv9so10212685ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZHWC0QZZA37dcKrvB+jA2eMe/FYFoxrvp88RR54inU=;
        b=a2niozalS5x3ybbQChS+nPD+2ab6W0/kt0PFw46W1AX+wreKDIEfNPpr5Zj9lOcF+q
         nC2/oUSgvc976KUmJSIeLtrOQjtRqmloROV2AypxhQg+hwFAFMtW2xLiauW44AEUUBiF
         hqXn3dj4jQ5kvRsie+iEc1dnVD+pn3+DuO9fCEdZWEo81leY7mAk4Cx6Moxuh8V+XrmI
         XxgfHHGW3RJazwFFiCy2xfbua/KA4gLR/tjJ0mIGxAyexDL649yOZ+ArNgq88o25sLpw
         DdCK0x9a0chUuwCzclGE21GM+/fZ31LlbfIZ4ABbK16Qx/3fLiJRXvJuyzFIiBeOl8hu
         JbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZHWC0QZZA37dcKrvB+jA2eMe/FYFoxrvp88RR54inU=;
        b=jy83UWUHoWaGK3A4Mvp1+ZUp+rEg0quJQDXGYjivFqicR0s5neMdSXjfIw/rcVj0iq
         RhJNmCb3k0RZsT6x83aExvkHuuxJTphJD0F8//kUMCR2iJ0L08r9hUKY7hvXtnI+0snW
         oIiRLJ8XQ1ekzxCYawEGK5la8nQSvYHc8krzJ2Q5r4Ds3OQZqFG62OM1xfTCaF9iw4XI
         8380FPMCQyfXei+COOlJesvYPXs2/aLe+TJxL7BmQbXbxG1A76jQpAxjkEPE4QcqwWaL
         1eiLhpZVYUnml+llHtenYuzn6o0wym+NxHHNODRqm8BPfChjfqDher25iA5/py8Csldp
         ZE6g==
X-Gm-Message-State: AOAM530Q9Old2a5mcaPPkE9c2BQykqiInL/F2jFWc2YcbFKS2Pg/F1x9
        1iii0HKpKOvPgkmwNcmBAyd6JSLPDa7OVQQxIJJS+A==
X-Google-Smtp-Source: ABdhPJwcM5QQPYi/sgWHIWgDz4u3w27IDZzkKokmBVapf4JwhJZ/P1/Dbfiwu5YNNk0+Bg+9VIWUvMUFFqXOuhMG3RE=
X-Received: by 2002:a17:906:eb95:: with SMTP id mh21mr4823614ejb.175.1611364524697;
 Fri, 22 Jan 2021 17:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-11-pasha.tatashin@soleen.com> <e6faa23d-27a8-838a-33ef-2a6ad8a5c746@arm.com>
In-Reply-To: <e6faa23d-27a8-838a-33ef-2a6ad8a5c746@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 20:14:49 -0500
Message-ID: <CA+CK2bDJeYPzGyVkRJu2AOkvV8SJ=ea3jbAZtho8_VA416kZ4A@mail.gmail.com>
Subject: Re: [PATCH v9 10/18] arm64: kexec: cpu_soft_restart change argument types
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Change argument types from unsigned long to a more descriptive
> > phys_addr_t.
>
> For 'entry', which is a physical addresses, sure...
>
> > diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> > index ed50e9587ad8..38cbd4068019 100644
> > --- a/arch/arm64/kernel/cpu-reset.h
> > +++ b/arch/arm64/kernel/cpu-reset.h
> > @@ -10,17 +10,17 @@
> >
> >  #include <asm/virt.h>
> >
> > -void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
> > -     unsigned long arg0, unsigned long arg1, unsigned long arg2);
>
> > +void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
> > +                     phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);
>
> This looks weird because its re-using the hyp-stub API, because it might call the hyp-stub
> from the idmap. entry is passed in, so this isn't tied to kexec. Without tying it to
> kexec, how do you know arg2 is a physical address?
> I think it tried to be re-usable because 32bit has more users for this.

I will drop this patch. It was intended as a cleanup from suggestions
in earlier versions of this series, but I see it is not really needed.

Thank you,
Pasha
