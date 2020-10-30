Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6122A0650
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgJ3NRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3NRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:17:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8676C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ssKZleQhR30609q7SB5SmVWDlFD9abABkXUfNq1YT8M=; b=pRmAnRb1KCg1FDvP3XW89iYwJ6
        zg9G7Gf9BetAYHAIV7kbqZavxXKQs7LSkpKsXqfFIpzSxzU1HK/R/OE4cFq2b6/ZxAV4gwPNySHQD
        ZW7WgKIj1s3Rq6+xylSzDHbjLMsixI3rKeY4FJhir2VVYKSWpg0QkFP18NizHudCy/AuLLwsSN+PI
        Fu/8V2LbAuaz5Xx1monZ3fpA9Lgj0mCEOXATzSbRVrZ6KoOry8O7Xu/bqnJuo8H+j++4X6yx9jXyp
        c0ySMsH4rDM4K8Mzj3RboLxJTJ4rVdC08tFn1qqDEfEPxYbDRPtvM6gxMpppUxVbmc/oNQ4C63yp5
        0e4uLYqA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYUHH-0003Ao-GY; Fri, 30 Oct 2020 13:17:11 +0000
Date:   Fri, 30 Oct 2020 13:17:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7% regression
Message-ID: <20201030131711.GJ27442@casper.infradead.org>
References: <20201030071715.GV31092@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030071715.GV31092@shao2-debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 03:17:15PM +0800, kernel test robot wrote:
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml

Do you actually test these instructions before you send them out?

hdd_partitions: "/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WX11A23L4840-part
1"
ssd_partitions: "/dev/nvme1n1p1 /dev/nvme0n1p1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2CW240A3_CVCV204303WP240CGN-part1"

That's _very_ specific to a given machine.  I'm not familiar with
this test, so I don't know what I need to change.

[snipped 4000 lines of gunk]

