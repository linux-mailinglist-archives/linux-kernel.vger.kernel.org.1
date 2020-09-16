Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1D26CD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgIPU6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:58:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:8404 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgIPQbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:31:46 -0400
IronPort-SDR: DP0SPWB6BtUVdPJ8EMrzDQu4tdcofjtkqugKFr0ptwGe/B6PgqchDl5foqzcor8FXY0pMGeLKz
 egTuHEesu2QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="139498286"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="139498286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 08:16:10 -0700
IronPort-SDR: uu2rgLYbGEv6J48JHwMxcBc511k4mgfP134TD7aU7UXlQzTz0M+Iv/9M61KM0JCqy+ben9akZ8
 q7ZlZTEB55QA==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="483349223"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 08:16:10 -0700
Date:   Wed, 16 Sep 2020 08:16:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, madhuparnabhowmik10@gmail.com,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
Message-ID: <20200916151607.GB2485491@iweiny-DESK2.sc.intel.com>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916100232.GF18329@kadam>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:02:32PM +0300, Dan Carpenter wrote:
> On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> > There is an error when pin_user_pages_fast() returns -ERRNO and
> > inside error handling path driver end up calling unpin_user_pages()
> > with -ERRNO which is not correct.
> > 
> > This patch will fix the problem.
> 
> There are a few ways we could prevent bug in the future.
> 
> 1) This could have been caught with existing static analysis tools
>    which warn about when a value is set but not used.
> 
> 2) I've created a Smatch check which warngs about:
> 
> 	drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
> 
>    I'll test it out tonight and see how well it works.  I don't
>    immediately see any other bugs allthough Smatch doesn't like the code
>    in siw_umem_release().  It uses "min_t(int" which suggests that
>    negative pages are okay.
> 
> 	   int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
> 
> 3) We could add a check in unpin_user_pages().
> 
> 	if (WARN_ON(IS_ERR_VALUE(npages)))
> 		return;

Does IS_ERR_VALUE() work on an unsigned variable?  The issue with adding a
check in unpin_user_pages() is that npages is unsigned long.

Ira

> 
> It's not possible to pin more than "ULONG_MAX - 4095" because otherwise
> returning error pointers wouldn't work.  So this check can't break
> anything and it could prevent a crash.
> 
> regards,
> dan carpenter
> 
