Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1220C302D54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbhAYVLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:11:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:60333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731970AbhAYVHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611608724;
        bh=sjbOI4xhiYHyjdiqU5WxTIUZ/iRYGETEMKRxSMMCVIc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a6pfJYP7AY2SxcPFkNSMXlu15gkQwVxhmWcniHfNRI6sirqaIS3LvL/qaR001n75f
         CR6DGASnoH06IkzdfP/WFpzZtclsLHu6UQSA82w3q4d04wQHdx2zdKuooNgFn9r0wy
         7DnYFOaGcPcoi/SrB33H420Ds6lqgXrpxSU0OqCU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1lFe2k2be2-00EyJI; Mon, 25
 Jan 2021 22:05:24 +0100
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     John David Anglin <dave.anglin@bell.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
 <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
 <20210125204720.GA28462@ls3530.fritz.box>
 <CAKwvOd=RHb5yQj5kKuvt9BnywNUmRtivPu_qebLG8XXDyr8cCA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <ec7d8302-1040-2161-efaa-4b148caabe3e@gmx.de>
Date:   Mon, 25 Jan 2021 22:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=RHb5yQj5kKuvt9BnywNUmRtivPu_qebLG8XXDyr8cCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h4DQNExUFuQJNVweSm8X9dy/oQ+Y1VCGfZTuvsia+zvdf/FMdaz
 yti7yET9jkqXi3LNisHCxEA5bjiWI1uP0vtZwxwRAx394qO8n1SrdcUBZhyl2YUu2i5T8DR
 vW14FU3leE/9l5PzFSMNcTssZfGbxcHHAprFCSMfcifiU6Qfn1/W3vG0tfWGksZcuaimfpg
 CftVp57VOCHkh3+b0U2Cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MuCR39nhkI0=:NLPlA9VLBfTR4DJZBzoBmm
 8RAkkMxGYrdWaACAGHM2PG5b4tJemRX0wI+GY9oQ1U0UdGwESl91nHayxNnUh8ZbGzqqqKi7f
 uQdsua3gJ/IR8ZgoYcrzb37Ci6yBmSDe6PSjdfS5r7Sf7ZQcEXVfB8zmaVZU8j8T2kGmf8Yym
 Ra2z9/DmbHhlEOgLiCTpJpt7zw2KFJdruGt40oavvd78c8XXrRGMk9Yl0DoEamiNLNRPAR4ph
 PvrYmVynmwbxcHCqPp3ee0XQqFKixC58947/mS4v+aT8nACOSuGiuEFKtOTS/RmaCsCTsFb5n
 05j0BhrI+Gal+6wlBXdqGXwOXE7mUwG2SJY/PV34d1zsDHhvjRJqqCk65yrZxBHrByxDZwZK3
 dBp0j3V7Wg/s5B+eAykmhgeH4Ve+fx6iDRwddC919Y2P+Gom+IhWZtZje56JNj5mHA9h7DGqt
 UTU/v62rWTOCmompUdXgI1lPKMW4Aij/fnAKMjAgrjUxTOD0ISrk07MQP0lBSMOGQ96bMI3At
 /MhNOg8vYAB756mdqjapoHmhzJkEVrllCruuBtguh4vRUAcdpIkLqXDXdseJld2d12wfeI+E+
 n+crnaCptcaRU+joTyjPEQS59VT/N7LbnRFTmEhmIbTMZ3Ec9SCXTbcUP7LdkNDnkWPRdQU9e
 NLUFqS/L/9ClLDyC2G3YiCyS5ykOmzT0i8td4HxMd50yvNbHw8mbCMr35Kv5uOFh3EIYGlyI3
 VY8wBL8XN2H6SvrRjaIMvujtd3JDmKu0IseftfM1h2JbHUx09YJJgGtkaISQ6iqjRDBZb0xKO
 1hwxZpBMOGgD0RGjJtj/BI52fKLHT34kZfAbaFr+O8v9yj6Nx/tR2Qrg/3e7dTvpZt+PPD44M
 jnV2zqW1TlC1Gibo9P0Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:58 PM, Nick Desaulniers wrote:
> On Mon, Jan 25, 2021 at 12:47 PM Helge Deller <deller@gmx.de> wrote:
>>
>>>>> On Sat, Jan 16, 2021 at 6:37 AM kernel test robot <lkp@intel.com> wr=
ote:
>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
>>>>>> head:   1d94330a437a573cfdf848f6743b1ed169242c8a
>>>>>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add=
 PGO and AutoFDO input sections
>>>>>> date:   5 months ago
>>>>>> config: parisc-randconfig-r032-20210116 (attached as .config)
>>>>>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>>>>>> reproduce (this is a W=3D1 build):
>>>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
>>>>>>         chmod +x ~/bin/make.cross
>>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3Deff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/k=
ernel/git/torvalds/linux.git
>>>>>>         git fetch --no-tags linus master
>>>>>>         git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>>>         # save the attached .config to linux build tree
>>>>>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 mak=
e.cross ARCH=3Dparisc
>>>>>>
>>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All errors (new ones prefixed by >>):
>>>>>>
>>>>>>    hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x110): cannot reach =
unknown
>>>>>>    hppa64-linux-ld: mm/memblock.o(.text+0x27c): cannot reach __warn=
_printk
>>>>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xc4): cannot reach=
 printk
>> ....
>>
>> The problem with this .config is, that both CONFIG_MODULES and
>> CONFIG_MLONGCALLS are set to "n".
>> The Kconfig autodetection needs fixing to enable CONFIG_MLONGCALLS in
>> this case.
>>
>>
>> This patch fixes it for me:
>>
>> [PATCH] Require -mlong-calls gcc option for !CONFIG_MODULES
>>
>> When building a kernel without module support, the CONFIG_MLONGCALL
>> option needs to be enabled. This patch fixes the autodetection in the
>> Kconfig script and uses a far call to preempt_schedule_irq() in
>> intr_do_preempt().
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> ---
>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index 78b17621ee4a..278462186ac4 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -202,9 +202,8 @@ config PREFETCH
>>         depends on PA8X00 || PA7200
>>
>>  config MLONGCALLS
>> -       bool "Enable the -mlong-calls compiler option for big kernels"
>> -       default y if !MODULES || UBSAN || FTRACE
>> -       default n
>> +       def_bool y if !MODULES || UBSAN || FTRACE
>> +       bool "Enable the -mlong-calls compiler option for big kernels" =
if MODULES && !UBSAN && !FTRACE
>
> ^ this looks like the same constraints specified twice?  Am I
> understanding that correctly? (I don't understand why this isn't
> specified _once_).

The logic is:
- if (!MODULES || UBSAN || FTRACE) then don't ask and always set to Y,
- otherwise show menu entry but leave default as N.

If this can be done in one line I'm happy to correct it.

Helge
