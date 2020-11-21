Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19E2BBD6A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 06:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgKUFYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 00:24:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:64081 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgKUFYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 00:24:55 -0500
IronPort-SDR: M0ynaYCAMGvJnN0iYW6IiE77/nsp6eLHKN8zqV4KfaJ4LSmGs+znyQatkb+jSY+KmmB4M0053H
 V2fv52y5cWiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="159344633"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="gz'50?scan'50,208,50";a="159344633"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 21:24:53 -0800
IronPort-SDR: RHrZEdKKyhd2CfSgECWcG/vT9BX9FMoorunsmi1WHoAFztmxFLYQNbXd5a++yv3WtstoOhW9Ed
 ZHejkBlrVxmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="gz'50?scan'50,208,50";a="357926083"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2020 21:24:51 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgLOE-0000DN-TJ; Sat, 21 Nov 2020 05:24:50 +0000
Date:   Sat, 21 Nov 2020 13:24:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shakeel Butt <shakeelb@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: memcontrol: account pagetables per node
Message-ID: <202011211345.fiLVusum-lkp@intel.com>
References: <20201121022118.3143384-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20201121022118.3143384-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shakeel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on linus/master v5.10-rc4 next-20201120]
[cannot apply to mmotm/master cgroup/for-next hnaz-linux-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shakeel-Butt/mm-memcontrol-account-pagetables-per-node/20201121-102353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 33c0c9bdf7a59051a654cd98b7d2b48ce0080967
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e51fa7d7d401d329238b2f8bc4d506a2ab1f5c67
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shakeel-Butt/mm-memcontrol-account-pagetables-per-node/20201121-102353
        git checkout e51fa7d7d401d329238b2f8bc4d506a2ab1f5c67
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: arch/nds32/mm/mm-nds32.o: in function `pgd_alloc':
>> mm-nds32.c:(.text+0x6e): undefined reference to `inc_lruvec_page_state'
>> nds32le-linux-ld: mm-nds32.c:(.text+0x72): undefined reference to `inc_lruvec_page_state'
   nds32le-linux-ld: arch/nds32/mm/mm-nds32.o: in function `pgd_free':
>> mm-nds32.c:(.text+0xd8): undefined reference to `dec_lruvec_page_state'
>> nds32le-linux-ld: mm-nds32.c:(.text+0xdc): undefined reference to `dec_lruvec_page_state'
   nds32le-linux-ld: mm-nds32.c:(.text+0xf4): undefined reference to `dec_lruvec_page_state'
   nds32le-linux-ld: mm-nds32.c:(.text+0xf8): undefined reference to `dec_lruvec_page_state'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
jt9poS4uu5coM1HU/wGtmuoykUgAAA==

--82I3+IH0IqGh5yIs--
