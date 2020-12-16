Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD872DC003
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgLPMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:09:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:38911 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgLPMJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:09:16 -0500
IronPort-SDR: sEGLFT9SF3sUx+cqcEb/SX3hVI27CIs/6aEeSLKPcSFt3LwLY9BI43ic3AveY0BjmPFDwAgZ30
 jbcoI/IJXGbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="175199157"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="gz'50?scan'50,208,50";a="175199157"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 04:08:33 -0800
IronPort-SDR: aIYI4kGMEMYDZff12SJy5MXMDbGKKOH79Q91jEkYi9Qanc60sXZLImaiePiO0KWYeHKaAHl4Bn
 c2Uh8V9mabVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="gz'50?scan'50,208,50";a="412564857"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2020 04:08:32 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpVbb-00001s-Dq; Wed, 16 Dec 2020 12:08:31 +0000
Date:   Wed, 16 Dec 2020 20:07:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/tty/vt/keyboard.c:2037:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202012162048.l1ovj8ga-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d01e7f10dae29eba0f9ada82b65d24e035d5b2f9
commit: 07edff9265204e15c9fc8d07cc69e38c4c484e15 vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl
date:   6 weeks ago
config: sh-randconfig-s032-20201216 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07edff9265204e15c9fc8d07cc69e38c4c484e15
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 07edff9265204e15c9fc8d07cc69e38c4c484e15
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/tty/vt/keyboard.c:1745:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1745:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1745:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1745:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1745:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1745:21: sparse:     got unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1783:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1783:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1783:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1783:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tty/vt/keyboard.c:1783:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:1783:21: sparse:     got unsigned int const *__gu_addr
>> drivers/tty/vt/keyboard.c:2037:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/tty/vt/keyboard.c:2037:13: sparse:     expected unsigned char const *__gu_addr
   drivers/tty/vt/keyboard.c:2037:13: sparse:     got unsigned char [noderef] __user *
>> drivers/tty/vt/keyboard.c:2037:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/tty/vt/keyboard.c:2037:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/keyboard.c:2037:13: sparse:     got unsigned char const *__gu_addr

vim +2037 drivers/tty/vt/keyboard.c

  2020	
  2021	/* FIXME: This one needs untangling */
  2022	int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
  2023	{
  2024		char *kbs;
  2025		u_char *q;
  2026		int sz, fnw_sz;
  2027		int delta;
  2028		char *first_free, *fj, *fnw;
  2029		int j, k;
  2030		int ret;
  2031		unsigned long flags;
  2032		unsigned char kb_func;
  2033	
  2034		if (!capable(CAP_SYS_TTY_CONFIG))
  2035			perm = 0;
  2036	
> 2037		if (get_user(kb_func, &user_kdgkb->kb_func))
  2038			return -EFAULT;
  2039	
  2040		kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
  2041	
  2042		switch (cmd) {
  2043		case KDGKBSENT: {
  2044			/* size should have been a struct member */
  2045			ssize_t len = sizeof(user_kdgkb->kb_string);
  2046	
  2047			kbs = kmalloc(len, GFP_KERNEL);
  2048			if (!kbs)
  2049				return -ENOMEM;
  2050	
  2051			spin_lock_irqsave(&func_buf_lock, flags);
  2052			len = strlcpy(kbs, func_table[kb_func] ? : "", len);
  2053			spin_unlock_irqrestore(&func_buf_lock, flags);
  2054	
  2055			ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
  2056				-EFAULT : 0;
  2057	
  2058			goto reterr;
  2059		}
  2060		case KDSKBSENT:
  2061			if (!perm)
  2062				return -EPERM;
  2063	
  2064			kbs = strndup_user(user_kdgkb->kb_string,
  2065					sizeof(user_kdgkb->kb_string));
  2066			if (IS_ERR(kbs))
  2067				return PTR_ERR(kbs);
  2068	
  2069			fnw = NULL;
  2070			fnw_sz = 0;
  2071			/* race aginst other writers */
  2072			again:
  2073			spin_lock_irqsave(&func_buf_lock, flags);
  2074			q = func_table[kb_func];
  2075	
  2076			/* fj pointer to next entry after 'q' */
  2077			first_free = funcbufptr + (funcbufsize - funcbufleft);
  2078			for (j = kb_func + 1; j < MAX_NR_FUNC && !func_table[j]; j++)
  2079				;
  2080			if (j < MAX_NR_FUNC)
  2081				fj = func_table[j];
  2082			else
  2083				fj = first_free;
  2084			/* buffer usage increase by new entry */
  2085			delta = (q ? -strlen(q) : 1) + strlen(kbs);
  2086	
  2087			if (delta <= funcbufleft) { 	/* it fits in current buf */
  2088			    if (j < MAX_NR_FUNC) {
  2089				/* make enough space for new entry at 'fj' */
  2090				memmove(fj + delta, fj, first_free - fj);
  2091				for (k = j; k < MAX_NR_FUNC; k++)
  2092				    if (func_table[k])
  2093					func_table[k] += delta;
  2094			    }
  2095			    if (!q)
  2096			      func_table[kb_func] = fj;
  2097			    funcbufleft -= delta;
  2098			} else {			/* allocate a larger buffer */
  2099			    sz = 256;
  2100			    while (sz < funcbufsize - funcbufleft + delta)
  2101			      sz <<= 1;
  2102			    if (fnw_sz != sz) {
  2103			      spin_unlock_irqrestore(&func_buf_lock, flags);
  2104			      kfree(fnw);
  2105			      fnw = kmalloc(sz, GFP_KERNEL);
  2106			      fnw_sz = sz;
  2107			      if (!fnw) {
  2108				ret = -ENOMEM;
  2109				goto reterr;
  2110			      }
  2111			      goto again;
  2112			    }
  2113	
  2114			    if (!q)
  2115			      func_table[kb_func] = fj;
  2116			    /* copy data before insertion point to new location */
  2117			    if (fj > funcbufptr)
  2118				memmove(fnw, funcbufptr, fj - funcbufptr);
  2119			    for (k = 0; k < j; k++)
  2120			      if (func_table[k])
  2121				func_table[k] = fnw + (func_table[k] - funcbufptr);
  2122	
  2123			    /* copy data after insertion point to new location */
  2124			    if (first_free > fj) {
  2125				memmove(fnw + (fj - funcbufptr) + delta, fj, first_free - fj);
  2126				for (k = j; k < MAX_NR_FUNC; k++)
  2127				  if (func_table[k])
  2128				    func_table[k] = fnw + (func_table[k] - funcbufptr) + delta;
  2129			    }
  2130			    if (funcbufptr != func_buf)
  2131			      kfree(funcbufptr);
  2132			    funcbufptr = fnw;
  2133			    funcbufleft = funcbufleft - delta + sz - funcbufsize;
  2134			    funcbufsize = sz;
  2135			}
  2136			/* finally insert item itself */
  2137			strcpy(func_table[kb_func], kbs);
  2138			spin_unlock_irqrestore(&func_buf_lock, flags);
  2139			break;
  2140		}
  2141		ret = 0;
  2142	reterr:
  2143		kfree(kbs);
  2144		return ret;
  2145	}
  2146	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
TIkr51zjWV7/H229Tz8V4wEA

--mP3DRpeJDSE+ciuQ--
