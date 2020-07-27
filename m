Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C522F3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgG0PgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 11:36:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgG0PgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:36:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13D2DADBB;
        Mon, 27 Jul 2020 15:36:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B096DA701; Mon, 27 Jul 2020 17:35:38 +0200 (CEST)
Date:   Mon, 27 Jul 2020 17:35:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     David Sterba <dsterba@suse.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: fs/btrfs/tests/../ctree.h:2166:8: warning: type qualifiers
 ignored on function return type
Message-ID: <20200727153538.GP3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        David Sterba <dsterba@suse.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202007272305.7v7EMn6N%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007272305.7v7EMn6N%lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:02:07PM +0800, kernel test robot wrote:
> Hi David,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   92ed301919932f777713b9172e525674157e983d
> commit: f7cea56c0fff95bd5a6cd21b9fa299f66193b604 btrfs: sysfs: export supported checksums
> date:   8 months ago
> config: h8300-randconfig-r021-20200727 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f7cea56c0fff95bd5a6cd21b9fa299f66193b604
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from fs/btrfs/tests/extent-map-tests.c:8:
> >> fs/btrfs/tests/../ctree.h:2166:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>     2166 | size_t __const btrfs_get_num_csums(void);
>          |        ^~~~~~~

Ah right, the attribute is supposed to be __attribute_const__, thanks
for the report.
