Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059D12FE67B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbhAUJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:37:31 -0500
Received: from cmyk.emenem.pl ([217.79.154.63]:37580 "EHLO smtp.emenem.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728673AbhAUJal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:30:41 -0500
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (50-78-106-33-static.hfc.comcastbusiness.net [50.78.106.33])
        (authenticated bits=0)
        by cmyk.emenem.pl (8.15.2/8.15.2) with ESMTPSA id 10L9TPgd010680
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 21 Jan 2021 10:29:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
        t=1611221369; bh=Lq22v3RkUxykYRJ6+6won8Dh0Xg+coKzvzR7UFLaOq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gvwdg0mYxYF6epudhRb/4HyXhJpyXYsKV0HFgTgRtCY5rjRKVX5ewTPswTFxWbFo4
         wlyvcNnzoF/pq7jH8sZwW9vl2R+D1XNlkYrCF5ZhaOWl8ALKCzM8mlej0lpluUFNW1
         gWUq3l7y7ppvper7MabC2wJI8JX5AeDWXIC4dgJs=
Subject: Re: [PATCH v3 0/4] x86/fpu: Reduce unnecessary FNINIT and MXCSR usage
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1611205691.git.luto@kernel.org>
From:   =?UTF-8?Q?Krzysztof_Ol=c4=99dzki?= <ole@ans.pl>
Message-ID: <3e54439d-24cf-8b9d-6b5a-efb756f3a5be@ans.pl>
Date:   Thu, 21 Jan 2021 01:29:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1611205691.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 at 21:09, Andy Lutomirski wrote:
> This series fixes two regressions: a boot failure on AMD K7 and a
> performance regression on everything.
> 
> I did a double-take here -- the regressions were reported by different
> people, both named Krzysztof :)
> 
> Changes from v2:
>   - Tidy up the if statements (Sean)
>   - Changelog and comment improvements (Boris)
> 
> Changes from v1:
>   - Fix MMX better -- MMX really does need FNINIT.
>   - Improve the EFI code.
>   - Rename the KFPU constants.
>   - Changelog improvements.
> 
> Andy Lutomirski (4):
>    x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
>    x86/mmx: Use KFPU_387 for MMX string operations
>    x86/fpu: Make the EFI FPU calling convention explicit
>    x86/fpu/64: Don't FNINIT in kernel_fpu_begin()

Hi Andy,

I have tested the new patchset on the following CPUs running 5.4.90
(with some adjustments required for it to apply) and 5.10.9 kernels:
  - AMD Phenom(tm) II X3 B77 Processor (family: 0x10, model: 0x4, stepping: 0x3)
  - Intel(R) Xeon(R) CPU 3070  @ 2.66GHz (family: 0x6, model: 0xf, stepping: 0x6)
  - Intel(R) Xeon(R) CPU E3-1280 V2 @ 3.60GHz (family: 0x6, model: 0x3a, stepping: 0x9)

For all of them, it was possible to recover most of the performance lost
due to the introduction of "Reset MXCSR to default in kernel_fpu_begin":
  - B77: 90% instead of 82% for prefetch64-sse, 92% instead of 84% for generic_sse
  - 3070: 93% instead of 86% for prefetch64-sse, 93% instead of 88% for generic_sse
  - 1280v2: 99% instead of 88% for prefetch64-sse, 99% instead of 88% for generic_sse.

For some reason, 1280v2 (Ivy Bridge) sees almost no regression for
prefetch64-sse and generic_sse. The only issue is that AVX is still at
67% of its original performance. This is of course better compared to
60%. There is no AVX on the other 2 CPUs.

I was using 64 bit kernels for testing, please let me know if 32 bit
is also needed.

Tested-by: Krzysztof Piotr Olędzki <ole@ans.pl>

Thanks,
  Krzysztof

