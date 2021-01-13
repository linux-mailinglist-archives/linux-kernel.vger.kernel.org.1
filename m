Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64402F56CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbhANBxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbhANABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:01:13 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E285DC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:49:43 -0800 (PST)
Received: from jlbec by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzptR-00A5nn-Uf; Wed, 13 Jan 2021 23:49:38 +0000
Date:   Wed, 13 Jan 2021 15:49:33 -0800
From:   Joel Becker <jlbec@evilplan.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v3 0/4] configfs: implement committable items and
 add sample code
Message-ID: <X/+HDQBc1dx9Ipdm@google.com>
Mail-Followup-To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20201229102235.29550-1-brgl@bgdev.pl>
 <CAMRc=MdpYinY1zobG7e9Ds7KdX5-S5hVzHv8ZsShuPqK__QcAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdpYinY1zobG7e9Ds7KdX5-S5hVzHv8ZsShuPqK__QcAQ@mail.gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:32:14AM +0100, Bartosz Golaszewski wrote:
> On Tue, Dec 29, 2020 at 11:22 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Committable items in configfs are well defined and documented but unfortunately
> > so far never implemented.
> >
> > The use-case we have over at the GPIO subsystem is using configfs in
> > conjunction with sysfs to replace our current gpio-mockup testing module
> > with one that will be much more flexible and will allow complete coverage
> > of the GPIO uAPI.
> >
> > The current gpio-mockup module is controlled using module parameters which
> > forces the user to reload it everytime they need to change the chip
> > configuration or layout and makes it difficult to extend its functionality.
> >
> > Testing module based on configfs would allow fine-grained control over dummy
> > GPIO chips but since GPIO devices must be configured before they are
> > instantiated, we need committable items.
> >
> > This implements them and adds code examples to configfs_sample module. The
> > first two patches are just cosmetic.
> >
> > v1 -> v2:
> > - fix a 'set but not used' build warning reported by kernel test robot
> >
> > v2 -> v3:
> > - use (1UL << bit) instead of BIT() in patch 2/4
> > - extend configfs_dump_one() to make it print the new flags
> > - clear the CONFIGFS_USET_DIR bit on the live group dirent
> >
> > Rebased on top of v5.11-rc1.
> >
> > Bartosz Golaszewski (4):
> >   configfs: increase the item name length
> >   configfs: use (1UL << bit) for internal flags
> >   configfs: implement committable items
> >   samples: configfs: add a committable group
> >
> >  Documentation/filesystems/configfs.rst |   6 +-
> >  fs/configfs/configfs_internal.h        |  22 +--
> >  fs/configfs/dir.c                      | 240 ++++++++++++++++++++++++-
> >  fs/configfs/file.c                     |   8 +
> >  include/linux/configfs.h               |   3 +-
> >  samples/configfs/configfs_sample.c     | 150 ++++++++++++++++
> >  6 files changed, 409 insertions(+), 20 deletions(-)
> >
> > --
> > 2.29.1
> >
> 
> Joel, Christoph,
> 
> This series in its current form has been on the list for many weeks.
> Are there any objections from your side against merging it for v5.12?

Hey Bartosz,

I don't have much time for code reviews these days (you can see my
lack of mailing list stats), so I only saw your series today.  I
accidentally reviewed the first version, but my comments there still
stand.  Overall, I'm very happy to see this implemented.

Thanks,
Joel

-- 

"Get right to the heart of matters.
 It's the heart that matters more."

			http://www.jlbec.org/
			jlbec@evilplan.org
