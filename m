Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6799A23B1D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgHDAta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgHDAt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:49:29 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798CCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:49:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BLGNj2bMHz9sPC;
        Tue,  4 Aug 2020 10:49:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596502166;
        bh=3km56OESZEG1IUM1QfBpRjK0KZXxpHpMwagYVoTYTGM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Za5rUkj7GfVi2NgE+l0OjQQiWk3Cit3/ruEipW0TWiKNNpaqDN3ey4NZhYQvK1iE0
         UXwfqs3famv4I4mkymeNMWAsb3boWg2Vbok6ZZsFCbhwPloV5RSzjXGzmSTTH1U8ha
         dL/0Ve8EavL/rteDkH7Kza/b3+2vBa/SozZ0UWHm3vaGVUjPYAZFsW2I0dd7DL+DKq
         nFMiPjeutb080LI3VnEDIxPEFOJ7dYwb2XNeq+RXaiysW9hF7MzaG+SszubeLoArY8
         mv3azWtlB3rPOhtuvE+3sWAZwPu2ypmirlFZv4FdIBB50IEKEEZsNjIByyuWTGkUj7
         MjlbJCFm5ZcHA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Willy Tarreau <w@1wt.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
In-Reply-To: <20200803223147.28adac79@canb.auug.org.au>
References: <20200802204842.36bca162@canb.auug.org.au> <20200802172019.GB26677@1wt.eu> <20200803034547.GA15501@1wt.eu> <87v9i0yo47.fsf@mpe.ellerman.id.au> <20200803223147.28adac79@canb.auug.org.au>
Date:   Tue, 04 Aug 2020 10:49:20 +1000
Message-ID: <87pn87z14f.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> On Mon, 03 Aug 2020 21:18:00 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> If we just move the include of asm/paca.h below asm-generic/percpu.h
>> then it avoids the bad circular dependency and we still have paca.h
>> included from percpu.h as before.
>> 
>> eg:
>> 
>> diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
>> index dce863a7635c..8e5b7d0b851c 100644
>> --- a/arch/powerpc/include/asm/percpu.h
>> +++ b/arch/powerpc/include/asm/percpu.h
>> @@ -10,8 +10,6 @@
>>  
>>  #ifdef CONFIG_SMP
>>  
>> -#include <asm/paca.h>
>> -
>>  #define __my_cpu_offset local_paca->data_offset
>>  
>>  #endif /* CONFIG_SMP */
>> @@ -19,4 +17,6 @@
>>  
>>  #include <asm-generic/percpu.h>
>>  
>> +#include <asm/paca.h>
>> +
>>  #endif /* _ASM_POWERPC_PERCPU_H_ */
>> 
>> 
>> So I think I'm inclined to merge that as a minimal fix that's easy to
>> backport.
>> 
>> cheers
>
> Looks ok, except does it matter that the include used to be only done
> if __powerpc64__ and CONFIG_SMP are defined?

Basically all of paca.h is inside #ifdef CONFIG_PPC64.

SMP "shouldn't matter", but I tested a SMP=n build and it's clean, so I
think it's good. Of course there's really no guarantees with these
header tangles.

cheers
