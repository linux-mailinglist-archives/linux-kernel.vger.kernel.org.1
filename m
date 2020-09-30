Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFAB27DEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgI3DCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:02:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:25839 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbgI3DCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:02:52 -0400
IronPort-SDR: DkC8aMrSLFWiMTVugdWdPhFZZe2Zda7tVRE+sd/2K4xGk05Jzkl38ENVmUIVcgTS1TpQ/34KoT
 ku9DWplCrhiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="150001893"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="150001893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 20:02:50 -0700
IronPort-SDR: j0zYFtiI3CcvCNpGs+13Wz3yrYJ8yxSd5nN6Gc6o10LCLnsJUUEFnwJ4hqgDOKzrRYnJ5Fvenf
 BHMCuz9WFiKg==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="495006793"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 20:02:46 -0700
Date:   Wed, 30 Sep 2020 11:02:44 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 02/17] x86/acrn: Introduce acrn_{setup,
 remove}_intr_handler()
Message-ID: <20200930030244.GI1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-3-shuo.a.liu@intel.com>
 <20200929175947.GL21110@zn.tnic>
 <873630jqiy.fsf@nanos.tec.linutronix.de>
 <20200929202604.GP21110@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200929202604.GP21110@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue 29.Sep'20 at 22:26:54 +0200, Borislav Petkov wrote:
>On Tue, Sep 29, 2020 at 10:07:17PM +0200, Thomas Gleixner wrote:
>> That does not prevent that either and notifiers suck.
>
>Bah, atomic notifiers run functions which cannot block, not what is
>needed here, right.
>
>> The pointer is fine and if something removes the handler before all of
>> the muck is shutdown then the author can keep the pieces and mop up
>> the remains.
>
>Uhu, so what makes sure that the module is not removed while an IRQ is
>happening?

The precondition of the removing of the module is that there is no
User VM living (every opening of the dev file will hold a ref count of
the module). The interrupt only can occur with active User VMs. So if
a notification interrupt is happending, the module cannot be removed as
there is still User VM living.

Thanks
shuo
