Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3414C2DB1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgLOQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgLOQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:43:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5EC06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3T7s0daYmgzQ5E9IT4KzpXTrZSv/LE95qskLUzM8hIs=; b=A0DKZ2/4atzxbGBUnIxfvjZ3GI
        Nr6vtkmk3syL9+3KuZdxTjo9BQw1680Ps9CLNU+1OZtzmibYCKMu4Sj/kZwv6OfdiJ3fM+fbdcboW
        aBC9tWcqxs5ue3s+iCEz8LVHRmqlvk0l3ODRlOcSRkplEEySoJyUuZMRBPiRHix0uJrv9TO2ihVIG
        tExCCcqgr5hZbEU6N7Pd+BOw60R4uT1MF7PklInNQExodW16kDokalp9YQLgoECLdIk0Semh+DKF0
        qJdTpr/fqiKSywoAbYs6cOa46KZr5Bwm3KRUzCQv8nMUNFXbNNNLbZAIMKokKdPtXGZIQKrGy3hrw
        I/Tzypbg==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpDOz-0003Oq-Me; Tue, 15 Dec 2020 16:42:17 +0000
Subject: Re: [PATCH] arch: x86: entry: vdso: fix type conversion on printf()
 call
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <20201215160314.18773-1-info@metux.net>
 <41ef1cd1-017d-a0d4-91d3-a1183bd2ab01@infradead.org>
 <CALCETrXhZxyPUcrBaO=mzvANC72uXNBrivo7hGmdkV2bgdFxjw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1297989c-6a9e-0804-82a5-d55cc7502b77@infradead.org>
Date:   Tue, 15 Dec 2020 08:42:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXhZxyPUcrBaO=mzvANC72uXNBrivo7hGmdkV2bgdFxjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 8:39 AM, Andy Lutomirski wrote:
> On Tue, Dec 15, 2020 at 8:32 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 12/15/20 8:03 AM, Enrico Weigelt, metux IT consult wrote:
>>> Fixing the following compiler warning by explicit conversion to long:
>>>
>>> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:162:0:
>>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
>>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
>>>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>>>                                                     ^
>>>   CC      mm/filemap.o
>>> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:166:0:
>>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
>>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
>>>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>>>
>>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>>> ---
>>>  arch/x86/entry/vdso/vdso2c.h | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Hi,
>>
>> size_t is normally printed with %zu.
>> Is there some reason that isn't being used here?
> 
> No.  Want to send a patch?
> 

I was hoping that Enrico would fix this and maybe address your other comment,
although I'm not so sure that I agree with it.

-- 
~Randy

