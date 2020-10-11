Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBF28A740
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbgJKLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 07:43:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60456 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbgJKLns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 07:43:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 16EBE1F4102B
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
To:     Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
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
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
Date:   Sun, 11 Oct 2020 13:43:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav and Randy,

Thank you for your comments.

On 8/10/20 20:31, Randy Dunlap wrote:
> On 10/8/20 9:40 AM, Borislav Petkov wrote:
>> On Thu, Oct 08, 2020 at 06:22:06PM +0200, Enric Balletbo i Serra wrote:
>>> As part of KernelCI, we added a bunch of different x86 based Chromebooks
>>> to do test booting and runtime testing. It will be useful have serial
>>> support for these platforms in the default defconfig, as this, is the
>>> defconfig used by default for the different maintainer's tree.
>>>
>>> SERIAL_8250_DW is the actual support for the console, but to have
>>> support we need to enable X86_AMD_PLATFORM_DEVICE for specific AMD
>>> boards and MFD_INTEL for specific Intel boards.
>>>
>>> While here, also enable USB_RTL8152 config which enables a common
>>> USB-Ethernet adapter used very commonly in the KernelCI labs.
>>
>> To me defconfig sounds like the config which contains items which are
>> needed on the majority of x86 hardware out there.
> 
> to run in normal (or common) user mode(s).
> 
> Nothing to do with automated testing like syzbot or CI IMO.
> 
>> Are those which you enable that common and if not, why can't your build
>> supply a custom .config instead?
> 
> I suppose that we are lacking a definition of a defconfig, but again, IMO,
> these Kconfig symbols don't meet the need for normal users.
> 
> 

We're also probably lacking a definition of what normal users mean, because I
don't think normal users build their own kernel. I think that at least
X86_AMD_PLATFORM_DEVICE and MFD_INTEL_LPSS_PCI could be common enough to match
within the category of needed to run in normal (or common) user mode(s). I can
send a patch with only these two options.

But, yes, the main purpose after this patch is the serial console for CI. I saw
that there are already some configs with a specific purpose (tiny.config and
xen.config). So, I am wondering if would be acceptable support another specific
config for CI (i.e kernelci.config). Will it be acceptable?

Thanks,
 Enric
