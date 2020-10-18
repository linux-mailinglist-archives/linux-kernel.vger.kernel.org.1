Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF94D29180B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgJRP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 11:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbgJRP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603034963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CTKIbN/xVjEnO6qY3wyEbNeQNs54uP2PLOt/PBfoP4=;
        b=VsxKuqkfCZ683JEjKtfFtGsCSIozdhjKvvo1UQKPTYwZIcJ/tGuGJyokd7GPeHV1mej9Op
        MySwiGMMN+KDNrI2RfnRM90RatTvPcy9mHy1fPr8GJkbU4hx/DSr1FzSPB1FVoDOUnGHDj
        OYZzAM1gpLBpGWJHfq//XGq+mhMef0o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-dhxiXeFDOJ6--dxFRbNgCA-1; Sun, 18 Oct 2020 11:29:21 -0400
X-MC-Unique: dhxiXeFDOJ6--dxFRbNgCA-1
Received: by mail-wr1-f69.google.com with SMTP id h8so4349972wrt.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1CTKIbN/xVjEnO6qY3wyEbNeQNs54uP2PLOt/PBfoP4=;
        b=Bi1gOYz3ellgcUi5QqRfiITUbgJP+rhEU3BoitmAesAwL1QU4AO+c6G8KzfXae8/ki
         NklWbtRrMRblGBVvKO3HzSEhq7A6suYAL0KjmtF8XXxgwfR9Ve4tO5R5Q4aZKmK7gGJL
         dcWM5OcJe0RvFdm6ny669le7JhlxkUhg/HItipYZRXjlPgLpN+Ra5nu29pyDYHNv+OoB
         9iaNM3kQS89bnfbKlN9No3SUXvfbVXyorhB6nPoqg10iUb1Zq80h5YOrD+HgXC+T7Z2Y
         8HJqpl83+3MdHawcH1CENVFQz2zwC6ffe2U7ml/QQuJW+sCMv2qE7iPqzHQwsoDH3eev
         eYlw==
X-Gm-Message-State: AOAM5302ghvKbjRHzhlGS5QtjoNx7WYCk83ZWVWP5yREqIjFwZChpkst
        U1h/qL9zt/dj7w6DXBc2h9nerIq9Zq1Y7TaqAxpSZWtrJgRqAExrEbGaz6d/k+YjiQXu9q1h/mX
        SxWplfL2bdXrZxSjIxEhoVTLF
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr13134894wmk.43.1603034960405;
        Sun, 18 Oct 2020 08:29:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdSke2D/bQ/4Rv046vND4iUOBVEXFQoAjUmmIvF3U1fKjAq8Hc0bRgog5vC4nNUSJIsqNYWw==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr13134876wmk.43.1603034960186;
        Sun, 18 Oct 2020 08:29:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id u81sm12089933wmg.43.2020.10.18.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 08:29:19 -0700 (PDT)
Date:   Sun, 18 Oct 2020 11:29:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 00/29] virtio-mem: Big Block Mode (BBM)
Message-ID: <20201018112849-mutt-send-email-mst@kernel.org>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:52:54PM +0200, David Hildenbrand wrote:
> virtio-mem currently only supports device block sizes that span at most
> a single Linux memory block. For example, gigantic pages in the hypervisor
> result on x86-64 in a device block size of 1 GiB - when the Linux memory
> block size is 128 MiB, we cannot support such devices (we fail loading the
> driver). Of course, we want to support any device block size in any Linux
> VM.
> 
> Bigger device block sizes will become especially important once supporting
> VFIO in QEMU - each device block has to be mapped separately, and the
> maximum number of mappings for VFIO is 64k. So we usually want blocks in
> the gigabyte range when wanting to grow the VM big.

I guess it missed this Linux right? There's an mm change which did not
get an ack from mm mainatiners, so I can't merge it ...

> This series:
> - Performs some cleanups
> - Factors out existing Sub Block Mode (SBM)
> - Implements memory hot(un)plug in Big Block Mode (BBM)
> 
> I need one core-mm change, to make offline_and_remove_memory() eat bigger
> chunks.
> 
> This series is based on "next-20201009" and can be found at:
> 	git@gitlab.com:virtio-mem/linux.git virtio-mem-dbm-v1
> 
> Once some virtio-mem patches that are pending in the -mm tree are upstream
> (I guess they'll go in in 5.10), I'll resend based on Linus' tree.
> I suggest to take this (including the MM patch, acks/review please) via the
> vhost tree once time has come. In the meantime, I'll do more testing.
> 
> David Hildenbrand (29):
>   virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
>   virtio-mem: simplify calculation in
>     virtio_mem_mb_state_prepare_next_mb()
>   virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
>   virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
>   virtio-mem: generalize check for added memory
>   virtio-mem: generalize virtio_mem_owned_mb()
>   virtio-mem: generalize virtio_mem_overlaps_range()
>   virtio-mem: drop last_mb_id
>   virtio-mem: don't always trigger the workqueue when offlining memory
>   virtio-mem: generalize handling when memory is getting onlined
>     deferred
>   virtio-mem: use "unsigned long" for nr_pages when fake
>     onlining/offlining
>   virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
>   virtio-mem: factor out handling of fake-offline pages in memory
>     notifier
>   virtio-mem: retry fake-offlining via alloc_contig_range() on
>     ZONE_MOVABLE
>   virito-mem: document Sub Block Mode (SBM)
>   virtio-mem: memory block states are specific to Sub Block Mode (SBM)
>   virito-mem: subblock states are specific to Sub Block Mode (SBM)
>   virtio-mem: factor out calculation of the bit number within the
>     sb_states bitmap
>   virito-mem: existing (un)plug functions are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block
>     Mode (SBM)
>   virtio-mem: memory notifier callbacks are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
>   virtio-mem: factor out adding/removing memory from Linux
>   virtio-mem: print debug messages from virtio_mem_send_*_request()
>   virtio-mem: Big Block Mode (BBM) memory hotplug
>   virtio-mem: allow to force Big Block Mode (BBM) and set the big block
>     size
>   mm/memory_hotplug: extend offline_and_remove_memory() to handle more
>     than one memory block
>   virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
>   virtio-mem: Big Block Mode (BBM) - safe memory hotunplug
> 
>  drivers/virtio/virtio_mem.c | 1783 +++++++++++++++++++++++++----------
>  mm/memory_hotplug.c         |  105 ++-
>  2 files changed, 1373 insertions(+), 515 deletions(-)
> 
> -- 
> 2.26.2

