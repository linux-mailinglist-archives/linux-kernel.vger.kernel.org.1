Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36EE2CB2B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 03:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgLBCPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 21:15:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:40430 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgLBCPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:15:19 -0500
IronPort-SDR: qINJZtn3GCGvS7UUYBGQfjFtkDaROOReGQnkEqpgxsWg0wdaEndeaTgXM83fxmGT1Riq2WNG+0
 9i548VVBaJdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152769583"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="152769583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:14:35 -0800
IronPort-SDR: VE2kQQ2u+jXZZF/lF1p4onHQnSaV04KS7/IW+cjbSLejICEyKPW0/Pmpfwo+I+gDG3CynyANxr
 DzW0Stt/oy4g==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="549835606"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:14:31 -0800
Date:   Wed, 2 Dec 2020 10:14:29 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v6 06/18] virt: acrn: Introduce VM management interfaces
Message-ID: <20201202021429.GL17702@shuo-intel.sh.intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-7-shuo.a.liu@intel.com>
 <X8YWa8IUCgOARYMS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X8YWa8IUCgOARYMS@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  1.Dec'20 at 11:09:47 +0100, Greg Kroah-Hartman wrote:
>On Tue, Dec 01, 2020 at 05:38:41PM +0800, shuo.a.liu@intel.com wrote:
>> +		vm_param->reserved0 = 0;
>> +		vm_param->reserved1 = 0;
>
>NO!
>
>This means that userspace can put whatever crud they want in those
>fields, and you will happily zero it out.  Then, when those reserved
>fields are wanted to be used in the future, you will take those values
>from userspace and accept them as a valid value.  But, since userspace
>was sending crud before, now you will take that crud and do something
>with it.
>
>TEST IT to verify that it is zero, that way userspace gets it right the
>first time, and you don't get it wrong later, as you can not change it
>later.

OK. Thanks for the elaboration. I will test it and return -EINVAL if
it is not zero.

