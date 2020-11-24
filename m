Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C051F2C1DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 06:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgKXFuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 00:50:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:3047 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgKXFuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 00:50:12 -0500
IronPort-SDR: aPgRuEr4hKr2BG9iL5NZa1ScHNpDlOecoIqXh1Bct/xTFFxXLHU/oBpg8kmq1DrjY7OK6URjSG
 rNG93csuAePA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151153263"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="151153263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 21:50:11 -0800
IronPort-SDR: t3RNwX1Map1jDRetTwQUGnvO5neixIETF0IOkNUrd2EFFaKVPHkszkyG3YJJKTWrxJWffbgP6k
 t3/wakbV2wmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432500792"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2020 21:50:09 -0800
Date:   Tue, 24 Nov 2020 13:45:39 +0800
From:   Philip Li <philip.li@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: arch/powerpc/mm/book3s64/pgtable.c:174:15: error: no previous
 prototype for 'create_section_mapping'
Message-ID: <20201124054539.GB20421@intel.com>
References: <202011241003.eYk8XbNj-lkp@intel.com>
 <CAPcyv4hoGYDro_JKUtKv+A69u=+2rKdfkACmNR6ndb-ZXGJsDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hoGYDro_JKUtKv+A69u=+2rKdfkACmNR6ndb-ZXGJsDw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:20:46PM -0800, Dan Williams wrote:
> On Mon, Nov 23, 2020 at 6:13 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc
> > commit: a927bd6ba952d13c52b8b385030943032f659a3e mm: fix phys_to_target_node() and memory_add_physaddr_to_nid() exports
> > date:   31 hours ago
> > config: powerpc-randconfig-r024-20201123 (attached as .config)
> > compiler: powerpc64le-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a927bd6ba952d13c52b8b385030943032f659a3e
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout a927bd6ba952d13c52b8b385030943032f659a3e
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> arch/powerpc/mm/book3s64/pgtable.c:174:15: error: no previous prototype for 'create_section_mapping' [-Werror=missing-prototypes]
> >      174 | int __meminit create_section_mapping(unsigned long start, unsigned long end,
> >          |               ^~~~~~~~~~~~~~~~~~~~~~
> >    arch/powerpc/mm/book3s64/pgtable.c:405:6: error: no previous prototype for 'arch_report_meminfo' [-Werror=missing-prototypes]
> >      405 | void arch_report_meminfo(struct seq_file *m)
> >          |      ^~~~~~~~~~~~~~~~~~~
> >    arch/powerpc/mm/book3s64/pgtable.c:461:5: error: no previous prototype for 'pmd_move_must_withdraw' [-Werror=missing-prototypes]
> >      461 | int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> >          |     ^~~~~~~~~~~~~~~~~~~~~~
> >    cc1: all warnings being treated as errors
> >
> > vim +/create_section_mapping +174 arch/powerpc/mm/book3s64/pgtable.c
> 
> The whack-a-mole continues... the kbuild-robot success report I
> received gave me too much confidence.
sorry Dan, this is a newly generated randconfig, which is not in
the coverage of build success report. Sorry for the confusion.

> 
