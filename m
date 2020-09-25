Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C815277E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgIYDGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:06:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:19689 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgIYDGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:06:55 -0400
IronPort-SDR: XyObduikimX3ItyKU8QFfkfCdNwS67SZfIYCVJ08Ju7oWIIbDugCeVzCMEO1YeLVTFZM1XcLW6
 nr3wKTCESpSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158769176"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="158769176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 20:06:55 -0700
IronPort-SDR: yR0ZXUpAWSiGmfpVzBjaa8bbcbsTv8Ie0OCqvZQBUgJItTZ3vT7NtTV5Fbalt7gkcXchpZuP34
 sTMgzGVfUWfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="512524442"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2020 20:06:54 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <20200922184838.978540-1-aquini@redhat.com>
        <20200922124750.67a20d9764ec098b17705407@linux-foundation.org>
        <20200923134251.GN795820@optiplex-lnx>
        <20200924195914.d240877a10e22b457bd9b45d@linux-foundation.org>
Date:   Fri, 25 Sep 2020 11:06:53 +0800
In-Reply-To: <20200924195914.d240877a10e22b457bd9b45d@linux-foundation.org>
        (Andrew Morton's message of "Thu, 24 Sep 2020 19:59:14 -0700")
Message-ID: <87v9g2blma.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 23 Sep 2020 09:42:51 -0400 Rafael Aquini <aquini@redhat.com> wrote:
>
>> On Tue, Sep 22, 2020 at 12:47:50PM -0700, Andrew Morton wrote:
>> > On Tue, 22 Sep 2020 14:48:38 -0400 Rafael Aquini <aquini@redhat.com> wrote:
>> > 
>> > > The swap area descriptor only gets struct swap_cluster_info *cluster_info
>> > > allocated if the swapfile is backed by non-rotational storage.
>> > > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
>> > > will naturally return NULL.
>> > > 
>> > > CONFIG_THP_SWAP exposes cluster_info infrastructure to a broader number of
>> > > use cases, and split_swap_cluster(), which is the counterpart of split_huge_page()
>> > > for the THPs in the swapcache, misses checking the return of lock_cluster before
>> > > operating on the cluster_info pointer.
>> > > 
>> > > This patch addresses that issue by adding a proper check for the pointer
>> > > not being NULL in the wrappers cluster_{is,clear}_huge(), in order to avoid
>> > > crashes similar to the one below:
>> > > 
>> > > ...
>> > >
>> > > Fixes: 59807685a7e77 ("mm, THP, swap: support splitting THP for THP swap out")
>> > > Signed-off-by: Rafael Aquini <aquini@redhat.com>
>> > 
>> > Did you consider cc:stable?
>> >
>> 
>> UGH! I missed adding it to my cc list. Shall I just forward it, now, or
>> do you prefer a fresh repost?
>
> I added the cc:stable to my copy.

Please don't merge this patch.  This patch doesn't fix the bug, but hide
the real bug.  I will work with Rafael on root causing and fixing.

Best Regards,
Huang, Ying
