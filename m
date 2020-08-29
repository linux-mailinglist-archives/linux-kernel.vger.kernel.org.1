Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355412566FD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgH2LEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 07:04:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:5858 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgH2LEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:04:40 -0400
IronPort-SDR: J1cwb1yXm/2pAp2ynEzP+ZmVXMhRvuFvG1FRQF4O2o7lCmBjKN8+q4VM47tsiWhbHNXAYlk+9f
 8bOuq6BRokbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="218341472"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="218341472"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 04:04:39 -0700
IronPort-SDR: ZtQx8mFrOLJFCNO/bnyXbsFYf5aKDm2Czs65vOJUhs+EUA+bgGtw6IAUp78DPNofs3bI8UYd5/
 cUJYdBwx7Qlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="313855298"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2020 04:04:36 -0700
Date:   Sat, 29 Aug 2020 19:04:36 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, <x86@kernel.org>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200829110436.GF13723@shuo-intel.sh.intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-7-shuo.a.liu@intel.com>
 <20200828102738.GC1470435@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200828102738.GC1470435@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri 28.Aug'20 at 12:27:38 +0200, Greg Kroah-Hartman wrote:
>On Tue, Aug 25, 2020 at 10:45:06AM +0800, shuo.a.liu@intel.com wrote:
>> +	default:
>> +		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
>> +		ret = -EINVAL;
>
>Wrong error value here, right?

Right, it should be -ENOIOCTLCMD.

However, i found many instances in kernel drivers return -EINVAL for no
ioctl command support. :)

>
>And you just made a simple way to cause a DoS on the kernel log :(

Oh, let me remove the warn log.

Thanks
shuo
