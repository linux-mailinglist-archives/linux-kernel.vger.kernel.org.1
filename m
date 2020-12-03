Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474AA2CD133
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbgLCIXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:23:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:29770 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387545AbgLCIXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:23:05 -0500
IronPort-SDR: 7nlH4DAYP+8eE+KNaQZ35byN36jUNm1DpOJY/ViAjk4bsDIDvZSaZluUbR7rHWNmFiVuckbSUo
 cTgJbH7NZkPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="170588244"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="170588244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:22:24 -0800
IronPort-SDR: tVNgZCd0NrEoNU3NTr22Ytkm25gqA7omiRICkErN6sPz1Z6WM3HhJi7s+ducm7pW+3vX/qgDGC
 1N2TGYjwp/OQ==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="550401465"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:22:21 -0800
Date:   Thu, 3 Dec 2020 16:36:29 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [drm/fb] 1d46491d4a:
 WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_work[drm_kms_helper]
Message-ID: <20201203083629.GH27350@xsang-OptiPlex-9020>
References: <20201202022936.GA12321@xsang-OptiPlex-9020>
 <eb24560e-e6ef-6a97-10cd-59a167ad3fde@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb24560e-e6ef-6a97-10cd-59a167ad3fde@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 08:41:49AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> there should be a line in the kernel log that says something like "Damage
> blitter failed" with an error code. Is there any chance of recovering it?
> 

Hi Thomas,

we attached dmesg in original report, where below comes from.

[   28.258177] ------------[ cut here ]------------
[   28.259527] bochs-drm 0000:00:02.0: Damage blitter failed: ret=-12
[   28.261007] WARNING: CPU: 0 PID: 122 at drivers/gpu/drm/drm_fb_helper.c:434 drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
[   28.263802] Modules linked in: locktorture(E) torture(E) mousedev(E) ppdev(E) psmouse(E) crc32c_intel(E) input_leds(E) bochs_drm(E) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) parport_pc(E) rtc_cmos(E) parport(E) drm(E) evbug(E) i6300esb(E) i2c_piix4(E) autofs4(E)
[   28.271897] CPU: 0 PID: 122 Comm: kworker/0:2 Tainted: G            E     5.10.0-rc3-01102-g1d46491d4a08 #1
[   28.273904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   28.275819] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
[   28.279884] EIP: drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]


> Best regards
> Thomas
> 
> Am 02.12.20 um 03:29 schrieb kernel test robot:
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 1d46491d4a08d7ee657e09808f87d169444a2652 ("drm/fb-helper: Move damage blit code and its setup into separate routine")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > 
> > in testcase: locktorture
> > version:
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 
> > test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
> > test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
> > 
> > 
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +---------------------------------------------------------------------------------------+------------+------------+
> > |                                                                                       | fd2d856538 | 1d46491d4a |
> > +---------------------------------------------------------------------------------------+------------+------------+
> > | WARNING:at_drivers/gpu/drm/drm_fb_helper.c:#drm_fb_helper_damage_work[drm_kms_helper] | 0          | 26         |
> > | EIP:drm_fb_helper_damage_work                                                         | 0          | 26         |
> > +---------------------------------------------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > [   28.261007] WARNING: CPU: 0 PID: 122 at drivers/gpu/drm/drm_fb_helper.c:434 drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> > [   28.263802] Modules linked in: locktorture(E) torture(E) mousedev(E) ppdev(E) psmouse(E) crc32c_intel(E) input_leds(E) bochs_drm(E) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) parport_pc(E) rtc_cmos(E) parport(E) drm(E) evbug(E) i6300esb(E) i2c_piix4(E) autofs4(E)
> > [   28.271897] CPU: 0 PID: 122 Comm: kworker/0:2 Tainted: G            E     5.10.0-rc3-01102-g1d46491d4a08 #1
> > [   28.273904] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [   28.275819] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> > [   28.279884] EIP: drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> > [   28.281467] Code: 47 10 8b 58 2c 85 db 0f 84 bc 01 00 00 e8 1f f0 da f4 89 74 24 0c 89 5c 24 08 89 44 24 04 c7 04 24 98 c1 40 df e8 f7 50 1d f5 <0f> 0b 31 c9 c7 04 24 01 00 00 00 ba 01 00 00 00 b8 3c e8 40 df e8
> > [   28.285055] EAX: 00000036 EBX: c1c91420 ECX: 00000000 EDX: 00000000
> > [   28.289443] ESI: fffffff4 EDI: d2014000 EBP: d2c0dee4 ESP: d2c0de9c
> > [   28.291058] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010292
> > [   28.292717] CR0: 80050033 CR2: b727a028 CR3: 12141000 CR4: 00040690
> > [   28.294316] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   28.295915] DR6: fffe0ff0 DR7: 00000400
> > [   28.300768] Call Trace:
> > [   28.302117]  process_one_work+0x31b/0x7b0
> > [   28.303532]  ? process_one_work+0x272/0x7b0
> > [   28.304976]  worker_thread+0x29a/0x5d0
> > [   28.308712]  ? process_one_work+0x7b0/0x7b0
> > [   28.310129]  kthread+0x181/0x1a0
> > [   28.311464]  ? process_one_work+0x7b0/0x7b0
> > [   28.312878]  ? kthread_create_worker_on_cpu+0x30/0x30
> > [   28.314318]  ret_from_fork+0x1c/0x28
> > [   28.315645] CPU: 0 PID: 122 Comm: kworker/0:2 Tainted: G            E     5.10.0-rc3-01102-g1d46491d4a08 #1
> > [   28.317414] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [   28.319096] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> > [   28.320674] Call Trace:
> > [   28.321947]  dump_stack+0x6d/0x8b
> > [   28.323278]  __warn.cold+0x24/0x49
> > [   28.324639]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> > [   28.326167]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> > [   28.327670]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> > [   28.329165]  report_bug+0xb0/0xf0
> > [   28.330438]  ? irq_work_queue+0x13/0x70
> > [   28.331729]  ? exc_overflow+0x60/0x60
> > [   28.333002]  handle_bug+0x2a/0x50
> > [   28.334227]  exc_invalid_op+0x28/0x80
> > [   28.335462]  handle_exception+0x15d/0x15d
> > [   28.336729] EIP: drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> > [   28.338148] Code: 47 10 8b 58 2c 85 db 0f 84 bc 01 00 00 e8 1f f0 da f4 89 74 24 0c 89 5c 24 08 89 44 24 04 c7 04 24 98 c1 40 df e8 f7 50 1d f5 <0f> 0b 31 c9 c7 04 24 01 00 00 00 ba 01 00 00 00 b8 3c e8 40 df e8
> > [   28.341442] EAX: 00000036 EBX: c1c91420 ECX: 00000000 EDX: 00000000
> > [   28.342910] ESI: fffffff4 EDI: d2014000 EBP: d2c0dee4 ESP: d2c0de9c
> > [   28.344372] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010292
> > [   28.345883]  ? cpu_latency_qos_write+0xeb/0xf0
> > [   28.347203]  ? run_init_process+0x5b/0x158
> > [   28.348483]  ? run_init_process+0x5b/0x158
> > [   28.349714]  ? exc_overflow+0x60/0x60
> > [   28.350895]  ? drm_fb_helper_damage_work+0x109/0x2d0 [drm_kms_helper]
> > [   28.352244]  process_one_work+0x31b/0x7b0
> > [   28.353432]  ? process_one_work+0x272/0x7b0
> > [   28.354599]  worker_thread+0x29a/0x5d0
> > [   28.355730]  ? process_one_work+0x7b0/0x7b0
> > [   28.356894]  kthread+0x181/0x1a0
> > [   28.357942]  ? process_one_work+0x7b0/0x7b0
> > [   28.359019]  ? kthread_create_worker_on_cpu+0x30/0x30
> > [   28.360134]  ret_from_fork+0x1c/0x28
> > [   28.376652] irq event stamp: 9469
> > [   28.377678] hardirqs last  enabled at (9477): [<d3903085>] console_unlock+0x515/0x650
> > [   28.378986] hardirqs last disabled at (9484): [<d3902f95>] console_unlock+0x425/0x650
> > [   28.380284] softirqs last  enabled at (9464): [<d467123d>] __do_softirq+0x3fd/0x57c
> > [   28.381595] softirqs last disabled at (9381): [<d382793c>] call_on_stack+0x4c/0x60
> > [   28.382878] ---[ end trace b5fac24d1c204ab3 ]---
> > 
> > 
> > To reproduce:
> > 
> >          # build kernel
> > 	cd linux
> > 	cp config-5.10.0-rc3-01102-g1d46491d4a08 .config
> > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> > 	cd <mod-install-dir>
> > 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> > 
> > 
> >          git clone https://github.com/intel/lkp-tests.git
> >          cd lkp-tests
> >          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> > 
> > 
> > 
> > Thanks,
> > Oliver Sang
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer
> 



