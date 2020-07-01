Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D321011F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 02:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGAAsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 20:48:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:37112 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgGAAsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 20:48:35 -0400
IronPort-SDR: M0FQhrJXXaUE4xq8cqDbs6uBH6WQAaEK64L8vn1P0UTJ6I3FB4XfE5BaTzB8S0lI264TW3ff2z
 vYuxo5ODOy2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="207939015"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="207939015"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 17:48:33 -0700
IronPort-SDR: 7uQbbDbavB+IgSwg+d5bR+aRJ7G8ZlZcCA6NpkA6LEfKLyr+Jz6dawj0KC6OlDv2W2wM51K7Va
 6jJCjumgaKMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="454807974"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga005.jf.intel.com with ESMTP; 30 Jun 2020 17:48:32 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <rientjes@google.com>, <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 8/8] mm/numa: new reclaim mode to enable reclaim-based migration
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234517.A7EC4BD3@viggo.jf.intel.com>
        <87v9j9ow3a.fsf@yhuang-dev.intel.com>
        <29c67873-3cb9-e121-382c-9b81491016bc@linux.alibaba.com>
Date:   Wed, 01 Jul 2020 08:48:31 +0800
In-Reply-To: <29c67873-3cb9-e121-382c-9b81491016bc@linux.alibaba.com> (Yang
        Shi's message of "Tue, 30 Jun 2020 10:50:30 -0700")
Message-ID: <87mu4knjq8.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yang,

Yang Shi <yang.shi@linux.alibaba.com> writes:

>>> diff -puN mm/vmscan.c~enable-numa-demotion mm/vmscan.c
>>> --- a/mm/vmscan.c~enable-numa-demotion	2020-06-29 16:35:01.017312549 -0700
>>> +++ b/mm/vmscan.c	2020-06-29 16:35:01.023312549 -0700
>>> @@ -4165,9 +4165,10 @@ int node_reclaim_mode __read_mostly;
>>>    * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>>>    * ABI.  New bits are OK, but existing bits can never change.
>>>    */
>>> -#define RECLAIM_RSVD  (1<<0)	/* (currently ignored/unused) */
>>> -#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
>>> -#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
>>> +#define RECLAIM_RSVD	(1<<0)	/* (currently ignored/unused) */
>>> +#define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>>> +#define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>>> +#define RECLAIM_MIGRATE	(1<<3)	/* Migrate pages during reclaim */
>>>     /*
>>>    * Priority for NODE_RECLAIM. This determines the fraction of pages
>> I found that RECLAIM_MIGRATE is defined but never referenced in the
>> patch.
>>
>> If my understanding of the code were correct, shrink_do_demote_mapping()
>> is called by shrink_page_list(), which is used by kswapd and direct
>> reclaim.  So as long as the persistent memory node is onlined,
>> reclaim-based migration will be enabled regardless of node reclaim mode.
>
> It looks so according to the code. But the intention of a new node
> reclaim mode is to do migration on reclaim *only when* the
> RECLAIM_MODE is enabled by the users.
>
> It looks the patch just clear the migration target node masks if the
> memory is offlined.
>
> So, I'm supposed you need check if node_reclaim is enabled before
> doing migration in shrink_page_list() and also need make node reclaim
> to adopt the new mode.

But why shouldn't we migrate in kswapd and direct reclaim?  I think that
we may need a way to control it, but shouldn't disable it
unconditionally.

> Please refer to
> https://lore.kernel.org/linux-mm/1560468577-101178-6-git-send-email-yang.shi@linux.alibaba.com/
>

Best Regards,
Huang, Ying
