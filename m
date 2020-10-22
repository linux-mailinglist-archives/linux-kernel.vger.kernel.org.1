Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE22295D23
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896940AbgJVLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:03:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443221AbgJVLDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:03:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603363721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0b+aO4geVivMxoOImVN5TC2oxRBqcdDWLWc9IG6Dja4=;
        b=eNZuxA34i5wiLPoll7WkPXL2PX8QR7fJehNfp3WFLosE56YkjFThkSySoANZJSUtVORyjn
        vTuaFa64zaqVevu+h3k5ObPjj9MuRVNO4EeA082UC/Yf2AJPz+zCqLSmoAHttaXSq3E31/
        HZtKCZJjbqa6RE6eAcjPoSNlWdpRUa8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D57D8ACA3;
        Thu, 22 Oct 2020 10:48:40 +0000 (UTC)
Subject: Re: [PATCH] x86/alternative: don't call text_poke() in lazy TLB mode
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20201009144225.12019-1-jgross@suse.com>
 <28ccccfe-b95b-5c4d-af27-5004e9f02c40@suse.com>
 <20201022104527.GI2594@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <61d30267-733f-49b5-8ca1-3246485e8151@suse.com>
Date:   Thu, 22 Oct 2020 12:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022104527.GI2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 12:45, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 11:24:39AM +0200, Jürgen Groß wrote:
>> On 09.10.20 16:42, Juergen Gross wrote:
>>> When running in lazy TLB mode the currently active page tables might
>>> be the ones of a previous process, e.g. when running a kernel thread.
>>>
>>> This can be problematic in case kernel code is being modified via
>>> text_poke() in a kernel thread, and on another processor exit_mmap()
>>> is active for the process which was running on the first cpu before
>>> the kernel thread.
>>>
>>> As text_poke() is using a temporary address space and the former
>>> address space (obtained via cpu_tlbstate.loaded_mm) is restored
>>> afterwards, there is a race possible in case the cpu on which
>>> exit_mmap() is running wants to make sure there are no stale
>>> references to that address space on any cpu active (this e.g. is
>>> required when running as a Xen PV guest, where this problem has been
>>> observed and analyzed).
>>>
>>> In order to avoid that, drop off TLB lazy mode before switching to the
>>> temporary address space.
>>>
>>> Fixes: cefa929c034eb5d ("x86/mm: Introduce temporary mm structs")
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>
>> Can anyone look at this, please? It is fixing a real problem which has
>> been seen several times.
> 
> As it happens I picked it up yesterday, just pushed it out for you.

Thank you very much!


Juergen
