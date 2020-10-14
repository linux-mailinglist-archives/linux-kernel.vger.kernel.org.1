Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4528DECD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgJNKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 06:19:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgJNKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 06:19:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC59BABA2;
        Wed, 14 Oct 2020 10:19:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 643371E1338; Wed, 14 Oct 2020 12:19:04 +0200 (CEST)
Date:   Wed, 14 Oct 2020 12:19:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/writeback] 8d92890bd6: will-it-scale.per_process_ops -15.3%
 regression
Message-ID: <20201014101904.GA11144@quack2.suse.cz>
References: <20201014084706.GB11647@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014084706.GB11647@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-10-20 16:47:06, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -15.3% regression of will-it-scale.per_process_ops due
> to commit:
> 
> commit: 8d92890bd6b8502d6aee4b37430ae6444ade7a8c ("mm/writeback: discard
> NR_UNSTABLE_NFS, use NR_WRITEBACK instead")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Thanks for report but it doesn't quite make sense to me. If we omit
reporting & NFS changes in that commit (which is code not excercised by
this benchmark), what remains are changes like:

        nr_pages += node_page_state(pgdat, NR_FILE_DIRTY);
-       nr_pages += node_page_state(pgdat, NR_UNSTABLE_NFS);
        nr_pages += node_page_state(pgdat, NR_WRITEBACK);
...
-               nr_reclaimable = global_node_page_state(NR_FILE_DIRTY) +
-                                       global_node_page_state(NR_UNSTABLE_NFS);
+               nr_reclaimable = global_node_page_state(NR_FILE_DIRTY);
...
-       gdtc->dirty = global_node_page_state(NR_FILE_DIRTY) +
-                     global_node_page_state(NR_UNSTABLE_NFS);
+       gdtc->dirty = global_node_page_state(NR_FILE_DIRTY);

So if there's any negative performance impact of these changes, they're
likely due to code alignment changes or something like that... So I don't
think there's much to do here since optimal code alignment is highly specific
to a particular CPU etc.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
