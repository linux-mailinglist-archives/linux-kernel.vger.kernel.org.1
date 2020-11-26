Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E302C5D33
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbgKZUlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733025AbgKZUlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:41:07 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B6BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:41:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so3629082wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w6VmA0MSpBNFKGjboKbfCa/RS1kMg4YU1xfmJHUOcVc=;
        b=AIgsjqpKSHy6iapc6qUWhJHXk9u+Nwc98tW17cVqTWiuBOCpFKJaZpwQEDWCESW6xr
         0iiljROZxJuRGRmUFHAaH1o0I/sNmhVoyShowYoaw3F00CV3PJOoFDg34m9tUf2yvVd0
         i/UujVUT8Dz7IVws0tkhRV7l1emZKlAbZccIF7WKte3dZPzzULNEWKbPgnU2OrQ3Z2Cr
         9oIChr6BRPlN8NiA3agWLyOcEXPNg8Fz8eGV5DUDIU0FzgTfahZ91p6KuY/FXlA/mALC
         NaBnnGa09WWPjnkMD32vhePbew0RW6iw+ZNiZ6LEjqsqyWCGzHd5emjEMu5TK5ap3Dwq
         /0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6VmA0MSpBNFKGjboKbfCa/RS1kMg4YU1xfmJHUOcVc=;
        b=hj4iPzl5MpnXMBskDdgYg3ydmYgudSwhJUWKPohP11aIkkCX0VsUsX2jurL4ze4tbT
         yknc50SL9KpG17Bqnl47ZTX5+L2uqONsh6fJ4NIBVoZHCkaI2YLM1lZn4U2YkpunSEaG
         Q3HYX37rkZO5jxaeoRW7l8qc4OF7ltDhLZpCvnykEbogUbc/e34gXv+DWvjgFy/oyvIP
         uJpVnpipVYmhX3HZeP5zJg3sIuboYX9s5/3fJhO4WZhBUEdB8KeAT/i6gxYsTfUuTmgU
         vVBlZXW9NYUi677bCNeTMNHKjwMsqeWBG8pznfYj71JhvRiR8V71BbruO4jdQ1uU3doj
         LNcA==
X-Gm-Message-State: AOAM530Sg8/bkjnaQQWPD0bYwjjJco1U5fobGeTjrZnH7d2fSgWPhCZb
        NLo9sqpAxA+y3+tZjK1Zxw4S7w==
X-Google-Smtp-Source: ABdhPJz+5z7zQSHoNsFLo205RiTl/z0EFCCeqEXT+h/QL8PVpHo2PmiOksSPtmeBdcBQiOBpZlDSNQ==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr5352854wmm.150.1606423265079;
        Thu, 26 Nov 2020 12:41:05 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x4sm10879944wrv.81.2020.11.26.12.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 12:41:04 -0800 (PST)
Subject: Re: [PATCH v2 00/19] Add generic vdso_base tracking
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20201124002932.1220517-1-dima@arista.com>
 <5e315bf6-b03d-e66e-9557-22ece397080e@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <dc2b40ca-003f-2621-48d4-ae4a48e94126@arista.com>
Date:   Thu, 26 Nov 2020 20:41:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5e315bf6-b03d-e66e-9557-22ece397080e@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 11/24/20 6:53 AM, Christophe Leroy wrote:
> 
> 
> Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
>> v2 Changes:
>> - Rename user_landing to vdso_base as it tracks vDSO VMA start address,
>>    rather than the explicit address to land (Andy)
>> - Reword and don't use "new-execed" and "new-born" task (Andy)
>> - Fix failures reported by build robot
>>
>> Started from discussion [1], where was noted that currently a couple of
>> architectures support mremap() for vdso/sigpage, but not munmap().
>> If an application maps something on the ex-place of vdso/sigpage,
>> later after processing signal it will land there (good luck!)
>>
>> Patches set is based on linux-next (next-20201123) and it depends on
>> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
>> on my changes in akpm (fixing several mremap() issues).
> 
> I have a series that cleans up VDSO init on powerpc and migrates powerpc
> to _install_special_mapping() (patch 10 of the series).
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=204396&state=%2A&archive=both
> 
> 
> I'm wondering how we should coordinate with your series for merging.
> 
> I guess your series will also imply removal of arch_unmap() ? see
> https://elixir.bootlin.com/linux/v5.10-rc4/source/arch/powerpc/include/asm/mmu_context.h#L262

I think our series intersect only in that moment where I re-introduce
arch_setup_additional_pages() parameters. So, in theory we could
minimize the conflicts by merging both series in parallel and cleanup
the result by moving to generic vdso_base on the top, what do you think?

Thanks,
          Dmitry
