Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E722CD2A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbgLCJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:35:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:42814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgLCJfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:35:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5581AC55;
        Thu,  3 Dec 2020 09:34:50 +0000 (UTC)
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20201202022936.GA12321@xsang-OptiPlex-9020>
 <eb24560e-e6ef-6a97-10cd-59a167ad3fde@suse.de>
 <20201203083629.GH27350@xsang-OptiPlex-9020>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [drm/fb] 1d46491d4a:
 WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_work[drm_kms_helper]
Message-ID: <cc411397-b69c-253e-7ceb-b8a20519cf71@suse.de>
Date:   Thu, 3 Dec 2020 10:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201203083629.GH27350@xsang-OptiPlex-9020>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D9DwTcKceD3yx7fzSO6j8ODI1Av91HWfc"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D9DwTcKceD3yx7fzSO6j8ODI1Av91HWfc
Content-Type: multipart/mixed; boundary="jeUAEGX86NLKSys6FZjR8hVrTdXHxOrcR";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>, lkp@lists.01.org,
 lkp@intel.com
Message-ID: <cc411397-b69c-253e-7ceb-b8a20519cf71@suse.de>
Subject: Re: [drm/fb] 1d46491d4a:
 WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_work[drm_kms_helper]
References: <20201202022936.GA12321@xsang-OptiPlex-9020>
 <eb24560e-e6ef-6a97-10cd-59a167ad3fde@suse.de>
 <20201203083629.GH27350@xsang-OptiPlex-9020>
In-Reply-To: <20201203083629.GH27350@xsang-OptiPlex-9020>

--jeUAEGX86NLKSys6FZjR8hVrTdXHxOrcR
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 03.12.20 um 09:36 schrieb Oliver Sang:
> On Thu, Dec 03, 2020 at 08:41:49AM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> there should be a line in the kernel log that says something like "Dam=
age
>> blitter failed" with an error code. Is there any chance of recovering =
it?
>>
>=20
> Hi Thomas,
>=20
> we attached dmesg in original report, where below comes from.
>=20
> [   28.258177] ------------[ cut here ]------------
> [   28.259527] bochs-drm 0000:00:02.0: Damage blitter failed: ret=3D-12=


Thanks, that's the line I was looking for. Errno 12 means out-of-memory. =

It's not something related to the fbdev code, but rather another=20
instance of the test system running out of memory. Presumably, it comes=20
from [1].

Best regards
Thomas

[1]=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
drivers/gpu/drm/ttm/ttm_bo_util.c?id=3D1d46491d4a08d7ee657e09808f87d16944=
4a2652#n475


> [   28.261007] WARNING: CPU: 0 PID: 122 at drivers/gpu/drm/drm_fb_helpe=
r.c:434 drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> [   28.263802] Modules linked in: locktorture(E) torture(E) mousedev(E)=
 ppdev(E) psmouse(E) crc32c_intel(E) input_leds(E) bochs_drm(E) drm_vram_=
helper(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) parport_pc(E) rtc_cm=
os(E) parport(E) drm(E) evbug(E) i6300esb(E) i2c_piix4(E) autofs4(E)
> [   28.271897] CPU: 0 PID: 122 Comm: kworker/0:2 Tainted: G            =
E     5.10.0-rc3-01102-g1d46491d4a08 #1
> [   28.273904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.12.0-1 04/01/2014
> [   28.275819] Workqueue: events drm_fb_helper_damage_work [drm_kms_hel=
per]
> [   28.279884] EIP: drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_help=
er]
>=20
>=20
>> Best regards
>> Thomas
>>
>> Am 02.12.20 um 03:29 schrieb kernel test robot:
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 1d46491d4a08d7ee657e09808f87d169444a2652 ("drm/fb-helper: Mov=
e damage blit code and its setup into separate routine")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
>>>
>>>
>>> in testcase: locktorture
>>> version:
>>> with following parameters:
>>>
>>> 	runtime: 300s
>>> 	test: cpuhotplug
>>>
>>> test-description: This torture test consists of creating a number of =
kernel threads which acquire the lock and hold it for specific amount of =
time, thus simulating different critical region behaviors.
>>> test-url: https://www.kernel.org/doc/Documentation/locking/locktortur=
e.txt
>>>
>>>
>>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2=
 -m 8G
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire =
log/backtrace):
>>>
>>>
>>> +--------------------------------------------------------------------=
-------------------+------------+------------+
>>> |                                                                    =
                   | fd2d856538 | 1d46491d4a |
>>> +--------------------------------------------------------------------=
-------------------+------------+------------+
>>> | WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_wo=
rk[drm_kms_helper] | 0          | 26         |
>>> | EIP:drm_fb_helper_damage_work                                      =
                   | 0          | 26         |
>>> +--------------------------------------------------------------------=
-------------------+------------+------------+
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>> [   28.261007] WARNING: CPU: 0 PID: 122 at drivers/gpu/drm/drm_fb_hel=
per.c:434 drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
>>> [   28.263802] Modules linked in: locktorture(E) torture(E) mousedev(=
E) ppdev(E) psmouse(E) crc32c_intel(E) input_leds(E) bochs_drm(E) drm_vra=
m_helper(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) parport_pc(E) rtc_=
cmos(E) parport(E) drm(E) evbug(E) i6300esb(E) i2c_piix4(E) autofs4(E)
>>> [   28.271897] CPU: 0 PID: 122 Comm: kworker/0:2 Tainted: G          =
  E     5.10.0-rc3-01102-g1d46491d4a08 #1
>>> [   28.273904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.12.0-1 04/01/2014
>>> [   28.275819] Workqueue: events drm_fb_helper_damage_work [drm_kms_h=
elper]
>>> [   28.279884] EIP: drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_he=
lper]
>>> [   28.281467] Code: 47 10 8b 58 2c 85 db 0f 84 bc 01 00 00 e8 1f f0 =
da f4 89 74 24 0c 89 5c 24 08 89 44 24 04 c7 04 24 98 c1 40 df e8 f7 50 1=
d f5 <0f> 0b 31 c9 c7 04 24 01 00 00 00 ba 01 00 00 00 b8 3c e8 40 df e8
>>> [   28.285055] EAX: 00000036 EBX: c1c91420 ECX: 00000000 EDX: 0000000=
0
>>> [   28.289443] ESI: fffffff4 EDI: d2014000 EBP: d2c0dee4 ESP: d2c0de9=
c
>>> [   28.291058] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 0=
0010292
>>> [   28.292717] CR0: 80050033 CR2: b727a028 CR3: 12141000 CR4: 0004069=
0
>>> [   28.294316] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 0000000=
0
>>> [   28.295915] DR6: fffe0ff0 DR7: 00000400
>>> [   28.300768] Call Trace:
>>> [   28.302117]  process_one_work+0x31b/0x7b0
>>> [   28.303532]  ? process_one_work+0x272/0x7b0
>>> [   28.304976]  worker_thread+0x29a/0x5d0
>>> [   28.308712]  ? process_one_work+0x7b0/0x7b0
>>> [   28.310129]  kthread+0x181/0x1a0
>>> [   28.311464]  ? process_one_work+0x7b0/0x7b0
>>> [   28.312878]  ? kthread_create_worker_on_cpu+0x30/0x30
>>> [   28.314318]  ret_from_fork+0x1c/0x28
>>> [   28.315645] CPU: 0 PID: 122 Comm: kworker/0:2 Tainted: G          =
  E     5.10.0-rc3-01102-g1d46491d4a08 #1
>>> [   28.317414] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.12.0-1 04/01/2014
>>> [   28.319096] Workqueue: events drm_fb_helper_damage_work [drm_kms_h=
elper]
>>> [   28.320674] Call Trace:
>>> [   28.321947]  dump_stack+0x6d/0x8b
>>> [   28.323278]  __warn.cold+0x24/0x49
>>> [   28.324639]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_help=
er]
>>> [   28.326167]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_help=
er]
>>> [   28.327670]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_help=
er]
>>> [   28.329165]  report_bug+0xb0/0xf0
>>> [   28.330438]  ? irq_work_queue+0x13/0x70
>>> [   28.331729]  ? exc_overflow+0x60/0x60
>>> [   28.333002]  handle_bug+0x2a/0x50
>>> [   28.334227]  exc_invalid_op+0x28/0x80
>>> [   28.335462]  handle_exception+0x15d/0x15d
>>> [   28.336729] EIP: drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_he=
lper]
>>> [   28.338148] Code: 47 10 8b 58 2c 85 db 0f 84 bc 01 00 00 e8 1f f0 =
da f4 89 74 24 0c 89 5c 24 08 89 44 24 04 c7 04 24 98 c1 40 df e8 f7 50 1=
d f5 <0f> 0b 31 c9 c7 04 24 01 00 00 00 ba 01 00 00 00 b8 3c e8 40 df e8
>>> [   28.341442] EAX: 00000036 EBX: c1c91420 ECX: 00000000 EDX: 0000000=
0
>>> [   28.342910] ESI: fffffff4 EDI: d2014000 EBP: d2c0dee4 ESP: d2c0de9=
c
>>> [   28.344372] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 0=
0010292
>>> [   28.345883]  ? cpu_latency_qos_write+0xeb/0xf0
>>> [   28.347203]  ? run_init_process+0x5b/0x158
>>> [   28.348483]  ? run_init_process+0x5b/0x158
>>> [   28.349714]  ? exc_overflow+0x60/0x60
>>> [   28.350895]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_help=
er]
>>> [   28.352244]  process_one_work+0x31b/0x7b0
>>> [   28.353432]  ? process_one_work+0x272/0x7b0
>>> [   28.354599]  worker_thread+0x29a/0x5d0
>>> [   28.355730]  ? process_one_work+0x7b0/0x7b0
>>> [   28.356894]  kthread+0x181/0x1a0
>>> [   28.357942]  ? process_one_work+0x7b0/0x7b0
>>> [   28.359019]  ? kthread_create_worker_on_cpu+0x30/0x30
>>> [   28.360134]  ret_from_fork+0x1c/0x28
>>> [   28.376652] irq event stamp: 9469
>>> [   28.377678] hardirqs last  enabled at (9477): [<d3903085>] console=
_unlock+0x515/0x650
>>> [   28.378986] hardirqs last disabled at (9484): [<d3902f95>] console=
_unlock+0x425/0x650
>>> [   28.380284] softirqs last  enabled at (9464): [<d467123d>] __do_so=
ftirq+0x3fd/0x57c
>>> [   28.381595] softirqs last disabled at (9381): [<d382793c>] call_on=
_stack+0x4c/0x60
>>> [   28.382878] ---[ end trace b5fac24d1c204ab3 ]---
>>>
>>>
>>> To reproduce:
>>>
>>>           # build kernel
>>> 	cd linux
>>> 	cp config-5.10.0-rc3-01102-g1d46491d4a08 .config
>>> 	make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Di386 olddefconfig prepare modu=
les_prepare bzImage modules
>>> 	make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Di386 INSTALL_MOD_PATH=3D<mod-i=
nstall-dir> modules_install
>>> 	cd <mod-install-dir>
>>> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>>>
>>>
>>>           git clone https://github.com/intel/lkp-tests.git
>>>           cd lkp-tests
>>>           bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-s=
cript is attached in this email
>>>
>>>
>>>
>>> Thanks,
>>> Oliver Sang
>>>
>>
>> --=20
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
>> (HRB 36809, AG N=C3=BCrnberg)
>> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>>
>=20
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--jeUAEGX86NLKSys6FZjR8hVrTdXHxOrcR--

--D9DwTcKceD3yx7fzSO6j8ODI1Av91HWfc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/IsTkFAwAAAAAACgkQlh/E3EQov+AB
Pw//WlHYyOqvNHMV03nGI6YlEYNYAOiB2/FkIWUVeuxn3/lCWPn+vPCCGLprFs1Q5+rHVxKHdKsz
RY0QgsdCZTsuUrqFNs4EhLXZL2Ghj22dzMTs182lpfT7Purd8siu2bxAs4IZNih/if61ZX44uPC9
Oug+ABltHHfkDGklqRGRqbfGlfiCFfxKl659bHUAE51j7rOX976BpAGARf7+Lo2EzlaQvafKz/Ys
sH5x2jJXnfGAsyhcrlAWq2SRdl7Tql/mSp+v6P/AhfLrN/W/uZooEkGOwUrzlhGXIMHRv9b89IZa
PstS7N3rfV2/7wukge7CL2nMNpt7G5fZxCLZgCQOn3H4q6gawr6pjAmQD9OJYk+j4MSutJRB86Wd
ozwttN5/KzNNjMUNFU4BNEOnNZQrOA+NjK9e8Yf2BphAHAyN7VKSaJcUcVNdIFXm72Erfn8JZMMr
63bDXsHiqRvMiHh2Db+VA/L25178y9t6Rlsvp816XY8J8N5phCizG45PfhUsjpD6hg6bMC4zZIch
VnaCM5IaltIRv171kFjQGJWr+Vp+twxgEtBPCXBntzzGBbVdA+R2ETZfLbVuufp5FoprUO8Jn5fs
W4QsoN+RuDSZM37+ETzLMMA3XrQmw09xlJL8IOreTr6YPYyLHPjmqFSEUsap59YBOENKdtEzldOt
57o=
=qAmz
-----END PGP SIGNATURE-----

--D9DwTcKceD3yx7fzSO6j8ODI1Av91HWfc--
