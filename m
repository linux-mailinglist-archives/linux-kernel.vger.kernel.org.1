Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD712B79E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKRJBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:01:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgKRJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605690060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wqEQsvX22nx16Jojzb8KFZiOjvsM4OAXsB57jTMi5g=;
        b=gX8uJ6i5nfjv6AjTK92knEoCDkERJargMYXs2csnKHXLyPvjY0WgRKPqA51JNPmO9ssR2H
        DCvsgveWCVT6Abt2PF1/cQkmWbjEs6kEcPAYIic/plH2ouIa0MGPu+n77TTur5VImA/AFh
        m02o8IGN7ZgwS/fj4kitlr0wxPdl9pw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-blb0CB56OR-CfEaC4IDDqA-1; Wed, 18 Nov 2020 04:00:58 -0500
X-MC-Unique: blb0CB56OR-CfEaC4IDDqA-1
Received: by mail-wr1-f70.google.com with SMTP id f4so641692wru.21
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wqEQsvX22nx16Jojzb8KFZiOjvsM4OAXsB57jTMi5g=;
        b=qqspps2YTrMKygmipcqx46ihGYwDkwEvxqsW32MKTpF2Wl0fBGeMshx3cAYT32jjw0
         2foL8brvwh2K0iGF/tC8eV0jezmmqQFeaaYtI4Z2O623fvzd2UozpGqiq6ZTa/juXY37
         KFADosVN9eEdOfwNcWK6RGF+ciotZTbxLHDxx+rsGiDCbUqdfnxgBCCNqnZsMJVJjQa6
         FDd7pUfWw8ZVjxjxBtevd8npKSvdC/8AYqjPfIqgfPvwlAzgD65MUPsYmzzRAuvBogSn
         uxKNjk42Tao2SCn9uijsokpzYr87P88NLUgheo0B81mtmim/NfXAU2oRJq9AVFrUnM8g
         yfOg==
X-Gm-Message-State: AOAM533MiplneVksAJPlaaim9t+7t5yH3/Ffs9dqb6nGYj6dQ9jLubLR
        +bdj4vsbhOUvK7tX/jFWA0VDM1BACfCEG70k9pbXv+cgLhQVNDD8JW67UC1CnpLPRK/HiH2GmY/
        mhy5jB4aYenkuThvWyQ3xSayA
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr3616029wrr.353.1605690057431;
        Wed, 18 Nov 2020 01:00:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIcY5c9fabl6ughyv2LZhAK3/bgxlHsBiPuOq6RbM1KZQEh4wZshXsh3Bu1z6logi57UI1Rw==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr3616013wrr.353.1605690057263;
        Wed, 18 Nov 2020 01:00:57 -0800 (PST)
Received: from redhat.com (bzq-79-181-34-244.red.bezeqint.net. [79.181.34.244])
        by smtp.gmail.com with ESMTPSA id n10sm31309533wrv.77.2020.11.18.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:00:56 -0800 (PST)
Date:   Wed, 18 Nov 2020 04:00:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v2 00/29] virtio-mem: Big Block Mode (BBM)
Message-ID: <20201118040030-mutt-send-email-mst@kernel.org>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 02:37:46PM +0100, David Hildenbrand wrote:
> @Andrew, can we have an ack for patch #27, so that one can go via
> the vhost tree for 5.11?

OK, we got an ack, I'll put it in next now.
Thanks!

> ---
> 
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
> 
> Patch #1 - #10 are cleanups and optimizations
> Patch #11 - #24 are refactorings to prepare for BBM
> Patch #25 - #29 implement BBM, including one mm/memory_hotplug extension
> 
> This series is based on latest linus/master and can be found at:
>  git@github.com:davidhildenbrand/linux.git virtio-mem-bbm-v2
> 
> v1 -> v2:
> - Code wise, the only bigger change is using an union for sbm/bbm state
> - Reworked some subjects/patch descriptions
> - Reshuffled patches to make reviweing easier, and to have
>   cleanups+optimizations before all refactorings
> - "virtio-mem: more precise calculation in
>    virtio_mem_mb_state_prepare_next_mb()"
> -- Changed subject
> -- Avoid two local variables
> 
> David Hildenbrand (29):
>   virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
>   virtio-mem: more precise calculation in
>     virtio_mem_mb_state_prepare_next_mb()
>   virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
>   virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
>   virtio-mem: use "unsigned long" for nr_pages when fake
>     onlining/offlining
>   virtio-mem: factor out calculation of the bit number within the
>     subblock bitmap
>   virtio-mem: print debug messages from virtio_mem_send_*_request()
>   virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
>   virtio-mem: factor out handling of fake-offline pages in memory
>     notifier
>   virtio-mem: retry fake-offlining via alloc_contig_range() on
>     ZONE_MOVABLE
>   virtio-mem: generalize check for added memory
>   virtio-mem: generalize virtio_mem_owned_mb()
>   virtio-mem: generalize virtio_mem_overlaps_range()
>   virtio-mem: drop last_mb_id
>   virtio-mem: don't always trigger the workqueue when offlining memory
>   virtio-mem: generalize handling when memory is getting onlined
>     deferred
>   virito-mem: document Sub Block Mode (SBM)
>   virtio-mem: memory block states are specific to Sub Block Mode (SBM)
>   virito-mem: subblock states are specific to Sub Block Mode (SBM)
>   virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block
>     Mode (SBM)
>   virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
>   virito-mem: existing (un)plug functions are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: memory notifier callbacks are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: factor out adding/removing memory from Linux
>   virtio-mem: Big Block Mode (BBM) memory hotplug
>   virtio-mem: allow to force Big Block Mode (BBM) and set the big block
>     size
>   mm/memory_hotplug: extend offline_and_remove_memory() to handle more
>     than one memory block
>   virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
>   virtio-mem: Big Block Mode (BBM) - safe memory hotunplug
> 
>  drivers/virtio/virtio_mem.c | 1789 +++++++++++++++++++++++++----------
>  mm/memory_hotplug.c         |  105 +-
>  2 files changed, 1376 insertions(+), 518 deletions(-)
> 
> -- 
> 2.26.2

