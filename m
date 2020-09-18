Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B79C26F5D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIRGSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:18:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRGSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:18:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08I694Sg004475;
        Fri, 18 Sep 2020 06:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=k4jB8ZzwnSN5WyaxUV+OL5N2K/jvS8fi/VDt2bmoysU=;
 b=ckz41yeKNbjqullaLNTys4lZUbuTLVEK7wySqo1YyiCfceOTt42+o3k04CQ4ID1kWKsw
 t0DYzOlV/0YOjAwuM4EZu06TwBiT4J31MtZn8F6XbUrMYSxAHgXWx3x9uJFr/3WfWI2Y
 /XpxVJvTEP2JQkMREX4IMQy6H9RJSjjaTsC5mGgvL+X4Xpv9Tl53DxHnycOE5gG0oxrt
 f2PafetnW0uBQhRYJvX4AUCAw9tnpukLzr1/xVnZ6/LEiegFDKGqHS3orSF07XKp9Hic
 xEkTSRiYeoEDyuA4b3rL0GIphSLV9BlbpXcJZfV+pL2p4GgWvW5Qgl9XbBjqikSA6SB1 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33gp9mn5cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 06:17:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08I69aet144642;
        Fri, 18 Sep 2020 06:15:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33h88djr49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 06:15:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08I6FhfL012019;
        Fri, 18 Sep 2020 06:15:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 06:15:43 +0000
Date:   Fri, 18 Sep 2020 09:15:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        gustavoars@kernel.org, madhuparnabhowmik10@gmail.com,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
Message-ID: <20200918061535.GQ18329@kadam>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam>
 <20200917123951.GP18329@kadam>
 <CAFqt6zZUAtjU872kpem+nv7QM7h13Z9hH9gZFR=8=VKWxfxdmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZUAtjU872kpem+nv7QM7h13Z9hH9gZFR=8=VKWxfxdmQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=2 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=2 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 07:55:05AM +0530, Souptick Joarder wrote:
> Hi Dan,
> 
> On Thu, Sep 17, 2020 at 6:10 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Sep 16, 2020 at 01:02:32PM +0300, Dan Carpenter wrote:
> > > On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> > > > There is an error when pin_user_pages_fast() returns -ERRNO and
> > > > inside error handling path driver end up calling unpin_user_pages()
> > > > with -ERRNO which is not correct.
> > > >
> > > > This patch will fix the problem.
> > >
> > > There are a few ways we could prevent bug in the future.
> > >
> > > 1) This could have been caught with existing static analysis tools
> > >    which warn about when a value is set but not used.
> > >
> > > 2) I've created a Smatch check which warngs about:
> > >
> > >       drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
> > >
> > >    I'll test it out tonight and see how well it works.  I don't
> > >    immediately see any other bugs allthough Smatch doesn't like the code
> > >    in siw_umem_release().  It uses "min_t(int" which suggests that
> > >    negative pages are okay.
> > >
> > >          int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
> > >
> >
> > I only found one bug but I'm going to add unpin_user_pages_dirty_lock()
> > to the mix a retest.  There were a few other false positives.  In
> > reviewing the code, I noticed that orangefs_bufmap_map() is also buggy.
> >
> > I sort of feel like returning partial successes is not working.  We
> > could easily make a wrapper which either pins everything or it returns
> > an error code.
> >
> > drivers/misc/mic/scif/scif_rma.c:1399 __scif_pin_pages() warn: unpinning negative pages 'pinned_pages->nr_pages'
> >
> > drivers/misc/mic/scif/scif_rma.c
> >   1355                          vmalloc_addr = true;
> >   1356
> >   1357                  for (i = 0; i < nr_pages; i++) {
> >   1358                          if (vmalloc_addr)
> >   1359                                  pinned_pages->pages[i] =
> >   1360                                          vmalloc_to_page(addr + (i * PAGE_SIZE));
> >   1361                          else
> >   1362                                  pinned_pages->pages[i] =
> >   1363                                          virt_to_page(addr + (i * PAGE_SIZE));
> >   1364                  }
> >   1365                  pinned_pages->nr_pages = nr_pages;
> >   1366                  pinned_pages->map_flags = SCIF_MAP_KERNEL;
> >   1367          } else {
> >   1368                  /*
> >   1369                   * SCIF supports registration caching. If a registration has
> >   1370                   * been requested with read only permissions, then we try
> >   1371                   * to pin the pages with RW permissions so that a subsequent
> >   1372                   * transfer with RW permission can hit the cache instead of
> >   1373                   * invalidating it. If the upgrade fails with RW then we
> >   1374                   * revert back to R permission and retry
> >   1375                   */
> >   1376                  if (prot == SCIF_PROT_READ)
> >   1377                          try_upgrade = true;
> >   1378                  prot |= SCIF_PROT_WRITE;
> >   1379  retry:
> >   1380                  mm = current->mm;
> >   1381                  if (ulimit) {
> >   1382                          err = __scif_check_inc_pinned_vm(mm, nr_pages);
> >   1383                          if (err) {
> >   1384                                  pinned_pages->nr_pages = 0;
> >   1385                                  goto error_unmap;
> >   1386                          }
> >   1387                  }
> >   1388
> >   1389                  pinned_pages->nr_pages = pin_user_pages_fast(
> >   1390                                  (u64)addr,
> >   1391                                  nr_pages,
> >   1392                                  (prot & SCIF_PROT_WRITE) ? FOLL_WRITE : 0,
> >   1393                                  pinned_pages->pages);
> >   1394                  if (nr_pages != pinned_pages->nr_pages) {
> >   1395                          if (try_upgrade) {
> >   1396                                  if (ulimit)
> >   1397                                          __scif_dec_pinned_vm_lock(mm, nr_pages);
> >   1398                                  /* Roll back any pinned pages */
> >   1399                                  unpin_user_pages(pinned_pages->pages,
> >   1400                                                   pinned_pages->nr_pages);
> >                                                          ^^^^^^^^^^^^^^^^^^^^^^
> > Negative.
> >
> >   1401                                  prot &= ~SCIF_PROT_WRITE;
> >   1402                                  try_upgrade = false;
> >   1403                                  goto retry;
> >   1404                          }
> >   1405                  }
> >   1406                  pinned_pages->map_flags = 0;
> >   1407          }
> >   1408
> >   1409          if (pinned_pages->nr_pages < nr_pages) {
> >                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > These are both signed so it negative ->nr_pages are less than nr_pages.
> >
> >   1410                  err = -EFAULT;
> >   1411                  pinned_pages->nr_pages = nr_pages;
> >                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This sets it to "everything was pinned".
> >
> >   1412                  goto dec_pinned;
> >   1413          }
> >   1414
> >   1415          *out_prot = prot;
> >   1416          atomic_set(&pinned_pages->ref_count, 1);
> >   1417          *pages = pinned_pages;
> >   1418          return err;
> >   1419  dec_pinned:
> >   1420          if (ulimit)
> >   1421                  __scif_dec_pinned_vm_lock(mm, nr_pages);
> >   1422          /* Something went wrong! Rollback */
> >   1423  error_unmap:
> >   1424          pinned_pages->nr_pages = nr_pages;
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This assumes everything was pinned successfully.
> >
> >   1425          scif_destroy_pinned_pages(pinned_pages);
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > We absolutely don't want to pass negative ->nr_pages to this function
> > either.
> >
> >   1426          *pages = NULL;
> >   1427          dev_dbg(scif_info.mdev.this_device,
> >   1428                  "%s %d err %d len 0x%lx\n", __func__, __LINE__, err, len);
> >   1429          return err;
> >   1430  }
> >
> > regards,
> > dan carpenter
> 
> 
> I have drafted a patch for this bug. Shall I post it ?

Absolutely, please.  :)

regards,
dan carpenter
