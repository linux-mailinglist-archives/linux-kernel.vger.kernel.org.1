Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069CF2F3723
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405525AbhALR3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:29:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:42042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388300AbhALR3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:29:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4594BABD6;
        Tue, 12 Jan 2021 17:29:08 +0000 (UTC)
Date:   Tue, 12 Jan 2021 09:29:01 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 09/18] virt: acrn: Introduce I/O request management
Message-ID: <20210112172901.ilp7vf3hqmbvav7y@offworld>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-10-shuo.a.liu@intel.com>
 <20210111215219.l44yfpyqh4m2mcbl@offworld>
 <20210112060527.GF22447@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210112060527.GF22447@shuo-intel.sh.intel.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021, Shuo A Liu wrote:

>On Mon 11.Jan'21 at 13:52:19 -0800, Davidlohr Bueso wrote:
>>Could this not be done in process context instead?
>
>It could be. The original consideration with tasklet was more about
>performance as the I/O requests dispatching is a hot code path. I think
>irq thread has little performance impact? I can have a try to convert
>the tasklet to irq thread.

Yes, there is some added latency between when the work is scheduled and
actually executed - however this should not be a problem for this scenario,
and furthermore consider that tasklets do not guarantee performance as
ksoftirqd comes in the picture under heavy load.

Thanks,
Davidlohr
