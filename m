Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5072830404F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405897AbhAZO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:29:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:5622 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405550AbhAZO0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:26:13 -0500
IronPort-SDR: o68jXiInwOxN9TZsRLyhdk3hAtIkCI+LNTcXnz7iEiAg1lIM3Q76aakp1NoCY8xffL45XatDtb
 2ceof+v6UqaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="167578080"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="167578080"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 06:25:28 -0800
IronPort-SDR: vvt6Adz2BKcGwpgcWYcH6FKlCUOcTI7rq0u1VcZGFWVx6poy2y1ywqfBOwaSS9FpY9mYHyZd7I
 ONPGlqgmDVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="350679839"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2021 06:25:26 -0800
Subject: Re: [PATCH v6] usb: xhci-mtk: fix unreleased bandwidth data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210113180444.v6.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <YBAjjmpc4yPrpmgQ@kroah.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <b8a2cd47-ff32-2251-4431-da05a0f038f7@intel.com>
Date:   Tue, 26 Jan 2021 16:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBAjjmpc4yPrpmgQ@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.1.2021 16.13, Greg Kroah-Hartman wrote:
> On Wed, Jan 13, 2021 at 06:05:11PM +0800, Ikjoon Jang wrote:
>> xhci-mtk needs XHCI_MTK_HOST quirk functions in add_endpoint() and
>> drop_endpoint() to handle its own sw bandwidth management.
>>
>> It stores bandwidth data into an internal table every time
>> add_endpoint() is called, and drops those in drop_endpoint().
>> But when bandwidth allocation fails at one endpoint, all earlier
>> allocation from the same interface could still remain at the table.
>>
>> This patch moves bandwidth management codes to check_bandwidth() and
>> reset_bandwidth() path. To do so, this patch also adds those functions
>> to xhci_driver_overrides and lets mtk-xhci to release all failed
>> endpoints in reset_bandwidth() path.
>>
>> Fixes: 08e469de87a2 ("usb: xhci-mtk: supports bandwidth scheduling with multi-TT")
>> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> 
> Mathias, any objection to me taking this patch, or do you have others
> being queued up for 5.11-final?
> 

No objections, haven't tried it out but it looks good to me.

If I finish some additional small fix for 5.11-final I can make it on top of this

-Mathias 
