Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA08F2AB1E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgKIHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:52:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F93C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=DQp7Z8atBHTyupqZQXsiHfDtdq00mAq/dg+gPrxsabM=; b=C5Ly9d20rUqQLMssiKEQpyR9IJ
        fXb8BUn6LRAxyvNBhc9DyVlZ6MsgkNhp6GAshCYRt8EvKY0wIdtu1Y3q1+X3xaobvizCcmlc935Pq
        TvMCrhqPi9dIR1/p2A5fU/dDn/iCqGD1YVyV3ZFKoR1Co0QNIKrjrVCA13IsIZva4KJPmPPrr51x0
        nMECXM46ForuD6xUcH5eZmWadnureyK9AQ6kwzfe3JlJqUoZ7hakKBWympNYpLm1tN4fC7WsIqRvW
        66WWkv3SwHVh0/wgbCLHWM2LSbLfp2luvqb/FiUkQ61G7iPys0bDDlBXm9UZQ+/uk046rmg2BK7dH
        o6LcYBJw==;
Received: from [2601:1c0:6280:3f0::a1cb]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc1yL-00015P-BO; Mon, 09 Nov 2020 07:52:17 +0000
Subject: Re: [PATCH v2] mm/gup_test: GUP_TEST depends on DEBUG_FS
To:     John Hubbard <jhubbard@nvidia.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
References: <20201108083732.15336-1-song.bao.hua@hisilicon.com>
 <cf1b1b35-c608-9b5e-0c1a-216431b83750@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <071150d8-9159-91c4-118d-b19c2bd785ea@infradead.org>
Date:   Sun, 8 Nov 2020 23:52:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cf1b1b35-c608-9b5e-0c1a-216431b83750@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/20 11:45 PM, John Hubbard wrote:
> On 11/8/20 12:37 AM, Barry Song wrote:
>> Without DEBUG_FS, all the code in gup_test becomes meaningless. For sure
>> kernel provides debugfs stub while DEBUG_FS is disabled, but the point
>> here is that GUP_TEST can do nothing without DEBUG_FS.
>>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> ---
>>   -v2:
>>   add comment as a prompt to users as commented by John and Randy, thanks!
>>
>>   mm/Kconfig | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Thanks for suffering through a lot of discussion about this!
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> 
> thanks,

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
~Randy
