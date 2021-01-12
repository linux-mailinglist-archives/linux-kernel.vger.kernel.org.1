Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED952F2833
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbhALGGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:06:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:62078 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbhALGGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:06:12 -0500
IronPort-SDR: rSNf3gADql83cgqRjAAXayeqtz63BuVYgvmJZUhYhlE5BEGy6b8tFJ6Y01KWlGCfBHyJGRWMxb
 Zv5ij197lcAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165670069"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="165670069"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 22:05:32 -0800
IronPort-SDR: k91NCzqCPw+ib8MsM69HogY7wGpnG0aOIekctd4VJJy6zeh5aZ/Z2hYcMkFzGn7Ek/TFqdslQd
 KPhuppKijTtQ==
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="381295354"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 22:05:29 -0800
Date:   Tue, 12 Jan 2021 14:05:27 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 09/18] virt: acrn: Introduce I/O request management
Message-ID: <20210112060527.GF22447@shuo-intel.sh.intel.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-10-shuo.a.liu@intel.com>
 <20210111215219.l44yfpyqh4m2mcbl@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210111215219.l44yfpyqh4m2mcbl@offworld>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11.Jan'21 at 13:52:19 -0800, Davidlohr Bueso wrote:
>On Wed, 06 Jan 2021, shuo.a.liu@intel.com wrote:
>>The processing flow of I/O requests are listed as following:
>>
>>a) The I/O handler of the hypervisor will fill an I/O request with
>>  PENDING state when a trapped I/O access happens in a User VM.
>>b) The hypervisor makes an upcall, which is a notification interrupt, to
>>  the Service VM.
>>c) The upcall handler schedules a tasklet to dispatch I/O requests.
>>d) The tasklet looks for the PENDING I/O requests, assigns them to
>>  different registered clients based on the address of the I/O accesses,
>>  updates their state to PROCESSING, and notifies the corresponding
>>  client to handle.
>
>Hmm so tasklets are deprecated (and have been for a while) and it's sad
>to see incoming new users in modern Linux. This wouldn't be the first one,
>however. We should be _removing_ users, not adding... In addition, this
>expands the whole tasklet_disable/enable() hacks.

Sorry, i had not noticed that.

>
>Could this not be done in process context instead?

It could be. The original consideration with tasklet was more about
performance as the I/O requests dispatching is a hot code path. I think
irq thread has little performance impact? I can have a try to convert
the tasklet to irq thread.

Thanks
shuo
