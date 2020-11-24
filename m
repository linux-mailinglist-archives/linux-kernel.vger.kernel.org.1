Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD74C2C1E02
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgKXGOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:14:47 -0500
Received: from mout.web.de ([212.227.15.14]:48969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKXGOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606198470;
        bh=kc8NZOzMjf8/Ea0pSSpZ0r1QV6ULWIeuijdtJHKd8Ik=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FoSztPqd3fevTy4+RWOtC1Geevg1DnSbbbe7d2JFsRrqxpXtDWUrnckORUWwYBOig
         bBu/yvhb/o8XiI3tNhlQHhd8ngtOYHuHeBKB17/l0jXFW50GeX8of3BN85fZB/WHQZ
         MLAvfcBCC7AXCeM+8cKgRksd8QpWW6O8vvF/92ww=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.0.0.110] ([193.36.117.236]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0yzv-1kNJBB1HN1-00v40H; Tue, 24
 Nov 2020 07:14:30 +0100
Subject: Re: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen
 of Google Chromebook "samus"
To:     "Wang, Jiada" <jiada_wang@mentor.com>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        linux-kernel@vger.kernel.org
References: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
 <beae40be-4e84-ceea-ee00-351b18b26e06@mentor.com>
 <69305cdf-1ba7-a51a-302c-9b1b83e788aa@web.de>
 <e1d1c27e-3c02-d29c-7bf4-2b302a292e70@mentor.com>
From:   Andre Muller <andre.muller@web.de>
Message-ID: <fd717b9c-f363-d8e8-87e9-d967bd514cd4@web.de>
Date:   Tue, 24 Nov 2020 07:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <e1d1c27e-3c02-d29c-7bf4-2b302a292e70@mentor.com>
Content-Type: multipart/mixed;
 boundary="------------89B995608454B72526344E2F"
Content-Language: en-US
X-Provags-ID: V03:K1:GJMrkhrHue1j0lXM6OBGtU6fj3+W1QgcnyYggbBP0eTV9Yr3LM7
 vYGfPh9bH3YFYo8fBSOnqvx+uHK5yIovYsleQGiRfnb//ONdG9ign2f+p/mrVCopkHZFKeD
 LvP5YSqKFO7ummZCmSuXsIFPvznh7WAsU8Y1XF0zw3aCafVpkUWDrrEEyW4ztvmd6qINu8/
 VxPbS6xJQy++Vgo97SZZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CRamVNpFXwU=:F5UfAhlFzaXjBxNfEZ3+XH
 wNKQRLKXxkRpa/yT2Wed7hiJaAICJ4cDrMVJaFuCapScqc1BO/zzvjLzDCbvbLIQPCOecrM0U
 IpDw3I9Jcn02C0EQ148pnjNGacJR2Fq3HIsJV5HatWW0g41zfbspjcQjjCdekDELQ6Sitvm4K
 o5pGUkzIvvpRYOnbVE0PqwuYWBN/+KPm2NvP8BoJmz5Kjv4CECW98Yew0BGBpH1FJA9oGuRU2
 fsiwrWq7cSafW4oAAxMxJk4NIgB6YL6veeCFdd6NnHjNi0siNPLWEdodOSwGhplWItBmP9Tzo
 eYvqQM+1eGERWC9gtiyFR5n905WkRzmxHA2qVHhEgok22zIYsDAEsKgPoVaSUzKf+b8BfHqbz
 mNwLh7xv9X+Aq+CDtSf8lmv1qwPO+UGXABS5xJdCW+XXH24lUwzm0MHcnupGuXw48oILAtp/d
 QvT4N4Q54Fe+LcBkR5ivy7wQAbsDWWULjSAgj6f2AjH0ddW7fo+ibhjxAWLsHBvAEh+wEfbX+
 1zXhbSR0RmfzuDo01sXd64HxusdTbsCghGYn6dkmW+5pWRFSnPTb6g4jgUJSbZycu3kN+cEBc
 cXybu+f7lQJ4R7NsE9+dGTG7Kj38QSfAEfvflZZk2KVH+lVENNwd/QMFv3DLWecHZSDrqP14s
 j/GJX6yVz9YYRxZcm/3mXg3aaBcDARpPdjcfrM3K7lHK0uj/v8ch3o3o6W0ZA2VycIJZdDtiX
 3OsCsPo76XM4DDJoJxudhXj+MMZooty6Z5B2YwuphJo/KBHhYRbOencUhtI/ku8UsyvhxOC6g
 FWL0zI0XMnq2GlP9V5VQb37g/lHrRx9xP2+g547p4QzMe4ysoWR7G0m8XgjrcagpCUW3TaouB
 B2RKFNEGWo5XLZqZ7x5g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------89B995608454B72526344E2F
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 24/11/2020 04.02, Wang, Jiada wrote:
> Hello Andre
>
> Thanks for the log,
> can you add more debug information like following diff,
> and get full log?

Hi Jiada,

I added the warnings, but none of them triggers.
I double-checked the generated object file, it includes the debug strings.
(Also tested that touchscreen/touchpad don't work, as expected.)

Please find the full log attached.

Thank you,
Andre


>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/to=
uchscreen/atmel_mxt_ts.c
> index 98f17fa3a892..60bccd5c42f6 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1298,21 +1298,29 @@ static int mxt_check_retrigen(struct mxt_data *d=
ata)
>  =A0=A0=A0=A0=A0=A0=A0 data->use_retrigen_workaround =3D false;
>
>  =A0=A0=A0=A0=A0=A0=A0 irqd =3D irq_get_irq_data(data->irq);
> -=A0=A0=A0=A0=A0=A0 if (!irqd)
> +=A0=A0=A0=A0=A0=A0 if (!irqd) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(&client->dev, "unab=
le to get IRQ data\n");
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> +=A0=A0=A0=A0=A0=A0 }
>
> -=A0=A0=A0=A0=A0=A0 if (irqd_is_level_type(irqd))
> +=A0=A0=A0=A0=A0=A0 if (irqd_is_level_type(irqd)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(&client->dev, "IRQ =
is level type\n");
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> +=A0=A0=A0=A0=A0=A0 }
>
>  =A0=A0=A0=A0=A0=A0=A0 if (data->T18_address) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error =3D __mxt_read_reg(=
client,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->T18_address + MXT_COMM=
S_CTRL,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1, &val);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (error)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (error) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_=
warn(&client->dev, "failed to read reg: MXT_COMMS_CTRL\n");
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn error;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val & MXT_COMMS_RETRIGEN=
)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val & MXT_COMMS_RETRIGEN=
) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_=
warn(&client->dev, "RETRIGEN feature available\n");
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0 }
>
>  =A0=A0=A0=A0=A0=A0=A0 dev_warn(&client->dev, "Enabling RETRIGEN workaro=
und\n");
>
>
> Thanks,
> Jiada
>
> On 2020/11/05 23:23, Andre Muller wrote:
>> On 05/11/2020 14.25, Wang, Jiada wrote:
>>> Hi Andre
>>>
>>> Thanks for your report,
>>> could you also please post the log when with this commit reverted?
>>>
>>> Thanks,
>>> Jiada
>>
>> Shure!
>> The full dmesg with the revert is attached.
>>
>> The atmel_mxt bits are:
>>
>> [=A0=A0=A0 0.195879] atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant:=
 17 Firmware V1.0.AA Objects: 32
>> [=A0=A0=A0 0.211712] atmel_mxt_ts i2c-ATML0000:01: Direct firmware load=
 for maxtouch.cfg failed with error -2
>> [=A0=A0=A0 0.212986] atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X96=
0Y540
>> [=A0=A0=A0 0.213025] input: Atmel maXTouch Touchpad as /devices/pci0000=
:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
>> [=A0=A0=A0 0.219208] atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant:=
 13 Firmware V1.0.AA Objects: 41
>> [=A0=A0=A0 0.238825] atmel_mxt_ts i2c-ATML0001:01: Direct firmware load=
 for maxtouch.cfg failed with error -2
>> [=A0=A0=A0 0.238949] intel_rapl_common: Found RAPL domain package
>> [=A0=A0=A0 0.238955] intel_rapl_common: Found RAPL domain core
>> [=A0=A0=A0 0.238961] intel_rapl_common: Found RAPL domain uncore
>> [=A0=A0=A0 0.238966] intel_rapl_common: Found RAPL domain dram
>> [=A0=A0=A0 0.240121] atmel_mxt_ts i2c-ATML0001:01: Touchscreen size X25=
59Y1699
>> [=A0=A0=A0 0.240157] input: Atmel maXTouch Touchscreen as /devices/pci0=
000:00/INT3433:00/i2c-1/i2c-ATML0001:01/input/input5
>>
>> Regards,
>> Andre
>>
>>>
>>> On 2020/11/04 17:13, Andre wrote:
>>>> Hi,
>>>>
>>>> commit 74d905d2: Input: atmel_mxt_ts - only read messages in
>>>> mxt_acquire_irq() when necessary
>>>>
>>>> breaks the touchpad and touchscreen of the 2015 Chromebook Pixel "Sam=
us".
>>>>
>>>> Reverting the commit from the current git tree gets them to work agai=
n.
>>>>
>>>> I am not at all shure what info to include, but I will happily provid=
e
>>>> it on request.
>>>>
>>>> The dmesgs of a boot with commit 74d905d2 show "Enabling RETRIGEN
>>>> workaround", but otherwise looks the same as a boot without.
>>>>
>>>> Here is the relevant bit (with 74d905d2):
>>>>
>>>> atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmware V1.0.A=
A
>>>> Objects: 32
>>>> atmel_mxt_ts i2c-ATML0000:01: Enabling RETRIGEN workaround
>>>> atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxtouch.cfg
>>>> failed with error -2
>>>> atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
>>>> input: Atmel maXTouch Touchpad as
>>>> /devices/pci0000:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
>>>> atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmware V1.0.A=
A
>>>> Objects: 41
>>>> atmel_mxt_ts i2c-ATML0001:01: Enabling RETRIGEN workaround
>>>> atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxtouch.cfg
>>>> failed with error -2
>>>>
>>>> Thank you,
>>>> Andre M=FCller
>>


--------------89B995608454B72526344E2F
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_with_atmel-debug"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg_with_atmel-debug"

[    0.000000] microcode: microcode updated early to revision 0x2f, date =
=3D 2019-11-12
[    0.000000] Linux version 5.9.3+ (kernelbob@monty) (gcc (Gentoo 9.3.0-r=
1 p3) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #23 SMP Tue Nov 24 06:54:25 C=
ET 2020
[    0.000000] Command line: BOOT_IMAGE=3Dknown_good root=3D802
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poin=
t registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 b=
ytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usab=
le
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ce27fff] usab=
le
[    0.000000] BIOS-e820: [mem 0x000000007ce28000-0x000000007fffffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed84fff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027effffff] usab=
le
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: GOOGLE Samus, BIOS  04/02/2015
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2194.903 MHz processor
[    0.000303] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> res=
erved
[    0.000304] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000308] last_pfn =3D 0x27f000 max_arch_pfn =3D 0x400000000
[    0.000312] MTRR default type: uncachable
[    0.000313] MTRR fixed ranges enabled:
[    0.000314]   00000-9FFFF write-back
[    0.000315]   A0000-BFFFF uncachable
[    0.000315]   C0000-FFFFF write-back
[    0.000316] MTRR variable ranges enabled:
[    0.000317]   0 base 0000000000 mask 7F80000000 write-back
[    0.000318]   1 base 007D800000 mask 7FFF800000 uncachable
[    0.000319]   2 base 007E000000 mask 7FFE000000 uncachable
[    0.000320]   3 base 00D0000000 mask 7FF0000000 write-combining
[    0.000320]   4 base 00FF800000 mask 7FFF800000 uncachable
[    0.000321]   5 base 0100000000 mask 7F00000000 write-back
[    0.000322]   6 base 0200000000 mask 7F80000000 write-back
[    0.000322]   7 base 027F000000 mask 7FFF000000 uncachable
[    0.000323]   8 disabled
[    0.000323]   9 disabled
[    0.000632] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- W=
T
[    0.000981] last_pfn =3D 0x7ce28 max_arch_pfn =3D 0x400000000
[    0.000990] Using GB pages for direct mapping
[    0.001169] ACPI: Early table checksum verification disabled
[    0.001171] ACPI: RSDP 0x00000000000F7B40 000024 (v02 CORE  )
[    0.001175] ACPI: XSDT 0x000000007CF440E0 00004C (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001180] ACPI: FACP 0x000000007CF48970 0000F4 (v05 CORE   COREBOOT 0=
0000000 CORE 00000001)
[    0.001184] ACPI: DSDT 0x000000007CF44250 004720 (v02 COREv4 COREBOOT 2=
0110725 INTL 20130117)
[    0.001187] ACPI: FACS 0x000000007CF44210 000040
[    0.001190] ACPI: FACS 0x000000007CF44210 000040
[    0.001192] ACPI: HPET 0x000000007CF48A70 000038 (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001195] ACPI: APIC 0x000000007CF48AB0 00006C (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001198] ACPI: MCFG 0x000000007CF48B20 00003C (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001200] ACPI: SSDT 0x000000007CF49BC0 000FF8 (v02 CORE   COREBOOT 0=
000002A CORE 0000002A)
[    0.001207] ACPI: Local APIC address 0xfee00000
[    0.001243] No NUMA configuration found
[    0.001244] Faking a node at [mem 0x0000000000000000-0x000000027effffff=
]
[    0.001247] NODE_DATA(0) allocated [mem 0x27effe000-0x27effffff]
[    0.001258] Zone ranges:
[    0.001259]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001260]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001262]   Normal   [mem 0x0000000100000000-0x000000027effffff]
[    0.001263] Movable zone start for each node
[    0.001264] Early memory node ranges
[    0.001265]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.001267]   node   0: [mem 0x0000000000100000-0x000000007ce27fff]
[    0.001268]   node   0: [mem 0x0000000100000000-0x000000027effffff]
[    0.001394] Zeroed struct page in unavailable ranges: 16954 pages
[    0.001395] Initmem setup node 0 [mem 0x0000000000001000-0x000000027eff=
ffff]
[    0.001397] On node 0 totalpages: 2080198
[    0.001397]   DMA zone: 64 pages used for memmap
[    0.001398]   DMA zone: 21 pages reserved
[    0.001399]   DMA zone: 3998 pages, LIFO batch:0
[    0.001422]   DMA32 zone: 7929 pages used for memmap
[    0.001423]   DMA32 zone: 507432 pages, LIFO batch:63
[    0.005094]   Normal zone: 24512 pages used for memmap
[    0.005095]   Normal zone: 1568768 pages, LIFO batch:63
[    0.016593] Reserving Intel graphics memory at [mem 0x7e000000-0x7fffff=
ff]
[    0.016800] ACPI: PM-Timer IO Port: 0x1008
[    0.016802] ACPI: Local APIC address 0xfee00000
[    0.016817] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0=
-39
[    0.016819] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.016821] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.016822] ACPI: IRQ0 used by override.
[    0.016823] ACPI: IRQ9 used by override.
[    0.016824] Using ACPI (MADT) for SMP configuration information
[    0.016826] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.016829] TSC deadline timer available
[    0.016830] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.016840] [mem 0x80000000-0xefffffff] available for PCI devices
[    0.016843] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.020859] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_n=
ode_ids:1
[    0.021079] percpu: Embedded 41 pages/cpu s138648 r0 d29288 u524288
[    0.021083] pcpu-alloc: s138648 r0 d29288 u524288 alloc=3D1*2097152
[    0.021084] pcpu-alloc: [0] 0 1 2 3
[    0.021095] Built 1 zonelists, mobility grouping on.  Total pages: 2047=
672
[    0.021096] Policy zone: Normal
[    0.021098] Kernel command line: root=3D/dev/sda2 rfkill.default_state=
=3D0 mitigations=3Dauto,nosmt
[    0.021743] Dentry cache hash table entries: 1048576 (order: 11, 838860=
8 bytes, linear)
[    0.022048] Inode-cache hash table entries: 524288 (order: 10, 4194304 =
bytes, linear)
[    0.022082] mem auto-init: stack:__user(zero), heap alloc:off, heap fre=
e:off
[    0.047453] Memory: 8085824K/8320792K available (12291K kernel code, 61=
9K rwdata, 3548K rodata, 908K init, 1200K bss, 234708K reserved, 0K cma-re=
served)
[    0.047489] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, =
Nodes=3D1
[    0.047493] Kernel/User page tables isolation: enabled
[    0.047544] rcu: Hierarchical RCU implementation.
[    0.047545] rcu: 	RCU event tracing is enabled.
[    0.047547] rcu: RCU calculated value of scheduler-enlistment delay is =
30 jiffies.
[    0.047557] NR_IRQS: 4352, nr_irqs: 728, preallocated irqs: 16
[    0.047831] random: get_random_bytes called from start_kernel+0x2d4/0x4=
25 with crng_init=3D0
[    0.048130] Console: colour dummy device 320x106
[    0.048212] printk: console [tty0] enabled
[    0.048225] ACPI: Core revision 20200717
[    0.048280] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,=
 max_idle_ns: 133484882848 ns
[    0.048291] APIC: Switch to symmetric I/O mode setup
[    0.048860] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
[    0.064961] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles=
: 0x1fa36414070, max_idle_ns: 440795290854 ns
[    0.064966] Calibrating delay loop (skipped), value calculated using ti=
mer frequency.. 4391.71 BogoMIPS (lpj=3D7316343)
[    0.064969] pid_max: default: 32768 minimum: 301
[    0.064982] LSM: Security Framework initializing
[    0.065006] Mount-cache hash table entries: 16384 (order: 5, 131072 byt=
es, linear)
[    0.065023] Mountpoint-cache hash table entries: 16384 (order: 5, 13107=
2 bytes, linear)
[    0.065204] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.065216] process: using mwait in idle threads
[    0.065219] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.065221] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.065224] Spectre V1 : Mitigation: usercopy/swapgs barriers and __use=
r pointer sanitization
[    0.065226] Spectre V2 : Mitigation: Full generic retpoline
[    0.065228] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RS=
B on context switch
[    0.065229] Spectre V2 : Enabling Restricted Speculation for firmware c=
alls
[    0.065231] Spectre V2 : mitigation: Enabling conditional Indirect Bran=
ch Prediction Barrier
[    0.065233] Spectre V2 : User space: Mitigation: STIBP via seccomp and =
prctl
[    0.065235] Speculative Store Bypass: Mitigation: Speculative Store Byp=
ass disabled via prctl and seccomp
[    0.065237] SMT: disabled
[    0.065244] SMT: disabled
[    0.065249] SRBDS: Mitigation: Microcode
[    0.065255] MDS: Mitigation: Clear CPU buffers
[    0.065400] Freeing SMP alternatives memory: 36K
[    0.068349] smpboot: CPU0: Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz (fa=
mily: 0x6, model: 0x3d, stepping: 0x4)
[    0.068417] Performance Events: PEBS fmt2+, Broadwell events, 16-deep L=
BR, full-width counters, Intel PMU driver.
[    0.068441] ... version:                3
[    0.068445] ... bit width:              48
[    0.068450] ... generic registers:      4
[    0.068454] ... value mask:             0000ffffffffffff
[    0.068458] ... max period:             00007fffffffffff
[    0.068462] ... fixed-purpose events:   3
[    0.068467] ... event mask:             000000070000000f
[    0.068500] rcu: Hierarchical SRCU implementation.
[    0.068560] smp: Bringing up secondary CPUs ...
[    0.068616] x86: Booting SMP configuration:
[    0.068620] .... node  #0, CPUs:      #1 #2 #3
[    0.073192] smp: Brought up 1 node, 2 CPUs
[    0.073192] smpboot: Max logical packages: 2
[    0.073192] smpboot: Total of 2 processors activated (8783.42 BogoMIPS)
[    0.073192] devtmpfs: initialized
[    0.073192] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 6370867519511994 ns
[    0.073192] futex hash table entries: 1024 (order: 4, 65536 bytes, line=
ar)
[    0.073192] xor: automatically using best checksumming function   avx
[    0.073192] pinctrl core: initialized pinctrl subsystem
[    0.073192] pinctrl core: failed to create debugfs directory
[    0.073192] NET: Registered protocol family 16
[    0.073192] thermal_sys: Registered thermal governor 'step_wise'
[    0.073192] thermal_sys: Registered thermal governor 'user_space'
[    0.073192] cpuidle: using governor teo
[    0.073192] ACPI: bus type PCI registered
[    0.073192] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xf000000=
0-0xffffffff] (base 0xf0000000)
[    0.073192] PCI: MMCONFIG at [mem 0xf0000000-0xffffffff] reserved in E8=
20
[    0.073192] PCI: MMCONFIG for 0000 [bus00-3f] at [mem 0xf0000000-0xf3ff=
ffff] (base 0xf0000000) (size reduced!)
[    0.073192] PCI: Using configuration type 1 for base access
[    0.076028] HugeTLB registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.076028] raid6: skip pq benchmark and using algorithm avx2x4
[    0.076028] raid6: using avx2x2 recovery algorithm
[    0.076028] ACPI: Added _OSI(Module Device)
[    0.076028] ACPI: Added _OSI(Processor Device)
[    0.076028] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.076028] ACPI: Added _OSI(Processor Aggregator Device)
[    0.076028] ACPI: Added _OSI(Linux-Dell-Video)
[    0.076028] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.076028] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.076137] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.078298] ACPI: EC: EC started
[    0.078298] ACPI: EC: interrupt blocked
[    0.078298] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.078298] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tra=
nsactions
[    0.078298] ACPI: Interpreter enabled
[    0.078298] ACPI: (supports S0 S1 S2 S3 S5)
[    0.078298] ACPI: Using IOAPIC for interrupt routing
[    0.078298] PCI: Using host bridge windows from ACPI; if necessary, use=
 "pci=3Dnocrs" and report a bug
[    0.081631] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.081631] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Clo=
ckPM Segments MSI HPX-Type3]
[    0.081631] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability =
LTR]
[    0.081631] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 =
[bus 00-3f] only partially covers this bridge
[    0.081631] acpi PNP0A08:00: ignoring host bridge window [mem 0x000c400=
0-0x000c7fff window] (conflicts with Video ROM [mem 0x000c0000-0x000c6dff]=
)
[    0.081631] PCI host bridge to bus 0000:00
[    0.081631] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 windo=
w]
[    0.081631] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff windo=
w]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bff=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3f=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbf=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cff=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3f=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7f=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbf=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dff=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3f=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7f=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebf=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000eff=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fff=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0x80000001-0xfebfff=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44f=
ff window]
[    0.081631] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.081631] pci 0000:00:00.0: [8086:1604] type 00 class 0x060000
[    0.081631] pci 0000:00:02.0: [8086:1616] type 00 class 0x030000
[    0.081631] pci 0000:00:02.0: reg 0x10: [mem 0xe0000000-0xe0ffffff 64bi=
t]
[    0.081631] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bi=
t pref]
[    0.081631] pci 0000:00:02.0: reg 0x20: [io  0x1800-0x183f]
[    0.081631] pci 0000:00:02.0: DMAR: Disabling IOMMU for graphics on thi=
s chipset
[    0.081631] pci 0000:00:03.0: [8086:160c] type 00 class 0x040300
[    0.081631] pci 0000:00:03.0: reg 0x10: [mem 0xe1218000-0xe121bfff 64bi=
t]
[    0.081631] pci 0000:00:14.0: [8086:9cb1] type 00 class 0x0c0330
[    0.081631] pci 0000:00:14.0: reg 0x10: [mem 0xe1200000-0xe120ffff 64bi=
t]
[    0.081631] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.081631] pci 0000:00:1c.0: [8086:9c94] type 01 class 0x060400
[    0.081631] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.081631] pci 0000:00:1f.0: [8086:9cc3] type 00 class 0x060100
[    0.081631] pci 0000:00:1f.2: [8086:9c83] type 00 class 0x010601
[    0.081631] pci 0000:00:1f.2: reg 0x10: [io  0x1860-0x1867]
[    0.081631] pci 0000:00:1f.2: reg 0x14: [io  0x1870-0x1873]
[    0.081631] pci 0000:00:1f.2: reg 0x18: [io  0x1868-0x186f]
[    0.081639] pci 0000:00:1f.2: reg 0x1c: [io  0x1874-0x1877]
[    0.081650] pci 0000:00:1f.2: reg 0x20: [io  0x1840-0x185f]
[    0.081662] pci 0000:00:1f.2: reg 0x24: [mem 0xe1210000-0xe1217fff]
[    0.081697] pci 0000:00:1f.2: PME# supported from D3hot
[    0.081782] pci 0000:00:1f.6: [8086:9ca4] type 00 class 0x118000
[    0.081814] pci 0000:00:1f.6: reg 0x10: [mem 0xe1225000-0xe1225fff 64bi=
t]
[    0.082177] pci 0000:01:00.0: [8086:08b1] type 00 class 0x028000
[    0.082271] pci 0000:01:00.0: reg 0x10: [mem 0xe1100000-0xe1101fff 64bi=
t]
[    0.082571] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.084964] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.084964] pci 0000:00:1c.0:   bridge window [mem 0xe1100000-0xe11ffff=
f]
[    0.084964] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *11, disabled.
[    0.084964] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 =
15) *10, disabled.
[    0.084964] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *11, disabled.
[    0.084964] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14=
 15), disabled.
[    0.084964] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *0, disabled.
[    0.084964] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 =
15) *0, disabled.
[    0.084964] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *0, disabled.
[    0.084964] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 =
15) *0, disabled.
[    0.084972] ACPI: EC: interrupt unblocked
[    0.084972] ACPI: EC: event unblocked
[    0.084972] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.084972] ACPI: EC: GPE=3D0x24
[    0.084972] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization com=
plete
[    0.084972] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions=
 and events
[    0.084976] iommu: Default domain type: Translated
[    0.085015] SCSI subsystem initialized
[    0.085026] libata version 3.00 loaded.
[    0.101732] pxa2xx-spi INT3430:00: no DMA channels available, using PIO
[    0.102034] ACPI: bus type USB registered
[    0.102052] usbcore: registered new interface driver usbfs
[    0.102061] usbcore: registered new interface driver hub
[    0.102076] usbcore: registered new device driver usb
[    0.135994] pps_core: LinuxPPS API ver. 1 registered
[    0.136000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo=
 Giometti <giometti@linux.it>
[    0.136006] PTP clock support registered
[    0.136017] EDAC MC: Ver: 3.0.0
[    0.136203] Advanced Linux Sound Architecture Driver Initialized.
[    0.136203] PCI: Using ACPI for IRQ routing
[    0.139512] PCI: pci_cache_line_size set to 64 bytes
[    0.139826] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.139827] e820: reserve RAM buffer [mem 0x7ce28000-0x7fffffff]
[    0.139828] e820: reserve RAM buffer [mem 0x27f000000-0x27fffffff]
[    0.139867] clocksource: Switched to clocksource tsc-early
[    0.139925] pnp: PnP ACPI init
[    0.139980] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.139986] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.139992] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.139997] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.140003] system 00:00: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.140008] system 00:00: [mem 0xfed80000-0xfed83fff] has been reserved
[    0.140014] system 00:00: [mem 0xfed84000-0xfed84fff] has been reserved
[    0.140022] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.140119] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.140128] system 00:01: Plug and Play ACPI device, IDs PNP0103 PNP0c0=
1 (active)
[    0.140158] system 00:02: [io  0x1000-0x10fe] has been reserved
[    0.140165] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.140179] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.140307] system 00:04: [io  0x0900-0x09fe] has been reserved
[    0.140315] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.140341] system 00:05: [io  0x0200] has been reserved
[    0.140347] system 00:05: [io  0x0204] has been reserved
[    0.140352] system 00:05: [io  0x0800-0x087f] has been reserved
[    0.140358] system 00:05: [io  0x0880-0x08ff] has been reserved
[    0.140365] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.140386] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.140404] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 PNP030b (=
active)
[    0.140490] pnp 00:08: Plug and Play ACPI device, IDs PNP0c31 (active)
[    0.140592] system 00:09: [mem 0xe121e000-0xe121efff] has been reserved
[    0.140598] system 00:09: [mem 0xe1220000-0xe1220fff] has been reserved
[    0.140603] system 00:09: [mem 0xe1222000-0xe1222fff] has been reserved
[    0.140608] system 00:09: [mem 0xe1224000-0xe1224fff] has been reserved
[    0.140615] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.140718] pnp: PnP ACPI: found 10 devices
[    0.143401] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, =
max_idle_ns: 2085701024 ns
[    0.143401] NET: Registered protocol family 2
[    0.143401] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4=
, 65536 bytes, linear)
[    0.143401] TCP established hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.143401] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes=
, linear)
[    0.143401] TCP: Hash tables configured (established 65536 bind 65536)
[    0.143401] UDP hash table entries: 4096 (order: 5, 131072 bytes, linea=
r)
[    0.143401] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, =
linear)
[    0.143401] NET: Registered protocol family 1
[    0.144977] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.144992] pci 0000:00:1c.0:   bridge window [mem 0xe1100000-0xe11ffff=
f]
[    0.145005] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.145010] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.145015] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff wind=
ow]
[    0.145020] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff wind=
ow]
[    0.145025] pci_bus 0000:00: resource 8 [mem 0x000c8000-0x000cbfff wind=
ow]
[    0.145030] pci_bus 0000:00: resource 9 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.145035] pci_bus 0000:00: resource 10 [mem 0x000d0000-0x000d3fff win=
dow]
[    0.145040] pci_bus 0000:00: resource 11 [mem 0x000d4000-0x000d7fff win=
dow]
[    0.145044] pci_bus 0000:00: resource 12 [mem 0x000d8000-0x000dbfff win=
dow]
[    0.145049] pci_bus 0000:00: resource 13 [mem 0x000dc000-0x000dffff win=
dow]
[    0.145054] pci_bus 0000:00: resource 14 [mem 0x000e0000-0x000e3fff win=
dow]
[    0.145059] pci_bus 0000:00: resource 15 [mem 0x000e4000-0x000e7fff win=
dow]
[    0.145064] pci_bus 0000:00: resource 16 [mem 0x000e8000-0x000ebfff win=
dow]
[    0.145069] pci_bus 0000:00: resource 17 [mem 0x000ec000-0x000effff win=
dow]
[    0.145074] pci_bus 0000:00: resource 18 [mem 0x000f0000-0x000fffff win=
dow]
[    0.145079] pci_bus 0000:00: resource 19 [mem 0x80000001-0xfebfffff win=
dow]
[    0.145084] pci_bus 0000:00: resource 20 [mem 0xfed40000-0xfed44fff win=
dow]
[    0.145089] pci_bus 0000:01: resource 1 [mem 0xe1100000-0xe11fffff]
[    0.145138] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x=
000c0000-0x000dffff]
[    0.145471] PCI: CLS 64 bytes, default 64
[    0.145486] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.145491] software IO TLB: mapped [mem 0x78e28000-0x7ce28000] (64MB)
[    0.145527] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 65536=
0 ms ovfl timer
[    0.145532] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    0.145537] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.145541] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    0.145545] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    0.145972] Initialise system trusted keyrings
[    0.145997] workingset: timestamp_bits=3D45 max_order=3D21 bucket_order=
=3D0
[    0.157882] Key type asymmetric registered
[    0.157891] Asymmetric key parser 'x509' registered
[    0.157902] Block layer SCSI generic (bsg) driver version 0.4 loaded (m=
ajor 249)
[    0.157906] io scheduler mq-deadline registered
[    0.157911] io scheduler kyber registered
[    0.158112] pcieport 0000:00:1c.0: PME: Signaling with IRQ 40
[    0.158191] intel_idle: MWAIT substates: 0x11142120
[    0.158192] intel_idle: v0.5.1 model 0x3D
[    0.158281] intel_idle: Local APIC timer is reliable in all C-states
[    0.158385] ACPI: AC Adapter [AC] (on-line)
[    0.158438] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C=
0D:00/input/input0
[    0.158465] ACPI: Lid Switch [LID0]
[    0.158503] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP=
0C0C:00/input/input1
[    0.158523] ACPI: Power Button [PWRB]
[    0.158551] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inp=
ut/input2
[    0.158577] ACPI: Power Button [PWRF]
[    0.159359] thermal LNXTHERM:00: registered as thermal_zone0
[    0.159366] ACPI: Thermal Zone [THRM] (50 C)
[    0.159437] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.159661] Non-volatile memory driver v1.3
[    0.159703] Linux agpgart interface v0.103
[    0.159832] battery: ACPI: Battery Slot [BAT0] (battery present)
[    0.160117] resource sanity check: requesting [mem 0x000c0000-0x000dfff=
f], which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.160139] caller pci_map_rom+0x65/0x180 mapping multiple BARs
[    0.160144] i915 0000:00:02.0: Invalid PCI ROM data signature: expectin=
g 0x52494350, got 0xe937aa55
[    0.160150] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT)
[    0.171406] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on m=
inor 0
[    0.172356] loop: module loaded
[    0.172477] ahci 0000:00:1f.2: version 3.0
[    0.172624] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.185020] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0=
x1 impl SATA mode
[    0.185029] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo on=
ly pio slum part deso sadm sds apst
[    0.185386] scsi host0: ahci
[    0.185514] scsi host1: ahci
[    0.185600] scsi host2: ahci
[    0.185732] scsi host3: ahci
[    0.185780] ata1: SATA max UDMA/133 abar m32768@0xe1210000 port 0xe1210=
100 irq 42
[    0.185786] ata2: DUMMY
[    0.185791] ata3: DUMMY
[    0.185796] ata4: DUMMY
[    0.185834] tun: Universal TUN/TAP device driver, 1.6
[    0.185873] usbcore: registered new interface driver r8152
[    0.185990] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.186000] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus=
 number 1
[    0.187070] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x=
100 quirks 0x000000000004b810
[    0.187079] xhci_hcd 0000:00:14.0: cache line size of 64 is not support=
ed
[    0.187172] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.09
[    0.187179] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    0.187184] usb usb1: Product: xHCI Host Controller
[    0.187189] usb usb1: Manufacturer: Linux 5.9.3+ xhci-hcd
[    0.187194] usb usb1: SerialNumber: 0000:00:14.0
[    0.187311] hub 1-0:1.0: USB hub found
[    0.187328] hub 1-0:1.0: 11 ports detected
[    0.187547] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.187554] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus=
 number 2
[    0.187560] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.187594] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.09
[    0.187599] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    0.187604] usb usb2: Product: xHCI Host Controller
[    0.187608] usb usb2: Manufacturer: Linux 5.9.3+ xhci-hcd
[    0.187613] usb usb2: SerialNumber: 0000:00:14.0
[    0.187677] hub 2-0:1.0: USB hub found
[    0.187689] hub 2-0:1.0: 4 ports detected
[    0.187807] usbcore: registered new interface driver usb-storage
[    0.187830] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq=
 1
[    0.187835] i8042: PNP: PS/2 appears to have AUX port disabled, if this=
 is incorrect please boot with i8042.nopnp
[    0.188439] i8042: Warning: Keylock active
[    0.188578] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.188611] mousedev: PS/2 mouse device common for all mice
[    0.188896] rtc_cmos 00:03: RTC can wake from S4
[    0.189057] rtc_cmos 00:03: registered as rtc0
[    0.189073] rtc_cmos 00:03: alarms up to one month, 242 bytes nvram, hp=
et irqs
[    0.189178] intel_pstate: Intel P-state driver initializing
[    0.189282] hid: raw HID events driver (C) Jiri Kosina
[    0.189329] usbcore: registered new interface driver usbhid
[    0.189342] usbhid: USB HID core driver
[    0.192953] input: AT Translated Set 2 keyboard as /devices/platform/i8=
042/serio0/input/input3
[    0.195167] random: fast init done
[    0.195640] atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmw=
are V1.0.AA Objects: 32
[    0.195796] atmel_mxt_ts i2c-ATML0000:01: Enabling RETRIGEN workaround
[    0.195850] atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxt=
ouch.cfg failed with error -2
[    0.196980] atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
[    0.197020] input: Atmel maXTouch Touchpad as /devices/pci0000:00/INT34=
32:00/i2c-0/i2c-ATML0000:01/input/input4
[    0.203321] atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmw=
are V1.0.AA Objects: 41
[    0.203671] atmel_mxt_ts i2c-ATML0001:01: Enabling RETRIGEN workaround
[    0.203758] atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxt=
ouch.cfg failed with error -2
[    0.203886] intel_rapl_common: Found RAPL domain package
[    0.203893] intel_rapl_common: Found RAPL domain core
[    0.203898] intel_rapl_common: Found RAPL domain uncore
[    0.203903] intel_rapl_common: Found RAPL domain dram
[    0.205363] atmel_mxt_ts i2c-ATML0001:01: Touchscreen size X2559Y1699
[    0.205402] input: Atmel maXTouch Touchscreen as /devices/pci0000:00/IN=
T3433:00/i2c-1/i2c-ATML0001:01/input/input5
[    0.228561] Initializing XFRM netlink socket
[    0.228638] NET: Registered protocol family 10
[    0.228826] Segment Routing with IPv6
[    0.228884] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.228993] NET: Registered protocol family 17
[    0.238968] sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
[    0.251709] microcode: sig=3D0x306d4, pf=3D0x40, revision=3D0x2f
[    0.251726] microcode: Microcode Update Driver: v2.2.
[    0.251728] IPI shorthand broadcast: enabled
[    0.251741] sched_clock: Marking stable (251065043, 567445)->(253654932=
, -2022444)
[    0.259039] registered taskstats version 1
[    0.259049] Loading compiled-in X.509 certificates
[    0.259183] Btrfs loaded, crc32c=3Dcrc32c-generic
[    0.259252] haswell-pcm-audio haswell-pcm-audio: Direct firmware load f=
or intel/IntcPP01.bin failed with error -2
[    0.259259] haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP0=
1.bin not available(-2)
[    0.259461] ALSA device list:
[    0.259466]   No soundcards found.
[    0.278387] haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox rea=
dback FW info: type 01, - version: 00.00, build 77, source commit id: 876a=
c6906f31a43b6772b23c7c983ce9dcb18a19
[    0.299050] bdw-rt5677 bdw-rt5677: ASoC: no DMI vendor name!
[    0.301982] input: bdw-rt5677 Headphone Jack as /devices/pci0000:00/INT=
3438:00/bdw-rt5677/sound/card0/input6
[    0.302021] input: bdw-rt5677 Mic Jack as /devices/pci0000:00/INT3438:0=
0/bdw-rt5677/sound/card0/input7
[    0.379396] fbcon: i915drmfb (fb0) is primary device
[    0.501746] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.502036] ata1.00: ATA-10: KINGSTON RBU-SUS151S332GD, S9FM02.3, max U=
DMA/133
[    0.502037] ata1.00: 62533296 sectors, multi 16: LBA48 NCQ (depth 32), =
AA
[    0.502383] ata1.00: configured for UDMA/133
[    0.514974] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    0.656008] usb 1-1: New USB device found, idVendor=3D0bda, idProduct=
=3D8152, bcdDevice=3D20.00
[    0.656010] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    0.656011] usb 1-1: Product: USB 10/100 LAN
[    0.656012] usb 1-1: Manufacturer: Realtek
[    0.656013] usb 1-1: SerialNumber: 00E04C1209BB
[    0.778506] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[    0.928602] usb 1-7: New USB device found, idVendor=3D2232, idProduct=
=3D6001, bcdDevice=3D 0.02
[    0.928604] usb 1-7: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0
[    0.928605] usb 1-7: Product: NCM-G102
[    0.928606] usb 1-7: Manufacturer: NMGAAI00010200254L00639
[    1.042108] usb 1-1: reset high-speed USB device number 2 using xhci_hc=
d
[    1.168530] tsc: Refined TSC clocksource calibration: 2194.925 MHz
[    1.168541] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1f=
a3789b378, max_idle_ns: 440795248825 ns
[    1.168567] clocksource: Switched to clocksource tsc
[    1.209688] r8152 1-1:1.0: skip request firmware
[    1.236018] r8152 1-1:1.0 eth0: v1.11.11
[    1.305024] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[    1.446582] usb 1-8: New USB device found, idVendor=3D8087, idProduct=
=3D07dc, bcdDevice=3D 0.01
[    1.446586] usb 1-8: New USB device strings: Mfr=3D0, Product=3D0, Seri=
alNumber=3D0
[    1.610769] Console: switching to colour frame buffer device 320x106
[    1.682338] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    1.684895] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON RBU-SUS 0=
2.3 PQ: 0 ANSI: 5
[    1.687527] sd 0:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 G=
B/29.8 GiB)
[    1.690063] sd 0:0:0:0: [sda] Write Protect is off
[    1.692464] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.692491] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA
[    1.695038]  sda: sda1 sda2
[    1.697329] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.701641] EXT4-fs (sda2): mounted filesystem with ordered data mode. =
Opts: (null)
[    1.703836] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[    1.706767] devtmpfs: mounted
[    1.709138] Freeing unused kernel image (initmem) memory: 908K
[    1.721723] Write protecting the kernel read-only data: 18432k
[    1.724348] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.726433] Freeing unused kernel image (rodata/data gap) memory: 548K
[    1.728479] Run /sbin/init as init process
[    1.730509]   with arguments:
[    1.730509]     /sbin/init
[    1.730509]   with environment:
[    1.730510]     HOME=3D/
[    1.730510]     TERM=3Dlinux
[    2.306102] udevd[457]: starting version 3.2.9
[    2.309750] random: udevd: uninitialized urandom read (16 bytes read)
[    2.310043] random: udevd: uninitialized urandom read (16 bytes read)
[    2.310053] random: udevd: uninitialized urandom read (16 bytes read)
[    2.315292] udevd[457]: starting eudev-3.2.9
[    2.490465] rt5677 i2c-RT5677CE:00: DSP VAD: enable=3D0, activity=3D0
[    3.429843] EXT4-fs (sda2): re-mounted. Opts: (null)
[    3.506045] urandom_read: 4 callbacks suppressed
[    3.506046] random: ln: uninitialized urandom read (6 bytes read)
[    3.593901] random: dd: uninitialized urandom read (512 bytes read)
[    3.616621] random: mktemp: uninitialized urandom read (10 bytes read)
[    3.747816] elogind-daemon[1237]: New seat seat0.
[    3.748508] elogind-daemon[1237]: Watching system buttons on /dev/input=
/event2 (Power Button)
[    3.748561] elogind-daemon[1237]: Watching system buttons on /dev/input=
/event1 (Power Button)
[    3.748651] elogind-daemon[1237]: Watching system buttons on /dev/input=
/event0 (Lid Switch)
[    3.825109] elogind-daemon[1237]: Watching system buttons on /dev/input=
/event3 (AT Translated Set 2 keyboard)
[    3.896289] r8152 1-1:1.0 eth0: carrier on
[   12.433618] random: crng init done
[   14.361148] elogind-daemon[1237]: New session c1 of user andre.

--------------89B995608454B72526344E2F--
