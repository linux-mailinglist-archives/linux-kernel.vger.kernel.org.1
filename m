Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994692CD07C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbgLCHmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:42:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgLCHmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:42:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B31CEACEB;
        Thu,  3 Dec 2020 07:41:50 +0000 (UTC)
Subject: Re: [drm/fb] 1d46491d4a:
 WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_work[drm_kms_helper]
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20201202022936.GA12321@xsang-OptiPlex-9020>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <eb24560e-e6ef-6a97-10cd-59a167ad3fde@suse.de>
Date:   Thu, 3 Dec 2020 08:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202022936.GA12321@xsang-OptiPlex-9020>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DvI6JwtLv4nlvPjN5i34yK1LruptNUvbI"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DvI6JwtLv4nlvPjN5i34yK1LruptNUvbI
Content-Type: multipart/mixed; boundary="kmfEKcoqoHu7tJzXCbHf8kI0EM3rAVmNw";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>, lkp@lists.01.org,
 lkp@intel.com
Message-ID: <eb24560e-e6ef-6a97-10cd-59a167ad3fde@suse.de>
Subject: Re: [drm/fb] 1d46491d4a:
 WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_work[drm_kms_helper]
References: <20201202022936.GA12321@xsang-OptiPlex-9020>
In-Reply-To: <20201202022936.GA12321@xsang-OptiPlex-9020>

--kmfEKcoqoHu7tJzXCbHf8kI0EM3rAVmNw
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

there should be a line in the kernel log that says something like=20
"Damage blitter failed" with an error code. Is there any chance of=20
recovering it?

Best regards
Thomas

Am 02.12.20 um 03:29 schrieb kernel test robot:
>=20
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-9):
>=20
> commit: 1d46491d4a08d7ee657e09808f87d169444a2652 ("drm/fb-helper: Move =
damage blit code and its setup into separate routine")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master=

>=20
>=20
> in testcase: locktorture
> version:
> with following parameters:
>=20
> 	runtime: 300s
> 	test: cpuhotplug
>=20
> test-description: This torture test consists of creating a number of ke=
rnel threads which acquire the lock and hold it for specific amount of ti=
me, thus simulating different critical region behaviors.
> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.=
txt
>=20
>=20
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -=
m 8G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
>=20
>=20
> +----------------------------------------------------------------------=
-----------------+------------+------------+
> |                                                                      =
                 | fd2d856538 | 1d46491d4a |
> +----------------------------------------------------------------------=
-----------------+------------+------------+
> | WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_work=
[drm_kms_helper] | 0          | 26         |
> | EIP:drm_fb_helper_damage_work                                        =
                 | 0          | 26         |
> +----------------------------------------------------------------------=
-----------------+------------+------------+
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
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
> [   28.281467] Code: 47 10 8b 58 2c 85 db 0f 84 bc 01 00 00 e8 1f f0 da=
 f4 89 74 24 0c 89 5c 24 08 89 44 24 04 c7 04 24 98 c1 40 df e8 f7 50 1d =
f5 <0f> 0b 31 c9 c7 04 24 01 00 00 00 ba 01 00 00 00 b8 3c e8 40 df e8
> [   28.285055] EAX: 00000036 EBX: c1c91420 ECX: 00000000 EDX: 00000000
> [   28.289443] ESI: fffffff4 EDI: d2014000 EBP: d2c0dee4 ESP: d2c0de9c
> [   28.291058] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 000=
10292
> [   28.292717] CR0: 80050033 CR2: b727a028 CR3: 12141000 CR4: 00040690
> [   28.294316] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   28.295915] DR6: fffe0ff0 DR7: 00000400
> [   28.300768] Call Trace:
> [   28.302117]  process_one_work+0x31b/0x7b0
> [   28.303532]  ? process_one_work+0x272/0x7b0
> [   28.304976]  worker_thread+0x29a/0x5d0
> [   28.308712]  ? process_one_work+0x7b0/0x7b0
> [   28.310129]  kthread+0x181/0x1a0
> [   28.311464]  ? process_one_work+0x7b0/0x7b0
> [   28.312878]  ? kthread_create_worker_on_cpu+0x30/0x30
> [   28.314318]  ret_from_fork+0x1c/0x28
> [   28.315645] CPU: 0 PID: 122 Comm: kworker/0:2 Tainted: G            =
E     5.10.0-rc3-01102-g1d46491d4a08 #1
> [   28.317414] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.12.0-1 04/01/2014
> [   28.319096] Workqueue: events drm_fb_helper_damage_work [drm_kms_hel=
per]
> [   28.320674] Call Trace:
> [   28.321947]  dump_stack+0x6d/0x8b
> [   28.323278]  __warn.cold+0x24/0x49
> [   28.324639]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper=
]
> [   28.326167]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper=
]
> [   28.327670]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper=
]
> [   28.329165]  report_bug+0xb0/0xf0
> [   28.330438]  ? irq_work_queue+0x13/0x70
> [   28.331729]  ? exc_overflow+0x60/0x60
> [   28.333002]  handle_bug+0x2a/0x50
> [   28.334227]  exc_invalid_op+0x28/0x80
> [   28.335462]  handle_exception+0x15d/0x15d
> [   28.336729] EIP: drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_help=
er]
> [   28.338148] Code: 47 10 8b 58 2c 85 db 0f 84 bc 01 00 00 e8 1f f0 da=
 f4 89 74 24 0c 89 5c 24 08 89 44 24 04 c7 04 24 98 c1 40 df e8 f7 50 1d =
f5 <0f> 0b 31 c9 c7 04 24 01 00 00 00 ba 01 00 00 00 b8 3c e8 40 df e8
> [   28.341442] EAX: 00000036 EBX: c1c91420 ECX: 00000000 EDX: 00000000
> [   28.342910] ESI: fffffff4 EDI: d2014000 EBP: d2c0dee4 ESP: d2c0de9c
> [   28.344372] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 000=
10292
> [   28.345883]  ? cpu_latency_qos_write+0xeb/0xf0
> [   28.347203]  ? run_init_process+0x5b/0x158
> [   28.348483]  ? run_init_process+0x5b/0x158
> [   28.349714]  ? exc_overflow+0x60/0x60
> [   28.350895]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper=
]
> [   28.352244]  process_one_work+0x31b/0x7b0
> [   28.353432]  ? process_one_work+0x272/0x7b0
> [   28.354599]  worker_thread+0x29a/0x5d0
> [   28.355730]  ? process_one_work+0x7b0/0x7b0
> [   28.356894]  kthread+0x181/0x1a0
> [   28.357942]  ? process_one_work+0x7b0/0x7b0
> [   28.359019]  ? kthread_create_worker_on_cpu+0x30/0x30
> [   28.360134]  ret_from_fork+0x1c/0x28
> [   28.376652] irq event stamp: 9469
> [   28.377678] hardirqs last  enabled at (9477): [<d3903085>] console_u=
nlock+0x515/0x650
> [   28.378986] hardirqs last disabled at (9484): [<d3902f95>] console_u=
nlock+0x425/0x650
> [   28.380284] softirqs last  enabled at (9464): [<d467123d>] __do_soft=
irq+0x3fd/0x57c
> [   28.381595] softirqs last disabled at (9381): [<d382793c>] call_on_s=
tack+0x4c/0x60
> [   28.382878] ---[ end trace b5fac24d1c204ab3 ]---
>=20
>=20
> To reproduce:
>=20
>          # build kernel
> 	cd linux
> 	cp config-5.10.0-rc3-01102-g1d46491d4a08 .config
> 	make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Di386 olddefconfig prepare module=
s_prepare bzImage modules
> 	make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Di386 INSTALL_MOD_PATH=3D<mod-ins=
tall-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>=20
>=20
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-scri=
pt is attached in this email
>=20
>=20
>=20
> Thanks,
> Oliver Sang
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=FCrnberg, Germany
(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer


--kmfEKcoqoHu7tJzXCbHf8kI0EM3rAVmNw--

--DvI6JwtLv4nlvPjN5i34yK1LruptNUvbI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/Ilr0FAwAAAAAACgkQlh/E3EQov+DZ
3BAAmcFHkM94aREKE1BVaazAt6OcuTb+OtqfJbxFqpDgNrFFDYN/G3yb7lB3DhUnSkRqVmZ9TiXU
ukHyUJBqplalb/m4S0Dqx+pxjmZtTkw8j+YkUwm5kPtSeUm0lP2DlnEs3pwK7naX+5EnUQTFBtL9
ukZHbYmMGg4a9haCvituM5al62lcibBBgb+MPRUkBreUvunGhaOhQMz5R+fVghXi36hfwaAMxTeR
qrEd9/Wd/OGLy6nC43hNlWUE53PIrREdiYPtQG3QfE0VTVdjEkdH3O8RYdLVfCR0LYuTxRCkx/d2
NaXlafVwmOFGqW34gnt34INvWVyqQX8u1hOHwbFmjBcNvA/SKvDdlfi1tiQ4+HPwcmTUkmK5Oum7
SYVdvNX6SMwO1hDDaWJSv8u1jRDQ7HWTM6+jWJAPJiKZ8BZ4ZSizG6kOhcP3FitMnL7BQ+9z7Pdt
rbfa3lAkrRBpSv0h1pjcKBUf1UQIy3CE645nepb7o2h9FnUTCMmUeekLgnL8uG3ZUz3+p5/5iPch
p+xQ0Fse7JmwJkSoNuFqP+y2UzdZQ9tDFwdJY+OQP59BI7HzjnqSVqjJW6iBgjcy//3h/COAU0LS
Dxgy4/k0VAHSLeApQHM4WEP8WIuRUY5NadIlZZApkO7MlGlc6Z3B2zV733fyIGWPT16kFlaX/XNo
P4k=
=pC80
-----END PGP SIGNATURE-----

--DvI6JwtLv4nlvPjN5i34yK1LruptNUvbI--
