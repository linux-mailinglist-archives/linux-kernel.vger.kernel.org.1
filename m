Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F992A075B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgJ3ODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:03:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:43064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgJ3ODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:03:08 -0400
IronPort-SDR: +rjR0DeCvQyCDw67nVe9mLVMAHKG7RBuWMWfMMe1y7PNpDJe25g1ckrlj/CGo6xGskI2T0MYxP
 Lsz1qJUHIIYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="155583784"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="155583784"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 07:02:55 -0700
IronPort-SDR: Q3U52sSfyDhy6D8+Qn+ADT9gbqGym7r6Q48NRQeuEJGqTkHVSZRpMjbn+IWhWWqRZjw0fMVrV2
 hnQt1dBzl8CQ==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="537074393"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.168.224]) ([10.249.168.224])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 07:02:49 -0700
Subject: Re: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7% regression
To:     Matthew Wilcox <willy@infradead.org>
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
References: <20201030071715.GV31092@shao2-debian>
 <20201030131711.GJ27442@casper.infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
Date:   Fri, 30 Oct 2020 22:02:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201030131711.GJ27442@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2020 9:17 PM, Matthew Wilcox wrote:
> On Fri, Oct 30, 2020 at 03:17:15PM +0800, kernel test robot wrote:
>> Details are as below:
>> -------------------------------------------------------------------------------------------------->
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install job.yaml  # job file is attached in this email
>>          bin/lkp run     job.yaml
> 
> Do you actually test these instructions before you send them out?
> 
> hdd_partitions: "/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WX11A23L4840-part
> 1"
> ssd_partitions: "/dev/nvme1n1p1 /dev/nvme0n1p1"
> rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2CW240A3_CVCV204303WP240CGN-part1"
> 
> That's _very_ specific to a given machine.  I'm not familiar with
> this test, so I don't know what I need to change.


Hi Matthew,

Sorry about that, I copied the job.yaml file from the server,
the right way to do is to set your disk partitions in the yaml,
please see https://github.com/intel/lkp-tests#run-your-own-disk-partitions.

there is another reproduce script attached in the original mail
for your reference.

Best Regards,
Rong Chen



> 
> [snipped 4000 lines of gunk]
> 
