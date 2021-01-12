Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27242F3CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437544AbhALVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436926AbhALU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:29:44 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813CC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:29:04 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id x203so900032ooa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDLeYHAdyJXom8UBMPXNbz8kfcw4k2SFK/gIDfQI2Mo=;
        b=hACMNd12CHzJhQb2y9E5HlKzNxg6kPOhqWOGaDaCfMGGatsDYO2+ROrP/n8p3QmJ9R
         Rdk4qIA2XPaiz7rMV5Yq7TnzBkrzdOIQP1J2uw7qw1u3vGKh9hXCod3/pmGfQS5Dt25f
         vyp+wLnZz0lEHxrRYpMvHh71rkMyg958RZXm82SuqMjX7KL89fd+7xnyiec+GZPC4IP8
         NmtDu4tDAYXgMLiQuZfRLWMTkj14XB0Exu+9c1n1+6y3gFfPJfUqsHl9vA2/8XBRiwcn
         4C5XOa52DmPlwbBDM9vGa0KGC8WeuCX+prNE1b2aRmnLs7513D4v4q+8CiQXK2/rQcBS
         hMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDLeYHAdyJXom8UBMPXNbz8kfcw4k2SFK/gIDfQI2Mo=;
        b=mDBdufd0/58xS+5jeCB2golwyYackBmalF9APdVFKR0Nrnz+GbmViHzQujEkxFs7mW
         2SKk9PghL8Wxx+6dlbi3m2Ller6RV7+KrVZDfTvquqOKMDMdJgg8xT494TNFyRUy0wJ+
         zZAxk4tPM6rJpArUwhwELCIke712CHL7Efnr0lczdRMSptgcRkD7Tx0CKMSrWmJ6wlhd
         Um+OVDnfriCpjwLUs58Zbvmf4LkWFIRh6S2nGP1AYha76+0MXD8VQvIdNRS8qkOwPgaE
         XNwaNDH1ACJ4L14ORT7vIH0D079EnLe3bvlxgcpT4cv+F3izBdze3+BYSsOsj5XeK1g9
         IWfA==
X-Gm-Message-State: AOAM5335gEnavtZ+EkB2h6ycAfyyoXcpiFOsT5mBnKfUJYEADGPVyKW/
        PmQcbzx/mcPxbEJdYgavt/soYFy2lFfAMpb1ludFyg==
X-Google-Smtp-Source: ABdhPJzOPojmT2VBrMxKI3W3V3rQzq5X9DqoVBkUPwMTcVKp+Oj5xQbG7tR8lCWwkKUUfJvuGIFEfrk2Et/qTYvlNvU=
X-Received: by 2002:a4a:98e7:: with SMTP id b36mr550175ooj.3.1610483343593;
 Tue, 12 Jan 2021 12:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com> <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
In-Reply-To: <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Tue, 12 Jan 2021 22:28:50 +0200
Message-ID: <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, rdunlap@infradead.org,
        willemb@google.com, gustavoars@kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        pablo@netfilter.org, decui@microsoft.com, cai@lca.pw,
        jakub@cloudflare.com, elver@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        bpf@vger.kernel.org
Cc:     Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:49 PM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Tue, Jan 12, 2021 at 9:41 PM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > Existing TUN module is able to use provided "steering eBPF" to
> > calculate per-packet hash and derive the destination queue to
> > place the packet to. The eBPF uses mapped configuration data
> > containing a key for hash calculation and indirection table
> > with array of queues' indices.
> >
> > This series of patches adds support for virtio-net hash reporting
> > feature as defined in virtio specification. It extends the TUN module
> > and the "steering eBPF" as follows:
> >
> > Extended steering eBPF calculates the hash value and hash type, keeps
> > hash value in the skb->hash and returns index of destination virtqueue
> > and the type of the hash. TUN module keeps returned hash type in
> > (currently unused) field of the skb.
> > skb->__unused renamed to 'hash_report_type'.
> >
> > When TUN module is called later to allocate and fill the virtio-net
> > header and push it to destination virtqueue it populates the hash
> > and the hash type into virtio-net header.
> >
> > VHOST driver is made aware of respective virtio-net feature that
> > extends the virtio-net header to report the hash value and hash report
> > type.
>
> Comment from Willem de Bruijn:
>
> Skbuff fields are in short supply. I don't think we need to add one
> just for this narrow path entirely internal to the tun device.
>

We understand that and try to minimize the impact by using an already
existing unused field of skb.


> Instead, you could just run the flow_dissector in tun_put_user if the
> feature is negotiated. Indeed, the flow dissector seems more apt to me
> than BPF here. Note that the flow dissector internally can be
> overridden by a BPF program if the admin so chooses.
>
When this set of patches is related to hash delivery in the virtio-net
packet in general,
it was prepared in context of RSS feature implementation as defined in
virtio spec [1]
In case of RSS it is not enough to run the flow_dissector in tun_put_user:
in tun_ebpf_select_queue the TUN calls eBPF to calculate the hash,
hash type and queue index
according to the (mapped) parameters (key, hash types, indirection
table) received from the guest.
Our intention is to keep the hash and hash type in the skb to populate them
into a virtio-net header later in tun_put_user.
Note that in this case the type of calculated hash is selected not
only from flow dissections
but also from limitations provided by the guest.
This is already implemented in qemu (for case of vhost=off), see [2]
(virtio_net_process_rss)
For case of vhost=on there are WIP for qemu to load eBPF and attach it to TUN.

Note that exact way of selecting rx virtqueue depends on the guest,
it could be automatic steering (typical for Linux VM), RSS (typical
for Windows VM) or
any other steering mechanism implemented in loadable TUN steering BPF with
or without hash calculation.

[1] https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L3740
[2] https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L1591

> This also hits on a deeper point with the choice of hash values, that
> I also noticed in my RFC patchset to implement the inverse [1][2]. It
> is much more detailed than skb->hash + skb->l4_hash currently offers,
> and that can be gotten for free from most hardware.

Unfortunately in the case of RSS we can't get this hash from the hardware as
this requires configuration of the NIC's hardware with key and hash types for
Toeplitz hash calculation.

> In most practical
> cases, that information suffices. I added less specific fields
> VIRTIO_NET_HASH_REPORT_L4, VIRTIO_NET_HASH_REPORT_OTHER that work
> without explicit flow dissection. I understand that the existing
> fields are part of the standard. Just curious, what is their purpose
> beyond 4-tuple based flow hashing?

The hash is used in combination with the indirection table to select
destination rx virtqueue.
The hash and hash type are to be reported in virtio-net header, if requested.
For Windows VM - in case the device does not report the hash (even if
it calculated it to
schedule the packet to a proper queue), the driver must do that for each packet
(this is a certification requirement).

>
> [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=406859&state=*
> [2] https://github.com/wdebruij/linux/commit/0f77febf22cd6ffc242a575807fa8382a26e511e
> >
> > Yuri Benditovich (7):
> >   skbuff: define field for hash report type
> >   vhost: support for hash report virtio-net feature
> >   tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
> >   tun: free bpf_program by bpf_prog_put instead of bpf_prog_destroy
> >   tun: add ioctl code TUNSETHASHPOPULATION
> >   tun: populate hash in virtio-net header when needed
> >   tun: report new tun feature IFF_HASH
> >
> >  drivers/net/tun.c           | 43 +++++++++++++++++++++++++++++++------
> >  drivers/vhost/net.c         | 37 ++++++++++++++++++++++++-------
> >  include/linux/skbuff.h      |  7 +++++-
> >  include/uapi/linux/if_tun.h |  2 ++
> >  4 files changed, 74 insertions(+), 15 deletions(-)
> >
> > --
> > 2.17.1
> >
