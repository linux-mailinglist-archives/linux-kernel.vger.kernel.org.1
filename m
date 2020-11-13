Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529872B16A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKMHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:42:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:18866 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgKMHmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:42:08 -0500
IronPort-SDR: naX9WlIXwDkFM2m6uJyf1INCBhgHs5aRUj5O9Ln0gWqComNK9PbF44ciOvxgNerXeWTrL6xtAd
 zVnchKUIXFhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="232056840"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="gz'50?scan'50,208,50";a="232056840"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 23:41:57 -0800
IronPort-SDR: 4kRzQdet2s/Z3M3C0RADynd5nBAVdHHpPM3D3XSVE5tDVYhntyKG9velneKrBfw5ZPbAWsoJls
 TsbUIvDbFaWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="gz'50?scan'50,208,50";a="366864222"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2020 23:41:53 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdTiT-000091-51; Fri, 13 Nov 2020 07:41:53 +0000
Date:   Fri, 13 Nov 2020 15:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     kbuild-all@lists.01.org, s.hauer@pengutronix.de,
        ttynkkynen@nvidia.com, linus.walleij@linaro.org,
        axel.lin@ingics.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 5/6] regulator: mcp16502: add support for ramp delay
Message-ID: <202011131506.hPwZR8iv-lkp@intel.com>
References: <1605085578-6783-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <1605085578-6783-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Claudiu,

I love your patch! Yet something to improve:

[auto build test ERROR on regulator/for-next]
[also build test ERROR on linus/master linux/master v5.10-rc3 next-20201112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Claudiu-Beznea/regulator-mcp16502-add-support-for-ramp-delay/20201111-170928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: nios2-randconfig-r034-20201111 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d97d6b70286fa3a28e744a55da1b7eb6a026cee3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Claudiu-Beznea/regulator-mcp16502-add-support-for-ramp-delay/20201111-170928
        git checkout d97d6b70286fa3a28e744a55da1b7eb6a026cee3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:20,
                    from ./arch/nios2/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/current.h:5,
                    from ./arch/nios2/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/gpio/driver.h:5,
                    from include/asm-generic/gpio.h:11,
                    from include/linux/gpio.h:62,
                    from drivers/regulator/mcp16502.c:11:
   drivers/regulator/mcp16502.c: In function 'mcp16502_set_voltage_time_sel':
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:287:38: note: in definition of macro '__abs_choose_expr'
     287 |  __builtin_types_compatible_p(typeof(x),   signed type) || \
         |                                      ^
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:287:38: note: in definition of macro '__abs_choose_expr'
     287 |  __builtin_types_compatible_p(typeof(x),   signed type) || \
         |                                      ^
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:288:38: note: in definition of macro '__abs_choose_expr'
     288 |  __builtin_types_compatible_p(typeof(x), unsigned type),  \
         |                                      ^
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:288:38: note: in definition of macro '__abs_choose_expr'
     288 |  __builtin_types_compatible_p(typeof(x), unsigned type),  \
         |                                      ^
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:24: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                        ^
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:24: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                        ^
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> drivers/regulator/mcp16502.c:295:54: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |                                                      ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   drivers/regulator/mcp16502.c:296:47: error: 'const struct linear_range' has no member named 'uV_step'; did you mean 'step'?
     296 |          old_sel * rdev->desc->linear_ranges->uV_step);
         |                                               ^~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
>> include/linux/kernel.h:281:3: error: first argument to '__builtin_choose_expr' not a constant
     281 |   __builtin_choose_expr(     \
         |   ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   include/linux/kernel.h:286:43: error: first argument to '__builtin_choose_expr' not a constant
     286 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr( \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:280:3: note: in expansion of macro '__abs_choose_expr'
     280 |   __abs_choose_expr(x, char,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   include/linux/kernel.h:286:43: error: first argument to '__builtin_choose_expr' not a constant
     286 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr( \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:279:3: note: in expansion of macro '__abs_choose_expr'
     279 |   __abs_choose_expr(x, short,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   include/linux/kernel.h:286:43: error: first argument to '__builtin_choose_expr' not a constant
     286 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr( \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:278:3: note: in expansion of macro '__abs_choose_expr'
     278 |   __abs_choose_expr(x, int,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   include/linux/kernel.h:286:43: error: first argument to '__builtin_choose_expr' not a constant
     286 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr( \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:289:54: note: in definition of macro '__abs_choose_expr'
     289 |  ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                      ^~~~~
   include/linux/kernel.h:277:3: note: in expansion of macro '__abs_choose_expr'
     277 |   __abs_choose_expr(x, long,    \
         |   ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~
   include/linux/kernel.h:286:43: error: first argument to '__builtin_choose_expr' not a constant
     286 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr( \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:276:16: note: in expansion of macro '__abs_choose_expr'
     276 | #define abs(x) __abs_choose_expr(x, long long,    \
         |                ^~~~~~~~~~~~~~~~~
   drivers/regulator/mcp16502.c:295:13: note: in expansion of macro 'abs'
     295 |  uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
         |             ^~~

vim +295 drivers/regulator/mcp16502.c

   280	
   281	static int mcp16502_set_voltage_time_sel(struct regulator_dev *rdev,
   282						 unsigned int old_sel,
   283						 unsigned int new_sel)
   284	{
   285		static const u8 us_ramp[] = { 8, 16, 24, 32 };
   286		int id = rdev_get_id(rdev);
   287		unsigned int uV_delta, val;
   288		int ret;
   289	
   290		ret = regmap_read(rdev->regmap, MCP16502_REG_BASE(id, CFG), &val);
   291		if (ret)
   292			return ret;
   293	
   294		val = (val & MCP16502_DVSR) >> 2;
 > 295		uV_delta = abs(new_sel * rdev->desc->linear_ranges->uV_step -
   296			       old_sel * rdev->desc->linear_ranges->uV_step);
   297		switch (id) {
   298		case BUCK1:
   299		case LDO1:
   300		case LDO2:
   301			ret = DIV_ROUND_CLOSEST(uV_delta * us_ramp[val],
   302						mcp16502_ramp_b1l12[val]);
   303			break;
   304	
   305		case BUCK2:
   306		case BUCK3:
   307		case BUCK4:
   308			ret = DIV_ROUND_CLOSEST(uV_delta * us_ramp[val],
   309						mcp16502_ramp_b234[val]);
   310			break;
   311	
   312		default:
   313			return -EINVAL;
   314		}
   315	
   316		return ret;
   317	}
   318	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
VnXOM/BsFb3lXy7OzkfbfQEA

--tThc/1wpZn/ma/RB--
