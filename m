Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70102C5E57
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 00:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392037AbgKZXx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 18:53:26 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:47324 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392000AbgKZXxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1606434804;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SLCqDVANdN37IdpKE2EPB96P4WCdxVYJYzL//A+bO6c=;
  b=JULIwyseuDdN1N7n1ihKQvxYxut2FPTeh+Q1sSJkqWHbIHtEEM3MrY8k
   gkM9KZrGOMJIU/vNuRSY+GDY6b5eNJA3ICGyx/x5HifySlLCfyhhHP33C
   elgQ/IwTxE/LNI1RXQBRA66pxMAnvthmwpq5ug3tdSZSrUD7TiqV9ISVd
   U=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: Iw9tRvlxv26rSHbSTrCrHFZS+53Gad/KgOYmH6NGCIbJMA7M0HPQwfWvtiMAKBoPTFUnKNx0I1
 6GPp/2JQqwyFG8wVDwPA3oMDdYu8NwhpvNCwxIi2JIb5Jh7DyqFzcWJQi6WiS/3wiV2Cucpvc0
 BxGlm4EB8pPXM38rkYs6aguJXiiD0mrU5VkksDBbnxGq6ffkqLMkKKlT607ItHWicJVgjpd2Aj
 OXRxM40hBg0e3LeqhKKljQnGdRccjKrJumEijdww8rr/PswB82S5P8GaehwYdGqwuyjpnwcXnw
 VH4=
X-SBRS: None
X-MesageID: 32241856
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.78,373,1599537600"; 
   d="scan'208";a="32241856"
Subject: Re: [PATCH] x86/cpu: correct values for GDT_ENTRY_INIT
To:     Andy Lutomirski <luto@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201126115459.28980-1-lukas.bulwahn@gmail.com>
 <947b02eb-536f-16a0-fbb1-87b62ab8c13e@citrix.com>
 <CAKXUXMybmC=JE3uDnekAuHfRUZcrzSLJ04xB3nR=3BqHCsNVqA@mail.gmail.com>
 <CALCETrUyoaJyJ8mGpq9bdanKKfHgjg_1B=N0rtmuHCmCP9Q9=g@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <3d9f41b1-9687-4aae-ad7d-2e38a33132ba@citrix.com>
Date:   Thu, 26 Nov 2020 23:52:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUyoaJyJ8mGpq9bdanKKfHgjg_1B=N0rtmuHCmCP9Q9=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL04.citrite.net (10.13.108.177)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2020 19:15, Andy Lutomirski wrote:
> On Thu, Nov 26, 2020 at 11:07 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>> On Thu, Nov 26, 2020 at 6:16 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>>> On 26/11/2020 11:54, Lukas Bulwahn wrote:
>>>> Commit 1e5de18278e6 ("x86: Introduce GDT_ENTRY_INIT()") unintentionally
>>>> transformed a few 0xffff values to 0xfffff (note: five times "f" instead of
>>>> four) as part of the refactoring.
>>> The transformation in that change is correct.
>>>
>>> Segment bases are 20 bits wide in x86,

I of course meant segment limits here, rather than bases.

>>> Does:
>>>
>>> diff --git a/arch/x86/include/asm/desc_defs.h
>>> b/arch/x86/include/asm/desc_defs.h
>>> index f7e7099af595..9561f3c66e9e 100644
>>> --- a/arch/x86/include/asm/desc_defs.h
>>> +++ b/arch/x86/include/asm/desc_defs.h
>>> @@ -22,7 +22,7 @@ struct desc_struct {
>>>
>>>  #define GDT_ENTRY_INIT(flags, base, limit)                     \
>>>         {                                                       \
>>> -               .limit0         = (u16) (limit),                \
>>> +               .limit0         = (u16) (limit) & 0xFFFF,       \
>>>                 .limit1         = ((limit) >> 16) & 0x0F,       \
>>>                 .base0          = (u16) (base),                 \
>>>                 .base1          = ((base) >> 16) & 0xFF,        \
>>>
>>> fix the warning?
>>>
>> Thanks, I will try that out, and try compiling a 32-bit kernel as well.
> You should also try comparing the objdump output before and after your
> patch.  objdump -D will produce bizarre output but should work.

Expanding on this a little, if that does indeed fix the sparse warning,
then I'd make an argument for this being a bug in sparse.  Explicitly
casting to u16 is semantically and intentionally identical to & 0xffff.

~Andrew
