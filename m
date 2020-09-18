Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DAF26EE06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgIRCZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgIRCZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:25:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 19:25:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so3741387ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 19:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T56qMsPGzWF08KMWlAqdDFH5oLCCGt9BbEyPYpSUPFA=;
        b=YOBTCHpxoID28PxzYrpK+ZumDmkfyHunBhDSx1gEQzjODvEEq8Lb2mUsuV9AOO3rP3
         oFkfXzPkLOpW387WoQbiot3Ky6fc4ANzHU2C61l4Xx5i47RuVHx6c0okvGcTNibRCHPk
         /eR0euQrbeFQQB67Qg9SQ4evyKOhT/hbxMR4ruh5TgatOcbGDqwZzYNXTJWjWGBfPPuz
         IRBorP/Lyl7+lplynjVq8mbXIM0g+tCmaCXd2/36+DpTiyqp/2KzGQZ1v+h9Zgux3Nmo
         8txLPmbxPj6lXUpCuRNwUQdS4ErdpkOfC1KTwK0DczT9f19G+/G3/QO63NZZMFMiavFe
         BSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T56qMsPGzWF08KMWlAqdDFH5oLCCGt9BbEyPYpSUPFA=;
        b=eO0trpxAG0uJ2jYV7Zdo4WMM6NddEiylzR/hSjWcbuyqczGNk9ZJXFp2HobPMhxdlp
         8Kg+RPFz6p4tg8e5C6LzbGC5Gu/W4a2fpnLddmV9QWPPM8fbmTmiQfk7oNLxB36DXj6w
         5P5j0aHglnwknH2W7S7P9ssZ37Es2IKQ02HupwmQbWcwTymAEtl3OzjwW1K71Bdixkz9
         w0+Sa3rOc/ivyQcBsLwHkh1h0PuqH1b6/FEPOpHVjXD/d5Nj/JavC1Q2mLr3lPdhYJz4
         3w0FDKU7F9z6F7TgMjuGkrODufB6TCW54PkWxWuwpa7fsxD+BRaOGM3cIZJWJtf94Ly9
         Msow==
X-Gm-Message-State: AOAM530R7s91SrIjGOC+oX00gL5oXqpc9MvuMNmQ5+cFse0MGhGYvyyj
        ZLfeTamLUnrt2dXF2Km9UujhZMqnGgVR9az7eO0=
X-Google-Smtp-Source: ABdhPJwBAJIg+2yIRU9Pdzd8OhWVcrrYP9BdldKJKSAYVL0NNEewSTD+kdnp/sRiasc8yWPhEcGkb0gUE5hZVGqaSLw=
X-Received: by 2002:a2e:a16c:: with SMTP id u12mr10702578ljl.266.1600395917485;
 Thu, 17 Sep 2020 19:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam> <20200917123951.GP18329@kadam>
In-Reply-To: <20200917123951.GP18329@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 18 Sep 2020 07:55:05 +0530
Message-ID: <CAFqt6zZUAtjU872kpem+nv7QM7h13Z9hH9gZFR=8=VKWxfxdmQ@mail.gmail.com>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        gustavoars@kernel.org, madhuparnabhowmik10@gmail.com,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Sep 17, 2020 at 6:10 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
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
> >       drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
> >
> >    I'll test it out tonight and see how well it works.  I don't
> >    immediately see any other bugs allthough Smatch doesn't like the code
> >    in siw_umem_release().  It uses "min_t(int" which suggests that
> >    negative pages are okay.
> >
> >          int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
> >
>
> I only found one bug but I'm going to add unpin_user_pages_dirty_lock()
> to the mix a retest.  There were a few other false positives.  In
> reviewing the code, I noticed that orangefs_bufmap_map() is also buggy.
>
> I sort of feel like returning partial successes is not working.  We
> could easily make a wrapper which either pins everything or it returns
> an error code.
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


I have drafted a patch for this bug. Shall I post it ?
