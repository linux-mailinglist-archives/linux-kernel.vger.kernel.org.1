Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5C2F9B57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbhARIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:33:21 -0500
Received: from cmyk.emenem.pl ([217.79.154.63]:36392 "EHLO smtp.emenem.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbhARIdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:33:15 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 03:33:14 EST
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (50-78-106-33-static.hfc.comcastbusiness.net [50.78.106.33])
        (authenticated bits=0)
        by cmyk.emenem.pl (8.15.2/8.15.2) with ESMTPSA id 10I8PIpg000982
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 18 Jan 2021 09:25:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
        t=1610958323; bh=kjJTObn3SNG9Ne0tArY10Alh9eMqJqgn6mocqk1M0Fw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K9OnKgYAh5vzz99nWk4BwwLTddiIk+iVQwwLyss/HMCFP0snaQJ6tgbincKacC6ZA
         79o37AV8YfXFtbcEtP54Ablg76LsrXz+E7Vtmh7/IXj5RXzYhqZoHbP6S6jC022cVB
         uudMTDKBZTUpjvFt95R2rsZW/c81vZW0JGryznq4=
Subject: Re: [PATCH 0/4] x86/fpu: Reduce unnecessary FNINIT and MXCSR usage
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1610950681.git.luto@kernel.org>
From:   =?UTF-8?Q?Krzysztof_Ol=c4=99dzki?= <ole@ans.pl>
Message-ID: <5162ba3a-0b4c-a295-44dd-7ea2f17ca74d@ans.pl>
Date:   Mon, 18 Jan 2021 00:25:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1610950681.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-17 at 22:20, Andy Lutomirski wrote:
> This series fixes two regressions: a boot failure on AMD K7 and a
> performance regression on everything.
> 
> I did a double-take here -- the regressions were reported by different
> people, both named Krzysztof :)
> 
> Andy Lutomirski (4):
>    x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
>    x86/mmx: Use KFPU_MMX for MMX string operations
>    x86/fpu: Make the EFI FPU calling convention explicit
>    x86/fpu/64: Don't FNINIT in kernel_fpu_begin()

Thank you so much Andy!

What a coincidence! Sadly, my AMD K7 is sitting somewhere in a closet, 
on a different continent, and was running Linux for the last time over 
10 years ago. :/ However, I can offer some testing on different AMD & 
Intel CPUs.

Now... It is 12 AM here so I tested it very quickly only on 5.4-stable, 
where I initially noticed the problem. The patch applies almost cleanly 
in this release, almost as arch/x86/platform/efi/efi_64.c does not have 
kernel_fpu_begin() call to update. The kernel complies and boots.

Here is the result for:
  Intel(R) Xeon(R) CPU E3-1280 V2 @ 3.60GHz (family: 0x6, model: 0x3a, 
stepping: 0x9)

5.4-stable (with "Reset MXCSR to default in kernel_fpu_begin"):
     avx       : 21072.000 MB/sec
     prefetch64-sse: 20392.000 MB/sec
     generic_sse: 18572.000 MB/sec
xor: using function: avx (21072.000 MB/sec)

5.4-stable-c4db485dd3f2378b4923503aed995f7816e265b7-revert:
     avx       : 33764.000 MB/sec
     prefetch64-sse: 23432.000 MB/sec
     generic_sse: 21036.000 MB/sec
xor: using function: avx (33764.000 MB/sec)

5.4-stable-kernel_fpu_begin_mask:
    avx       : 23576.000 MB/sec
    prefetch64-sse: 23024.000 MB/sec
    generic_sse: 20880.000 MB/sec
xor: using function: avx (23576.000 MB/sec)

So, the performance regression for prefetch64-sse and generic_sse is 
almost gone, but the AVX code is still impacted. Not as much as before, 
but still noticeably, and it is now barely better than fixed prefetch64-sse.

I'm going to test the patches on 5.10 / 5.11-rc to make sure what I have 
seen on 5.4 is not due to wrong backporting, and on different CPUs. 
However, this may have to wait until Tuesday / Wednesday due to family 
duties, as Monday is a holiday here.

Best regards,
  Krzysztof Olędzki
