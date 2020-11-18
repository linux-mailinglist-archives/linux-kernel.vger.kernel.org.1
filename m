Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF992B757B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKRExD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKRExD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:53:03 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50EF92463B;
        Wed, 18 Nov 2020 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605675182;
        bh=YCosJ2qYaKYkNcdNS2lsX13OGUTapFeLurPSXtSY+yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tie7eb5a7TGFHuXfQKFc18si/9EZtnUmgSFQYX4CGvs5aVPpW1/N6cLGDnv9rC6UC
         zxkxaptgjS5j619jNjOTbYBMfZK21CQSMde6I8vSErrktiKlLf8Ra7hO19t9nbYWD8
         Z0U5Huazt/VSjcrl/OKncScPsDznNsmv5IAMZfx8=
Date:   Tue, 17 Nov 2020 20:53:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 27/29] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Message-Id: <20201117205301.bcef9773f3557a764d17b8df@linux-foundation.org>
In-Reply-To: <20201112133815.13332-28-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
        <20201112133815.13332-28-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 14:38:13 +0100 David Hildenbrand <david@redhat.com> wrote:

> virtio-mem soon wants to use offline_and_remove_memory() memory that
> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
> remove that restriction.
> 
> Let's remember the old state and try to restore that if anything goes
> wrong. While re-onlining can, in general, fail, it's highly unlikely to
> happen (usually only when a notifier fails to allocate memory, and these
> are rather rare).
> 
> This will be used by virtio-mem to offline+remove memory ranges that are
> bigger than a single memory block - for example, with a device block
> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
> block size of 128MB.
> 
> While we could compress the state into 2 bit, using 8 bit is much
> easier.
> 
> This handling is similar, but different to acpi_scan_try_to_offline():
> 
> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
> optimization is still relevant - it should only apply to ZONE_NORMAL
> (where we have no guarantees). If relevant, we can always add it.
> 
> b) acpi_scan_try_to_offline() simply onlines all memory in case
> something goes wrong. It doesn't restore previous online type. Let's do
> that, so we won't overwrite what e.g., user space configured.
> 
> ...
>

uint8_t is a bit of a mouthful.  u8 is less typing ;)  Doesn't matter.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
