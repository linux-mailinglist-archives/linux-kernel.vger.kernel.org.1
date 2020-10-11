Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2A28A7FE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbgJKPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:40:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbgJKPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:40:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CB3001F442DD
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
To:     Borislav Petkov <bp@alien8.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?Diego_Elio_Petten=c3=b2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Willy Tarreau <w@1wt.eu>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
Date:   Sun, 11 Oct 2020 17:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201011122020.GA15925@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 11/10/20 14:20, Borislav Petkov wrote:
> On Sun, Oct 11, 2020 at 01:43:44PM +0200, Enric Balletbo i Serra wrote:
>> We're also probably lacking a definition of what normal users mean, because I
>> don't think normal users build their own kernel.
> 
> You'd be surprised.
> 
>> I think that at least X86_AMD_PLATFORM_DEVICE and MFD_INTEL_LPSS_PCI
>> could be common enough to match within the category of needed to run
>> in normal (or common) user mode(s). I can send a patch with only these
>> two options.
> 
> How do you quantify those things are common enough?
> 

How do you quantify those things are NOT common enough? Do you have a number?

I don't have a number, the only I can tell is that both symbols enable support
for I2C, SPI an HS-UART. The AMD one, is found on AMD Carrizo and later
chipsets, the Intel one, is found on Intel Skylake and later. I.e Lots of
laptops need these to have support for the touchpad.

>> But, yes, the main purpose after this patch is the serial console for CI. I saw
>> that there are already some configs with a specific purpose (tiny.config and
>> xen.config). So, I am wondering if would be acceptable support another specific
>> config for CI (i.e kernelci.config). Will it be acceptable?
> 
> Why does this config have to be upstream?

KernelCI is focused on upstream kernel development. KernelCI builds lots of
different versions of the kernel, including stable kernels, and maintainers
trees. It does tests on real hardware, so having a config supporting as much as
possible the x86 hardware that we have in the KernelCI labs will help us to
increase the test coverage and catch more issues.

configs are tied to the kernel version, as one config symbol can be changed,
removed or renamed between kernel versions. Having in a separate project will
imply a maintenance effort for x86 hardware. Note that, for ARM and ARM64
hardware, we don't have this problem because the "normal" defconfigs seems to go
the other way regarding what could be or not in the config. So I think it would
be useful (having it would save hours of maintenance time in a separate project
to test only the x86 hardware).

> Can't your build process
> supply it? 

Yes, it can. As I said, is a matter of maintenance, if we do this we will have a
different workflow for x86 hardware.

Thanks,
 Enric

> Also, can your config be of any use outside of kernel CI?
> 
> Thx.
> 
