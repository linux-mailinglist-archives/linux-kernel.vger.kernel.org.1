Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F076A2FD296
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbhATOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbhATMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:45:32 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B6C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:44:17 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id h18so12946772vsg.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xt7JVmEFE/aJx6FE4Qvl47o9pAkmFlCT9+vpzHf5qLw=;
        b=fGWP96aayixQ3J4z0EyohXgXAbUnf33N8q/UY1tuVs/m8Xa1UVZhW1aZBCaOmBqHK2
         FcMa2kowZFptVFa8wvIwZ+x3bnx8MT8+IizLlwkx7KTCBXIaDZsYOffn8rZ5cjMgVU+D
         Tj4X2iPnIRfbf5uUmIdY5pcRIZGtXVyFaYtXylZlV+875MpUhhmbBm1sU1k067xtqAqo
         KTVhHrp1uJ3XxgoixjotVi/3OfJ7oC3UbTf94X0hwKmT4sEjzJmSGZSis02/7lEjGMvV
         WEgd1eO+Ic7t0d+lOY/INFj6UBf9yj5M3jhc0Mo2DQc4+TzDL2hJRpGQPRZGR3oqFEaI
         1bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xt7JVmEFE/aJx6FE4Qvl47o9pAkmFlCT9+vpzHf5qLw=;
        b=SUZayK2X01YnLmm2zvye9wftdNBsNBfHs0RZUEsqRlc4M8XR/+VNYi5tUcRjuzzjBn
         PbRkuvnEY5szeUos91lEPkY6+LylWhP3TnX+i1koGBIaFBV3Yz+o46DzJSDMb5yBMNRR
         VgRavlKBHrBG8ey88kRnJXEWNKS+YF4bsfXiOaRWfEDqdZqUI6wyZR8+BRWjCARDsi8J
         VK3vKeY99qy2jUk1nFiLFBCkd41GkHDyq/VOIkVNFReSWqzknhCZmw1a699wBedRqnTC
         evugHcNkYZNgj/wbOqb+5iRXwiZU/unL7XyZ2+Vy6vpLwB1R5P/hwwQpR6PltQEJR8JM
         DQxA==
X-Gm-Message-State: AOAM530AHqov+c3+1qALBKpLmtCS3xEcqjBZhhS5nsZf9gchXMqm2JSG
        SuawbnPTntmYXYP06u3BzZMmJJrhk2fgJka9Z11qKQ==
X-Google-Smtp-Source: ABdhPJwHKz/HISSKEW13+jRITfAZ0pDF7sP9tUx8JY9r8JXFfhafF7y8RJ66INMh7ccOdw76hnSi+qRQe6KwjMKndBU=
X-Received: by 2002:a67:25c3:: with SMTP id l186mr662163vsl.27.1611146655834;
 Wed, 20 Jan 2021 04:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20210113194619.RFC.1.I8f559ecdb01ffa98d5a1ee551cb802f288a81a38@changeid>
 <20210113195301.tyeeyrf5y7ajd5yw@treble>
In-Reply-To: <20210113195301.tyeeyrf5y7ajd5yw@treble>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Wed, 20 Jan 2021 23:44:03 +1100
Message-ID: <CAATStaPWxLvCsY77tgTsHj0Jp8+6WZ52Rm+t+=ie=uio50EgBg@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/speculation: Add finer control for when to issue IBPB
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, Anthony Steinhauser <asteinhauser@google.com>,
        tglx@linutronix.de, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joelaf@google.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This proposal attempts to reduce that cost by letting the system
> > developer choose whether to issue the IBPB on entry or exit of an IB
> > speculation disabled process (default is both, which is current
> > behaviour). Documentation/admin-guide/hw-vuln/spectre.rst documents two
> > mitigation strategies that use conditional IBPB;
> > "Protect sensitive programs", and "Sandbox untrusted programs".
>
> Why make the setting system-wide?  Shouldn't this decision be made on a
> per-task basis, depending on whether the task is sensitive or untrusted?

It definitely could be. I didn't give it as much thought since for me,
the entire system uses a "sandbox" approach, so the behaviour would
apply to any IB spec disabled process. And conversely, any system
taking the "sensitive programs" approach would also expect the same
behaviour from all processes.

I'm open to making it per-process. It's just that making it
system-wide seemed to "fit" with the documented mitigation strategies,
and it's what I would use in production.
