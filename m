Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2836629A582
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507646AbgJ0H1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:27:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:45807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507625AbgJ0H1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603783610;
        bh=5gbpb+V1uH9s0hXF5mnZo4RABY4NfZxg/OSD8rKtrVE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=hMXCVEWwyCPgtRnicUiDILKE90NK33YmwHiAIFiWmciq2mQENW2JCOq4M16FKmKnc
         4jOcMrz+liGpXvOkxXLhk9pEh5tilmdthDS4d0VhKXk2DbtAkbHJftf+Z9tessn/rM
         H8F7fTk6znL7ebnbV3kOey74oVW5W+4byHLotwik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1kY8Bw3GG5-003gyo; Tue, 27
 Oct 2020 08:26:49 +0100
Message-ID: <82f40988fb1c59d19833d198bd69d22cab7e81dd.camel@gmx.de>
Subject: 5.10-rc1 xhci  lockdep splat:  pin_fs_lock vs xhci->lock 
 HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb <linux-usb@vger.kernel.org>
Date:   Tue, 27 Oct 2020 08:26:48 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O0e2ZWBrwXPKV3ZPnDdEbp7MmDYp6oqTME9lmjDeM7gvXbbeJEv
 +d1ohBSCjEaFVRoyWlmV8cF/kyxg+t63WdRaVR9dtb9BquyV4kTbBzFmT/zggsDROxDehhd
 r+s66BYIsrsTMBASHuAXSlIcREJd9OhQCOhTFPXh2mx5S/em2FP5xVAdsJzNOOA5nvARuiJ
 r7EUdz2wP96PG47n/gVkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Vkn56gvtwA=:3yBoHT/BogMZ3kMEe9C6Ru
 mQu+3M6D/lrtXxIghLHYYIhvKzXZ95mBg6y0tVuNYBNCkmHf2ypnirsrrElbRRfnWfKpiIRPz
 3W2PkEfxj+UOzpJ2bmk5A/rDUrVrq2qyNPSqFFgHjq4L+DRzFtORUajw/j366uhtjz6Lou3bq
 MhEpJrou2RYK8FESy2fyxwPai+2kbec8LJEoZAiMKxhwi28nMOtWER4SqBqDQmJmGY0CFPfTv
 gYi3UhTZlDWxRgkZJ9Y4FumLoXZQtT/y1pTIm6qD6aLQ1S6VNr9iBNCLhRJ2XLlY0lviBEM0k
 p83BmiX1WmxciP6NigsTXYKlxrTgrVJ1K7OB1pG7RHhnnofQXR8OOq3f1z3ZgstQtUR5W4OkA
 ysgYVc1u2cIGenf2a5l2vX9ZVW8rRxg9LfQ/rRHMeJ4C1uqVe17qEjIGHu6a/0lpS/zYOFQot
 khKQnuCoNcHJsFjBHbvkOcSX1OZNV+yf1ZfkB9O3dQ8PEw6a718nVwqW5X7NerF7o386IzZk8
 Z7aAiPncyAEEDVnbHtf3zVWHT2rx6x6Gn3TFVWXrMBSt5K0RsJLINN6rnwEPQoP2GW1ByVZHr
 8RAojek1ccZaQAWa+p8Vs0o3Zhsc8yXJaHwnMN3T5utwzclbUfQAd8Olzc4m2pmgGh5pmdlR5
 SZHeKLDQQLRcgZE3liMB3OmF39Sw4PBP5KcKVNOzPOzwrir3Dgag60wx4nF6jknUHv/Pg3u0G
 1Wtl4BCcPgDL7RfwlBxjDVfWp0Oc0uLIfRGyNezqsba0hu8HisiXRhfOp063ITkQKicC49eeK
 Weg7HdR+74QLaw0bpNLOtepPkzEp4pAseuvgJnWJfVnda0Y+JlEmuKh8+SWWuk51GRgxBhzIs
 VUTgeDZ0wEhvCZvU7wrQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, $subject is followed by a might sleep splat.  Box is an aging HP
Spectre X360 lappy.

[    5.987129] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    5.987133] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[    5.987138] 5.10.0.g3650b22-master #15 Tainted: G          I E
[    5.987141] -----------------------------------------------------
[    5.987145] systemd-udevd/316 [HC0[0]:SC0[0]:HE0:SE1] is trying to acqu=
ire:
[    5.987149] ffffffffb85ba0f8 (pin_fs_lock){+.+.}-{2:2}, at: simple_pin_=
fs+0x22/0xa0
[    5.987161]
               and this task is already holding:
[    5.987164] ffff980789f4c430 (&xhci->lock){-.-.}-{2:2}, at: xhci_alloc_=
streams+0x592/0x880 [xhci_hcd]
[    5.987181] which would create a new lock dependency:
[    5.987184]  (&xhci->lock){-.-.}-{2:2} -> (pin_fs_lock){+.+.}-{2:2}
[    5.987191]
               but this new dependency connects a HARDIRQ-irq-safe lock:
[    5.987195]  (&xhci->lock){-.-.}-{2:2}
[    5.987197]
               ... which became HARDIRQ-irq-safe at:
[    5.987206]   lock_acquire+0x1a7/0x3b0
[    5.987211]   _raw_spin_lock_irqsave+0x3d/0x50
[    5.987220]   xhci_irq+0x3f/0x500 [xhci_hcd]
[    5.987225]   __handle_irq_event_percpu+0x4b/0x300
[    5.987229]   handle_irq_event_percpu+0x20/0x50
[    5.987232]   handle_irq_event+0x37/0x60
[    5.987236]   handle_edge_irq+0xaa/0x1d0
[    5.987239]   asm_call_irq_on_stack+0xf/0x20
[    5.987243]   common_interrupt+0x169/0x240
[    5.987247]   asm_common_interrupt+0x1e/0x40
[    5.987251]   native_queued_spin_lock_slowpath+0x6f/0x1f0
[    5.987255]   do_raw_spin_lock+0xb1/0xc0
[    5.987259]   dput+0x206/0x460
[    5.987262]   terminate_walk+0xfa/0x150
[    5.987265]   path_openat+0x29d/0xa60
[    5.987268]   do_filp_open+0x8c/0xf0
[    5.987272]   do_sys_openat2+0x1f8/0x2b0
[    5.987275]   do_sys_open+0x47/0x60
[    5.987278]   do_syscall_64+0x33/0x40
[    5.987282]   entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.987285]
               to a HARDIRQ-irq-unsafe lock:
[    5.987288]  (pin_fs_lock){+.+.}-{2:2}
[    5.987290]
               ... which became HARDIRQ-irq-unsafe at:
[    5.987296] ...
[    5.987298]   lock_acquire+0x1a7/0x3b0
[    5.987303]   _raw_spin_lock+0x2f/0x40
[    5.987306]   simple_pin_fs+0x22/0xa0
[    5.987310]   start_creating+0x57/0x180
[    5.987313]   debugfs_create_dir+0x15/0x140
[    5.987318]   em_debug_init+0x13/0x1d
[    5.987322]   do_one_initcall+0x54/0x2f0
[    5.987327]   kernel_init_freeable+0x26a/0x2ac
[    5.987331]   kernel_init+0xa/0x110
[    5.987334]   ret_from_fork+0x1f/0x30
[    5.987337]
               other info that might help us debug this:

[    5.987341]  Possible interrupt unsafe locking scenario:

[    5.987345]        CPU0                    CPU1
[    5.987348]        ----                    ----
[    5.987351]   lock(pin_fs_lock);
[    5.987354]                                local_irq_disable();
[    5.987357]                                lock(&xhci->lock);
[    5.987362]                                lock(pin_fs_lock);
[    5.987366]   <Interrupt>
[    5.987368]     lock(&xhci->lock);
[    5.987371]
                *** DEADLOCK ***

[    5.987375] 3 locks held by systemd-udevd/316:
[    5.987378]  #0: ffff98078a974218 (&dev->mutex){....}-{3:3}, at: __devi=
ce_driver_lock+0x38/0x50
[    5.987388]  #1: ffff98078a9769a8 (&dev->mutex){....}-{3:3}, at: device=
_driver_attach+0x1d/0x60
[    5.987396]  #2: ffff980789f4c430 (&xhci->lock){-.-.}-{2:2}, at: xhci_a=
lloc_streams+0x592/0x880 [xhci_hcd]
[    5.987409]
               the dependencies between HARDIRQ-irq-safe lock and the hold=
ing lock:
[    5.987420] -> (&xhci->lock){-.-.}-{2:2} {
[    5.987426]    IN-HARDIRQ-W at:
[    5.987430]                     lock_acquire+0x1a7/0x3b0
[    5.987434]                     _raw_spin_lock_irqsave+0x3d/0x50
[    5.987444]                     xhci_irq+0x3f/0x500 [xhci_hcd]
[    5.987448]                     __handle_irq_event_percpu+0x4b/0x300
[    5.987452]                     handle_irq_event_percpu+0x20/0x50
[    5.987456]                     handle_irq_event+0x37/0x60
[    5.987460]                     handle_edge_irq+0xaa/0x1d0
[    5.987464]                     asm_call_irq_on_stack+0xf/0x20
[    5.987468]                     common_interrupt+0x169/0x240
[    5.987472]                     asm_common_interrupt+0x1e/0x40
[    5.987477]                     native_queued_spin_lock_slowpath+0x6f/0=
x1f0
[    5.987481]                     do_raw_spin_lock+0xb1/0xc0
[    5.987485]                     dput+0x206/0x460
[    5.987488]                     terminate_walk+0xfa/0x150
[    5.987492]                     path_openat+0x29d/0xa60
[    5.987496]                     do_filp_open+0x8c/0xf0
[    5.987499]                     do_sys_openat2+0x1f8/0x2b0
[    5.987503]                     do_sys_open+0x47/0x60
[    5.987507]                     do_syscall_64+0x33/0x40
[    5.987511]                     entry_SYSCALL_64_after_hwframe+0x44/0xa=
9
[    5.987515]    IN-SOFTIRQ-W at:
[    5.987519]                     lock_acquire+0x1a7/0x3b0
[    5.987523]                     _raw_spin_lock_irqsave+0x3d/0x50
[    5.987533]                     xhci_hub_status_data+0xc2/0x390 [xhci_h=
cd]
[    5.987547]                     usb_hcd_poll_rh_status+0x41/0x180 [usbc=
ore]
[    5.987552]                     call_timer_fn+0x9d/0x2b0
[    5.987556]                     run_timer_softirq+0x48d/0x570
[    5.987560]                     __do_softirq+0xeb/0x4a4
[    5.987563]                     asm_call_irq_on_stack+0xf/0x20
[    5.987568]                     do_softirq_own_stack+0x81/0xa0
[    5.987573]                     irq_exit_rcu+0xf6/0x100
[    5.987577]                     sysvec_apic_timer_interrupt+0x57/0xf0
[    5.987582]                     asm_sysvec_apic_timer_interrupt+0x12/0x=
20
[    5.987586]                     debug_lockdep_rcu_enabled+0x2b/0x30
[    5.987592]                     dput+0x5f/0x460
[    5.987597]                     path_openat+0x87b/0xa60
[    5.987603]                     do_filp_open+0x8c/0xf0
[    5.987609]                     do_sys_openat2+0x1f8/0x2b0
[    5.987615]                     do_sys_open+0x47/0x60
[    5.987620]                     do_syscall_64+0x33/0x40
[    5.987628]                     entry_SYSCALL_64_after_hwframe+0x44/0xa=
9
[    5.987634]    INITIAL USE at:
[    5.987641]                    lock_acquire+0x1a7/0x3b0
[    5.987648]                    _raw_spin_lock_irqsave+0x3d/0x50
[    5.987665]                    xhci_hub_control+0xa5/0x2440 [xhci_hcd]
[    5.987681]                    usb_hcd_submit_urb+0x743/0xb00 [usbcore]
[    5.987701]                    usb_start_wait_urb+0x55/0x140 [usbcore]
[    5.987712]                    usb_control_msg+0xc3/0x110 [usbcore]
[    5.987721]                    hub_configure+0x103/0xc00 [usbcore]
[    5.987730]                    hub_probe+0x29c/0x350 [usbcore]
[    5.987740]                    usb_probe_interface+0x105/0x300 [usbcore=
]
[    5.987745]                    really_probe+0xf7/0x4d0
[    5.987749]                    driver_probe_device+0x5d/0x140
[    5.987753]                    bus_for_each_drv+0x5e/0x90
[    5.987757]                    __device_attach+0xbe/0x140
[    5.987761]                    bus_probe_device+0x9c/0xb0
[    5.987764]                    device_add+0x3fa/0x820
[    5.987774]                    usb_set_configuration+0x469/0x960 [usbco=
re]
[    5.987784]                    usb_generic_driver_probe+0x28/0x70 [usbc=
ore]
[    5.987794]                    usb_probe_device+0x3b/0xc0 [usbcore]
[    5.987798]                    really_probe+0xf7/0x4d0
[    5.987802]                    driver_probe_device+0x5d/0x140
[    5.987806]                    bus_for_each_drv+0x5e/0x90
[    5.987810]                    __device_attach+0xbe/0x140
[    5.987814]                    bus_probe_device+0x9c/0xb0
[    5.987817]                    device_add+0x3fa/0x820
[    5.987826]                    usb_new_device+0x21d/0x4a0 [usbcore]
[    5.987835]                    usb_add_hcd+0x60b/0x7f0 [usbcore]
[    5.987845]                    usb_hcd_pci_probe+0x237/0x480 [usbcore]
[    5.987850]                    xhci_pci_probe+0x6d/0x1df [xhci_pci]
[    5.987855]                    local_pci_probe+0x42/0x90
[    5.987859]                    pci_device_probe+0xe7/0x1a0
[    5.987863]                    really_probe+0xf7/0x4d0
[    5.987867]                    driver_probe_device+0x5d/0x140
[    5.987872]                    device_driver_attach+0x4f/0x60
[    5.987876]                    __driver_attach+0xa4/0x140
[    5.987879]                    bus_for_each_dev+0x67/0x90
[    5.987883]                    bus_add_driver+0x18c/0x230
[    5.987887]                    driver_register+0x5b/0xf0
[    5.987891]                    do_one_initcall+0x54/0x2f0
[    5.987896]                    do_init_module+0x5b/0x21b
[    5.987900]                    load_module+0x1e40/0x2370
[    5.987904]                    __do_sys_finit_module+0x98/0xe0
[    5.987908]                    do_syscall_64+0x33/0x40
[    5.987912]                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.987916]  }
[    5.987923]  ... key      at: [<ffffffffc06054e0>] __key.49448+0x0/0xff=
fffffffffe5b20 [xhci_hcd]
[    5.987927]  ... acquired at:
[    5.987930]    lock_acquire+0x1a7/0x3b0
[    5.987934]    _raw_spin_lock+0x2f/0x40
[    5.987938]    simple_pin_fs+0x22/0xa0
[    5.987941]    start_creating+0x57/0x180
[    5.987944]    __debugfs_create_file+0x3c/0x160
[    5.987954]    xhci_debugfs_create_stream_files+0x6a/0x90 [xhci_hcd]
[    5.987962]    xhci_alloc_streams+0x5fb/0x880 [xhci_hcd]
[    5.987971]    usb_alloc_streams+0xc2/0x120 [usbcore]
[    5.987976]    uas_configure_endpoints+0x124/0x150 [uas]
[    5.987981]    uas_probe+0x44d/0x5f6 [uas]
[    5.987990]    usb_probe_interface+0x105/0x300 [usbcore]
[    5.987994]    really_probe+0xf7/0x4d0
[    5.987998]    driver_probe_device+0x5d/0x140
[    5.988003]    device_driver_attach+0x4f/0x60
[    5.988008]    __driver_attach+0xa4/0x140
[    5.988013]    bus_for_each_dev+0x67/0x90
[    5.988018]    bus_add_driver+0x18c/0x230
[    5.988023]    driver_register+0x5b/0xf0
[    5.988032]    usb_register_driver+0xb1/0x170 [usbcore]
[    5.988036]    uas_init+0x46/0x1000 [uas]
[    5.988040]    do_one_initcall+0x54/0x2f0
[    5.988043]    do_init_module+0x5b/0x21b
[    5.988046]    load_module+0x1e40/0x2370
[    5.988050]    __do_sys_finit_module+0x98/0xe0
[    5.988053]    do_syscall_64+0x33/0x40
[    5.988057]    entry_SYSCALL_64_after_hwframe+0x44/0xa9

[    5.988062]
               the dependencies between the lock to be acquired
[    5.988062]  and HARDIRQ-irq-unsafe lock:
[    5.988074] -> (pin_fs_lock){+.+.}-{2:2} {
[    5.988080]    HARDIRQ-ON-W at:
[    5.988084]                     lock_acquire+0x1a7/0x3b0
[    5.988088]                     _raw_spin_lock+0x2f/0x40
[    5.988092]                     simple_pin_fs+0x22/0xa0
[    5.988096]                     start_creating+0x57/0x180
[    5.988099]                     debugfs_create_dir+0x15/0x140
[    5.988104]                     em_debug_init+0x13/0x1d
[    5.988108]                     do_one_initcall+0x54/0x2f0
[    5.988113]                     kernel_init_freeable+0x26a/0x2ac
[    5.988117]                     kernel_init+0xa/0x110
[    5.988121]                     ret_from_fork+0x1f/0x30
[    5.988124]    SOFTIRQ-ON-W at:
[    5.988128]                     lock_acquire+0x1a7/0x3b0
[    5.988132]                     _raw_spin_lock+0x2f/0x40
[    5.988136]                     simple_pin_fs+0x22/0xa0
[    5.988139]                     start_creating+0x57/0x180
[    5.988143]                     debugfs_create_dir+0x15/0x140
[    5.988147]                     em_debug_init+0x13/0x1d
[    5.988151]                     do_one_initcall+0x54/0x2f0
[    5.988155]                     kernel_init_freeable+0x26a/0x2ac
[    5.988159]                     kernel_init+0xa/0x110
[    5.988163]                     ret_from_fork+0x1f/0x30
[    5.988166]    INITIAL USE at:
[    5.988170]                    lock_acquire+0x1a7/0x3b0
[    5.988174]                    _raw_spin_lock+0x2f/0x40
[    5.988178]                    simple_pin_fs+0x22/0xa0
[    5.988181]                    start_creating+0x57/0x180
[    5.988185]                    debugfs_create_dir+0x15/0x140
[    5.988189]                    em_debug_init+0x13/0x1d
[    5.988193]                    do_one_initcall+0x54/0x2f0
[    5.988197]                    kernel_init_freeable+0x26a/0x2ac
[    5.988201]                    kernel_init+0xa/0x110
[    5.988205]                    ret_from_fork+0x1f/0x30
[    5.988208]  }
[    5.988211]  ... key      at: [<ffffffffb85ba0f8>] pin_fs_lock+0x18/0x4=
0
[    5.988215]  ... acquired at:
[    5.988218]    lock_acquire+0x1a7/0x3b0
[    5.988222]    _raw_spin_lock+0x2f/0x40
[    5.988225]    simple_pin_fs+0x22/0xa0
[    5.988228]    start_creating+0x57/0x180
[    5.988231]    __debugfs_create_file+0x3c/0x160
[    5.988241]    xhci_debugfs_create_stream_files+0x6a/0x90 [xhci_hcd]
[    5.988249]    xhci_alloc_streams+0x5fb/0x880 [xhci_hcd]
[    5.988258]    usb_alloc_streams+0xc2/0x120 [usbcore]
[    5.988262]    uas_configure_endpoints+0x124/0x150 [uas]
[    5.988267]    uas_probe+0x44d/0x5f6 [uas]
[    5.988276]    usb_probe_interface+0x105/0x300 [usbcore]
[    5.988280]    really_probe+0xf7/0x4d0
[    5.988283]    driver_probe_device+0x5d/0x140
[    5.988287]    device_driver_attach+0x4f/0x60
[    5.988290]    __driver_attach+0xa4/0x140
[    5.988294]    bus_for_each_dev+0x67/0x90
[    5.988297]    bus_add_driver+0x18c/0x230
[    5.988301]    driver_register+0x5b/0xf0
[    5.988310]    usb_register_driver+0xb1/0x170 [usbcore]
[    5.988314]    uas_init+0x46/0x1000 [uas]
[    5.988317]    do_one_initcall+0x54/0x2f0
[    5.988321]    do_init_module+0x5b/0x21b
[    5.988324]    load_module+0x1e40/0x2370
[    5.988327]    __do_sys_finit_module+0x98/0xe0
[    5.988330]    do_syscall_64+0x33/0x40
[    5.988334]    entry_SYSCALL_64_after_hwframe+0x44/0xa9

[    5.988339]
               stack backtrace:
[    5.988343] CPU: 0 PID: 316 Comm: systemd-udevd Tainted: G          I E=
     5.10.0.g3650b22-master #15
[    5.988348] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.=
47 11/22/2017
[    5.988352] Call Trace:
[    5.988357]  dump_stack+0x77/0x97
[    5.988362]  check_irq_usage+0x7a8/0x7b0
[    5.988367]  ? check_path.constprop.54+0x22/0x40
[    5.988373]  ? __lock_acquire+0x14af/0x1a70
[    5.988377]  __lock_acquire+0x14af/0x1a70
[    5.988383]  lock_acquire+0x1a7/0x3b0
[    5.988386]  ? simple_pin_fs+0x22/0xa0
[    5.988392]  _raw_spin_lock+0x2f/0x40
[    5.988395]  ? simple_pin_fs+0x22/0xa0
[    5.988398]  simple_pin_fs+0x22/0xa0
[    5.988402]  start_creating+0x57/0x180
[    5.988406]  __debugfs_create_file+0x3c/0x160
[    5.988416]  xhci_debugfs_create_stream_files+0x6a/0x90 [xhci_hcd]
[    5.988425]  xhci_alloc_streams+0x5fb/0x880 [xhci_hcd]
[    5.988433]  ? xhci_free_streams+0x390/0x390 [xhci_hcd]
[    5.988443]  usb_alloc_streams+0xc2/0x120 [usbcore]
[    5.988448]  uas_configure_endpoints+0x124/0x150 [uas]
[    5.988453]  uas_probe+0x44d/0x5f6 [uas]
[    5.988464]  usb_probe_interface+0x105/0x300 [usbcore]
[    5.988470]  really_probe+0xf7/0x4d0
[    5.988474]  driver_probe_device+0x5d/0x140
[    5.988478]  device_driver_attach+0x4f/0x60
[    5.988482]  __driver_attach+0xa4/0x140
[    5.988486]  ? device_driver_attach+0x60/0x60
[    5.988490]  bus_for_each_dev+0x67/0x90
[    5.988494]  ? preempt_count_sub+0x9b/0xd0
[    5.988498]  bus_add_driver+0x18c/0x230
[    5.988502]  driver_register+0x5b/0xf0
[    5.988511]  usb_register_driver+0xb1/0x170 [usbcore]
[    5.988516]  ? 0xffffffffc03d1000
[    5.988520]  uas_init+0x46/0x1000 [uas]
[    5.988523]  do_one_initcall+0x54/0x2f0
[    5.988528]  ? kmem_cache_alloc_trace+0x5d5/0x7d0
[    5.988533]  do_init_module+0x5b/0x21b
[    5.988536]  load_module+0x1e40/0x2370
[    5.988544]  ? __do_sys_finit_module+0x98/0xe0
[    5.988547]  __do_sys_finit_module+0x98/0xe0
[    5.988553]  do_syscall_64+0x33/0x40
[    5.988557]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.988561] RIP: 0033:0x7f793ca6b839
[    5.988566] Code: 00 48 81 c4 80 00 00 00 89 f0 c3 66 0f 1f 44 00 00 48=
 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2f d6 2b 00 f7 d8 64 89 01 48
[    5.988574] RSP: 002b:00007ffe91014848 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000139
[    5.988579] RAX: ffffffffffffffda RBX: 000055611701cd10 RCX: 00007f793c=
a6b839
[    5.988583] RDX: 0000000000000000 RSI: 00007f793d3a687d RDI: 0000000000=
00000e
[    5.988587] RBP: 00007f793d3a687d R08: 0000000000000000 R09: 0000000000=
000000
[    5.988591] R10: 000000000000000e R11: 0000000000000246 R12: 0000000000=
020000
[    5.988595] R13: 000055611700d820 R14: 0000000000000000 R15: 0000000003=
938700
[    5.988603] BUG: sleeping function called from invalid context at kerne=
l/locking/rwsem.c:1530
[    5.988608] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 316,=
 name: systemd-udevd
[    5.988612] INFO: lockdep is turned off.
[    5.988615] irq event stamp: 59514
[    5.988618] hardirqs last  enabled at (59513): [<ffffffffb79bfee4>] _ra=
w_spin_unlock_irq+0x24/0x50
[    5.988624] hardirqs last disabled at (59514): [<ffffffffb79bfcc7>] _ra=
w_spin_lock_irqsave+0x17/0x50
[    5.988629] softirqs last  enabled at (58022): [<ffffffffb7c002d7>] __d=
o_softirq+0x2d7/0x4a4
[    5.988634] softirqs last disabled at (57585): [<ffffffffb7a00fdf>] asm=
_call_irq_on_stack+0xf/0x20
[    5.988639] Preemption disabled at:
[    5.988640] [<0000000000000000>] 0x0
[    5.988645] CPU: 0 PID: 316 Comm: systemd-udevd Tainted: G          I E=
     5.10.0.g3650b22-master #15
[    5.988650] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.=
47 11/22/2017
[    5.988654] Call Trace:
[    5.988658]  dump_stack+0x77/0x97
[    5.988662]  ___might_sleep+0x17d/0x260
[    5.988666]  down_write+0x1c/0x70
[    5.988669]  start_creating+0x7b/0x180
[    5.988673]  __debugfs_create_file+0x3c/0x160
[    5.988684]  xhci_debugfs_create_stream_files+0x6a/0x90 [xhci_hcd]
[    5.988692]  xhci_alloc_streams+0x5fb/0x880 [xhci_hcd]
[    5.988700]  ? xhci_free_streams+0x390/0x390 [xhci_hcd]
[    5.988710]  usb_alloc_streams+0xc2/0x120 [usbcore]
[    5.988715]  uas_configure_endpoints+0x124/0x150 [uas]
[    5.988721]  uas_probe+0x44d/0x5f6 [uas]
[    5.988731]  usb_probe_interface+0x105/0x300 [usbcore]
[    5.988736]  really_probe+0xf7/0x4d0
[    5.988741]  driver_probe_device+0x5d/0x140
[    5.988745]  device_driver_attach+0x4f/0x60
[    5.988749]  __driver_attach+0xa4/0x140
[    5.988753]  ? device_driver_attach+0x60/0x60
[    5.988756]  bus_for_each_dev+0x67/0x90
[    5.988760]  ? preempt_count_sub+0x9b/0xd0
[    5.988764]  bus_add_driver+0x18c/0x230
[    5.988768]  driver_register+0x5b/0xf0
[    5.988777]  usb_register_driver+0xb1/0x170 [usbcore]
[    5.988781]  ? 0xffffffffc03d1000
[    5.988785]  uas_init+0x46/0x1000 [uas]
[    5.988788]  do_one_initcall+0x54/0x2f0
[    5.988792]  ? kmem_cache_alloc_trace+0x5d5/0x7d0
[    5.988797]  do_init_module+0x5b/0x21b
[    5.988801]  load_module+0x1e40/0x2370
[    5.988808]  ? __do_sys_finit_module+0x98/0xe0
[    5.988811]  __do_sys_finit_module+0x98/0xe0
[    5.988817]  do_syscall_64+0x33/0x40
[    5.988821]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.988825] RIP: 0033:0x7f793ca6b839
[    5.988828] Code: 00 48 81 c4 80 00 00 00 89 f0 c3 66 0f 1f 44 00 00 48=
 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2f d6 2b 00 f7 d8 64 89 01 48
[    5.988836] RSP: 002b:00007ffe91014848 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000139
[    5.988841] RAX: ffffffffffffffda RBX: 000055611701cd10 RCX: 00007f793c=
a6b839
[    5.988845] RDX: 0000000000000000 RSI: 00007f793d3a687d RDI: 0000000000=
00000e
[    5.988849] RBP: 00007f793d3a687d R08: 0000000000000000 R09: 0000000000=
000000
[    5.988853] R10: 000000000000000e R11: 0000000000000246 R12: 0000000000=
020000
[    5.988857] R13: 000055611700d820 R14: 0000000000000000 R15: 0000000003=
938700

