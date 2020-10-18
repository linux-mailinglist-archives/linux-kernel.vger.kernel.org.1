Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DE29176E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgJRMuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 08:50:07 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41897 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgJRMuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 08:50:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UCN7nX9_1603025394;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCN7nX9_1603025394)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Oct 2020 20:49:55 +0800
Date:   Sun, 18 Oct 2020 20:49:54 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 00/29] virtio-mem: Big Block Mode (BBM)
Message-ID: <20201018124954.GA51680@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:52:54PM +0200, David Hildenbrand wrote:
>virtio-mem currently only supports device block sizes that span at most
>a single Linux memory block. For example, gigantic pages in the hypervisor
>result on x86-64 in a device block size of 1 GiB - when the Linux memory
>block size is 128 MiB, we cannot support such devices (we fail loading the
>driver). Of course, we want to support any device block size in any Linux
>VM.
>
>Bigger device block sizes will become especially important once supporting
>VFIO in QEMU - each device block has to be mapped separately, and the
>maximum number of mappings for VFIO is 64k. So we usually want blocks in
>the gigabyte range when wanting to grow the VM big.
>
>This series:
>- Performs some cleanups
>- Factors out existing Sub Block Mode (SBM)
>- Implements memory hot(un)plug in Big Block Mode (BBM)
>
>I need one core-mm change, to make offline_and_remove_memory() eat bigger
>chunks.
>
>This series is based on "next-20201009" and can be found at:
>	git@gitlab.com:virtio-mem/linux.git virtio-mem-dbm-v1
>

I am trying to apply this patch set, while found I can't 'git fetch' this
repo. Is there any other repo I would apply this patch set?

-- 
Wei Yang
Help you, Help me
