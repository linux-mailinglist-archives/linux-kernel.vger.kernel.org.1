Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20912CD3F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgLCKpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728849AbgLCKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606992265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7VeQja9swCsfB3PhqTDwyJ4bV4pwvq3wq0Enpf6L0I=;
        b=CTi6eUKoMkvCsL3FZO09qy8j3Pk3FgVggisn8DtaKVDVhI9pQnClcGckz2T2msLt9QUR89
        o7e7fBekxs9q9VFVJiQVVSO4oxBokzUWgToIoddLx9urst1jZMHY6S9eqU7wnKregxT3lM
        hdqFoiesozs1nGwrikYACsD/08sq7EA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-NNKM3lpFP0m3WoPpJ6JTpA-1; Thu, 03 Dec 2020 05:44:22 -0500
X-MC-Unique: NNKM3lpFP0m3WoPpJ6JTpA-1
Received: by mail-wm1-f71.google.com with SMTP id q17so1298404wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v7VeQja9swCsfB3PhqTDwyJ4bV4pwvq3wq0Enpf6L0I=;
        b=X7P1AfKLwxMkyOqE/++0kTRjQYg0SaAdRwWRDvdAfPiwn+wOQyvpRSuoHIpj4HWU7+
         UUp4TtF6gC6jRezsDXL7hqYTSS2c8dD3u+tJN/MtjnJ70D5BWYnjmCAGd7EhZqgym37p
         d01TGu6rwQSk6EP+xmuK6jwR1OHhlZxQYzscxzptaDZVhqUe+lASBKjfTtPA0UUrkymz
         Jgs7GCTrbSEkqZD87KFWyQLKeMcYHExHqHEp4zHrTp9LT7T5Qa3pswQ7wbyZAQrTTgyo
         sRJNMdqLInN9NyyQc1fOtihdNp4Uhx36n7hCmroh3kSfLlSlpVGudUcECeAS+uaDcMUs
         SjJA==
X-Gm-Message-State: AOAM5328gujG07+Jk6QA5QSGBJHI/ebcvUnLmPkGPPV4VufRbgm8yw5y
        bPYnR8kekJbE4FeCqumdweihG7/Icyn07pI5NBM/k8MJU//9lOoxUtLl628idf/uhpceDOzH+2U
        jJpLqO2XMlw9uFAx0KDMDYSPp
X-Received: by 2002:a1c:c902:: with SMTP id f2mr2644377wmb.130.1606992260987;
        Thu, 03 Dec 2020 02:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgiZ+YA0a+3SUdB0hAWy+TIzjqKgOEcekO5gTV3mLa/6sgQvs6/WfonlWBQbEWZrnSzEd8SQ==
X-Received: by 2002:a1c:c902:: with SMTP id f2mr2644348wmb.130.1606992260670;
        Thu, 03 Dec 2020 02:44:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id a144sm985141wmd.47.2020.12.03.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 02:44:19 -0800 (PST)
Date:   Thu, 3 Dec 2020 05:44:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201203054330-mutt-send-email-mst@kernel.org>
References: <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
 <20201202165932-mutt-send-email-mst@kernel.org>
 <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 08:49:28AM +0200, Eli Cohen wrote:
> On Wed, Dec 02, 2020 at 05:00:22PM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 02, 2020 at 09:48:25PM +0800, Jason Wang wrote:
> > > 
> > > On 2020/12/2 下午5:23, Michael S. Tsirkin wrote:
> > > > On Wed, Dec 02, 2020 at 07:57:14AM +0200, Eli Cohen wrote:
> > > > > On Wed, Dec 02, 2020 at 12:18:36PM +0800, Jason Wang wrote:
> > > > > > On 2020/12/1 下午5:23, Cindy Lu wrote:
> > > > > > > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin<mst@redhat.com>  wrote:
> > > > > > > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > > > > > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin<mst@redhat.com>  wrote:
> > > > > > > > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > > > > > > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > > > > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > > > > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > > > > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > > > > > > > > > generated MAC address.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Suggested by: Cindy Lu<lulu@redhat.com>
> > > > > > > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > > > > > > > > > Signed-off-by: Eli Cohen<elic@nvidia.com>
> > > > > > > > > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > > > > > > > > with and without vdpa.
> > > > > > > > > > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > > > > > > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > > > > > > > > > several instances of vdpa net devices and nic net devices.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > > Could you include a bit more description on the failure
> > > > > > > > > > > > > > mode?
> > > > > > > > > > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > > > > > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > > > > > > > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > > > > > > > > > 
> > > > > > > > > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > > > > > > > > > 
> > > > > > > > > > > > > > Is switching to a random mac for such an unusual
> > > > > > > > > > > > > > configuration really justified?
> > > > > > > > > > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > > > > > > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > > > > > > > > > >      NIC. This should invoke the set_config callback. Unfortunately this
> > > > > > > > > > > > >      is not implemented yet.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > > > > > > > > > >      can always override this random configuration.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > > > > > > > > can it not?
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > > > > > > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > > > > > > > > > from steering point of view. I will post them here once other patches on
> > > > > > > > > > > > > which they depend will be merged.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > > > > > > > > > Could you be more explicit on the following points:
> > > > > > > > > > > > - which configuration is broken ATM (as in, two device have identical
> > > > > > > > > > > >     macs? any other issues)?
> > > > > > > > > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > > > > > > > > > It's not breaking anything yet is wrong. The random MAC address setting
> > > > > > > > > > > is required for the steering patches.
> > > > > > > > > > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > > > > > > > > > dependency of a new feature.
> > > > > > > > > > 
> > > > > > > > > > > > - why won't device MAC change from guest point of view?
> > > > > > > > > > > > 
> > > > > > > > > > > It's lack of implementation in qemu as far as I know.
> > > > > > > > > > Sorry not sure I understand. What's not implemented in QEMU?
> > > > > > > > > > 
> > > > > > > > > HI Michael, there are some bug in qemu to set_config, this will fix in future,
> > > > > > > > > But this patch is still needed, because without this patch the mlx
> > > > > > > > > driver will give an 0 mac address to qemu
> > > > > > > > > and qemu will overwrite the default mac address.  This will cause traffic down.
> > > > > > > > Hmm the patch description says VF mac address, not 0 address. Confused.
> > > > > > > > If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> > > > > > > > use a random value ...
> > > > > > I'm not sure this can work for all types of vDPA (e.g it could not be a
> > > > > > learning bridge in the swtich).
> > > > > > 
> > > > > > 
> > > > > > > hi Michael，
> > > > > > > I have tried as your suggestion, seems even remove the
> > > > > > > VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
> > > > > > > default address in  VM,
> > > > > > This looks a bug in qemu, in guest driver we had:
> > > > > > 
> > > > > >      /* Configuration may specify what MAC to use.  Otherwise random. */
> > > > > >      if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > > > > >          virtio_cread_bytes(vdev,
> > > > > >                     offsetof(struct virtio_net_config, mac),
> > > > > >                     dev->dev_addr, dev->addr_len);
> > > > > >      else
> > > > > >          eth_hw_addr_random(dev);
> > > > > > 
> > > > > > 
> > > > > > > this process is like
> > > > > > > vdpa _init -->qemu call get_config ->mlx driver will give  an mac
> > > > > > > address with all 0-->
> > > > > > > qemu will not check this mac address and use it --> overwrite the mac
> > > > > > > address in qemu
> > > > > > > 
> > > > > > > So for my understanding there are several method to fix this problem
> > > > > > > 
> > > > > > > 1, qemu check the mac address, if the mac address is all 0, qemu will
> > > > > > > ignore it and set the random mac address to mlx driver.
> > > > > > So my understanding is that, if mac address is all 0, vDPA parent should not
> > > > > > advertise VIRTIO_NET_F_MAC. And qemu should emulate this feature as you did:
> > > > > Thinking it over, at least in mlx5, I should always advertise
> > > > > VIRTIO_NET_F_MAC and set a non zero MAC value. The source of the MAC can
> > > > > be either randomly generated value by mlx5_vdpa or by a management tool.
> > > > > This is important becauase we should not let the VM modify the MAC. If
> > > > > we do it can set a MAC value identical to the mlx5 NIC driver and can
> > > > > kidnap traffic that was not destined to it.
> > > > > 
> > > > > In addition, when VIRTIO_NET_F_MAC is published, attempts to change the
> > > > > MAC address from the VM should result in error.
> > > > That is not what the spec says though.
> > > > VIRTIO_NET_F_MAC only says whether mac is valid in the config space.
> > > > Whether guest can control that depends on VIRTIO_NET_F_CTRL_MAC_ADDR:
> > > > 
> > > > 	The VIRTIO_NET_CTRL_MAC_ADDR_SET command is used to set the default MAC address which rx
> > > > 	filtering accepts (and if VIRTIO_NET_F_MAC_ADDR has been negotiated, this will be reflected in mac in
> > > > 	config space).
> > > > 	The command-specific-data for VIRTIO_NET_CTRL_MAC_ADDR_SET is the 6-byte MAC address.
> > > 
> > > 
> > > Consider VIRTIO_NET_CTRL_MAC_ADDR_SET is not supported now. What Eli
> > > proposed here should work?
> > > 
> > > Thanks
> > > 
> > 
> > We can have management set a MAC address. Randomizing it in kernel
> > does not seem like a reasonable policy to me ...
> > 
> 
> This manangement should be the VDPA tool that Parav is pushing. We can
> use it to set a MAC chosen by the user. The mlx5 vdpa driver can then
> use that MAC instead of randomizing a value. If no admin value is given
> we can use a random MAC.

IIUC in this model devices are created by this tool, right?
Why not require the MAC when device is created?

> > 
> > > > 
> > > > 
> > > > 
> > > > 
> > 

