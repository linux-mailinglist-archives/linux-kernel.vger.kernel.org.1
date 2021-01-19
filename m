Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D412FB3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbhASICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731250AbhASH7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611043061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qNmdLSS5lsljSlr43wHmEkle6qxUVtow9wAgfeuvxc=;
        b=DxzpMxkQ18DYqjMmWfS3x20taPC6xAXaT8Vsa40akUsFlzkH6ipYVMo6Zpza2ok1tGHqz1
        bUbkcgPUuZG9Nel71YnSaHWnzMcQ0Wb+MNwzyn+fV7iDhVp1CyljtVYR25dz9VdDpTZDtV
        kMP6TIY0Tei4MON/i8UAG4pcdJxTMLM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-yAa2RPojNceNOGfYig2k1w-1; Tue, 19 Jan 2021 02:57:39 -0500
X-MC-Unique: yAa2RPojNceNOGfYig2k1w-1
Received: by mail-wr1-f69.google.com with SMTP id j5so9514964wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 23:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qNmdLSS5lsljSlr43wHmEkle6qxUVtow9wAgfeuvxc=;
        b=irdK9u/o3zD9+D9OKxi8onx9T1FP/nRFrAGDyBRDgqj/se6dOb3DXfKF7XNKigtiVd
         FZ+Kvlk0u2hRRs/X/16t//+gT+UsoAbL23EEub5Ls3DZ8+SOyYn9/22CouULwXU/ssf3
         Of2zd9D7ATcaHUw03xWeJUTfb4eXPa12CjCCz98pbNulg41I4X0ig4w8tkOUftJzAnXM
         QMMvySXZiZXyLyJM/lYFg06FIexp1bEwYnmrrt0qT/38f9PNYrg+dIcsjklpELAyxvdw
         tRQqlJSEh+SSbLXuVjzr5+O/qFdLazwifw6LFyR9/QePbTuaLiM6rRSrCd7/rwOmYV7X
         mD2A==
X-Gm-Message-State: AOAM530pjTDiUptJiOfg/5JYEBQ7JKkmLQtUhSOqRbDcQGczcE2Jh9jB
        up0/I9czrl2WkgdP+U60ggrM4hs7xpQ8mRSpVD9SMDiX7pMtil0w+Sfnmhj3JuziZTwS8UThsMM
        wDB2Ibi8YooxK+WfoBlWZRribscBnhyz1jqlNpGRihI585sQlG+D7IjZeNt8RiPToDJ7PBli55p
        6b
X-Received: by 2002:adf:e541:: with SMTP id z1mr3021328wrm.143.1611043057866;
        Mon, 18 Jan 2021 23:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCWTj4etfSQSfrsVGnDa05ynRnIWz5xJxfD+AlFdsC6qTk9zKdjl5YWJPa++3p4njMhamhdA==
X-Received: by 2002:adf:e541:: with SMTP id z1mr3021308wrm.143.1611043057690;
        Mon, 18 Jan 2021 23:57:37 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id n6sm3154700wmi.23.2021.01.18.23.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 23:57:37 -0800 (PST)
Subject: Re: Live patching on ARM64
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, jpoimboe@redhat.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f3fe6a60-9ac2-591d-1b83-9113c50dc492@linux.microsoft.com>
 <20210115123347.GB39776@C02TD0UTHF1T.local>
 <a5f22237-a18d-3905-0521-f0d0f9c253ea@linux.microsoft.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <1cd6ab9a-74bc-258e-abf8-fcabba5e3484@redhat.com>
Date:   Tue, 19 Jan 2021 08:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a5f22237-a18d-3905-0521-f0d0f9c253ea@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Madhavan,

On 1/17/21 6:25 PM, Madhavan T. Venkataraman wrote:
> 
> 
> On 1/15/21 6:33 AM, Mark Rutland wrote:
> 
>>> It looks like the most recent work in this area has been from the
>>> following folks:
>>>
>>> Mark Brown and Mark Rutland:
>>> 	Kernel changes to providing reliable stack traces.
>>>
>>> Julien Thierry:
>>> 	Providing ARM64 support in objtool.
>>>
>>> Torsten Duwe:
>>> 	Ftrace with regs.
>>
>> IIRC that's about right. I'm also trying to make arm64 patch-safe (more
>> on that below), and there's a long tail of work there for anyone
>> interested.
>>
> 
> OK.
> 
>>> I apologize if I have missed anyone else who is working on Live Patching
>>> for ARM64. Do let me know.
>>>
>>> Is there any work I can help with? Any areas that need investigation, any code
>>> that needs to be written, any work that needs to be reviewed, any testing that
>>> needs to done? You folks are probably super busy and would not mind an extra
>>> hand.
>>
>> One general thing that I believe we'll need to do is to rework code to
>> be patch-safe (which implies being noinstr-safe too). For example, we'll
>> need to rework the instruction patching code such that this cannot end
>> up patching itself (or anything that has instrumented it) in an unsafe
>> way.
>>
> 
> OK.
> 
>> Once we have objtool it should be possible to identify those cases
>> automatically. Currently I'm aware that we'll need to do something in at
>> least the following places:
>>
>> * The entry code -- I'm currently chipping away at this.
>>
> 
> OK.
> 
>> * The insn framework (which is used by some patching code), since the
>>    bulk of it lives in arch/arm64/kernel/insn.c and isn't marked noinstr.
>>    
>>    We can probably shift the bulk of the aarch64_insn_gen_*() and
>>    aarch64_get_*() helpers into a header as __always_inline functions,
>>    which would allow them to be used in noinstr code. As those are
>>    typically invoked with a number of constant arguments that the
>>    compiler can fold, this /might/ work out as an optimization if the
>>    compiler can elide the error paths.
>>
>> * The alternatives code, since we call instrumentable and patchable
>>    functions between updating instructions and performing all the
>>    necessary maintenance. There are a number of cases within
>>    __apply_alternatives(), e.g.
>>
>>    - test_bit()
>>    - cpus_have_cap()
>>    - pr_info_once()
>>    - lm_alias()
>>    - alt_cb, if the callback is not marked as noinstr, or if it calls
>>      instrumentable code (e.g. from the insn framework).
>>    - clean_dcache_range_nopatch(), as read_sanitised_ftr_reg() and
>>      related code can be instrumented.
>>
>>    This might need some underlying rework elsewhere (e.g. in the
>>    cpufeature code, or atomics framework).
>>
> 
> OK.
> 
>> So on the kernel side, maybe a first step would be to try to headerize
>> the insn generation code as __always_inline, and see whether that looks
>> ok? With that out of the way it'd be a bit easier to rework patching
>> code depending on the insn framework.
>>
> 
> OK.
> 
> I have an understanding of some of the above already. I will come up to
> speed on the others. I will email you any questions I might have.
> 
>> I'm not sure about the objtool side, so I'll leave that to Julien and co
>> to answer.
>>

Sorry for the late reply. The last RFC for arm64 support in objtool is a 
bit old because it was preferable to split things into smaller series.

I touched it much lately, so I'm picking it back up and will try to get 
a git branch into shape on a recent mainline (a few things need fixing 
since the last time I rebased it).

I'll update you once I have something at least usable/presentable.

Cheers,

-- 
Julien Thierry

