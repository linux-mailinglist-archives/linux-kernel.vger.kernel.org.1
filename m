Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4202CC7DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgLBUdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgLBUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:33:04 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651FDC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:32:24 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o1so5494662wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ArIFLNBSlJoptv1NLBX8RCWaznOMpzj84NJClOoUcF8=;
        b=G0CtFsHun/dE8SSNtH7NxfhkCWLQmuZ6mNkABiVQ5wQi6se/ypQU3NMZLz2lJlqXHn
         vz5oDZZlAOqH5t47URdf5IrkzkyevG+F5YCBKFnlrWrSq+3YG06WDHHOKI/K7YDzfVRE
         nfaT5cpgVL5dxqsHF/YZA/82YzAVfUKHhAGQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ArIFLNBSlJoptv1NLBX8RCWaznOMpzj84NJClOoUcF8=;
        b=iKXDql0rkz/w1bpfqk45Nw8nIevJdcat57FBHFlknFy3iLzQi2AAGWfOay5UZw/JVT
         cxtxHT5TqwNbO/zIlItH9u7u3wdH5nkVMs/aaTBOpGh9e1NdE8vvm1K2YFY4o0L+JZQU
         ahZNlUnOkjz2Ql753RhXXZK08Xr82kI5iSHrlXMrla3zrsVevyznj2gFF4aAN9Znjz9a
         UF2VzMwwzwzXykDOnEFAH4fbTQ3sYl08s76bwcxD2YJ+0+FfD5t8/oz8dm961MB7pZnz
         HkMhnlQ7s4ffz3evohyvJRqOtjLL6zCczjiD0oAguI/oOE7pfd8LxbfjL97IvzOlDU2s
         htLA==
X-Gm-Message-State: AOAM533TCsAUa1xcM/QeIpIX09g9r7emCtBJb77AWmeUj7chgSV8ic6F
        lw//2iLl0U+uca6gi7ni6+mv3w==
X-Google-Smtp-Source: ABdhPJwFn0cMmM9TtBd5VsGLgIsh0lp6ft09CuQ3DjfdGheaYY6uRRYDX3R/PMhp4EvYEpYANDBH3g==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr5622939wrm.414.1606941142955;
        Wed, 02 Dec 2020 12:32:22 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id b14sm3426327wrq.47.2020.12.02.12.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:32:22 -0800 (PST)
Message-ID: <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
From:   Florent Revest <revest@chromium.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Dec 2020 21:32:21 +0100
In-Reply-To: <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
References: <20201126165748.1748417-1-revest@google.com>
         <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
         <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
         <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
         <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 16:55 -0800, Andrii Nakryiko wrote:
> On Fri, Nov 27, 2020 at 8:09 AM Yonghong Song <yhs@fb.com> wrote:
> > 
> > 
> > On 11/27/20 3:20 AM, KP Singh wrote:
> > > On Fri, Nov 27, 2020 at 8:35 AM Yonghong Song <yhs@fb.com> wrote:
> > > > 
> > > > In this case, module name may be truncated and user did not get
> > > > any indication from return value. In the helper description, it
> > > > is mentioned that module name currently is most 64 bytes. But
> > > > from UAPI perspective, it may be still good to return something
> > > > to let user know the name is truncated.
> > > > 
> > > > I do not know what is the best way to do this. One suggestion
> > > > is to break it into two helpers, one for symbol name and
> > > > another
> > > 
> > > I think it would be slightly preferable to have one helper
> > > though. maybe something like bpf_get_symbol_info (better names
> > > anyone? :)) with flags to get the module name or the symbol name
> > > depending
> > > on the flag?
> > 
> > This works even better. Previously I am thinking if we have two
> > helpers,
> > we can add flags for each of them for future extension. But we
> > can certainly have just one helper with flags to indicate
> > whether this is for module name or for symbol name or something
> > else.
> > 
> > The buffer can be something like
> >     union bpf_ksymbol_info {
> >        char   module_name[];
> >        char   symbol_name[];
> >        ...
> >     }
> > and flags will indicate what information user wants.
> 
> one more thing that might be useful to resolve to the symbol's "base
> address". E.g., if we have IP inside the function, this would resolve
> to the start of the function, sort of "canonical" symbol address.
> Type of ksym is another "characteristic" which could be returned (as
> a single char?)
> 
> I wouldn't define bpf_ksymbol_info, though. Just depending on the
> flag, specify what kind of memory layou (e.g., for strings -
> zero-terminated string, for address - 8 byte numbers, etc). That way
> we can also allow fetching multiple things together, they would just
> be laid out one after another in memory.
> 
> E.g.:
> 
> char buf[256];
> int err = bpf_ksym_resolve(<addr>, BPF_KSYM_NAME | BPF_KSYM_MODNAME |
> BPF_KSYM_BASE_ADDR, buf, sizeof(buf));
> 
> if (err == -E2BIG)
>   /* need bigger buffer, but all the data up to truncation point is
> filled in */
> else
>   /* err has exact number of bytes used, including zero terminator(s)
> */
>   /* data is laid out as
> "cpufreq_gov_powersave_init\0cpufreq_powersave\0\x12\x23\x45\x56\x12\
> x23\x45\x56"
> */

Great idea! I like that, thanks for the suggestion :) 

