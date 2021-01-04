Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9A92EA06D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbhADXHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:07:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:41651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbhADXHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609801545;
        bh=Ph+KfxfHII7H/eYZnQmZxzCyQ62zxV2gAts9WRV9CVE=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=gjJfe/5vbZstJVz7MwPSC0pAKuNJnQm/JXEG8tEJy1IJR1BZEY/QgrsndAAO4YY/K
         ff5air+r6s5RkFsBucj2TjVI7n1q1ww8bOWbhjHBqbAZIMYIZNxH0iMzguh3bvKn6k
         iOWB87BC4D6mCqgUQ3bum/Plj1742pUzLwTLkm9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.36] ([85.127.169.10]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1kasm61KfX-00O1PF; Tue, 05
 Jan 2021 00:05:45 +0100
From:   Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Subject: PROBLEM: commit f36a74b9345a leads to not booting system with AMD
 2990WX
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     dwmw@amazon.co.uk, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ed4be9b4-24ac-7128-c522-7ef359e8185d@gmx.at>
Date:   Tue, 5 Jan 2021 00:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PG3wwKpq18DLGURmYZJaQkyQT32C+beD3yB+Z0e+9HzbRaJopri
 2ITn7MmASCjScdrvK/KmuBKBPpaGEVlXYBrzLMx2E8xhCfdid30lHwem3Kwj6SESW5O2FZu
 h+ogP/Zc12BR9yEifRH0Vi0RDmvt//0JJJpMjPfBzSeZmTQfd6DbDDvrg2TNX1IRq+uUsm4
 P1Vca45P1HaAiJT8ovIHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KI3u8r8F2hM=:yea3r6VvsYWmsvBNkp6O1v
 mwBecIWtYI3Si6yhJY/S/RMb3rtiYt6vYnp2lGlwUcrIO2iH0qJV+NdI7NY8fItssd0npgDwK
 lLUy6TGUb49+To4NfzGsqwfcLzMPdVQr+NSgs0zc7230xsYZXdTGF7Upi2Cu5JPRkZRy8pb9T
 gc7CdAk2DCjCkUNAMAv5GmKaE/DMGaXKdfw/o24NOHTQyCAerO3P5CoXOGUCUuM9PO9bKT7ju
 9+Cno4k1MSOaYpQtwi69ZnyieY2nVt+tGMSLzPc7aqJjkDZK2QyYl/WJpzUisa4Jd2GuXJT9v
 b5rV0LONlxV5petDwLL63OwEbWwzO7PP6w8ulY+kAUZ9D5hQENtSL9eFFzUhvKLylkxs0HzTq
 HM1yOumsdd47CI++Ycxm2EYX2lrf0LH/LwbGeZQomjxz8jWHN0smpefMYT/HxarxjwC0jCCR/
 7l6xP6QpcD3cPPsnxUzG8MwMOWXnFA7MQJLAHHhXBbgGBtZbxO88IN0sdOFrz/ASYAUPnVIbW
 lRpmtL/n+Gq56Kps6sLquZbz69YV64M3+jvMtgaRrln36Poesita9mAbpDVNRIPBawVwFCIwm
 HjFpXGEfvBFBzxMrYNY4CR9YDVYb1pTNc/Up8Zal9+CkcbKFqULzsHlAy/ggXT3+aI1OUkEML
 GDjpYswhzsT79v6fcmH3sHaqtzhxZIs3sCxcujbeET8MO/GzhsWVSlmr0qoKF2VxsLWcwk7eH
 /ZMcVqiSrXYLIxMCif2eqEsFpyKJsNw88Lt4EPKivNi67Elz84SQVZWKJQyIpFhaEVB6oqylJ
 Z/0l2b+LtO6fXPgKWnAoolFZrSZn0kBtgpCHouJM/PCepftCEIu2CdS/RFHN+5mzFwbtW5N6U
 xkCqa93DRhqRMTjDkqSiLLAfE6ZyGV4tRDyELHCvE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f36a74b9345a leads to not booting system with AMD 2990WX


When trying to boot 5.11-rc2 as usual the messages of the bootloader stay =
on my
screen and not much appears to happen (fans run a bit slower than in GRUB,
devices don't seem to get accessed). Without this commit everything seems =
to
work as usual.

(In the hope that it is helpful I appended messages mentioning "IO APIC"
from 5.11-rc2 with the mentioned commit reverted (and the kernel parameter
apic=3Ddebug added).
I'm sorry that I can't provide more details: I'm unsure how I can gather
more information since my Motherboard (ASUS ROG ZENITH EXTREME) does not h=
ave
any documented serial ports and USB devices don't seem to get turned on.)

Kind regards
John



Output from dmesg containing "IO APIC":
(multiple removed messages indicated by "...")
=2D--

...
[    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI=
 0-23
[    0.000000] IOAPIC[1]: apic_id 129, version 33, address 0x82e00000, GSI=
 24-55
[    0.000000] IOAPIC[2]: apic_id 130, version 33, address 0xfb000000, GSI=
 56-87
[    0.000000] IOAPIC[3]: apic_id 131, version 33, address 0xfa800000, GSI=
 88-119
[    0.000000] IOAPIC[4]: apic_id 132, version 33, address 0x82400000, GSI=
 120-151
...
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (fec00000)
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (82e00000)
[    0.000000] mapped IOAPIC to ffffffffff5fa000 (fb000000)
[    0.000000] mapped IOAPIC to ffffffffff5f9000 (fa800000)
[    0.000000] mapped IOAPIC to ffffffffff5f8000 (82400000)
...
[    0.000000] AMD-Vi: [Firmware Bug]: : IOAPIC[130] not in IVRS table
[    0.000000] AMD-Vi: [Firmware Bug]: : IOAPIC[131] not in IVRS table
[    0.000000] AMD-Vi: [Firmware Bug]: : IOAPIC[132] not in IVRS table
[    0.000000] AMD-Vi: Disabling interrupt remapping
[    0.000000] Switched APIC routing to physical flat.
[    0.000000] enabled ExtINT on CPU#0
[    0.000000] ENABLING IO-APIC IRQs
[    0.000000] init IO_APIC IRQs
[    0.000000]  apic 128 pin 0 not connected
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-1 -> IRQ 1 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-2 -> IRQ 0 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-3 -> IRQ 3 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-4 -> IRQ 4 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-5 -> IRQ 5 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-6 -> IRQ 6 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-7 -> IRQ 7 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-8 -> IRQ 8 Leve=
l:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-9 -> IRQ 9 Leve=
l:1 ActiveLow:1)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-10 -> IRQ 10 Le=
vel:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-11 -> IRQ 11 Le=
vel:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-12 -> IRQ 12 Le=
vel:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-13 -> IRQ 13 Le=
vel:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-14 -> IRQ 14 Le=
vel:0 ActiveLow:0)
[    0.000000] IOAPIC[0]: Preconfigured routing entry (128-15 -> IRQ 15 Le=
vel:0 ActiveLow:0)
...
[    0.316256] ACPI: Using IOAPIC for interrupt routing
...
[    0.371387] IOAPIC[1]: Preconfigured routing entry (129-0 -> IRQ 24 Lev=
el:1 ActiveLow:1)
[    0.371453] pci 0000:06:00.0: PME# does not work under D0, disabling it
[    0.371483] IOAPIC[1]: Preconfigured routing entry (129-2 -> IRQ 24 Lev=
el:1 ActiveLow:1)
[    0.371512] IOAPIC[1]: Preconfigured routing entry (129-1 -> IRQ 25 Lev=
el:1 ActiveLow:1)
[    0.371593] pci 0000:07:00.0: Video device with shadowed ROM at [mem 0x=
000c0000-0x000dffff]
[    0.371619] pci 0000:07:00.1: D0 power state depends on 0000:07:00.0
[    0.371667] IOAPIC[1]: Preconfigured routing entry (129-20 -> IRQ 26 Le=
vel:1 ActiveLow:1)
[    0.371731] IOAPIC[1]: Preconfigured routing entry (129-13 -> IRQ 27 Le=
vel:1 ActiveLow:1)
[    0.371832] IOAPIC[3]: Preconfigured routing entry (131-20 -> IRQ 27 Le=
vel:1 ActiveLow:1)
[    0.371859] IOAPIC[3]: Preconfigured routing entry (131-13 -> IRQ 28 Le=
vel:1 ActiveLow:1)
[    0.371904] PCI: CLS 64 bytes, default 64
...
[    0.952962] Block layer SCSI generic (bsg) driver version 0.4 loaded (m=
ajor 245)
[    0.953035] io scheduler mq-deadline registered
[    0.953037] io scheduler kyber registered
[    0.955047] IOAPIC[1]: Preconfigured routing entry (129-8 -> IRQ 32 Lev=
el:1 ActiveLow:1)
[    0.955349] IOAPIC[1]: Preconfigured routing entry (129-3 -> IRQ 35 Lev=
el:1 ActiveLow:1)
[    0.955473] IOAPIC[1]: Preconfigured routing entry (129-0 -> IRQ 37 Lev=
el:1 ActiveLow:1)
[    0.955947] IOAPIC[2]: Preconfigured routing entry (130-20 -> IRQ 40 Le=
vel:1 ActiveLow:1)
[    0.956163] IOAPIC[2]: Preconfigured routing entry (130-8 -> IRQ 42 Lev=
el:1 ActiveLow:1)
[    0.956794] IOAPIC[3]: Preconfigured routing entry (131-8 -> IRQ 47 Lev=
el:1 ActiveLow:1)
[    0.957100] IOAPIC[4]: Preconfigured routing entry (132-20 -> IRQ 49 Le=
vel:1 ActiveLow:1)
[    0.957314] IOAPIC[4]: Preconfigured routing entry (132-8 -> IRQ 51 Lev=
el:1 ActiveLow:1)
...
[    0.990713] nvme nvme0: pci function 0000:41:00.0
[    0.991037] nvme nvme1: pci function 0000:42:00.0
[    0.991080] IOAPIC[3]: Preconfigured routing entry (131-0 -> IRQ 53 Lev=
el:1 ActiveLow:1)
[    0.991388] IOAPIC[3]: Preconfigured routing entry (131-4 -> IRQ 55 Lev=
el:1 ActiveLow:1)
...
[    1.119108] hub 4-0:1.0: USB hub found
[    1.119510] hub 4-0:1.0: 2 ports detected
[    1.120021] IOAPIC[1]: Preconfigured routing entry (129-13 -> IRQ 103 L=
evel:1 ActiveLow:1)
[    1.120036] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    1.120433] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus=
 number 5
...
[    1.128213] hub 6-0:1.0: USB hub found
[    1.128609] hub 6-0:1.0: 4 ports detected
[    1.129237] IOAPIC[3]: Preconfigured routing entry (131-13 -> IRQ 112 L=
evel:1 ActiveLow:1)
[    1.129274] xhci_hcd 0000:43:00.3: xHCI Host Controller
[    1.130019] xhci_hcd 0000:43:00.3: new USB bus registered, assigned bus=
 number 7
...
[    1.189702] ... APIC ID:      00000000 (0)
[    1.189898] ... APIC VERSION: 80050010
[    1.190092] 00000000000000000000000000000000000000000000000000000000000=
00000
[    1.190101] 00000000000000000000000000000000000000000000000000000000000=
00000
[    1.190108] 00000000000000000000000000000000000000000000000000000000000=
00000

[    1.190311] number of MP IRQ sources: 15.
[    1.190311] number of IO-APIC #128 registers: 24.
[    1.190312] number of IO-APIC #129 registers: 32.
[    1.190313] number of IO-APIC #130 registers: 32.
[    1.190314] number of IO-APIC #131 registers: 32.
[    1.190315] number of IO-APIC #132 registers: 32.
[    1.190316] testing the IO APIC.......................
[    1.190446] IO APIC #128......
[    1.190447] .... register #00: 80000000
[    1.190448] .......    : physical APIC id: 80
[    1.190448] .......    : Delivery Type: 0
[    1.190449] .......    : LTS          : 0
[    1.190450] .... register #01: 00178021
[    1.190451] .......     : max redirection entries: 17
[    1.190451] .......     : PRQ implemented: 1
[    1.190452] .......     : IO APIC version: 21
[    1.190453] .... register #02: 00000000
[    1.190453] .......     : arbitration: 00
[    1.190454] .... IRQ redirection table:
[    1.190454] IOAPIC 0:
[    1.190464]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190474]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190484]  pin02, enabled , edge , high, V(30), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190494]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190504]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190513]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190523]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190533]  pin07, enabled , level, low , V(21), IRR(0), S(0), physica=
l, D(0008), M(0)
[    1.190542]  pin08, enabled , edge , high, V(25), IRR(0), S(0), physica=
l, D(000E), M(0)
[    1.190552]  pin09, enabled , level, low , V(21), IRR(0), S(0), physica=
l, D(0002), M(0)
[    1.190562]  pin0a, enabled , edge , high, V(21), IRR(0), S(0), physica=
l, D(0004), M(0)
[    1.190571]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190581]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190591]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190600]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190610]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190620]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190630]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190639]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190649]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190659]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190668]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190678]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190688]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190691] IO APIC #129......
[    1.190691] .... register #00: 81000000
[    1.190692] .......    : physical APIC id: 81
[    1.190692] .......    : Delivery Type: 0
[    1.190693] .......    : LTS          : 0
[    1.190693] .... register #01: 001F8021
[    1.190693] .......     : max redirection entries: 1F
[    1.190694] .......     : PRQ implemented: 1
[    1.190694] .......     : IO APIC version: 21
[    1.190695] .... register #02: 00000000
[    1.190695] .......     : arbitration: 00
[    1.190696] .... IRQ redirection table:
[    1.190696] IOAPIC 1:
[    1.190698]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190700]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190702]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190705]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190707]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190709]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190711]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190713]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190716]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190718]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190720]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190722]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190725]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190727]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190729]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190731]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190733]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190736]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190738]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190740]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190742]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190744]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190747]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190749]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190751]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190753]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190756]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190758]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190760]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190762]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190764]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190767]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190770] IO APIC #130......
[    1.190771] .... register #00: 82000000
[    1.190771] .......    : physical APIC id: 82
[    1.190771] .......    : Delivery Type: 0
[    1.190772] .......    : LTS          : 0
[    1.190772] .... register #01: 001F8021
[    1.190773] .......     : max redirection entries: 1F
[    1.190773] .......     : PRQ implemented: 1
[    1.190774] .......     : IO APIC version: 21
[    1.190774] .... register #02: 00000000
[    1.190774] .......     : arbitration: 00
[    1.190775] .... IRQ redirection table:
[    1.190775] IOAPIC 2:
[    1.190777]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190780]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190782]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190785]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190787]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190790]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190792]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190795]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190797]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190800]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190802]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190804]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190807]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190809]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190812]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190814]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190817]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190819]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190822]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190824]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190827]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190829]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190831]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190834]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190836]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190839]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190841]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190844]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190846]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190849]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190851]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190854]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190857] IO APIC #131......
[    1.190857] .... register #00: 83000000
[    1.190858] .......    : physical APIC id: 83
[    1.190858] .......    : Delivery Type: 0
[    1.190859] .......    : LTS          : 0
[    1.190859] .... register #01: 001F8021
[    1.190859] .......     : max redirection entries: 1F
[    1.190860] .......     : PRQ implemented: 1
[    1.190860] .......     : IO APIC version: 21
[    1.190861] .... register #02: 00000000
[    1.190861] .......     : arbitration: 00
[    1.190862] .... IRQ redirection table:
[    1.190862] IOAPIC 3:
[    1.190864]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190866]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190869]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190872]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190875]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190877]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190880]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190883]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190885]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190888]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190890]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190893]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190896]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190898]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190901]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190904]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190907]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190909]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190912]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190914]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190917]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190919]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190921]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190924]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190926]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190928]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190931]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190933]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190936]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190938]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190940]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190943]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190946] IO APIC #132......
[    1.190946] .... register #00: 84000000
[    1.190947] .......    : physical APIC id: 84
[    1.190947] .......    : Delivery Type: 0
[    1.190948] .......    : LTS          : 0
[    1.190948] .... register #01: 001F8021
[    1.190948] .......     : max redirection entries: 1F
[    1.190949] .......     : PRQ implemented: 1
[    1.190949] .......     : IO APIC version: 21
[    1.190950] .... register #02: 00000000
[    1.190950] .......     : arbitration: 00
[    1.190950] .... IRQ redirection table:
[    1.190951] IOAPIC 4:
[    1.190953]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190955]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190958]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190960]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190963]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190965]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190967]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190970]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190972]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190975]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190977]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190979]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190982]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190984]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190986]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190989]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190991]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190994]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190996]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.190998]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191001]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191003]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191005]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191008]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191010]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191013]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191015]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191017]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191020]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191022]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191024]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191027]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physica=
l, D(0000), M(0)
[    1.191028] IRQ to pin mappings:
[    1.191028] IRQ0 -> 0:2
[    1.191030] IRQ1 -> 0:1
[    1.191031] IRQ3 -> 0:3
[    1.191032] IRQ4 -> 0:4
[    1.191033] IRQ5 -> 0:5
[    1.191034] IRQ6 -> 0:6
[    1.191035] IRQ7 -> 0:7
[    1.191036] IRQ8 -> 0:8
[    1.191037] IRQ9 -> 0:9
[    1.191037] IRQ10 -> 0:10
[    1.191039] IRQ11 -> 0:11
[    1.191040] IRQ12 -> 0:12
[    1.191041] IRQ13 -> 0:13
[    1.191042] IRQ14 -> 0:14
[    1.191043] IRQ15 -> 0:15
[    1.191044] IRQ24 -> 1:2
[    1.191045] IRQ25 -> 1:1
[    1.191046] IRQ26 -> 1:20
[    1.191047] IRQ27 -> 3:20
[    1.191048] IRQ32 -> 1:8
[    1.191049] IRQ35 -> 1:3
[    1.191050] IRQ37 -> 1:0
[    1.191052] IRQ40 -> 2:20
[    1.191053] IRQ42 -> 2:8
[    1.191054] IRQ47 -> 3:8
[    1.191056] IRQ49 -> 4:20
[    1.191057] IRQ51 -> 4:8
[    1.191058] IRQ53 -> 3:0
[    1.191059] IRQ55 -> 3:4
[    1.191062] IRQ103 -> 1:13
[    1.191064] IRQ112 -> 3:13
[    1.191066] .................................... done.
...
[    1.335933] ata8: SATA max UDMA/133 abar m131072@0xb1780000 port 0xb178=
0480 irq 121
[    1.337658] IOAPIC[1]: Preconfigured routing entry (129-18 -> IRQ 127 L=
evel:1 ActiveLow:1)
[    1.337911] ahci 0000:09:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0=
x1 impl SATA mode
[    1.338611] ahci 0000:09:00.2: flags: 64bit ncq sntf ilck pm led clo on=
ly pmp fbs pio slum part
[    1.340344] AVX2 version of gcm_enc/dec engaged.
[    1.340467] scsi host8: ahci
[    1.340746] AES CTR mode by8 optimization enabled
[    1.342149] ata9: SATA max UDMA/133 abar m4096@0xb1808000 port 0xb18081=
00 irq 128
[    1.343011] IOAPIC[3]: Preconfigured routing entry (131-18 -> IRQ 129 L=
evel:1 ActiveLow:1)
[    1.343140] ahci 0000:44:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0=
x1 impl SATA mode
[    1.343635] ahci 0000:44:00.2: flags: 64bit ncq sntf ilck pm led clo on=
ly pmp fbs pio slum part
...
[    5.592021] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[    5.592959] IOAPIC[1]: Preconfigured routing entry (129-12 -> IRQ 131 L=
evel:1 ActiveLow:1)
[    5.597734] efivars: duplicate variable: DeploymentModeNv-97e8965f-c761=
-4f48-b6e4-9ffa9cb2a2d6
[    5.597794] pstore: Using crash dump compression: deflate
[    5.597797] pstore: Registered efi as persistent store backend
[    5.607392] ccp 0000:08:00.2: ccp enabled
[    5.608759] ccp 0000:21:00.2: enabling device (0000 -> 0002)
[    5.609623] IOAPIC[2]: Preconfigured routing entry (130-12 -> IRQ 134 L=
evel:1 ActiveLow:1)
[    5.615917] ccp 0000:21:00.2: ccp enabled
[    5.616979] ccp 0000:43:00.2: enabling device (0000 -> 0002)
[    5.617313] IOAPIC[3]: Preconfigured routing entry (131-12 -> IRQ 137 L=
evel:1 ActiveLow:1)
[    5.622893] ccp 0000:43:00.2: ccp enabled
[    5.623433] ccp 0000:61:00.2: enabling device (0000 -> 0002)
[    5.624701] IOAPIC[4]: Preconfigured routing entry (132-12 -> IRQ 140 L=
evel:1 ActiveLow:1)
[    5.635438] random: crng init done
...
[    5.873394] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data m=
ode. Opts: (null). Quota mode: none.
[    5.876660] IOAPIC[1]: Preconfigured routing entry (129-31 -> IRQ 143 L=
evel:1 ActiveLow:1)
[    5.876674] snd_hda_intel 0000:07:00.1: Disabling MSI
[    5.876691] snd_hda_intel 0000:07:00.1: Handle vga_switcheroo audio cli=
ent
[    5.876773] intel_rapl_common: Found RAPL domain package
[    5.876775] intel_rapl_common: Found RAPL domain core
[    5.876845] snd_hda_intel 0000:09:00.3: enabling device (0000 -> 0002)
[    5.876912] IOAPIC[1]: Preconfigured routing entry (129-19 -> IRQ 144 L=
evel:1 ActiveLow:1)
[    5.893817] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: =
line_outs=3D3 (0x14/0x15/0x16/0x0/0x0) type:line
...

=2D--
