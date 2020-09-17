Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A991426E28B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIQRf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:35:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:13515 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIQRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:34:26 -0400
IronPort-SDR: OdVklUU62wCQs3ZUYy/pJF9iDiWC/NKL6kzXRqEmpZEiRu8VjxGtvsYiYRRI815LFuf9VEnzyn
 V10KevEOolJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="160678242"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="160678242"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:34:25 -0700
IronPort-SDR: Tfk15wsHCj+1fwMeEfq68zQkzJwAiQxm0lrVLBwfSLsqhngWIMQX1PcBBY0QXO/v0ToPNSju5z
 AtGPm0O6iGkg==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="307557365"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:34:24 -0700
Date:   Thu, 17 Sep 2020 10:34:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, jhubbard@nvidia.com,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        madhuparnabhowmik10@gmail.com, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
Message-ID: <20200917173424.GB2540965@iweiny-DESK2.sc.intel.com>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam>
 <20200917123951.GP18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917123951.GP18329@kadam>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:39:51PM +0300, Dan Carpenter wrote:
> On Wed, Sep 16, 2020 at 01:02:32PM +0300, Dan Carpenter wrote:
> > On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> > > There is an error when pin_user_pages_fast() returns -ERRNO and
> > > inside error handling path driver end up calling unpin_user_pages()
> > > with -ERRNO which is not correct.
> > > 
> > > This patch will fix the problem.
> > 
> > There are a few ways we could prevent bug in the future.
> > 
> > 1) This could have been caught with existing static analysis tools
> >    which warn about when a value is set but not used.
> > 
> > 2) I've created a Smatch check which warngs about:
> > 
> > 	drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
> > 
> >    I'll test it out tonight and see how well it works.  I don't
> >    immediately see any other bugs allthough Smatch doesn't like the code
> >    in siw_umem_release().  It uses "min_t(int" which suggests that
> >    negative pages are okay.
> > 
> > 	   int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
> >
> 
> I only found one bug but I'm going to add unpin_user_pages_dirty_lock()
> to the mix a retest.  There were a few other false positives.  In
> reviewing the code, I noticed that orangefs_bufmap_map() is also buggy.
> 
> I sort of feel like returning partial successes is not working.  We
> could easily make a wrapper which either pins everything or it returns
> an error code.

I guess the question is are there drivers which will keep working (or limp
along?) on partial pins?  A quick search of a driver I thought did this does
not apparently any more...  So it sounds good to me from 30,000 feet!  :-D

Ira

> 
> drivers/misc/mic/scif/scif_rma.c:1399 __scif_pin_pages() warn: unpinning negative pages 'pinned_pages->nr_pages'
> 
> drivers/misc/mic/scif/scif_rma.c
>   1355                          vmalloc_addr = true;
>   1356  
>   1357                  for (i = 0; i < nr_pages; i++) {
>   1358                          if (vmalloc_addr)
>   1359                                  pinned_pages->pages[i] =
>   1360                                          vmalloc_to_page(addr + (i * PAGE_SIZE));
>   1361                          else
>   1362                                  pinned_pages->pages[i] =
>   1363                                          virt_to_page(addr + (i * PAGE_SIZE));
>   1364                  }
>   1365                  pinned_pages->nr_pages = nr_pages;
>   1366                  pinned_pages->map_flags = SCIF_MAP_KERNEL;
>   1367          } else {
>   1368                  /*
>   1369                   * SCIF supports registration caching. If a registration has
>   1370                   * been requested with read only permissions, then we try
>   1371                   * to pin the pages with RW permissions so that a subsequent
>   1372                   * transfer with RW permission can hit the cache instead of
>   1373                   * invalidating it. If the upgrade fails with RW then we
>   1374                   * revert back to R permission and retry
>   1375                   */
>   1376                  if (prot == SCIF_PROT_READ)
>   1377                          try_upgrade = true;
>   1378                  prot |= SCIF_PROT_WRITE;
>   1379  retry:
>   1380                  mm = current->mm;
>   1381                  if (ulimit) {
>   1382                          err = __scif_check_inc_pinned_vm(mm, nr_pages);
>   1383                          if (err) {
>   1384                                  pinned_pages->nr_pages = 0;
>   1385                                  goto error_unmap;
>   1386                          }
>   1387                  }
>   1388  
>   1389                  pinned_pages->nr_pages = pin_user_pages_fast(
>   1390                                  (u64)addr,
>   1391                                  nr_pages,
>   1392                                  (prot & SCIF_PROT_WRITE) ? FOLL_WRITE : 0,
>   1393                                  pinned_pages->pages);
>   1394                  if (nr_pages != pinned_pages->nr_pages) {
>   1395                          if (try_upgrade) {
>   1396                                  if (ulimit)
>   1397                                          __scif_dec_pinned_vm_lock(mm, nr_pages);
>   1398                                  /* Roll back any pinned pages */
>   1399                                  unpin_user_pages(pinned_pages->pages,
>   1400                                                   pinned_pages->nr_pages);
>                                                          ^^^^^^^^^^^^^^^^^^^^^^
> Negative.
> 
>   1401                                  prot &= ~SCIF_PROT_WRITE;
>   1402                                  try_upgrade = false;
>   1403                                  goto retry;
>   1404                          }
>   1405                  }
>   1406                  pinned_pages->map_flags = 0;
>   1407          }
>   1408  
>   1409          if (pinned_pages->nr_pages < nr_pages) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> These are both signed so it negative ->nr_pages are less than nr_pages.
> 
>   1410                  err = -EFAULT;
>   1411                  pinned_pages->nr_pages = nr_pages;
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This sets it to "everything was pinned".
> 
>   1412                  goto dec_pinned;
>   1413          }
>   1414  
>   1415          *out_prot = prot;
>   1416          atomic_set(&pinned_pages->ref_count, 1);
>   1417          *pages = pinned_pages;
>   1418          return err;
>   1419  dec_pinned:
>   1420          if (ulimit)
>   1421                  __scif_dec_pinned_vm_lock(mm, nr_pages);
>   1422          /* Something went wrong! Rollback */
>   1423  error_unmap:
>   1424          pinned_pages->nr_pages = nr_pages;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This assumes everything was pinned successfully.
> 
>   1425          scif_destroy_pinned_pages(pinned_pages);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We absolutely don't want to pass negative ->nr_pages to this function
> either.
> 
>   1426          *pages = NULL;
>   1427          dev_dbg(scif_info.mdev.this_device,
>   1428                  "%s %d err %d len 0x%lx\n", __func__, __LINE__, err, len);
>   1429          return err;
>   1430  }
> 
> regards,
> dan carpenter
> 
