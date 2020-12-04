Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0907D2CE5B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgLDCaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDCaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:30:52 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F39C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 18:30:11 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o5so2602552pgm.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=799HwfENk8y05soNUsgKUZdfsq1t4k4wBTh65JJiSEA=;
        b=ftzJWQm/j8jHeKBDnmArPbBNNHejuHEDOu3YwEq4vTCJ9/LSe8sr1q28Wft90kK2gp
         rtho3xfRbr/PztkloRpS8Rp+V7yW7nY9C2UqQW1I0IBrxCl7gJ4phnGvDofBt8hvWt89
         ER+Un8KmxXu9N/FPjcTbPXjMHRDQ0peQLSG6ye9Rnvy0pPpIMt3d5tcax5ShsqJUSd9q
         cUkchBqNYjvbOA4ni+aKCbf09D36Dl27osonFDILmSdOAKT11UAZpW+nEaxwa90aDY7c
         vv0rDq85+uWwl+bGvHdVvBEUbTA6URRcJwu61vNeJ8SYFFIYs9sJoAgvBGZuJ7+KEInH
         9zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=799HwfENk8y05soNUsgKUZdfsq1t4k4wBTh65JJiSEA=;
        b=iyemndQlOk+VeZbl3pMoar8w6URnolbDTxYKElVyHrv50xVZs/zzCK+RtrOJiGMtSc
         yi4dvlFZbakV/yNuofCQMi7nyQoAPX0fPNrv7pPqanYI7BqKGay1m2Vc6dm02lTlcxen
         uvP5oKLhaEGc0i2AWAoBVixvKFswTCTJeeFUS7+evNV0sRuMW8ZZPzRaS4Qy2tyyW4pC
         xhLLLDky2WNobrLvcLDdXOocotpoIRr+QHo+u+gGy/GRY2W+Hkzm4wEzPANC+wU442M/
         q639ckHFGO4PvTAqfwLjktfz+4dIh4SD06iNiyIA1i0PqWGiMPVlpc5FaVUWtHRGdDpi
         57Ig==
X-Gm-Message-State: AOAM530jRisozSp1ZZTcbZtLMwWyKuweZwsHhqeVDA/pkQ6oxgRa9uh6
        pXT8nci5Zbx/6CDj7x6EKGKQvlWah+bw9g==
X-Google-Smtp-Source: ABdhPJy67dblort2ZZG7gknq7FZK9pDsmrI509Q/tBToy09P/cPzyhs3E53ELXZ/btb+5xBlEQu9Ww==
X-Received: by 2002:a62:61c2:0:b029:197:f5ee:6ffa with SMTP id v185-20020a6261c20000b0290197f5ee6ffamr1730101pfb.18.1607049011041;
        Thu, 03 Dec 2020 18:30:11 -0800 (PST)
Received: from [192.168.10.153] (124-171-134-245.dyn.iinet.net.au. [124.171.134.245])
        by smtp.gmail.com with UTF8SMTPSA id g14sm2971248pfo.198.2020.12.03.18.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 18:30:10 -0800 (PST)
Subject: Re: WARN_ON_ONCE
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <87f443cf-26c0-6302-edee-556045bca18a@ozlabs.ru>
 <CACT4Y+ZAyhk6CuddQNix0fAupXhOpv1t3iOdcXbDh4VDEPyOJQ@mail.gmail.com>
 <CACT4Y+ZHH5DiDj7KvRKtPqkV1CS0TFOkCH-M5bitfCgd5PWotg@mail.gmail.com>
 <87k0tyuztw.fsf@mpe.ellerman.id.au>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <414bc088-9441-70c7-88e2-2c928b97db36@ozlabs.ru>
Date:   Fri, 4 Dec 2020 13:30:06 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <87k0tyuztw.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2020 12:25, Michael Ellerman wrote:
> Dmitry Vyukov <dvyukov@google.com> writes:
>> On Thu, Dec 3, 2020 at 10:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Thu, Dec 3, 2020 at 10:10 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>
>>>> Hi!
>>>>
>>>> Syzkaller triggered WARN_ON_ONCE at
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/tracepoint.c?h=v5.10-rc6#n266
>>>>
>>>>
>>>> ===
>>>> static int tracepoint_add_func(struct tracepoint *tp,
>>>>                                 struct tracepoint_func *func, int prio)
>>>> {
>>>>          struct tracepoint_func *old, *tp_funcs;
>>>>          int ret;
>>>>
>>>>          if (tp->regfunc && !static_key_enabled(&tp->key)) {
>>>>                  ret = tp->regfunc();
>>>>                  if (ret < 0)
>>>>                          return ret;
>>>>          }
>>>>
>>>>          tp_funcs = rcu_dereference_protected(tp->funcs,
>>>>                          lockdep_is_held(&tracepoints_mutex));
>>>>          old = func_add(&tp_funcs, func, prio);
>>>>          if (IS_ERR(old)) {
>>>>                  WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
>>>>                  return PTR_ERR(old);
>>>>          }
>>>>
>>>> ===
>>>>
>>>> What is the common approach here? Syzkaller reacts on this as if it was
>>>> a bug but WARN_ON_ONCE here seems intentional. Do we still push for
>>>> removing such warnings?
> 
> AFAICS it is a bug if that fires.
> 
> See the commit that added it:
>    d66a270be331 ("tracepoint: Do not warn on ENOMEM")
> 
> Which says:
>    Tracepoint should only warn when a kernel API user does not respect the
>    required preconditions (e.g. same tracepoint enabled twice,


This says that the userspace can trigger the warning if it does not use 
the API right.


> or called
>    to remove a tracepoint that does not exist).
>    
>    Silence warning in out-of-memory conditions, given that the error is
>    returned to the caller.
> 
> 
> So if you're seeing it then you've someone caused it to return something
> other than ENOMEM, and that is a bug.


This is an userspace bug which registers the same thing twice, the 
kernel returns a correct error. The question is should it warn by 
WARN_ON or pr_err(). The comment in bug.h suggests pr_err() is the right 
way, is not it?


-- 
Alexey
