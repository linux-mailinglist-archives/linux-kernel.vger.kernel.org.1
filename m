Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7EC289CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgJJAkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:40:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:14878 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgJJA0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:26:35 -0400
IronPort-SDR: S65T5W2vE9EfbT5UW6GA1PoJYZZlle+qsGKnPj8LUjSqn0J1kW+tRBACaf9n/uZXf48KS8lKld
 axQY2HgeCBWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="152471864"
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="152471864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 17:26:28 -0700
IronPort-SDR: 5ePig7T99IXUzWtaUC9ICLZ7NtCQnvXRIXwwjMvIVfN6FJI/cfVIFsk/SetacBKMYJQuwx9UUl
 /otEad6RQUWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="317208202"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2020 17:26:26 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm: Fix a race during split THP
References: <20201009073647.1531083-1-ying.huang@intel.com>
        <20201009132704.GS20115@casper.infradead.org>
Date:   Sat, 10 Oct 2020 08:26:26 +0800
In-Reply-To: <20201009132704.GS20115@casper.infradead.org> (Matthew Wilcox's
        message of "Fri, 9 Oct 2020 14:27:04 +0100")
Message-ID: <87362n7wp9.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Oct 09, 2020 at 03:36:47PM +0800, Huang, Ying wrote:
>> +	if (PageSwapCache(head)) {
>> +		swp_entry_t entry = { .val = page_private(head) };
>> +
>> +		split_swap_cluster(entry);
>> +	}
> ...
>> -		if (PageSwapCache(head)) {
>> -			swp_entry_t entry = { .val = page_private(head) };
>> -
>> -			ret = split_swap_cluster(entry);
>
> Are we sure split_swap_cluster() can't fail?  Or if it does fail, it's
> OK to continue with the split and not report the error?

split_swap_cluster() can only fail for invalid swap entry.  Which isn't
expected to happen in this situation.

Best Regards,
Huang, Ying
