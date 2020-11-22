Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408372BC90A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 21:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgKVUEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 15:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKVUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 15:03:59 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA453C0613CF;
        Sun, 22 Nov 2020 12:03:57 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id y24so8472350otk.3;
        Sun, 22 Nov 2020 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ej8UpWpNx+kUjy78/+aVbJoBSOM5eLbaK9OKb7VyLI=;
        b=PwMRZESW533KneoTQK8K5CHxtXlhn3H22HZBkb4qtK4MyM9cMqlMasP8DroFVvixxO
         3XFphc0B6iyrRdRzCQr1fHfYsWp0NSR30ztNN4aryHTe7kYjvdUY4XX487nRcdWeixbL
         roySrRpYGCb66SBKFGgNQg/VGWuShvctoGQ6NtN/NTmxvsM87mldtEq+LxnuYBpISl+W
         Loj4rRjkhfcbSgQ1BJ5rYOCWp7kt0J5TrtkZUtXX/pva3gxh8axTuWGit7ztLqcbNktg
         4N2V7cvwPyn9ZKxRZ24sPUUfYRLuRzsKm0EsSPdaiVYPdlT3kW4HoVaCz4PXxKh6gmQy
         4oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ej8UpWpNx+kUjy78/+aVbJoBSOM5eLbaK9OKb7VyLI=;
        b=T1vz9ei3rBtm6N++ECPyZt6YJug5jYviY9Q9tIEKwCX3lzWjIN3ZxBwjXiME2iuRu0
         5y8Ay/gmYA1ODxHCPo6ltkpaXe8kaMXuDESdX2Qxsocmz2MPJ6jsGeu+oFtpu3lSPOit
         6vZ2GVfbCqy2IbiuMo0uS8SEgufqDrWe6i9z5Ct8vJO3CHR3UV++mVFRurEjfl+X8PmS
         QTNc8YC6K/0wtmRrjHiAli225Ddqd5uOfPG99OtLklUlSYv9OPv4vWsP5wiTWCyZBoiX
         8TWB4WhaBAr2xBTJGC3YBYHZPvf+TGbqQLjiJRbIxiIfrUdlux7g4cXlUHDfLFzyEld+
         sscw==
X-Gm-Message-State: AOAM531noVrqwUYxuND21u7MIYICGYAKJh475pQauVVDXMbGOGtwNTC6
        UfYorXvD1b+huRM6M6+y2hdZvwA8a3el22fRih44M/W3YCQqPQ==
X-Google-Smtp-Source: ABdhPJxkvm+HQDwFMvLc3u9wq/xiXOZIw66duw8m4fGX2RSdBeaEx64Q4IPtWvJ29TPDPhZyhpOmXPmH4g56IxVcoxU=
X-Received: by 2002:a05:6830:2151:: with SMTP id r17mr21434345otd.328.1606075436894;
 Sun, 22 Nov 2020 12:03:56 -0800 (PST)
MIME-Version: 1.0
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com> <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com> <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
 <20201112192524.GB287229@rowland.harvard.edu> <CAO5W59hXOHAd_D0K3HnvJmf883e_u+s6oM+DGJMqpr392N5Gww@mail.gmail.com>
 <20201113163449.GB322940@rowland.harvard.edu> <CAO5W59iqXGeAQTP7hzzRmbqwZUcK=vwuJ7pFzzNzZ9o11_k2tw@mail.gmail.com>
 <20201113171658.GF322940@rowland.harvard.edu>
In-Reply-To: <20201113171658.GF322940@rowland.harvard.edu>
From:   John Boero <boeroboy@gmail.com>
Date:   Sun, 22 Nov 2020 20:03:43 +0000
Message-ID: <CAO5W59hRNB0xH1Z2cd17ckYuHp38zL366K_3AuMoH8WTZYatow@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alan
I just spent some more time investigating and playing with different patches,
locks, mutexes, and sleeps, and I think I see exactly what's happening now.
I now understand why it:
A) seems to happen randomly during uvc start_stream
B) affects multiple device vendors
C) has been reported in RaspberryPi and IoT threads

I put a trace on usb/core/hub.c:usb_disconnect to identify why the device was
disconnecting and it seems this is a low power issue.  An idle webcam appears
fine to usbcore but as soon as you initialize it or uvc starts a stream, it
consumes more power, might find the cable can't supply it, and then disconnects
via interrupt. In my case I can reproduce this consistently with a cheap USB
extension cable, but this issue appears common to passive hubs, and IoT or SBCs
that don't always supply clean power over USB.  My simplified patch can at least
protect usbcore from crashing on a bad device:

From 73019d79fe4fd8b2c945005f8a067f528d8056fd Mon Sep 17 00:00:00 2001
From: jboero <boeroboy@gmail.com>
Date: Sun, 22 Nov 2020 19:30:41 +0000
Subject: [PATCH] USBCore NULL interface deref fix

---
drivers/usb/core/usb.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index bafc113f2b3e..da46c84c87ce 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -278,7 +278,7 @@ struct usb_interface *usb_ifnum_to_if(const struct
usb_device *dev,
       if (!config)
               return NULL;
       for (i = 0; i < config->desc.bNumInterfaces; i++)
-               if (config->interface[i]->altsetting[0]
+               if (config->interface[i] && config->interface[i]->altsetting[0]
                               .desc.bInterfaceNumber == ifnum)
                       return config->interface[i];

--
2.26.2



This protects ongoing USB functionality including lsusb, and prevents a hang on
reboot after error.  It doesn't help a user diagnose the error on the UVC side.
A fix from the uvc side is a little trickier and I'd like an opinion on how
best to handle locks in uvc_video_start_transfer. I've tried a few options
around uvcvideo.c:1874

ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);

I've even used multiple msleeps and checked for NULL interfaces but that feels
like a cheap trick and I was wondering what lock solution might help best here?

Thanks!
John Boero

Trace:
[ 115.872606] uvcvideo: Device requested 2688 B/frame bandwidth.
[ 115.872610] uvcvideo: Selecting alternate setting 10 (2688 B/frame bandwidth).
[ 115.872611] uvcvideo: jboero sleeping 5ms for race condition.
[ 115.886305] ------------[ cut here ]------------
[ 115.886310] jboero dev disconnecting - 200ms sleep!
[ 115.886354] WARNING: CPU: 18 PID: 321 at drivers/usb/core/hub.c:2194
usb_disconnect+0x25/0xb0
[ 115.886359] Modules linked in: snd_seq_dummy snd_hrtimer rfcomm
rc_cec nouveau vboxnetadp(OE) vboxnetflt(OE) mxm_wmi video vboxdrv(OE)
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp
nft_objref nf_conntrack_tftp tun bridge stp llc rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables
iptable_filter overlay cmac bnep lm75 sunrpc vfat fat squashfs loop
intel_rapl_msr intel_rapl_common btusb btrtl snd_hda_codec_realtek
sb_edac btbcm btintel x86_pkg_temp_thermal snd_hda_codec_generic
snd_hda_codec_hdmi ledtrig_audio uvcvideo intel_powerclamp ucsi_ccg
videobuf2_vmalloc snd_hda_intel coretemp dm_cache_smq videobuf2_memops
[ 115.886422] bluetooth typec_ucsi snd_intel_dspcfg videobuf2_v4l2
kvm_intel iTCO_wdt intel_pmc_bxt typec iTCO_vendor_support
snd_usb_audio videobuf2_common snd_hda_codec dm_cache ecdh_generic ecc
pktcdvd kvm dm_persistent_data snd_usbmidi_lib videodev snd_hda_core
dm_bio_prison snd_hwdep snd_rawmidi snd_seq mc joydev irqbypass
snd_seq_device ocrdma rapl intel_cstate ib_uverbs snd_pcm hp_wmi
sparse_keymap intel_uncore pcspkr rfkill wmi_bmof ib_core snd_timer
snd i2c_i801 i2c_smbus lpc_ich soundcore i2c_nvidia_gpu tpm_infineon
binfmt_misc ip_tables amdgpu iommu_v2 gpu_sched crct10dif_pclmul
crc32_pclmul i2c_algo_bit crc32c_intel ttm drm_kms_helper cec
ghash_clmulni_intel serio_raw nvme drm e1000e be2net nvme_core wmi nbd
fuse
[ 115.886482] CPU: 18 PID: 321 Comm: kworker/18:1 Tainted: G W OE
5.8.18-200.jboero.fc32.x86_64 #1
[ 115.886485] Hardware name: Hewlett-Packard HP Z640 Workstation/212A,
BIOS M60 v02.54 06/12/2020
[ 115.886492] Workqueue: usb_hub_wq hub_event
[ 115.886498] RIP: 0010:usb_disconnect+0x25/0xb0
[ 115.886503] Code: 00 00 0f 1f 00 0f 1f 44 00 00 41 57 41 56 41 55 41
54 55 53 48 89 fb 48 83 ec 20 4c 8b 27 48 c7 c7 a0 29 68 98 e8 9f 86
78 ff <0f> 0b bf c8 00 00 00 e8 8f d7 83 ff 48 c7 c7 c0 b7 ea 98 e8 53
c5
[ 115.886507] RSP: 0018:ffffb96645bffd28 EFLAGS: 00010292
[ 115.886512] RAX: 0000000000000027 RBX: ffff92eab42e9000 RCX: 0000000000000000
[ 115.886515] RDX: ffff92eab4d38000 RSI: ffffffff9716eac5 RDI: 0000000000000246
[ 115.886519] RBP: 0000000000000100 R08: 0000001afb5cc4e1 R09: 0000000000000027
[ 115.886522] R10: 0000000000000000 R11: 0000000000000000 R12: ffff92eab0793000
[ 115.886526] R13: 000000000000000e R14: ffff92eab42eab70 R15: 000000000000000e
[ 115.886530] FS: 0000000000000000(0000) GS:ffff92eacd200000(0000)
knlGS:0000000000000000
[ 115.886534] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 115.886537] CR2: 00007f11514b2f40 CR3: 0000001fb95a0004 CR4: 00000000001606e0
[ 115.886541] Call Trace:
[ 115.886554] ? __mutex_unlock_slowpath+0x35/0x270
[ 115.886562] hub_event+0xc0e/0x1890
[ 115.886582] process_one_work+0x25d/0x570
[ 115.886592] worker_thread+0x55/0x3c0
[ 115.886598] ? process_one_work+0x570/0x570
[ 115.886605] kthread+0x13a/0x150
[ 115.886611] ? kthread_create_worker_on_cpu+0x40/0x40
[ 115.886621] ret_from_fork+0x22/0x30
[ 115.886638] irq event stamp: 11070
[ 115.886646] hardirqs last enabled at (11069): [<ffffffff97cc66a4>]
_raw_spin_unlock_irq+0x24/0x40
[ 115.886651] hardirqs last disabled at (11070): [<ffffffff97cbf702>]
__schedule+0xd2/0xa40
[ 115.886656] softirqs last enabled at (6882): [<ffffffff9800033d>]
__do_softirq+0x33d/0x44c
[ 115.886661] softirqs last disabled at (6871): [<ffffffff97e010d2>]
asm_call_irq_on_stack+0x12/0x20
[ 115.886664] ---[ end trace d02727115f119a2f ]---
[ 116.094920] usb 3-14: USB disconnect, device number 7
[ 120.933639] uvcvideo: uvc_v4l2_release
