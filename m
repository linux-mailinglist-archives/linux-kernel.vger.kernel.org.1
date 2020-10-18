Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85FE2916ED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 12:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgJRK0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 06:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgJRK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 06:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603016764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GVfsA82+v5YLueWSOkK8X8Xx4ZnsJpv+KSk122YM5A=;
        b=Wgt0nu9Bv3bo5p4pvCvmT4eXRvJv+im7atTZdmewLeOyScyKslGifcIPoCHc9RL577F9kf
        N/MhGnk5sy7TRm8ye1bQY6YkC6B0nJysTThENrQj+E3kYhqu/jqaQ1l3M8Ca6QRYZOFkWh
        nurTThohv1pk0BKqyFrmohav+QbtIOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316--g9Epb7vO-Ot-Km96qHyCQ-1; Sun, 18 Oct 2020 06:26:01 -0400
X-MC-Unique: -g9Epb7vO-Ot-Km96qHyCQ-1
Received: by mail-wr1-f71.google.com with SMTP id 2so6008763wrd.14
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 03:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GVfsA82+v5YLueWSOkK8X8Xx4ZnsJpv+KSk122YM5A=;
        b=szPRK6DgRZIEO82ri0ZbnLP2KZtsTRT3H4z+tJyf9ibRI+cfcZCHKYPJrewGEJT/vt
         PFoGcb6H3ZPq87ko7LfpqZsjDfKCXDlHpBeSHSwd44TQ3TfB1mUduPui8DKhEzMf0lu4
         lPQaBjRa3AfYzEbJxs2xJcjnfhCZFF0rXTHyJOJHV0W/ot/PgBiNVTvHGAIPjMSYvrqk
         Wz0AyqzJ2pJXjmQkiKxfLE6nWzDwj/AKbvV1+IczbUVEoN0KhighYmf0pyRbypXtMEt5
         ugnrP2EAiXlKfo/pdTa/yXBGklBaFQ7Twxz6nN3qkZ81j/Etm4jpYb9RFcnpuaLv7+eL
         PWmQ==
X-Gm-Message-State: AOAM532WMNDi0h6jSccn/xmz+lsVHUjGDVW94LwtzW8bTQnHxNJBaJ1G
        dQP0t4DaGfdQzi+oTdz9ghcJx1YlIxDjOZ9AuANGcjA51yPJsh5vpbmRb3myf9qLN7pVSc/EQ68
        84wMqS+rNtqNCrRknwh0blERt
X-Received: by 2002:a1c:55c1:: with SMTP id j184mr12555676wmb.180.1603016759298;
        Sun, 18 Oct 2020 03:25:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcp/KKt4lwPJK3QoVoLfEFo7QRRsHfLvPrJtzgOKfVSp91pBI06r+DbbW+jZ+uapztLmnNzQ==
X-Received: by 2002:a1c:55c1:: with SMTP id j184mr12555657wmb.180.1603016759049;
        Sun, 18 Oct 2020 03:25:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id y4sm2597311wmj.2.2020.10.18.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 03:25:58 -0700 (PDT)
Date:   Sun, 18 Oct 2020 06:25:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [virtio] 3618ad2a7c: kernel_BUG_at_drivers/net/virtio_net.c
Message-ID: <20201018055716-mutt-send-email-mst@kernel.org>
References: <20201018082514.GI11647@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018082514.GI11647@shao2-debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 04:25:14PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 3618ad2a7c0e78e4258386394d5d5f92a3dbccf8 ("virtio-net: ethtool configurable RXCSUM")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: trinity
> version: trinity-i386
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------+------------+------------+
> |                                        | c9bf52a173 | 3618ad2a7c |
> +----------------------------------------+------------+------------+
> | boot_successes                         | 18         | 0          |
> | boot_failures                          | 0          | 20         |
> | kernel_BUG_at_drivers/net/virtio_net.c | 0          | 20         |
> | invalid_opcode:#[##]                   | 0          | 20         |
> | EIP:virtnet_send_command               | 0          | 20         |
> | Kernel_panic-not_syncing               | 0          | 20         |
> +----------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> [   72.229171] kernel BUG at drivers/net/virtio_net.c:1667!
> [   72.230266] invalid opcode: 0000 [#1] PREEMPT SMP
> [   72.231172] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc8-02934-g3618ad2a7c0e7 #1
> [   72.231172] EIP: virtnet_send_command+0x120/0x140
> [   72.231172] Code: 00 0f 94 c0 8b 7d f0 65 33 3d 14 00 00 00 75 1c 8d 65 f4 5b 5e 5f 5d c3 66 90 be 01 00 00 00 e9 6e ff ff ff 8d b6 00 00 00 00 <0f> 0b e8 d9 bb 82 00 eb 17 8d b4 26 00 00 00 00 8d b4 26 00 00 00
> [   72.231172] EAX: 0000000d EBX: f72895c0 ECX: 00000017 EDX: 00000011
> [   72.231172] ESI: f7197800 EDI: ed69bd00 EBP: ed69bcf4 ESP: ed69bc98
> [   72.231172] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   72.231172] CR0: 80050033 CR2: 00000000 CR3: 02c84000 CR4: 000406f0
> [   72.231172] Call Trace:
> [   72.231172]  ? __virt_addr_valid+0x45/0x60
> [   72.231172]  ? ___cache_free+0x51f/0x760
> [   72.231172]  ? kobject_uevent_env+0xf4/0x560
> [   72.231172]  virtnet_set_guest_offloads+0x4d/0x80
> [   72.231172]  virtnet_set_features+0x85/0x120
> [   72.231172]  ? virtnet_set_guest_offloads+0x80/0x80
> [   72.231172]  __netdev_update_features+0x27a/0x8e0
> [   72.231172]  ? kobject_uevent+0xa/0x20
> [   72.231172]  ? netdev_register_kobject+0x12c/0x160
> [   72.231172]  register_netdevice+0x4fe/0x740
> [   72.231172]  register_netdev+0x1c/0x40
> [   72.231172]  virtnet_probe+0x728/0xb60
> [   72.231172]  ? _raw_spin_unlock+0x1d/0x40
> [   72.231172]  ? virtio_vdpa_get_status+0x1c/0x20
> [   72.231172]  virtio_dev_probe+0x1c6/0x271
> [   72.231172]  really_probe+0x195/0x2e0
> [   72.231172]  driver_probe_device+0x26/0x60
> [   72.231172]  device_driver_attach+0x49/0x60
> [   72.231172]  __driver_attach+0x46/0xc0
> [   72.231172]  ? device_driver_attach+0x60/0x60
> [   72.231172]  bus_for_each_dev+0x5d/0xa0
> [   72.231172]  driver_attach+0x19/0x20
> [   72.231172]  ? device_driver_attach+0x60/0x60
> [   72.231172]  bus_add_driver+0x197/0x1c0
> [   72.231172]  driver_register+0x66/0xc0
> [   72.231172]  register_virtio_driver+0x1b/0x40
> [   72.231172]  virtio_net_driver_init+0x61/0x86
> [   72.231172]  ? veth_init+0x14/0x14
> [   72.231172]  do_one_initcall+0x76/0x2e4
> [   72.231172]  ? rdinit_setup+0x2a/0x2a
> [   72.231172]  do_initcalls+0xb2/0xd5
> [   72.231172]  kernel_init_freeable+0x14f/0x179
> [   72.231172]  ? rest_init+0x100/0x100
> [   72.231172]  kernel_init+0xd/0xe0
> [   72.231172]  ret_from_fork+0x1c/0x30
> [   72.231172] Modules linked in:
> [   72.269563] ---[ end trace a6ebc4afea0e6cb1 ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.9.0-rc8-02934-g3618ad2a7c0e7 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> lkp
> 

OK I more or less see what is going on.

virtnet_set_features now calls virtnet_set_guest_offloads
unconditionally, it used to only call it when there is something
to configure.


If device does not have a control vq, everything breaks.

Looking at this some more, I noticed that it's not really checking the
hardware too much. E.g.

        if ((dev->features ^ features) & NETIF_F_LRO) {
                if (features & NETIF_F_LRO)
                        offloads |= GUEST_OFFLOAD_LRO_MASK &
                                    vi->guest_offloads_capable;
                else
                        offloads &= ~GUEST_OFFLOAD_LRO_MASK;
        }


and

#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
                                (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
                                (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
                                (1ULL << VIRTIO_NET_F_GUEST_UFO))

But there's no guarantee that e.g. VIRTIO_NET_F_GUEST_TSO6 is set.
If it isn't command should not send it.

And also

static int virtnet_set_features(struct net_device *dev,
                                netdev_features_t features)
{
        struct virtnet_info *vi = netdev_priv(dev);
        u64 offloads = vi->guest_offloads;


seems wrong since guest_offloads is zero initialized,
it does not reflect the state after reset which comes from
the features.

I suggest we revert 3618ad2a7c0e78 for now.

Let's work on something more robust wrt possible hardware features.



-- 
MST

