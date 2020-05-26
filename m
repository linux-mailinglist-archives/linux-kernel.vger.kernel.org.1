Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089BF1D5E75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 06:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgEPEIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 00:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPEIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 00:08:45 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34726C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:08:44 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id 59so2149201qva.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=JLYon1khC+eLSB3T5yIWcEJuhbgDHgHLlnuv7ZU3dhk=;
        b=mFvRiZhecmwLYm5l9KNIE/vtdE8qUAe9hp2hsnr2PX9xg9BOgVi4qtzyUgtAC5+xN9
         gzr9aPXrekEB6e1OGUlx0Sds6YjHkFWX9tTCtlE2BFfYrt3Hl3N3bLhrSYASAIpmbEPS
         aPxhNJJiyXLxA7+TY4O2EUxcHUdyXOmJ70TelgHJBgOo2hDMetmXztNpjYJoChkP8MeE
         jZwWyDI/egW5yRF1RlbiDyyGLdWwkMAmK38Awt3Q3WTuWq+0vm7iBUc3dE+Dlv6ESLkp
         Ufh91CZ3Dmatr57/8Ng1tQsEXuBq4vACYlwt1/+wfabYrY9SMSsN6Md4NrP12KhaMbhE
         jymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=JLYon1khC+eLSB3T5yIWcEJuhbgDHgHLlnuv7ZU3dhk=;
        b=gmXilHsnOJvvOWl9Ipcgl6fgKj1dnBlnC1usTwgLbFWEH4HX+rihWyMciNraJXLLlk
         b9BZhP6pdRqtZHChf8Cg8d6KEUsX/79AYLCH+0/BXu26vI8/n7XVVCZ/Y+U6BL6U5rV+
         uOg7uIQHjXyH7SaOEStJgq096i7rDGvZlQXLB7dgUrk1HAUnnocnUdbTqt4MB1hmPh5v
         Zzd7ZjSXrKpHkmXaAmu08J6w1wc8ZWU5/XiRME7UFyu24lXSUCiCJQRqiGyW5FRXqsFZ
         wPvFU6lQwAycnt/rIV6ozjNFIaJfoZ2GrJ4jN6FfcwQZf4TEM0zz0az9Ta2h+z7c6ADP
         D73g==
X-Gm-Message-State: AOAM530uE3BLWb1Xq27UdDYxBdiDpkWQtdJn2DLKPNQzsAXjf/RGO1bj
        ohllOk2HjCjjRqHR2Jiypc0=
X-Google-Smtp-Source: ABdhPJwV0bAzte0qxgz4LPU+Qi0Jji9W/CS3UUB2E/LXBbuOssBt4QMYPAiKrw/w64nGdh9PtV8R/w==
X-Received: by 2002:a05:6214:42a:: with SMTP id a10mr6285253qvy.78.1589602123418;
        Fri, 15 May 2020 21:08:43 -0700 (PDT)
Received: from LeoBras (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id f198sm3185622qke.46.2020.05.15.21.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 21:08:42 -0700 (PDT)
Message-ID: <97dcf4d840871ae3ce87e3f3c2efbdb709d66db5.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] powerpc/rtas: Implement reentrant rtas call
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <namit@vmware.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 16 May 2020 01:08:24 -0300
In-Reply-To: <1589525800.2asfsw2zlu.astroid@bobo.none>
References: <20200514235138.150722-1-leobras.c@gmail.com>
         <20200514235138.150722-3-leobras.c@gmail.com>
         <1589525800.2asfsw2zlu.astroid@bobo.none>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

On Fri, 2020-05-15 at 17:30 +1000, Nicholas Piggin wrote:
> Excerpts from Leonardo Bras's message of May 15, 2020 9:51 am:
> > Implement rtas_call_reentrant() for reentrant rtas-calls:
> > "ibm,int-on", "ibm,int-off",ibm,get-xive" and  "ibm,set-xive".
> > 
> > On LoPAPR Version 1.1 (March 24, 2016), from 7.3.10.1 to 7.3.10.4,
> > items 2 and 3 say:
> > 
> > 2 - For the PowerPC External Interrupt option: The * call must be
> > reentrant to the number of processors on the platform.
> > 3 - For the PowerPC External Interrupt option: The * argument call
> > buffer for each simultaneous call must be physically unique.
> > 
> > So, these rtas-calls can be called in a lockless way, if using
> > a different buffer for each cpu doing such rtas call.
> 
> What about rtas_call_unlocked? Do the callers need to take the rtas 
> lock?
> 
> Machine checks must call ibm,nmi-interlock too, which we really don't 
> want to take a lock for either. Hopefully that's in a class of its own
> and we can essentially ignore with respect to other rtas calls.
> 
> The spec is pretty vague too :(
> 
> "The ibm,get-xive call must be reentrant to the number of processors on 
> the platform."
> 
> This suggests ibm,get-xive can be called concurrently by multiple
> processors. It doesn't say anything about being re-entrant against any 
> of the other re-entrant calls. Maybe that could be reasonably assumed,
> but I don't know if it's reasonable to assume it can be called 
> concurrently with a *non-reentrant* call, is it?

This was discussed on a previous version of the patchset:

https://lore.kernel.org/linuxppc-dev/875zcy2v8o.fsf@linux.ibm.com/

He checked with partition firmware development and these calls can be
used concurrently with arbitrary other RTAS calls.

> 
> > For this, it was suggested to add the buffer (struct rtas_args)
> > in the PACA struct, so each cpu can have it's own buffer.
> 
> You can't do this, paca is not limited to RTAS_INSTANTIATE_MAX.
> Which is good, because I didn't want you to add another 88 bytes to the 
> paca :) Can you make it a pointer and allocate it separately? Check
> the slb_shadow allocation, you could use a similar pattern.

Sure, I will send the next version with this change.

> 
> The other option would be to have just one more rtas args, and have the 
> crashing CPU always that. That would skirt the re-entrancy issue -- the
> concurrency is only ever a last resort. Would be a bit tricker though.

It seems a good idea, but I would like to try the previous alternative
first.

> Thanks,
> Nick

Thank you Nick! 

