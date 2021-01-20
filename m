Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E972FCC34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbhATH60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:58:26 -0500
Received: from cmyk.emenem.pl ([217.79.154.63]:34474 "EHLO smtp.emenem.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730282AbhATH4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:56:52 -0500
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (50-78-106-33-static.hfc.comcastbusiness.net [50.78.106.33])
        (authenticated bits=0)
        by cmyk.emenem.pl (8.15.2/8.15.2) with ESMTPSA id 10K7pY7U020705
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 20 Jan 2021 08:51:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
        t=1611129098; bh=UKvDotcD+dWv0G1iUeqG4pW8YJnJrX7YOEAsqojYKLY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Etg5C7FKQ3TBVFDspkZuyk/OMPGILLDnupPNN7jL6pxot+yDkfQf/a0kjgHmbAumv
         pD1zAUBkJbH+n7ymEb5yPx00Niu1LDSxmKpgkDi3zSsheWRg9ZkQKyvsTi+X84+fMj
         IGEq5fZeM2SQXysbtP+hfz080P5coBKczbgGEfbg=
Subject: Re: [PATCH v2 0/4] x86/fpu: Reduce unnecessary FNINIT and MXCSR usage
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1611077835.git.luto@kernel.org>
From:   =?UTF-8?Q?Krzysztof_Ol=c4=99dzki?= <ole@ans.pl>
Message-ID: <e4b495a8-a23a-3c8c-e9c0-3f23b21d41a4@ans.pl>
Date:   Tue, 19 Jan 2021 23:51:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1611077835.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-19 at 09:38, Andy Lutomirski wrote:
> This series fixes two regressions: a boot failure on AMD K7 and a
> performance regression on everything.
> 
> I did a double-take here -- the regressions were reported by different
> people, both named Krzysztof :)
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

Hi Andy.

I have quickly tested the new version on E3-1280 V2.

* 5.10.9 + 7ad816762f9bf89e940e618ea40c43138b479e10 reverted (aka unfixed)
xor: measuring software checksum speed
    avx             : 38616 MB/sec
    prefetch64-sse  : 25797 MB/sec
    generic_sse     : 23147 MB/sec
xor: using function: avx (38616 MB/sec)

* 5.10.9 (the original)
xor: measuring software checksum speed
    avx             : 23318 MB/sec
    prefetch64-sse  : 22562 MB/sec
    generic_sse     : 20431 MB/sec
xor: using function: avx (23318 MB/sec)

* 5.10.9 + "Reduce unnecessary FNINIT and MXCSR usage" v2
xor: measuring software checksum speed
    avx             : 26451 MB/sec
    prefetch64-sse  : 25777 MB/sec
    generic_sse     : 23178 MB/sec
xor: using function: avx (26451 MB/sec)

Overall, kernel xor benchmark reports better performance on 5.10.9 than 
on 5.4.90 (see my prev e-mail), but the general trend is the same.

The "unfixed" kernel is much faster for all of avx, prefetch64-sse and 
generic_sse. With the fix, we see the expected perf regression.

Now, with your patchset, both prefetch64-sse and generic_sse are able to 
recover the full performance, as seen on 5.4. However, this is not the 
case for avx. While there is still an improvement, it is nowhere close 
to where it used to be.

I wonder why AVX still sees a regression and if anything more can be 
done about it?

Will do more tests tomorrow.

Thanks,
  Krzysztof
