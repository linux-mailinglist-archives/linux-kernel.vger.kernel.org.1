Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A82CC94C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgLBWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgLBWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606946434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mgQhA2o4decZhuJk4kraIyyghNyU3KxHcdGPG8L0FI=;
        b=IV7oGGVgqcnI3CR8Wwf3qBwSG9hfGIi2BOqr8WG65oGChC1HlSl/30qthWyfAyENtkRPEB
        8NbGUlulboA1YmwhcCbeGOaC2eyc7jxEB9uQtlRzSKWD3FSY+V+KuHYTVl5YAvlc/q7j8R
        l45B+Op4ieKM7unJ/vp7FCx9HBGfeyE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-Pz9Cl0WUP_6U-sj7t-p_dw-1; Wed, 02 Dec 2020 17:00:28 -0500
X-MC-Unique: Pz9Cl0WUP_6U-sj7t-p_dw-1
Received: by mail-wm1-f70.google.com with SMTP id z12so213983wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+mgQhA2o4decZhuJk4kraIyyghNyU3KxHcdGPG8L0FI=;
        b=CFTh2PcpHGgaDkF3u2rLZLxeaecN/1oVW2K9Ju2oLbq7oNP1R+MO1UtVO0OfZXntQr
         E0Z+gmeU+IVLfTQR8xQFVbRJ+hVTRT/VlxnvPYtZQ9O6yxvy8DGKlNk/kVYHrKrh8biU
         jOd94T5w0c84Y0E20Blau7Foo6I0bDuj5hlfbeOWeAn+QOj9JsZFfE59KVhs8XP24VL4
         ADdxJPV7BOJWELdDVmtJIWG4FfyEYZWcdalgtCRJOct587aalWoD20xMizNsIsjZ0830
         o27VcFT8Lcn1cwX+L312zgSJNK8C9PmADEPPr9w3bVK9qXziTNxDfaevmqRRFq0+Owuu
         RnNQ==
X-Gm-Message-State: AOAM532S/RM2GsWNPeRI72YhresN9Pbrj6aMkaoominSl73dIXwvy575
        J5U6iGi490ISRuDKWBr6eA2K3HoroQcv4EF/Kvy6w+BuoDVpPpO5c/0c0UcyyO+DoPnivWQDHaU
        GkJ2hnETaCAoXEN+anlf5BQqA
X-Received: by 2002:a1c:9ecf:: with SMTP id h198mr57200wme.104.1606946427224;
        Wed, 02 Dec 2020 14:00:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF95JQh5iC1sPJmk3A5wyLf0qbaVlCIvoCNnL7gkjsiBsLQdflO0b44GTd0LEtQu/64S8AbA==
X-Received: by 2002:a1c:9ecf:: with SMTP id h198mr57179wme.104.1606946426950;
        Wed, 02 Dec 2020 14:00:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id q17sm10042wro.36.2020.12.02.14.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:00:25 -0800 (PST)
Date:   Wed, 2 Dec 2020 17:00:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Cindy Lu <lulu@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202165932-mutt-send-email-mst@kernel.org>
References: <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:48:25PM +0800, Jason Wang wrote:
> 
> On 2020/12/2 下午5:23, Michael S. Tsirkin wrote:
> > On Wed, Dec 02, 2020 at 07:57:14AM +0200, Eli Cohen wrote:
> > > On Wed, Dec 02, 2020 at 12:18:36PM +0800, Jason Wang wrote:
> > > > On 2020/12/1 下午5:23, Cindy Lu wrote:
> > > > > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin<mst@redhat.com>  wrote:
> > > > > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > > > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin<mst@redhat.com>  wrote:
> > > > > > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > > > > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > > > > > > > generated MAC address.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Suggested by: Cindy Lu<lulu@redhat.com>
> > > > > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > > > > > > > Signed-off-by: Eli Cohen<elic@nvidia.com>
> > > > > > > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > > > > > > with and without vdpa.
> > > > > > > > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > > > > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > > > > > > > several instances of vdpa net devices and nic net devices.
> > > > > > > > > > > 
> > > > > > > > > > > > Could you include a bit more description on the failure
> > > > > > > > > > > > mode?
> > > > > > > > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > > > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > > > > > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > > > > > > > 
> > > > > > > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > > > > > > > 
> > > > > > > > > > > > Is switching to a random mac for such an unusual
> > > > > > > > > > > > configuration really justified?
> > > > > > > > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > > > > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > > > > > > > >      NIC. This should invoke the set_config callback. Unfortunately this
> > > > > > > > > > >      is not implemented yet.
> > > > > > > > > > > 
> > > > > > > > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > > > > > > > >      can always override this random configuration.
> > > > > > > > > > > 
> > > > > > > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > > > > > > can it not?
> > > > > > > > > > > > 
> > > > > > > > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > > > > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > > > > > > > from steering point of view. I will post them here once other patches on
> > > > > > > > > > > which they depend will be merged.
> > > > > > > > > > > 
> > > > > > > > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > > > > > > > Could you be more explicit on the following points:
> > > > > > > > > > - which configuration is broken ATM (as in, two device have identical
> > > > > > > > > >     macs? any other issues)?
> > > > > > > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > > > > > > > It's not breaking anything yet is wrong. The random MAC address setting
> > > > > > > > > is required for the steering patches.
> > > > > > > > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > > > > > > > dependency of a new feature.
> > > > > > > > 
> > > > > > > > > > - why won't device MAC change from guest point of view?
> > > > > > > > > > 
> > > > > > > > > It's lack of implementation in qemu as far as I know.
> > > > > > > > Sorry not sure I understand. What's not implemented in QEMU?
> > > > > > > > 
> > > > > > > HI Michael, there are some bug in qemu to set_config, this will fix in future,
> > > > > > > But this patch is still needed, because without this patch the mlx
> > > > > > > driver will give an 0 mac address to qemu
> > > > > > > and qemu will overwrite the default mac address.  This will cause traffic down.
> > > > > > Hmm the patch description says VF mac address, not 0 address. Confused.
> > > > > > If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> > > > > > use a random value ...
> > > > I'm not sure this can work for all types of vDPA (e.g it could not be a
> > > > learning bridge in the swtich).
> > > > 
> > > > 
> > > > > hi Michael，
> > > > > I have tried as your suggestion, seems even remove the
> > > > > VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
> > > > > default address in  VM,
> > > > This looks a bug in qemu, in guest driver we had:
> > > > 
> > > >      /* Configuration may specify what MAC to use.  Otherwise random. */
> > > >      if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > > >          virtio_cread_bytes(vdev,
> > > >                     offsetof(struct virtio_net_config, mac),
> > > >                     dev->dev_addr, dev->addr_len);
> > > >      else
> > > >          eth_hw_addr_random(dev);
> > > > 
> > > > 
> > > > > this process is like
> > > > > vdpa _init -->qemu call get_config ->mlx driver will give  an mac
> > > > > address with all 0-->
> > > > > qemu will not check this mac address and use it --> overwrite the mac
> > > > > address in qemu
> > > > > 
> > > > > So for my understanding there are several method to fix this problem
> > > > > 
> > > > > 1, qemu check the mac address, if the mac address is all 0, qemu will
> > > > > ignore it and set the random mac address to mlx driver.
> > > > So my understanding is that, if mac address is all 0, vDPA parent should not
> > > > advertise VIRTIO_NET_F_MAC. And qemu should emulate this feature as you did:
> > > Thinking it over, at least in mlx5, I should always advertise
> > > VIRTIO_NET_F_MAC and set a non zero MAC value. The source of the MAC can
> > > be either randomly generated value by mlx5_vdpa or by a management tool.
> > > This is important becauase we should not let the VM modify the MAC. If
> > > we do it can set a MAC value identical to the mlx5 NIC driver and can
> > > kidnap traffic that was not destined to it.
> > > 
> > > In addition, when VIRTIO_NET_F_MAC is published, attempts to change the
> > > MAC address from the VM should result in error.
> > That is not what the spec says though.
> > VIRTIO_NET_F_MAC only says whether mac is valid in the config space.
> > Whether guest can control that depends on VIRTIO_NET_F_CTRL_MAC_ADDR:
> > 
> > 	The VIRTIO_NET_CTRL_MAC_ADDR_SET command is used to set the default MAC address which rx
> > 	filtering accepts (and if VIRTIO_NET_F_MAC_ADDR has been negotiated, this will be reflected in mac in
> > 	config space).
> > 	The command-specific-data for VIRTIO_NET_CTRL_MAC_ADDR_SET is the 6-byte MAC address.
> 
> 
> Consider VIRTIO_NET_CTRL_MAC_ADDR_SET is not supported now. What Eli
> proposed here should work?
> 
> Thanks
> 

We can have management set a MAC address. Randomizing it in kernel
does not seem like a reasonable policy to me ...


> > 
> > 
> > 
> > 

