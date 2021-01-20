Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889BC2FCFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388821AbhATMHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:07:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:47507 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388195AbhATLnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:43:55 -0500
IronPort-SDR: +BCH0flfog8NY5GeCLTuWdRgKfum3MzRxCMVdqAlzHAp5Y/fPR/EycwQ5oXnYv7DBWrjNz+wOT
 X9n0/nbrX0/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158864851"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="gz'50?scan'50,208,50";a="158864851"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 03:43:11 -0800
IronPort-SDR: qY7NsRjFG8i0ywTWC+QajTYLxYrgWLPakYB4iFfrB8izNd7i9zRwrn4auev4Ich16ASrrAxIj2
 69bdNYhLB/oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="gz'50?scan'50,208,50";a="501578929"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2021 03:43:08 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2BtD-0005mM-S4; Wed, 20 Jan 2021 11:43:07 +0000
Date:   Wed, 20 Jan 2021 19:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yejune Deng <yejune.deng@gmail.com>, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, frederic@kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, paulmck@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yejune Deng <yejune.deng@gmail.com>
Subject: Re: [PATCH] smp: Modify 'int' to 'bool' in smp_call_function_single()
Message-ID: <202101201916.VfPnemgs-lkp@intel.com>
References: <20210119141350.80522-1-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20210119141350.80522-1-yejune.deng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yejune,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.11-rc4 next-20210120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yejune-Deng/smp-Modify-int-to-bool-in-smp_call_function_single/20210120-154807
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 45dfb8a5659ad286c28fa59008271dbc4e5e3f2d
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/856e1f8de78bcf1c02ffa0f33a5047172bd0d0c9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yejune-Deng/smp-Modify-int-to-bool-in-smp_call_function_single/20210120-154807
        git checkout 856e1f8de78bcf1c02ffa0f33a5047172bd0d0c9
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/up.c:12:5: error: conflicting types for 'smp_call_function_single'
      12 | int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/up.c:6:
   include/linux/smp.h:50:5: note: previous declaration of 'smp_call_function_single' was here
      50 | int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:7,
                    from include/linux/interrupt.h:6,
                    from kernel/up.c:6:
   kernel/up.c:26:15: error: conflicting types for 'smp_call_function_single'
      26 | EXPORT_SYMBOL(smp_call_function_single);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:98:21: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                     ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   kernel/up.c:26:1: note: in expansion of macro 'EXPORT_SYMBOL'
      26 | EXPORT_SYMBOL(smp_call_function_single);
         | ^~~~~~~~~~~~~
   In file included from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/up.c:6:
   include/linux/smp.h:50:5: note: previous declaration of 'smp_call_function_single' was here
      50 | int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/up.c:39:6: error: conflicting types for 'on_each_cpu'
      39 | void on_each_cpu(smp_call_func_t func, void *info, int wait)
         |      ^~~~~~~~~~~
   In file included from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/up.c:6:
   include/linux/smp.h:56:6: note: previous declaration of 'on_each_cpu' was here
      56 | void on_each_cpu(smp_call_func_t func, void *info, bool wait);
         |      ^~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:7,
                    from include/linux/interrupt.h:6,
                    from kernel/up.c:6:
   kernel/up.c:47:15: error: conflicting types for 'on_each_cpu'
      47 | EXPORT_SYMBOL(on_each_cpu);
         |               ^~~~~~~~~~~
   include/linux/export.h:98:21: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                     ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:158:29: note: in expansion of macro '_EXPORT_SYMBOL'
     158 | #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
         |                             ^~~~~~~~~~~~~~
   kernel/up.c:47:1: note: in expansion of macro 'EXPORT_SYMBOL'
      47 | EXPORT_SYMBOL(on_each_cpu);
         | ^~~~~~~~~~~~~
   In file included from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/up.c:6:
   include/linux/smp.h:56:6: note: previous declaration of 'on_each_cpu' was here
      56 | void on_each_cpu(smp_call_func_t func, void *info, bool wait);
         |      ^~~~~~~~~~~


vim +/smp_call_function_single +12 kernel/up.c

53ce3d956490879 Andrew Morton       2009-01-09  11  
53ce3d956490879 Andrew Morton       2009-01-09 @12  int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
53ce3d956490879 Andrew Morton       2009-01-09  13  				int wait)
53ce3d956490879 Andrew Morton       2009-01-09  14  {
081192b25c2d462 David Daney         2013-09-11  15  	unsigned long flags;
081192b25c2d462 David Daney         2013-09-11  16  
1e474b28e78897d Paul E. McKenney    2020-02-05  17  	if (cpu != 0)
1e474b28e78897d Paul E. McKenney    2020-02-05  18  		return -ENXIO;
93423b8665f43a0 Ingo Molnar         2009-01-11  19  
081192b25c2d462 David Daney         2013-09-11  20  	local_irq_save(flags);
081192b25c2d462 David Daney         2013-09-11  21  	func(info);
081192b25c2d462 David Daney         2013-09-11  22  	local_irq_restore(flags);
93423b8665f43a0 Ingo Molnar         2009-01-11  23  
53ce3d956490879 Andrew Morton       2009-01-09  24  	return 0;
53ce3d956490879 Andrew Morton       2009-01-09  25  }
53ce3d956490879 Andrew Morton       2009-01-09  26  EXPORT_SYMBOL(smp_call_function_single);
fa688207c9db48b David Daney         2013-09-11  27  
966a967116e6997 Ying Huang          2017-08-08  28  int smp_call_function_single_async(int cpu, call_single_data_t *csd)
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  29  {
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  30  	unsigned long flags;
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  31  
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  32  	local_irq_save(flags);
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  33  	csd->func(csd->info);
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  34  	local_irq_restore(flags);
08eed44c7249d38 Jan Kara            2014-02-24  35  	return 0;
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  36  }
c46fff2a3b29794 Frederic Weisbecker 2014-02-24  37  EXPORT_SYMBOL(smp_call_function_single_async);
40c01e8bd5575e3 Christoph Hellwig   2013-11-14  38  
caa759323c73676 Nadav Amit          2019-06-12 @39  void on_each_cpu(smp_call_func_t func, void *info, int wait)
bff2dc42bcafdd7 David Daney         2013-09-11  40  {
bff2dc42bcafdd7 David Daney         2013-09-11  41  	unsigned long flags;
bff2dc42bcafdd7 David Daney         2013-09-11  42  
bff2dc42bcafdd7 David Daney         2013-09-11  43  	local_irq_save(flags);
bff2dc42bcafdd7 David Daney         2013-09-11  44  	func(info);
bff2dc42bcafdd7 David Daney         2013-09-11  45  	local_irq_restore(flags);
bff2dc42bcafdd7 David Daney         2013-09-11  46  }
bff2dc42bcafdd7 David Daney         2013-09-11  47  EXPORT_SYMBOL(on_each_cpu);
bff2dc42bcafdd7 David Daney         2013-09-11  48  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
0m78P5u0FpMzqQAA

--VbJkn9YxBvnuCH5J--
