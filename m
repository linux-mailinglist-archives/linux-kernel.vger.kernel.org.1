Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0F28CDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgJMMMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgJMMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602591161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udtC/1hm8WYvL6m+geYpRdEZb4H/tQKYED5kun2ydIM=;
        b=JFF5wJ+QMda/sTKawYjI40oGSfXUpd2SCe7LQssH6lh27qHfEURwuqLLztyzuH5UfSYhYf
        sup3ec01GwT6KHxablUwzQsaF5Y64VtPuCzP3iU9oZ4BBVUxtDyvQ+wGv1H+b/1yfeS7OR
        fR8nsNRxdFosybRB18mquJHrj0+9zzw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-QvmBQqXjNjeQg_BgihHWRg-1; Tue, 13 Oct 2020 08:12:40 -0400
X-MC-Unique: QvmBQqXjNjeQg_BgihHWRg-1
Received: by mail-wm1-f70.google.com with SMTP id r19so6678489wmh.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udtC/1hm8WYvL6m+geYpRdEZb4H/tQKYED5kun2ydIM=;
        b=YtNAAk6/f2QY9PAs25zN+tXcmF9V8tiW0I03Gw4jGQfO+UKDAUht1Te5CIBafeiUjB
         6qw/fQuNkYFOMTdGaIpwQi8VMjLQlcFRT4Z0DOlHcvG2uQkO9vBRU3UpbfPxA4V+gR2Z
         cHp23CH1UuKI27mOOs2qm2bhwG73WK6D7lN7dYBpEJG1sgtboiaf2kBCxg83ZLTZt86P
         GWb11TF2/EF48rjGgiGKdV9PKvWfsZVu4pJsb0GYJ8Pl791VY4wt8EXJSI0twIAVA0nc
         KH3OCkqJ+xiIXDlPERtegiP6eUgPPdauPJLZu2zzV7B1LQbAklXYKEv5//6eJf0Y051m
         /Fkw==
X-Gm-Message-State: AOAM530ZJQe73Z3VgsowcMU7ajx4V1BVtOgOFZPxDzZw5/pZUvzNcDrW
        tyDZLneQQq7O47ZMkChClu/7v4hg7uY/QyxY805DPGlrjsnBeq2Qmt/xpufON53iCnWwTSgDvf5
        2+V3bREtn1mGP6N4BAh85ica/
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr16189167wmi.140.1602591158755;
        Tue, 13 Oct 2020 05:12:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1sd4CMQs2UivsepzGRMRZvro+UKn6OLqIpqicwemf8TWCoo8eTGWMmFc7KvVZSXEgIoXUhg==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr16189137wmi.140.1602591158517;
        Tue, 13 Oct 2020 05:12:38 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id c130sm32689471wma.1.2020.10.13.05.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 05:12:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] objtool: check: Fully validate the stack frame
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200928093631.210610-1-jthierry@redhat.com>
 <20200928093631.210610-2-jthierry@redhat.com>
 <20200929191834.7daofidv6b5aef3y@treble>
 <5540c2a9-db13-e05e-713c-22ec00f21aa6@redhat.com>
 <20201012153500.owcyvgjv4m3t3nh3@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <1283e5a8-67e3-090c-0904-3d03ae10a178@redhat.com>
Date:   Tue, 13 Oct 2020 13:12:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201012153500.owcyvgjv4m3t3nh3@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/20 4:35 PM, Josh Poimboeuf wrote:
> On Mon, Oct 12, 2020 at 11:21:49AM +0100, Julien Thierry wrote:
>> On 9/29/20 8:18 PM, Josh Poimboeuf wrote:
>>> "Stack frame" has more than one meaning now, I suppose.  i.e. it could
>>> also include the callee-saved registers and any other stack space
>>> allocated by the function.
>>>
>>> Would "call frame" be clearer?
>>>
>>>     CALL_FRAME_BP_OFFSET
>>>     CALL_FRAME_RA_OFFSET
>>>
>>> ?
>>
>> I would've thought that the call-frame could include the stackframe + other
>> callee saved regs.
> 
> Hm, probably so.
> 
>> Whereas stackframe tends to used for the caller's frame pointer +
>> return address (i.e. what allows unwinding). Unless I'm getting lost
>> with things.
> 
> I've always seen "stack frame" used to indicate the function's entire
> stack.
> 
>> And if call frame is associated with the region starting from the stack
>> pointer at the parent call point (since this is what CFA is), then it
>> shouldn't be associated with the framepointer + return address structure
>> since this could be anywhere on the call frame (not at a fixed offset) as
>> long as the new frame pointer points to the structure.
> 
> I suppose "call frame" and "stack frame" probably mean the same thing,
> in which case neither is appropriate here...
> 
> In fact, maybe we could forget the concept of a frame (or even a struct)
> here.
> 
> If cfa.base is CFI_BP, then is regs[CFI_BP].offset always the same as
> -cfa.offset?  i.e. could the BP checks could it just be a simple
> 
>    regs[CFI_BP].offset == -cfa.offset
> 
> check?
> 

I guess that makes sense. If the above was no true it would mean that BP 
is not pointing to the unwind information.

> And then is RA at regs[CFI_BP].offset + 8?
> 

In the case of aarch64, the saved frame pointer and return address 
appear in the same order as on x86_64. So that would work. If that can 
make things simpler for now I can go with that.

Thanks for the suggestion.

-- 
Julien Thierry

