Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01922CAA63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgLASBs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Dec 2020 13:01:48 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41148 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLASBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:01:48 -0500
Received: by mail-ej1-f65.google.com with SMTP id f23so5969469ejt.8;
        Tue, 01 Dec 2020 10:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OB+Hqk1PmlZ4ftbIA0TQ8qnbxHVt4BJHYtXBZHFPTDo=;
        b=eQHLlqvM4XdtEcj1xxjDEYNbexmrvrouC/pZ85xHMnTo6j1v4WiWJxL1EDvRbvCGqP
         ME0BjnskdsvAjIzolSMDdOjW+18cFDs9a98Q5nS1SheRbct7V3BjglmX9jGWebTyp4Pt
         sW1plTieUiOFqeORTxofakM5dnRR+bVTSf6cW/LGRc3wuE4Pps7vr4ZGtL8ua9HMy53Z
         g6Aac18E/I3K6wpZmgOKbm5OSCYrZt+qESi2aQgc12amFXwTgokgXH0cpSogCvWaW/Ig
         XdU88uS32+fQhxVlj9CY6ZkSdiZD6lXVeTEfXKH32W8HiPNpTCR9vQCZBi5oIWxUpby9
         tP5A==
X-Gm-Message-State: AOAM530zI9uJr5XHbmtKcnYu9zO67fwDzyFLDJW1kiCGikoAiwbYkJbA
        ivlZWGoPkE/TzTnAZZfh8D9h2mr70uZhD7+87LoJ+vWkA/A=
X-Google-Smtp-Source: ABdhPJybhgiq1OPsE29YW/dUukjFPtOpcSFPbONMO0salgmbkEWl4urIsO55d9iXGGnU4Aq+bdfzH0j71KtjXFQMT2w=
X-Received: by 2002:a17:907:214d:: with SMTP id rk13mr4100873ejb.501.1606845665874;
 Tue, 01 Dec 2020 10:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-23-chang.seok.bae@intel.com> <CALCETrXBRATBVySDM9f0H-+gD37n7=CsNLWa446eLHi1mjokGw@mail.gmail.com>
 <CAJvTdKng_WMrmO_KtkuCxvvzGZ_HLcd84u2SwJiD_UJivb4Yaw@mail.gmail.com> <CALCETrX_1RkatiJxScjXhA38KTHvgrDxtj_e1YUs6fLTeHZufw@mail.gmail.com>
In-Reply-To: <CALCETrX_1RkatiJxScjXhA38KTHvgrDxtj_e1YUs6fLTeHZufw@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 1 Dec 2020 13:00:54 -0500
Message-ID: <CAJvTdKnVqUw8qBWJOCssk0pBhUzXzj-qR+UJOoyzx=eSYCKKYQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > ﻿On Fri, Nov 20, 2020 at 12:03 AM Andy Lutomirski <luto@kernel.org> wrote:

> We may want to taint the kernel if one of these flags is used

I agree with Andy.
I can imagine a distro would want to see the taint bit set if a user
overrides the default that they ship and support.

Chang,
Please taint when the enable flag is used -- Thanks!

> because,
> frankly, Intel’s track record is poor. Suppose we get a new feature
> with PKRU-like semantics -- switching it blindly using
> XSAVE(C,S,OPT,whatever) would simply incorrect.

A valid concern.
To mitigate, there is a new CPUID bit on the way to tell us explicitly
which features are simple (require just XSAVE), versus which
features are not simple and require more complex support.n t
When that bit is locked down, we will add that sanity check here.

> And XFD itself has
> problems — supposedly it’s difficult or impossible to virtualize. It
> wouldn’t utterly shock me if Intel were to drop IA32_XFD_ERR and
> replace it with a new mechanism that’s less janky.
>
> So this whole thing makes me quite nervous.
>
> (I'm not a virtualization expert, but AIUI IA32_XFD_ERR has some
> issues.  If it's too late to fix those issues, Intel could probably
> get away with completely dropping IA32_XFD_ERR from the spec -- OSes
> can handle AMX just fine without it.  Then the next XFD-able feature
> could introduce a new improved way of reporting which feature
> triggered #NM.)

I don't follow the XFD concern.

There are a couple of cases.

If the hypervisor isn't aware of XFD, it neither uses it, or shows it
to the guests.

If the hypervisor is aware of XFD and supports TMUL, it allocates its
own context
switch buffers at boot time, and does not use the XFD optimization to
save space inside the hypervisor.  It can expose XFD to the guests,
(and context switch it when guests switch on/off physical CPUs)

The guest sees two cases, either XFD exists or it doesn't, just like
on real hardware.

thanks,
Len Brown, Intel Open Source Technology Center
