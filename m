Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131902AD56A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgKJLij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:38:39 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:33956 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:38:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7553D803071A;
        Tue, 10 Nov 2020 11:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yNvMC4C0WzIc; Tue, 10 Nov 2020 14:38:29 +0300 (MSK)
Date:   Tue, 10 Nov 2020 14:38:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <20201110113827.hl5i27cpl6exo3md@mobilestation>
References: <202011021254.XC70BaQT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202011021254.XC70BaQT-lkp@intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel,

A situation noted by the warning below won't cause any problem because
the casting is done to a non-dereferenced variable. It is utilized
as a pointer bias later in that function. Shall we just ignore the
warning or still fix it somehow?

-Sergey

On Mon, Nov 02, 2020 at 12:42:57PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3cea11cd5e3b00d91caf0b4730194039b45c5891
> commit: b3e79e7682e075326df8041b826b03453acacd0a mtd: physmap: Add Baikal-T1 physically mapped ROM support
> date:   4 weeks ago
> config: sparc64-randconfig-s032-20201031 (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-76-gf680124b-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3e79e7682e075326df8041b826b03453acacd0a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b3e79e7682e075326df8041b826b03453acacd0a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
> >> drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast removes address space '__iomem' of expression
> 
> vim +/__iomem +78 drivers/mtd/maps/physmap-bt1-rom.c
> 
>     57	
>     58	static void __xipram bt1_rom_map_copy_from(struct map_info *map,
>     59						   void *to, unsigned long from,
>     60						   ssize_t len)
>     61	{
>     62		void __iomem *src = map->virt + from;
>     63		ssize_t shift, chunk;
>     64		u32 data;
>     65	
>     66		if (len <= 0 || from >= map->size)
>     67			return;
>     68	
>     69		/* Make sure we don't go over the map limit. */
>     70		len = min_t(ssize_t, map->size - from, len);
>     71	
>     72		/*
>     73		 * Since requested data size can be pretty big we have to implement
>     74		 * the copy procedure as optimal as possible. That's why it's split
>     75		 * up into the next three stages: unaligned head, aligned body,
>     76		 * unaligned tail.
>     77		 */
>   > 78		shift = (ssize_t)src & 0x3;
>     79		if (shift) {
>     80			chunk = min_t(ssize_t, 4 - shift, len);
>     81			data = readl_relaxed(src - shift);
>     82			memcpy(to, &data + shift, chunk);
>     83			src += chunk;
>     84			to += chunk;
>     85			len -= chunk;
>     86		}
>     87	
>     88		while (len >= 4) {
>     89			data = readl_relaxed(src);
>     90			memcpy(to, &data, 4);
>     91			src += 4;
>     92			to += 4;
>     93			len -= 4;
>     94		}
>     95	
>     96		if (len) {
>     97			data = readl_relaxed(src);
>     98			memcpy(to, &data, len);
>     99		}
>    100	}
>    101	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


