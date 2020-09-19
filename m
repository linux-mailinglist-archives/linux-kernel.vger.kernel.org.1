Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F7270D4E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgISK6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 06:58:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:26536 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgISK6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 06:58:21 -0400
IronPort-SDR: Qn5skENPEmTfZqKw2keLOSiQAqRtB+CAwSOQ4w8Hdl8BldLywvB+sVQdret9s5ywrpl+wa00Wf
 YcRX5/bGA7ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147786893"
X-IronPort-AV: E=Sophos;i="5.77,278,1596524400"; 
   d="gz'50?scan'50,208,50";a="147786893"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2020 03:57:55 -0700
IronPort-SDR: zWEU7K0zoVzDr/9FsA8IS/BvHbjYvjUAuGHWRtxDAf0S1Qpp7XniiiEE2PxhM97mgeh+ORlUxs
 lmFnBkKEY1tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,278,1596524400"; 
   d="gz'50?scan'50,208,50";a="337121659"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2020 03:57:53 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJaYy-00010u-N0; Sat, 19 Sep 2020 10:57:52 +0000
Date:   Sat, 19 Sep 2020 18:57:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202009191806.DeS6VZVs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eb5f95f1593f7c22dac681b19e815828e2af3efd
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   3 weeks ago
config: sh-randconfig-s032-20200919 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-201-g24bdaac6-dirty
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected int const *__gu_addr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int [noderef] __user *
>> drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int const *__gu_addr
--
   net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected unsigned short const *__gu_addr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
>> net/bluetooth/hci_core.c:2099:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short const *__gu_addr

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
vim +736 drivers/rtc/rtc-m41t80.c

617780d290bd6e Atsushi Nemoto      2007-07-17  702  
617780d290bd6e Atsushi Nemoto      2007-07-17  703  /**
617780d290bd6e Atsushi Nemoto      2007-07-17  704   *	wdt_ioctl:
617780d290bd6e Atsushi Nemoto      2007-07-17  705   *	@file: file handle to the device
617780d290bd6e Atsushi Nemoto      2007-07-17  706   *	@cmd: watchdog command
617780d290bd6e Atsushi Nemoto      2007-07-17  707   *	@arg: argument pointer
617780d290bd6e Atsushi Nemoto      2007-07-17  708   *
617780d290bd6e Atsushi Nemoto      2007-07-17  709   *	The watchdog API defines a common set of functions for all watchdogs
617780d290bd6e Atsushi Nemoto      2007-07-17  710   *	according to their available features. We only actually usefully support
617780d290bd6e Atsushi Nemoto      2007-07-17  711   *	querying capabilities and current status.
617780d290bd6e Atsushi Nemoto      2007-07-17  712   */
55929332c92e5d Arnd Bergmann       2010-04-27  713  static int wdt_ioctl(struct file *file, unsigned int cmd,
617780d290bd6e Atsushi Nemoto      2007-07-17  714  		     unsigned long arg)
617780d290bd6e Atsushi Nemoto      2007-07-17  715  {
617780d290bd6e Atsushi Nemoto      2007-07-17  716  	int new_margin, rv;
617780d290bd6e Atsushi Nemoto      2007-07-17  717  	static struct watchdog_info ident = {
617780d290bd6e Atsushi Nemoto      2007-07-17  718  		.options = WDIOF_POWERUNDER | WDIOF_KEEPALIVEPING |
617780d290bd6e Atsushi Nemoto      2007-07-17  719  			WDIOF_SETTIMEOUT,
617780d290bd6e Atsushi Nemoto      2007-07-17  720  		.firmware_version = 1,
617780d290bd6e Atsushi Nemoto      2007-07-17  721  		.identity = "M41T80 WTD"
617780d290bd6e Atsushi Nemoto      2007-07-17  722  	};
617780d290bd6e Atsushi Nemoto      2007-07-17  723  
617780d290bd6e Atsushi Nemoto      2007-07-17  724  	switch (cmd) {
617780d290bd6e Atsushi Nemoto      2007-07-17  725  	case WDIOC_GETSUPPORT:
617780d290bd6e Atsushi Nemoto      2007-07-17  726  		return copy_to_user((struct watchdog_info __user *)arg, &ident,
617780d290bd6e Atsushi Nemoto      2007-07-17  727  				    sizeof(ident)) ? -EFAULT : 0;
617780d290bd6e Atsushi Nemoto      2007-07-17  728  
617780d290bd6e Atsushi Nemoto      2007-07-17  729  	case WDIOC_GETSTATUS:
617780d290bd6e Atsushi Nemoto      2007-07-17  730  	case WDIOC_GETBOOTSTATUS:
617780d290bd6e Atsushi Nemoto      2007-07-17  731  		return put_user(boot_flag, (int __user *)arg);
617780d290bd6e Atsushi Nemoto      2007-07-17  732  	case WDIOC_KEEPALIVE:
617780d290bd6e Atsushi Nemoto      2007-07-17  733  		wdt_ping();
617780d290bd6e Atsushi Nemoto      2007-07-17  734  		return 0;
617780d290bd6e Atsushi Nemoto      2007-07-17  735  	case WDIOC_SETTIMEOUT:
617780d290bd6e Atsushi Nemoto      2007-07-17 @736  		if (get_user(new_margin, (int __user *)arg))
617780d290bd6e Atsushi Nemoto      2007-07-17  737  			return -EFAULT;
617780d290bd6e Atsushi Nemoto      2007-07-17  738  		/* Arbitrary, can't find the card's limits */
617780d290bd6e Atsushi Nemoto      2007-07-17  739  		if (new_margin < 1 || new_margin > 124)
617780d290bd6e Atsushi Nemoto      2007-07-17  740  			return -EINVAL;
617780d290bd6e Atsushi Nemoto      2007-07-17  741  		wdt_margin = new_margin;
617780d290bd6e Atsushi Nemoto      2007-07-17  742  		wdt_ping();
c3e04915b8674a Gustavo A. R. Silva 2018-10-04  743  		/* Fall through */
617780d290bd6e Atsushi Nemoto      2007-07-17  744  	case WDIOC_GETTIMEOUT:
617780d290bd6e Atsushi Nemoto      2007-07-17  745  		return put_user(wdt_margin, (int __user *)arg);
617780d290bd6e Atsushi Nemoto      2007-07-17  746  
617780d290bd6e Atsushi Nemoto      2007-07-17  747  	case WDIOC_SETOPTIONS:
617780d290bd6e Atsushi Nemoto      2007-07-17  748  		if (copy_from_user(&rv, (int __user *)arg, sizeof(int)))
617780d290bd6e Atsushi Nemoto      2007-07-17  749  			return -EFAULT;
617780d290bd6e Atsushi Nemoto      2007-07-17  750  
617780d290bd6e Atsushi Nemoto      2007-07-17  751  		if (rv & WDIOS_DISABLECARD) {
a737e835e5769e Joe Perches         2015-04-16  752  			pr_info("disable watchdog\n");
617780d290bd6e Atsushi Nemoto      2007-07-17  753  			wdt_disable();
617780d290bd6e Atsushi Nemoto      2007-07-17  754  		}
617780d290bd6e Atsushi Nemoto      2007-07-17  755  
617780d290bd6e Atsushi Nemoto      2007-07-17  756  		if (rv & WDIOS_ENABLECARD) {
a737e835e5769e Joe Perches         2015-04-16  757  			pr_info("enable watchdog\n");
617780d290bd6e Atsushi Nemoto      2007-07-17  758  			wdt_ping();
617780d290bd6e Atsushi Nemoto      2007-07-17  759  		}
617780d290bd6e Atsushi Nemoto      2007-07-17  760  
617780d290bd6e Atsushi Nemoto      2007-07-17  761  		return -EINVAL;
617780d290bd6e Atsushi Nemoto      2007-07-17  762  	}
617780d290bd6e Atsushi Nemoto      2007-07-17  763  	return -ENOTTY;
617780d290bd6e Atsushi Nemoto      2007-07-17  764  }
617780d290bd6e Atsushi Nemoto      2007-07-17  765  

:::::: The code at line 736 was first introduced by commit
:::::: 617780d290bd6eb2b260928c6acff5b7c6084154 rtc: watchdog support for rtc-m41t80 driver

:::::: TO: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICALVZV8AAy5jb25maWcAjDzbcts2sO/9Ck360j6kle1ESc4ZP4AgKKLizQQoy37hOLKS
aGpbOZLcNn9/dgFeABBU1JlOrN3FAtgF9gaAv/7y64S8HnfPD8ft+uHp6cfk6+Zls384bh4n
X7ZPm/+dhPkky+WEhVz+AcTJ9uX1vz8P3ybv//j0x/Ttfn05WWz2L5unCd29fNl+fYW2293L
L7/+QvMs4vOa0nrJSsHzrJZsJa/fHL69e/uEXN5+Xa8nv80p/X3y6Y+rP6ZvjCZc1IC4/tGC
5j2b60/Tq+m0RSRhB7+8ejdV/3V8EpLNO/TUYB8TUROR1vNc5n0nBoJnCc+YgcozIcuKyrwU
PZSXN/VtXi4AAhP+dTJXsnuaHDbH1++9CIIyX7CsBgmItDBaZ1zWLFvWpIR58JTL66tL4NJ1
mRY8YSA1ISfbw+Rld0TG3cRzSpJ2bm/e+MA1qczpBRUHaQmSSIM+JktWL1iZsaSe33NjeCYm
AMylH5Xcp8SPWd2PtcBBdfM0Ojen6eLVEE4R4EBO4Vf3HilaQ2pgIYtIlUilH0NSLTjOhcxI
yq7f/Paye9n83hGIO7HkhbFoGwD+S2XSw4tc8FWd3lSsYn7ooMktkTSu2xbd1CrBEh545kUq
2K+O+EkJLBQCuZPEYO9A1WKGxT05vH4+/DgcN8/9Yk7JnWYnClIKhnvA2KYsYyWnamOIOL/1
Y3j2F6MS1621k8I8JdyBCZ7agCgvKQtrGZeMhDybG9L+yXhCFlTzSCjxbV4eJ7svzhTdRhT2
0oItWSZFKxO5fd7sDz6xSE4XsMMZzNqQe5bX8T3u5FRNttMbAAvoIw859ShPt+JhwhxOFgs+
j+uSCeg5he1ur/xmfoPh9s2LkrG0kMA3Y95d0xIs86TKJCnvPANtaIw13DSiObQZgLXGlSBp
Uf0pHw5/T44wxMkDDPdwfDgeJg/r9e715bh9+eqIFhrUhCq+ltYDEQL7nDIhEC9NEbm4ennl
mYQkYiEkkYZdRxCslwSWustToVYI9UtNcK8mzpivkktJq4nwrC4QYA24oaQ1sOsfftZsBWvL
5zKExUHxdEAoCsWj2QMe1ABUhcwHlyWhDgIZg6STpN8RBiZjsK8Fm9Mg4UKa29QWSmcNFvoP
wz4sOuHk1ATHYCuY6biTHN1hBDaKR/L6ctpLlWdyAT4yYg7NxZVrHgSNYcDKSLSrWqy/bR5f
nzb7yZfNw/F1vzkocDMND7YLL+ZlXhXC1GTKUjr3rrEgWTQNvGiN0sM7RVDwUJzCl+GIP23w
Eayfe1aeIgnZklO/eWkoYF+M7qV2nKyMTuGD4iRamX0vATpxcBpgHvztY0YXRQ4LAs0sBH7+
iehlgJHWuErAs0YCRgKblhJpq6XdAWhtDLOWoAFaqhikDO2YsSQpcBN5BZ7QiE/K0AngANDG
bb19CAdxUo9Z3Q9Ic+98FOrdGOpeSN8MgzxHx2BvWQi5c3AMKb9n6NqVsvMyJRm14hyXTMAf
PgPnRE0qTql4eDEzJFtE/Q9tKq2ICqk9rFMI/TiEW6URcMyZTNEdDMIpre8BOIpJpp167y9U
0Dd04ZY9Mq2+sk9Zys2w3pAnSyKQcWn1ERAIi6IqSTwdRBUkZcYI8SdYBkeEGkzTYkVjs7Mi
t2bN5xlJImO1qnmZABVNmQDCrVyA53UFU/TvVxIuuWCtWP2bFqxmQMqS23apDfax2V1q+IEW
Ult66qBKcrgzJV8yawkZyu36hq5ZGHp3t5Iiru26iydbjSIQ1lW9TIGd6bYKejF913qWJscu
Nvsvu/3zw8t6M2H/bF4ggiDgXCjGEBDp9QGD3Vc3RGUMB316I5Yze2w7XKa6Ox36aWfb27+k
CoaGuN3bkOcSCUnywm5CfHkNcrLJcj8ZCWAtlHPWpm0ub+W+MNCoS9iUeTrGpCOLSRmC5w8t
RnEVRZCiFwQ6UqIk4Cd81iMlhSK4rasMbTgnCZiw0DIZkqV1SCTBigWPOPCyUiQIaiKeWMGv
irGUi7LSGrsM0fVQgd7jYW5k2Y8WGN8yyC+MEB7iNrrQMR0wKvLSwGEIBM5tiICkhecIgqzR
cEzFXJIAxJbAiknE9WUTPKnwbnL88X1jVI8g7BfxleULEFQF8q6AocQfZhef/O7bIPvLXzhw
OF1OL84juzqPbHYW2ew8bjO/ux2Q/VwY6cpvXh1WH6bvzyPzecsB0YcTGvww/XheTz+fG5Jd
TM8jO2tNgBrPIztr6Xx4fxa36adzuY1E3wO6kQjXpTuz24vzup2dM9l39eX0TE2ctVE+XJ61
UT5cnUf2/sN5Uz1vbB/OW0wfzyQ7b4N+PMcOrc6awNW7M3VwlkavZtbIlBNIN8+7/Y8JxBsP
XzfPEG5Mdt/xPEEn0p03rXyxMjrhPIoEk9fT/6ZT+yxA1Q3BDa3q+zxjOfjy8vriXeefWZqX
d+jkStX4o924RYPLRqxzzHB1GZi1VlVmjSBmhFY1y9DTOUhdqTwD3ccuFp4ljMp2UGkeMisM
VXLAodbvFr7YqMd/XAT+hhczu6WHZPbOJWmCj3ENahU+rL9tJmvnrKhfIgTS6fq25JIFEHD4
l1FPI2PIueexzwMpIlgOZmDk61z1Xux3683hsHMKN8a6TbiUELKwLOQkG/F4ASYBisCIm2At
AIqllR04QjbjK/0iGzyDgpCOLQ3Ft3BR1mVgTskzcjX0YPewf5wcXr9/3+2PfTwFHdNKyDyt
abIw+dj0fbFb1SrXT7v13wOl9SwLYIaR8s31e2fbYX9YrirmlkgaGESAc0LvzHGc7rStHU+i
/eb/Xjcv6x+Tw/rhSZeLTyItZeJQx8q0vtan0Yo7Fst80g7V6ZipeIDUpOAe5WdlnWc05oWi
oTHJMoyPZ/0AzF70pHbP3x9eQDQT+m373So3uiiFI4+PW5QkZAfi9ftmH0/CzT9byO3C/fYf
K4OMGdjCgBGzjF/B8MUtlzQ2VfZznl0F1AjxzbTW2HRt7/f1xXTqHJlcjoRPgLqajqKAz9Qj
7Pj++sI4Ki4JqqYyz2eL+E5AFpaMugXBKCavRvZUCWL/0rtV5zdaNn9ORPw23X3ePrUCmuSd
i+tXCRgA2p3EYaq9f/1+xN1w3O+esIa8cxthC8yzCkgRdbJtKumM3p3M37Unu+Owz3tW5h7H
e2kISZX9IG1dmCQfLTmyTIIjG3IwjNPOcSPB68GKDFpCA6wN++5fmOLQGU1+U6U/nkLfJPnd
KJyklktMR8sWRWtCm9+3N3WR37KyZhHk7hxLIb377kwTf3xyslvuVARbWD3Pl3VCwtBbyrKo
YBLVKAvJ8lFTp0fTuZIzZWVddXjYr79tj5s1LpW3j5vvwMuO2pox5bp8YcQ6qiZmgPvzeoAF
zFcO1bcINNphtCiZ9CKsWml/Dq5KGXGeGxrsDnbSQotPHzJ7TpMRibVPsACyMva/4qzCQVzN
tXsAX7K5qEkW6mIKHi2qk8lBuTW+rQPoWR8+OLiUr1hooIXi6gyhnbg+yBrUbRXNLYEVircT
9LF5e5PEI6rGzNWgJ2nVv0fg+nYAThEUIhnembFcoIXxFcvysEqYUBVKrGdjAbbnnuMdFj4X
lSgg1hrAiXOxoKkuaqVgPdqOqbLc2K9RZFUtsaxlFjXFIFuZ03z59vPDYfM4+Vsbze/73Zft
k3V8jUTNPZOBmoTGNpugdgrKLs67j0+Owa0I/mS3dmdBkF1gyd/cTKoWLrBgfH3haMo6tlSg
Jt1KcuI/gmyoquwURbMkRwr9moMoaXfZyRWQQ8n9Za8GjeukhO14ikYXcFMuBLrY7viw5inW
OP1NqwyWMazMuzTIR84sJJjWlm6B5w4n9oQ6tE/AbJlmJ2jOoLufi1pQwWHj3FRM2FcimnPF
QIyfLTd4/8Wi/mBSsjmkYHc+7phi+9Wqzq7TEC/XacPjLyUh2W3gPxbWneA5RuSTlJo9SDIv
SGLLRN/pg2iDlneFbSW86DoChWMW2jrw4mF/VJHuREIEa6WIMBfJVSMSLvH00ncKlIowFz2p
cSwWcQvcu2SnR3O86U295NAmt6ehAhgdNub9lQPDE0M7nutT6xDcm33P0UAu7gJmGe4WEUT+
5Mnur7N0Irvo+ePphxKzgDBV7f9evOy/zfr1+PAZQlO8ejpR505HS8wBz6JUKq8QhQX3ZdAN
iaAlL9zKCRrcBo8FGkNwFtDtDsHoX/zLUdPcI9GJ4cSkBNF5ewWDQk2HBYQ6D+kkOyYZs2SW
+kpmnaf2VYzaylhTqkpJVhHL//SFKI3znR/rxjY38Kohq3U7w0z17PC6lXm5SBQJeOdCKo8L
bllcf1L/OfW3AA2wdSSGmUfJ0Ppa52JZnqZV3ZyzafvKVhhs9a5L3TaCqFZFAQtjAjRhsH+x
etTD7os8NyR2H1TWMeD9VeSsjlYYJfgICK2aEKgdNStVJdS+czbHqyxgfOKUlAvPui0kbhpG
eaMju9zm0X4/U/NEjuG91jl6OhvIWphaU9nm+O9u/zfEEMPFBC5vYbLUv+uQk7m1z1f2L9iR
qQNpmvSOcMRBrqIyxWjQ7ytw9Avmu564Cota4B1OU84G0Bkz15Lq7V2hb31QIvyeCAhaa1+X
OQRMvmgWiIrMvPWtftdhTAunMwRjtuy/Q9QQlKT045Vmi5E71BoJKgaTn1YrX+1JUdSyyjK7
nCzuMrBJ+YKPXJPSDZeSj2KjvDqF67v1d4BqqUk8joMobBwJGQ5Edj69ILabrgkcropa0mKw
WhWiCjVifAAluf0JBWJBL0KW+Z2XCnuHP+enYouOhlaBaVrbW+st/vrN+vXzdv3G5p6G7534
uFt1y5m9TJezZq3jFVT/zTtFpO9rCdg+dTgS4+PsZ6dUOzup25lHufYYUl74D78Ulif++40K
6SxoEyW4HIgEYPWs9ClGobMQfLxyi3j4NWitl+GJeaAZKrAigcdFI9tEESrVjOMFm8/q5PZn
/SkycER0nKQsktOMQEEJCUaQaQGrbhxTLyp8G4MvX3whPrDGVzdYgGicpdmrQhXxncr2wcmm
hXOhrCftKhdmew307rWm5L7foIOESOy42Y89e+oZ+dxtg0IZ8Wxx/TyKwlvIBhov92UZ1q4W
FhTvKjd3qp+NyWgEsIKkzCcBg50hTB8Wb1Tb1RELrTTtVZVJFcnCP5eal9QZeI+D4QeQetTZ
T/kL7vCXhoQ9Km5lPE8qVlNf9A5MMojYn+3fg4kgTE/BhrkDQlhKBGTlJQmZI83h3h4MeKVp
rp/1SlyplOAwWe+eP29fNo+T5x0mXwffKlxhz+XCbXp82H/dHMdaSFLOmbq0m7XLw7NUe0J7
sZoEWooeHfSNM7xN6/PUXuJI93WSIyRSvGR+xXrIDc2cnOVZogArloqBpiBrgwx5XEH4yIuE
Yam8hJ+/JvKZgSEVphhMSak7Ezxhu6xYU7DRmHc5LITy4n/OMIkRRiMlUR7knbPfdUiuMH53
AhsEjNDq7iRJCEmUi7eNIYTPA8vZDKcHlgwfqDlwmDmgeNHtQQveuBIH2i1E5OcinT1htejX
oj+lAErIyecJG3KAgNNfnjmho0aJ/8xOqdGvLn+AZalrlKRRl+8GoaWFmU9lM1OeszHdzLSo
cDdgG/0SaEAw1N7spPpmYwqYndbAKQF7t8ls1C0GJQ/n/lAvKPR8xjZwSEeCL9z3dCT/LEde
C0Fg6g8TiUy98ORS+qy8kOZBOm7TvihZWqnycOYNQh97YUYliBPUIcjTYpmQrP44vbww3oz2
sHq+NIdhIFILETLqlA40ZLwokCRGigY/rDc6RJJk4Wm0unxvNCJFYF5VyJ0RzJL8tvDeVOKM
MZzF+3dWHtJB6yxp/jCPff3rpW+kDYI/pCdUE42UHVRVua083bxuXjfbl69/NqVk6yitoa5p
cGOF0woYy8ADjMzaagstSvvZSQtXedbN+DAxohhyE5GnYxF5hijZTeKBBtEQSAMxBIKH9zQn
zXQc+Nw72FA4UX4Dh3/NMm5HXrrpkRbUDfY5WtVRAlgELo07xThfsGGXNz7JUbtm3YKjmw4z
GAAlC5+R6Jv6GsVxdKJNwZmvEYwCMCfa9SngoG2RjL1O7HQ+XndTGtIFnmGa+vRwOGy/bNfD
xLSmibO4AIAHvKpwZPWACEl5FrLV6CiQRlm6kbCsIYluRySEyOrKMoENaPD200EPl7Iai1gW
fujMNz3IJG5PDvzEW9tOdsXYsml7MC9ItHAVllgvz1Q5U4F9MH11wvpIiIGk3jKnQZAFd5J5
+WrpD+EpkwNH2qDwWy6nu6Mk4+FIa4jUTsiL2E/uVf0XAsEiT5zXxA7BXDfsYghsU+aOcUZo
ysuBcUS4IGmRDLY4UUHo2IARmxH/gPGjOSeaCZ4WvnZgOt2WAxoqKt+btW6GRTIwNwjHGOYk
3/GV3IwszQdKVQKKTmlG1wnxmGYo9DmRA5FLil3V42tMmV0emV9toYaiwwzvRYkcv4RjhY4Q
lBJ1Ru8VQl6wbKkvuPqCxf4sqWuxNI+STrTBOxtFc5egRanDe5OrHzH4WEJbtrLPKRqNGzJC
SD0XVqSjYGisR2uidSYM4xOLof9X8nEqihZFcoX5K1Yi/HXHm1JaXPE3LpFRhhl1P6vROgL9
xh9pRgMSg4YmRAjuq9KraH1VB5W4q+1XzcFN90Wc5lR0ctwcjs6tcjWChZyz8UmEZV7UoEju
3Hrr0sMBewdhnsb2rGOSliT0BlqUWB+dgZ/D1NTABdRnURAzv3X5/HXx6cp6jqeFAcZlcJ/c
arek/tcTiFp5xiuS8QawuIxjewBQktA64BIPnszrAIiLEtbwNxvUfhBEZUTidwgcHP3wYeqO
UAFr7k0ve7zB0GrNI47/Rr41ifjUp8TUGuOoPsVfxL37buPzyDUDFl5fstLf8PB/X8ij727b
2Bdp8H03C32pMKBsl6sAI8UGwKUiGok9Aml946mHCpZE7lfUTHzEiKzU2bhz1VtfNX963Rx3
u+O3yaOe6uNwaQOTmPJAinDECGmCipSjgwB0KBP/C8yW/ZX3wpNGJhWjpAydqQNmCf/7m6Xl
MnHoEVS7szDQcoFI8wLKqHiMgkYEtrUcKxNF9cJreG55yRIna6LRHEsJF0PL0yJeNpvHw+S4
m3zewAix6v6I16UmTRHiwvyQmYZgVI03bGL1OlC/8evHALDeCKifzb5Qj9evP7aoMlpw023o
32olmxNowDwrKt8SbtDzwk3oPxXu7/7yn+VlPnm+eNPtaR7ZpoRHJz6Po9CjZ4cKWwnrASFl
RVw710aN4qVv8Rb+kNsfTbbnzUYVrIHYX3UJhaydG1wQA8DwEjNEighP8qWZlzEZyzxPukPD
xu2PvZAqaLPhut8p5Va+pCHqGnRN+fDYpKBv1/js7vN++/hVHQv1byu269HnQZW+lB6zpDCH
b4HrgsjY+nrhUqZF5HwNRMMgKqkyv2GCvZGFJDnxkTjVZ8TL9JaACVXfmBzMM9run/992G8m
T7uHx82+n0l0q4RjzqIDqdt9IX6Cy9DQSpak682YXt8K74kNRONFm/d7B3TtfXDT1LnTaFvp
e+F48dm6vNlJWbnRki+9peDOy5bM86kWdFtNW0hoUlivvk2U1je5MC5NmHwUByLuMtryUc9k
vOrUHFqy0U+PlmxuXezUv2t+SQewNDUtWUtofqKxgQlq5m8t4ZV5kykl7TVaWBORqd7/5+xK
mtzGlfRfqdPEzMFjkRQl8tAHiKQkuriZoCTKF4barh5XTLldUVV+3e/fDxIASSwJVsccvCi/
xEKsiURmAqB9ViWZcOtR+8wxlyYnMrFpqbayOSxI0KbsMKAdnY45kFBBSM1pWiFrtjIZlp9t
nVgRgA6VahxSdtoWzn7aZjCGMfrz7eVVt/BmiUi75Sbletaq7b1+kAWw3gs60uUAs5bnznxI
tiMk7tu5rS637P7g6SVoWQynSsbMwa3lLX7wxqqrQvMXtpuBt86J/feuFOYQPGBR93L78/WJ
60Lvitu/rfbaFfdsDhqfNTpWTN+w7zAj6Grf6Rpo9nto8YNWXuF5tPt02Kuxyyjdp5o6lpaO
4nnX1Y3VnZNHAZsx4jxuDaKWlB/buvy4f7q9fr/7+v3xWZFu1WGzz/WW+ZSlWcIXEp3ODsDD
SNYqw3IAtQs3C6xRUx7ggkm/I9U9k7TS7jh4euYG6i+ia2Pgs/JzD6H5CK3qmOTZdzZCSiZb
pDadbZPEpp66vDDmCSkNQm0QyI5mlR790t1Hwv7/9vwMqgFJ5NIu57p9hcgAWuAMqFgN61s/
egq7egKcn7VFXiFKpzocG52lzRAaCkuRKdG4VQC6j/feb74xlCVDjRucAsspYQsbatrMM2CH
ZdH4s+X8O+0mnLYfnv74AF7XN25gxbKyT4FKMbSwerg5WiT2x6Sx30NXd+BsDgeQ9SreGGjW
cgc8QD0/slYpX2wcQmB9fP3fD/WfH8Dv3ym9Qsq0Tg6BouoShkVMXiiV2CgztfttPTff+y0j
dGZMftQLBcoYo1BdwaoMEGtPEmQRE+0qon641kDJasWuVcG6a1xF+D0sXQfW2I4COFeWJAO9
gNpNKpm0vBAWtnBjJx+xHFwG7KPVXHa6Llos27e/PrLt7vb09PDEW/juD7E4TOEBrGnPs4Rg
JEXSOWxyR66yz10VFu3b6MfOCcA0UlbHM+laBPcUi9fj61dkeMBfWujvCUlzei+CZKBVmGGx
DS264y0kSrnsv1ouYbfrrPE4K21h4PNvLBqW3d1/iH99dugr734Irx10DeFs+pd/ZlJDreyr
soj3M1YzOe2MPZwRhkvBvdzpsS5Sc9XhDLtsJ98m8I3WAHTPxArcaHPkANtarGBLtALgeGXH
MkPGHkX8TpnQtabHYGIrnFschxWGgk8aOM6qGQz39e6TRkivFSlzrZRpIKg07fRScxWJ9lve
O2k00DNo8X25W1cJIRZlbFDuhy+jJ87Ha0HCdHHC01ZZu6XrbXUqCvjhRobxdQMrCH+SauLI
mBCurnAq+4JKxnqPFDWi5OB+tDXw4UpNyZa2OzRc8FjtXWoXrm2fClFWxttgmLWz8u+Fa5sk
PadGM4xkedaks6ZPhy+Gognid0JvgzJppsorvV2hDfmpcjtbZVKdywyCtsiAQvPZgtGlXSK+
7KjppiVWOebOitc09MN+SJsaG2DpqSyv+ljPExoHPl2vFDGareVFTUF5TrOWXxSoH0ialMbR
yicu1y5a+PFKj6epQf5KORBlFa1bOnQMCUME2B09435mRHg94hVuwnIsk00Q+lgbUG8TKecD
qg27HoKx9gNN95katffckEpdRRJfzmrh45yxVby0I0UJOhs9vnJukcQpSJZOLkm/ibah+r0S
iYOkx2xqJcwE7CGKj01GeyRxlnmr1RodW0blRZCwh79vr3f5n69vL79+8PDAr99vL0wgfIMD
N/DdPTEB8e4bG4WPz/BfdQx2cHRCy/p/5Gv3e5HTANRS+MUDmMgSOK80hTX9IOTS0x3bDtj2
+vLwxN9DsjrtzFZAQ0l0Nhe70fR3Ib+pe5KjdrOiTVxxGoF7cCll28HGIOSDYZ3RkpwdKdnm
h88/at2rj8I9UtBYjtivYJ3DLjUZHZcucRfAycOkdZiPyOtH/fbDinBeV6nrJpMvZCgCF0yH
E2nxmmWfTzxGs8OKeu+45QDjlYzgl7IlSZz2N3njhM69C4GTztlhA07a7JTiO+/BYeLN6kcz
fLKw74IzYF3gpbmMNxh9OPMea2vK5iOe+sz2ShwQ22blMCyuirLGy2XilSuRuPXiKm5bqcpO
zm8vj7//gulJ/3p8+/r9jighc7Sr3zEk3z9MMs3y7gixgAyf/HNWpXU7BEmtxx8TF0hBEm5x
48qZIYrxCTRmTQqSwGHFNC0c4ZJ8MYyMZihF6lSVSYGaZqgp2Ryqupzg2bYJTj+1dYsnmQ+P
GHbOTyUO8fgQ2s3cIWOiaz51Br5yGICdcfbFPIgKylA1YN1ZEVYMXI9l7+a0P33KO3pC2nlf
nj95kctlXyY/1PWhwNvleCKXLEehPGICYI9DoAJFkZK050yPU1WeS9xiQE3G0pCq1iSOsujp
xVr7VdhpMzzmmietbv19T6Mo9FhaVFGvp6xl7zlQmpV4u1Wkc2NZ19ZVXeKdUeGJoiBeIV1P
etfQJH0UbWPcr0ombpwrIO0qVMGjVKhhAhQ8i4DWFjZGsEnUBI3y3SHesllAif4uBJi3Y6aW
ajKwgmzRilBS0pMW90XBsuwzDtQFafcFafEeoiU1bl2S2MMPDrKhOUcS4yGvOehID0WZIFbf
BK5wenzDoB0fqjh2reqGXikKnh2r8iX/UumeRIIyXELPYUs2MQRooFUlc3FkUjOXhyjS52Aa
jssekqcomGRl8GBFtPgeCoDfOOK7seVr6bGq5nh1mbU0jePJp0IPxcJFhuPP17cPr4/fHu5O
dDcK1pzr4eGbNFQCZLQEJd9uz+AoaMn6l0K3ChxtpYZLiinPgH3aXtOyy9S4pSrWHXVZ/ug0
JtKTlepmoUK7tiZpomqVVDTJaVLjkLEBmVBLc23Zh0c5UT2kmnDeujAwS3PibBlku1DhlkiD
IQzL4KTpAmmOA7TD6Z2D/8s1JRSHuBCWVRVmmtSSa2KLwZfHkvTsb3ZSfXh9vdu9/Lx9+x1i
cs9qJKHN4AZ22mB++8myeZA5AICIzO9mrwzsd1wYR0le/TRxaqQ5fgiDtWI0/XIopVJUrD2r
wuW5HBpNyzpSpsjLUo3w/OvNeWLnVoBqzTnBsn7VwP0eoqGZdpECA8N13FpP4CIA2712rSuQ
knRt3ktkMqB4gj55hODTf9w0GxmZqIaQlaoSWqeDcd+pd6KUiW5ZNfS/eSt/vcxz/W27iXSW
T/UVKTo7o0SrR1yXoiLBfXbd1Zpp30iBqP0otQnDKHIiMYZ09zushM+dt1K1mxqgqzcVyPcc
r61MPKn0GWk3+rshJl9xj9dLt0nVyHzg6S9jTXiXkM0afVFPZYnWHtZ6YlgiQFFGgR84gAAD
2IqzDcIYrWOZYPNthpvW8z0kzyq7dOqZeQLAjwiONRTBLKF1Rrr6Qi7qLdEMnSq8V2o2ZdcI
vUsCNuywputKf+jqU3LUnLEmuJfD0m6lhDRMWMWk1Ylll5R4A3cQlxQ9dCgTfq4N/8mWDx8h
DaQwTJ0mZHdFr3knvKgPOfu3abBsmbRMmi5P6CLIhHah8bVYkmujXxXOEA/YYATzntGsgO1Z
VcvY2FQs8tVgL5QVOS47K5XgfY76I85Me3g93lUZ9NNp1uZ61FBBJ01TZLzMhXqx8RLGDs2W
4EiupME8awQKzSPNTo10I2Jq/3EmR+uead/3xF28ZQghWmQaK66bB5MPxCTXzGD7HMTQ0+4N
R9pAKsLGNFrGzBPg+u2ZIcV96yaGpN61WCNMDIe9j9fv0DriUWocA+q4PLOccra7lOqz6hPG
jwKa1+8E0TzNLuC43iJgV+q2lXOGPHD5cp0v8MAoGrl+YinJgeu70DJ40PC6xfpc59lpvuEz
Bl5bul/r/GGXPP1UY8FQJ5Yvx6w6ngiSMaHhyvMQAIQtw6p9wvrGEd1x4mj6Fp8HE8ee5mSD
n6/FLOBxfRwBqQQDrDRCWlzggkjLSNO0Zb627pQ4EV89OMTWDIt9j15lc8hP5a3k3LwiCW9w
IxsPu40WULCy2fW37DQoXJvlheEoCh9vL9+4O0P+sb6Dk4kWMVqLKcJ/wt/6+56CXOQ7sVUr
969AN3xNNUxevqLpGLE0IlroadsET0gaqAiujuEMQlh1sJw4D1LqgZSZaZkz0oaKMvkev2Ub
WQr8Nh1r/vm6GDk3iovz77eX21dQClmeC50ejP+MtSDEXY6joelUtaAwMHASpVGNH06GMwUP
ZwpvnoO3zDie6MPL4+3JNmoTIsKQkba4Jqq8LIHI1605JqLyYvpoN47zeZswXJHhTBjJePFY
ZdvDdoFFVlKZEnHN6cojcdykKywlO7GWCfosscJVtcOJO1KsMbRlLZ6X2cSCFpT1XValjpcW
VEZCGwh3fnb6n2qNjjsuaLXr/ChyKLUFG7iSINagwrTp558fIBtG4QOG641ebVMnmVVe9tPY
WSoSPq6wrDF1Hni/DPWGlbhulqwQF4YFzfe54xJ+5EiSqneoiUcOb5PTbb/YpnLN/NSRw3sd
KVnfY5Oa9Ya+y0kcW7iE97SAN77Ayf69nBK4zIC3h9L8kCdsAcG1cJIb5tIXLwjRFdRYcIxu
K5OuLSwZXYIVGLSDa6PD+qMaDtShPwQzSrbU4vYO4oHsvMJfrpSF8wdWTE+yeRGHUBZVh+cg
LSIS2xZjFHTYOXs4si8rVMGXU2FC8gfGTToYrAm3NBShXWtYunNQ3JcIEXxP0MA8nI9ruPWk
lM0ZF/sFAgSl9cGsCoRQEs95zuSdVQntTuCCvO0u/W5B+X33FdlL5766VglXmaHKIfD8hUgy
8BTsXKWZutbtEJPWX+NzO2/Guxt0iDtrOhbJGkB7f4P9vtcIPP48V5IrR3fSCzp4vCn7epew
P/oLeJyUY00gEX6ANm6AVIitCnmVqdu+ilanc93VlVnimdVi4PFDFwqmXRB8aVSDSRPRXVLZ
aldcx4P+GMHCbthZuOaDh83pE+34wwzCNdgaTXBIsHX7asnwpVwTBnb8OnlypZpHBFCPjBnX
5DO05Fp1Ydz76+nt8fnp4W/2BVAP7vKDVYat4Dsh//KQYxk7QZqFsmw5Bz5OJwbj/QiLo+iS
dYC+Cj9yNAmJw7WnN8QM/I1VrMkrWM8XS24z9AkDhvJXL8Y8sOzLok8a84Wf0Q5zqY3VUqRb
OcjF03UD458EffASnvtmHjviVdTfwYdY+qL954+fr29P/757+PH7wze4Gf4ouT4w2Qmc1P5L
Xar4iGED2+o9rQVofqi4j74u5BggLcjZjWIWn8CSldkZP1UBujio7rOyQR/PAbAetehaEjZM
lqPfcJ1eXnYZqnFm4GSIIB+eYgsAPF/LoI/sXM864iZv3pFYL5C+IzVlO6a9s9Rv38Uokfko
napPx73cFscDn2ucGB/VnVBVIUCy43R+IErLbmdLiUgDTjOsmYUUB3c/ChaXg7y6Rk61DjQd
XAJB2xgN8VUe97aLgmv7K/qcMm20pz+p/kNbkIU+hOaGB91MfnoEG3R1GEAWsEwjBTf6BQX7
6QgtxJAxa+wABAmZDAIWhPdwGsQlZYWLn8vxCo0sUh6eiv8f/jLk288Xa2lquka+wW0A8tZf
GsXAHXHlenVDWgOwScFm1PRKNM/19b9VkwC7sKnu06ItCeMrrBIYeHg3RTHA6KV67azww0q/
P1WJoUqAnNj/8CIEMLW2GObIbqRXl8nZ8Wrj62UAvUwaP6CrSBcQTNRG4MlJ1cJzovdeuNJM
qiakK/cOwzXJ0ZCCzaVFlvY+WoWLHHWSFagH0VSP49DssW8FYYrY9ISut0UUOoBYadP5rVv5
pj2Xb5S7K/jNxqhF4H6LECBHujaGnj9y1HvjpntMkrefTWNfMRYcmy6vC73SPdXzUtyT1ef7
ftyen9k+zzOzNgyebrvu+zGeyqxkbCZlqqsOs9G0niq9kAbXuXN438E/Kw83K1C/ZMnvV/C1
dpMOx+KSGiS4n03OiUEtd9GGbnuTmlVfPH9rUCkpSZj6bMjUu5OJXWminzQ4WYgCrqqTMh32
+nP3Cx02iXSc+vD3M1sc7Y6crUWMbhR0GGnO6qTqU3KicS+s/VMrM27vgNpjzrDf48n8fqkO
XEgPzP6QVOkxqGfKsa2zLk2yj0Krg7smT/zIW5lSktG0Yg7t0+Um36XbVejbTc7oXuRHrprt
UlZvr7yc7cnDlvcQl3g57pRqZSvLpc9u/O0mdDcUX6/NdposPfTMuoZuQt9z3E1MHDF61yTw
z2UfbYziLmUUeGZfAVHV4Y/EOF5rM8fuJn10Hw7sCEe0kEmiYepEe/D4ot2ZXTzQh1nClffh
r0cpTJc3dnZSBwVLMkaopf468o3sJsy74GLzzONY/WcGetAEfaRWam3p0+1fuh6K5SSkeHBV
cdZGsNAye4cDPtexoes8+LjReLzgH+SD6QE0DtWMSwWY3GH0ypwmcBiiazzeeyVzOzFH4mBI
WkyS1rkivOpCIEOAbbRyFbmN3qtvlK3WjqbKvC0yxuRYmsQo0KAORI1x9TlhQlPSqBHKOBM7
c+s+AArZfZo3meC/nes2QGUuusSPUQ9slavsNsLmD83jn5YlpIB/yDZpnbH79YxHJoPHlLWj
qEiooEhacNIvjRy0StBT0xRXnDpZGM8VT4ngwFZyKaORNIHo52xF0i6J2ZYTxX7oTC6W+wGi
JGoLsCA3+rsGYhuYqLNGF0IQukqQlRqiqCmjjTpz4HR94C8xNuFqo6gLxyTJxV952ioxIjCh
Ntg+qjLok1FDsLmoMfh2bYrsUA/ZObARqr7lMn6VICodAd6CnIwOzjGv3Wd/2zvuCacauoUT
hcVDBY2RgQ0MbyuuMXDExxqPYz7q0jR+t9LPs+pHYnw0rvBtZeQpmmjrbxcKAAZduh4R58o1
l887Ybn8LtiE2PgYGdKs4zEQeWOsN+HG8aUuUU9niQMsORsFay9cambOoXsVqpAfLjUhcGyD
0JE4NEpGeVg/LhRAy12w3mL5S7EVq904yA7kdMjEprFGVoW2C1eqCfiYc9vF6zC06aeEequV
bwPzocEC4jjWn886Xlyu6Fxsc7yfNd51WrIrv3L449efX3m8SmfEuX1qma0BjSRdxL7VEYgB
GGiw9fBQ4yPs4+sHWHGLg6qP9S9PTTo/2q7wmsE9oYjFX6NhwiaeY5GorhYAcGvhleqwzKnY
GY3n0zf+qncZAO9TSwE10yybYmho0D55uOg84QHmWjGhUYhmis6UGdUWWt7+sL4H2OSf0NDX
P0vQsM/iiKvWphJzogUWzQtXZtbwsAuoheEREmcfJF7Qm10qibqKlAONv/FjnXbMN2vf45+u
TcgOImrRPMF3E4BZ9taVn5Jx/plufDSeJAPF+V6vCd/ZVHOAmRgiRGMPFKOP7Rjhduusk9gT
nFNv3FXMMQ1U9SQ/U/XtZaJHa8yQVcJsad9aeYEUiWQVxTG2lM9oZOTEhPyNWX9Gi80Ss2rv
e7vSGCBt1p3MWjTJnomPgeuDpu1CS9QmYRdGzjT30SqyklRht/EwXRKgNEvQFZHm6+2mdwXA
4Rz314iNCv2JyF0frlYLoRMgXVc2zjwtXShQOwhwGwRhP3Q0YQcGZ9ZFE8TOEWLLXzLvojw5
kpiKLRACvFWozQ8uGBjqaA3aWtNJ0CM8TMLM4Fx/R1kE+xb2kQEuBSkc4ca1so7aObTK0WYh
Z6G0W6xy7Blr9ki1V1SGsCUr0PRp3aVYr4KF0cUYNuxosDRoL4XnbwMzzCuMjjIIA2P7sJzV
OHHUPuojr06OTEYnuIzOt/02/1JXxO18A7UrozWqG5egpuGcaXbzmYrPmYbyCn2oumbUx1Io
oc09cER0CVRP41vDh3awD7olO/edIK9hksaBaaemGsG4JNJZJ3I4Fbr+diJNagsL2Oc9GCfX
RUcOGcYARo8nYTpKT2WG5g7W+9xpZpGLbbwHNrsckL57G9BG3fRmDGTtaBOiUBoG6v6mIEJE
VntvBkcxF9U5TUzmyNAgOTRwqO8d5Y6CNDo+lH60tAsoiyo3GkjgQHwPbX6OeHil96QKgzDE
xXKDLYpwtfHM5lDmzwxC2MQqKZBzGDh6NadFHKyw7UDj2fhbj2D5w5a7dTQCx5Z7hGtN0HHP
96nQlTFs5e80WiGW7+XiGc9mu8HKB5k3jFyQIc5qWLRZx05o4+gHKb8u1hYRZw3QoV0zuGJM
GDQ/b+nTY3SmCAl9hc4vgfl4nvJYpW/KOr6NAsdnMzCKlwdZmTQe6y7fkUMTGoEAUKYoCpfH
ErBsHGtY2XzexujxSOFhxwkPncPTDQOKhJGjTH48WSxykm+R5HA5vkYVgQrP/vQFwrJiVWvO
bF3buKHIMRE4GL+3IvIbIjCkW6wf5zrR3XDWPMRnhvHAZANMmMHrJ85li8VSv2zIyrEoAkgd
Si6FKyyj7Wa597AD2P9Rdm1NauvK+q9Q6+FUVp29TnzB2Dwa24DX+BbLMJAXikXIhMoMTDHk
7GT/+qOWfNGlxeQ8pCb017pYl1ZLanULaLbw1DCLOhPNwZqggp1CgTNGRTOD/AIvl2runk3H
6zsf2G2l7lYPmBwXH0R8j4RPC2zjpaC2e19mCHssE4YOHH2jI2HdpkbXJWVjwgHo1X7kS7hK
f/c7BGsHfHpk4Syd4fZWdXRnJw9uqXZRErHbP9wZPOdpcWlLIAJUz85wu9qObRbXa2a9TpIs
iXqf1fnxy2nfqfy3X6/im9O2emHOXCn3NZBQ7qVg16xNDPASDEKfmDlYhFsTSOLaBHWWaSac
3UyKDdfbeGmfLDTF4XJFvDmt0zgpZaf8beuURVODhxwxYtl6NhwHSYVKmbNC16cvx8s4O51/
/Ozj/yqlrseZMBMGmrwLFejQ2Qnt7Ep6nMUZIEyTOSwk5+F7tjwtmPOzYpFgL4RYSfMMQmtm
lJtFXxZqw9DHortAb1sB+1qp7TsDbb0t1OaGVsYaWMuh9f37dLrtn0fNWs8ZuiuX/GYBRfLi
y1jCDW29sAL/dEIQAoDa6BK8yeRAf4Cy9ymEB2TYZcxXcok9ZgHmVZYINgC9G2Kt9uLk1Z8x
8CnV1RbrPejo2WruKArjQEdGHaPnSV6KFtlCipxFfJPG3Dgbpinil1lgo/k6YDgx+HwTWkXN
Y0BBPphRyFiIskj0+bBOc/woqYcd3OqqwyM6xJUcZDkjhfNipP35cHp+3qMxYrhQbZqQ2aWy
ROGPL6cLlVeHC1jV/Wv0er1ADCuw6gf7/JfTTykLXrFmHa5i2Zy4BeLQH6Prdo9PA9E0oCUn
4OrL0wQOozsae04qd2xp5Ii4rqgrdlTPHXt6VYGeuQ5+1dkWn61dxwrTyHHx5ZezreLQdse4
OsU56BLv+9gOfoDdqSZtK8cnebVR6aQstrtZM99xrB8Rv9eTPApUTHpGcWa3BYThxFM3711I
OTHlsMaIuakrgm/LGwkRwLT0AR8HGzzhRA0zoXEEY/MgnDWBrbU2JXoThDiZ6FV4IJaNGpK0
wzMLJrSOE19PSZvWt9EjeBHXupydk9CJhUy4FgE9zzzr1pVnj5G2ZACqnva4b8m78hZ4dAIL
8x3TwdOp5WpfAVSkOYF+p03W1cZ1ECEQbqYOOwIRhiEM9L00D9QByVrY11o42jheMJZMxpWB
LZRyPN+ZOv69ocHwAJFGbDr4+J5a5MCPKwcOd4zfWgsc0/uTzpMPTCVAHWUa19QNptgzwxZ/
CAIbG4ZLEjiqi2ipF/oWF3rh9EIl3P8eIcQLi76odfWqiidjupkL9RI5FLh3itSzH9bLj5zl
cKE8VMTCvQZaA5CkvucsiSanjTlwfzhxPbr9OB+varagkNCBT3e9npilyt9HbzpSTeB8vPx4
G307Pr8K+ek94LuoC6p2snmOP9WmILJFgAiQaZXGrdAQ4tEYqsLrsn85Xve02DNdrnT3RO3o
qSAUA9XHMq3QPA2rCkOWqadL9TSnDTjWBwWjT++Mb2DwsJPZAfbHWGlTZAGkdNfGzisH2EME
Rbl26Mg1JgPY0xY3oAZa9zEqWoR3vwgKe3pmlOrr1Il0Cj/w+jjVUJ3pPblXrn0HtavsYd9B
pA6lK5+JMKBvj4Z8dVW2XAeIIlGupxOMdzrxkKFRrm03uDPQ1mQycbSBljfT3LIQ4c2AO0o5
4LZ4rt2TK+V+vwcaWtCdlgMOG30e1ONrCy1xTSuKkZH6kdpyrSpytWYtyrKwbBTKvbzM1P3l
ro7DKHeQjqj/9saFeWQR72EiRm8WqIiqRunjJFpg56k9gzcL51p+TLqp1KQJkodAFLK4EOVx
RClN3w52i7YX6NpV+OC72GSMH6e+bVb8AJ4EaLLA8nfrKEdXXKl+rMY8ZLVpJYjhtkjTL8FA
ZKJ9CaVOxhOxoeS8+YJbpfoK2S2uKqYcBK4KdjzHF7Ifb7fLy+k/RzhNYSuytv1m/OBjohIf
ZYsY3STbsmc7BQ2c6T1Q1G71fH3biE6DwDeASej5E1NKBhpS5o0jG94qmHzbqqGoqZjM5Mhb
NAW1XYNNi8AG/tFxuyiBaRM5lmRQI2Ge5M1JxlpPT3gNNxlN6qGx1DU2Xz+F5mg0HpNA3HBJ
KOiLE89UAz4qDK89RcZ5RIU+Jgw1JgevCMMMlWxrYUiZjI3NO4+oSmZu3iCoyYQmxp93STVY
hVNlVUPnrWN7vqm4tJnaqHm1yFRTcYvctfQd7Vp2jT0bk0Zsbsc2bU75LY3GMbNMATkxQSVK
sLfjKF7PRvPr5XyjSXqXJsyY6+1G99n765fRh7f9jer1p9vxz9FXgbWtDxyukmZmBVNBI22J
E+lSmhPX1tT6iRBtqX9b8sS2rZ+Gc24O22oqmEWGB1AMDoKYuLa8DcK++sC8mPz36Ha80s3b
DVwJyt8vn9DXG9wjH4CdTI6cGHvzzT4mVacvq2wRBGPUdGdA3W5ZoqS/yO/0VrRxxratdAwj
ite4rITGtR21Up8z2qsu9nB3QNWh4C1t6Yi363VHjIrRDRoLGzSOPrzY6MCGl0KE9dKSDVe6
XrEU818llSOuhkBcJ8TeTPWsWsEQqzf9CBdvfWzJG0rd6AWEExs1Ihg6dIJ0qGycPPSzKScY
huJCzsomjuVok5NOItyqgY2bWTAJ1Qrx9maaST9em9EH4/wSq1UFga92NdC0hqKf5/h3+oDj
+DF+P1INVhPtPDdN4YxujQMb++axVs1i00zuDRU68fCQ0+0Mcz1lpsbpDPpDdjouAviRXsvh
A8d7DLiH2pZhah4MbRsoEz2cT7meIOWUROZRDnPbFTVQ3p+xQ5da9eocqGNbvVGvm8wJXAsj
alKOCWRsd866ILbpAg7XsmUsDueoXTaMAxnkR6BPJt5EDqaXCLCLSUW/Kz9sCC2+uFxv30Yh
3SSeDvvzx4fL9bg/j5phjn2M2LoWN2tjJengdCxLkQJl7dmObetEW2+7WUQ3aaiuzebJIm5c
V82/pWpLYEufYP6LOA6xjZDlxlLWi3AVeI5WVU7d0eYw5N8yrMcZUobdC7OUxL8vzaaOrc3e
QFv1mBB1LCIVIS/w//X/KreJwDLbUUoBJWLs9s4OO0MBIcPR5fz8q9UfP1ZZJucqHcgOyxz9
JMtSZbYAsc0t35YnUWd00e3XWaRDps8gepY73Wz/NsqirJgtHfwgsYexA9kWrNSuYTSlzcAQ
e6wPVUY2TmKOahIP9vkmZSBbkGCReepEoUR1jQ6bGVVsVdFG5cZk4inKdrpxPMtbK6MAtlCO
NgRBSLuK2FmW9Yq4ocJIorJxEoUzyZIi6U9NLi8vlzOLdM/ixY0+JIVnOY79p2hyo51fdeLc
mk7VpiOVsk7L2x5td8Oq0Vwuz2/geJAOtePz5XV0Pv7bNGFYbPjdHLHC0u0vWOaL6/712+mg
+UoM61zyId1dEglkfiB23b8cR//8+PqVNkWsnovNaUvkEKdNaGdKK8omnW9FkthQ87TOmW9W
um3ENBfIlP6bp1lWJ2KknBaIympLk4cakEIQm1mWyknIluB5AYDmBQCe17ysk3RR7JKC7ngl
M1cKzspm2SL4V83oHzQlLabJkrtp2VdINkpzMMKaJ3WdxDvRVx2lg4OW1rcvUYpq0ox9FkTk
0fabUmd/65y7ahOAZrOiaoPSaHTf3z6MFssjS1qbGS10B8/j8W9LZ/lusWnGnjjZKb19RSV/
mhCtWiqHHWyiQhZQAuqRj85NdISz5pjtD9+fT0/fbnRVo7U3RsWkGDcVbJ27DxUGRPBA3FLB
N02WLpaNIdWAq28PB6R/M99/5oC1r0HQxhi4mI3vY2YIxjHwcTPjd5jCGN444O5ZJB5x/R0g
3ZWOkKx/eoY1z0Tc2A+IYAGvYboB94CpwReEstaeY/kZvuUY2GYx3RXjz+GFT6qjTVRgM10o
rw1P2Y7Sd8Zil34Zix6Es3IhfQ38hqgX4D6cTiKkfIFjveD7ZSx1lK0ax8HuYxgTWVHJs2Rl
yJXpEDzvFkQy75tBW86GLEi5KmJNpC3pEqNNWEoUC6c/B89HTZ0UCzTEO2Wrw8fhg1Y8GyET
xVEqeT0eQFmFOmhCFPjDsRy5kNGierVRa8eIO9SrF4OrSg70wogriONsSDFLsoe0kEuOlnQx
2aq0lP5SieVqEdYyLQ+jMMtURnYyrND6qJNSbWnTLsqiTgn2PhsYkpwugHM5LzD6FyN1M9pn
HiZUyn2R5LPUEDiF4XODo0IGZmWdloboJ8BAC9TiRorwNpGr+BhmTVmpdVynySMpixRbJFk1
tnUIxtZyXik4y1VIjTYW/g7xgIiANY9psQyVbB+SAvw3K4EuAMkik180hibKlKD6drkuFVq5
SPWB31HhR1UpwoEj6AQAtF7lsyypwtjhY0RKupiOLXPSx2WSZPrQoupfGilBXjk9AwVEbZU8
3LJnA8YxQrU0NsIN7caitZNy3iillRAmJlGmFcSaS9mIU6tRNNizN0DKWoroDqQqLMDVEx3d
Qp8JRKUpWZKkCbMt6nyYwRAeKdJka0umitj9dMPqp1S0hXnWGJDEmkCpIBBtDfMJu+RkHDVV
8jdyjiRMtXbS4h8zIsQng2g7CrlJwlwj0QFG1wUxuDIDVkWVrbSK1+jTRSYBIFhkSESJ2pO0
AUzysG7+LrdtEd0iKVCR/m3SNaYVMIhuPhJ1djdLKiRylQbhZ/SQByLdvJStYI3dVcSVM31M
07xslLm4SYtcES2fk7qUv7ijaA30eRvTZVWVpzzk5W65mqH01m27GhiTrbddlOfOfgNZ/YcI
K5hawiKypJLap/H2sRgFYq+QkNmuXEapvJ8UFBaKI2/ugAyvnZo6xR9QAcMqq1JjCDBgoP8t
TO4IAG9d35PdUhYQSihh1kJAYzH2Bq2pp1fffr2dDrRds/0vPNxJUVasxE2UpLhrCECZv9e1
MahZuFyXat36xr9TD6WQMF4YosA228pg1AwJ65L2H3lMG1SryHPpQVL1WJPkE9WQDFcqLa5v
kYfsdrOsjARZ1pO651+BoGjDMyw1aJ6QDt4mdSow/f2RxB8hyWh5ebuNouFgLda7DpJrD/nE
rHMWSk5y0UPJJF5KrwI7Gjs1ialqilthANcS/six3SSGJcHcyudUG21jXCuU/p2bECqB3E6H
79hI7ROtChLOE/Dku8rRHiJVXWp9RHqKVpi5rbtJkjx2y2anDNFf6ovHgcZfRaIIU0dYXEQF
ntWwlhdU24fIdtESXl32l1Nw8KBtilgyzNccA8KwsR2DAwDOULiW400xTZfjxJ2MvVCpZghO
eV2ttFmUT1zU0/4Ae4GSFzuwsbS8GBm7PR1QvQLMghC/9+3xqYOfzPQMFuralsG6e2pG5nER
7pRrEPK8SPCzNlYbhRLFo5iW6HnMtUeey+p0jzq4Bd2A409OenxibvAq8Cxbq5DqBa4j4wdb
Q2N5GyWrlqrEZemhiasmaL11kSZsVur0Uz12MaLqMpMREWdWfKjGTiC/puJf1rgeetHDR0fv
W0WkNlEI/hNUahZ5U8lKg2ehecMRyFN0wHveT3On9i4UzSwPTexMUKcvDE6Ja88z156qVW0B
Z7PR5RO7+vvn+XT+/sH+k6399WI2ag9Of0BUCEzXG30YFGQp9h3vEtg6YP5kGao7O+Tfn22U
gIEyDh7FTFlyb4bDdNMEidang0dDqWqL3LXHlthKzfX09KSLcVAnF9LDZZHMom7V2id2aElX
jWWJa04SY95gV0gSyzKhusosCRtDTZBdp4RH1cqAhBHdMKXN1gAj07+D4mQe0mVzx/qCteTp
9QZmEG+jG2/OYXAVx9vX0zPE9jtczl9PT6MP0Oq3/fXpeNNHVt++dVgQCKD2XvNwVxjGnqhC
5UgKZyuSBg//qWQGp6z6yO4bFJ53I5mEUUS1iHSWZry1u+PV/fcfr9Aqb5fn4+jt9Xg8fJNM
6HGOLte6iXZSsC0gKBoQkJZRU5ItTuwub/643g7WH8NnAQuFG7ofQxsPcLPLCkBZyAVta0SR
0am7sJbdI4CD4KKZ8xBexmwZC9UmzdViHHhnslrXa0nFhy0q1EpT5jpm/XJHQmRFr4PC2cz7
nBDUnVLPkpSfp3qu4WwTYKXFBO4AscI4sovobFnVeJxskdXHX4ELLBPcuV3LsNzmgTdxsZro
/usUBrp4TiRzUgFo3RxrmSL3gRiH5PlxAFSPby2ieRTuAeJF7t3vT0lmOxZSGgdkkygFw2xj
O5YNZfCwtCxel3NvLDEOC+8ThrnokxCJ5U5q1OFA38ZjuwmwHmX03WPc6BgSHqyHPrnOw726
Kq6L+zmNONbtMEI3KFML21d1HHOqFiieJLvxQGcjanknMHgBWiwkvTtuk5xu+HxkcK5dC2+d
GpzI3esN4uVoC8RUQgSaOIZHWkbhx4JYF3BWnPZrFuUHZwHvCs2Y0L2Zo38ZHU6ObfzkaeR0
JVXP+xtVXF+UYjBp5RgcTgssnskvncDi3WtWEIqBt5uHeZptDTKYMrwrWHG3nQOD7wSoCABo
/H7+VPjeG28sF1Q8sdBh76wLRje0AgMuREjzYPtNaHBs2suLoEHfDogMLto6gHj4E/SeheQT
x3AcMYiecWDd+8K68iJx493RYewiElB1bC3SPYT/87b4lFfdDLic/6Kq+3vjn2AHrB04XOgr
ABKitJeEDf2fKQpp35rcs+l9HqObzq41fdfqzX1h60n4G1z5i7kNbR7OVnPdTRjZFhFYxwkH
quSRUcVP46l3eblOWts+tOItG0myOSiIuA7aMtFNWYUH3laq2m8BVps4JVUWipeh8Xjsi0tn
mi/A8DNNd+o1ZGNPHlDnnHR/k2Tt4eQup7sMyaU3R3nUsxb7Q9DyIb4Ou7jMdnjMNZFB2vYI
gHZxLLMMlQF7OMQdGKWK+0z+Gw5LVhpxHVehRpyBhzO5di2SFtUK2z+22QzsyxIccNAStQUy
Px2ul7fL19to+ev1eP1rPXr6cXy7ScHDe28d91m70hd1spW8tpImXKSFFGAuKsH0xDC9MogC
rlY0pRvPt9v+6XR+UidPeDgcn4/Xy8vx1gmRzlxWRjj3ef98eWL2vK3hOt1+0uy0tPf4xJw6
+J/TX19O1yP3Zy/l2U2RuPFd2a6qJemxBeRKvFdE6y3ldX+gbGfwMGn8ur5gH/fwRAFffhf/
fr7tMwCoWP8agPw6374d305Smxp5GFNxvP37cv3OPvrXf47Xf43Sl9fjF1ZwhLanN23P5dv8
fzOHdtTc6CgaQbT6p18jNkJgbKWR3EyJH3i4rZs5A34ScHy7PMPx5Lsj7T3O/rIZmQLKHNt1
Fl3tAP1yvZy+yKOak4TrwjblrAxrNL4w2c2rRQgyVroXLlKyJaQyBM54ID6+q2ilA5PZtWgc
1gGS1V5HVM7/enK5wIhlBWeGOqLFkeyAOny8U9V1OquVGMLdR9RpvEjiXbXcYtkawwN2DHgo
sQ4lii/Fjq7e7fKHBPu378cb9mZAQbpSNmm2CzcpGN/PpWLmaZLFUA5+xrSEGLFRJjQv/QGu
X2m7SyE9GWOWLMJoK/MvH+k2qxCvRqPny+H7iFx+XLGodHCM19pFELgRbnJh5YTfcFTdUoe7
W7DYipZptavSZjLGDQXQcruc8zDNZqV0+tU7/cyXWOShENwhh7ucp5Kzkc7k6uPL5XYET4yS
6tvLAw3lqV5f3p5QXbnKSRt7dwEXF0BAv1fOQZABYJv7mMoeo/mGuIxGH8ivt9vxZVSeR9G3
0+ufcE57OH09HYRray5vXuhiRcnkEmHfhcE8HRz8fjEm01Fu/n+97L8cLi+mdCjOF5pN9XF+
PR7fDvvn4+jT5Zp+MmXyHiu/G/iffGPKQMMY+OnH/plWzVh3FO+HfBnRMd+Npc3p+XT+qWU0
zPK02OzW0QodEFji/nT+t7q+18RzkBfzOvnUVaz9OVpcKOP5Ij3R4tBuUa5bsxeqfsdJHhbS
rkBkq5IaZl5Id3XIzJM4QcoTKnyGOSjCfVwfHK5CQtJ1on4EYgwzfPEuWeMXOcmmiYYrpOTn
jS7r7RsW3eSDM7O4yn9Ly1cLzEk4HYu7qZauvoloyXm4cV00EOPAoN3zthA/gzQnrZrCsz29
KnUTTH3xpd//sfYky40jud7nKxx9eoeqaIlaLB36kOIiscTNJGXLvjBcLnWVom3Lz0tM13z9
AJlcACaomnnxIrqrSgCYeyKRSCw1vIhnM5pepAY3dl6Mb/txynX8zd2RXqJCvBftgoD6a3ew
yl2JYLRysXI5IX6LZyBScXD97AUHvFSX+WdQiN9YpLrWApdxS+JQErjW9/2ManBXonzbaUXV
fTShAfhqAA/HqIGXjgXgVKtY9aLzAkROcLaKXVgJ+gUwogV0UF60pxxesqcmA8pLLwaJdCRG
29AY6q6NAB4PhliFmmZMJOlWj3HZUKA81Bv/sutEi++k3H3hyWq57d79sh2PxKgdsTtxqONt
HKtLlki4BvQyvgGwl4QIQIupqLIEzHI2G9sJIg188AsahklHqOLxofbu3BFZSlFuFxMapgkB
KzVjkXP/T7fx7lo6Wo5zqW5AOcsxXdGX89G8/7sKA8zlBvcVFUV0qQJ6uWRSnvJClIwrJTpE
uhhwYjRGLF/GmLEW2Jn8lZ9c+1Ga+W0ybyIO7y95TKIwUc5+P1C9eYGsa29gpetMeS4vDRrQ
p2ucnEVV7ccTlotX7ZdzGsMhdrPJlL8Axn5S3Y1Nm2Q7TZ1kd6A/idrx1FPm7DEDSatpEwdV
4VBFHcn1r0mAQlzJnj6B49Tr22qV+pvRYuz2YAXscx4TMZiPRwP9rQWyfdO7/1bbpJ3TL3zm
eY6MKvcLV0W+UCb5opbSXx5BhOttsE3sTvs+qa3c3n5gvvhxeNKm1UafTc+gMoKpyzaWAb5B
+HdphyFHiz8fSKTnusVi4HAI1dVAttDC9SajnhWygTF+ig0Jc8yOUawz/jRaZMVEDPB6t1iy
2PrWSBhV//Fbo+pHlY0JY8A9C+uDycgG3OSrh+5O/863QCyfLoa4qIso6j6bu1yRNd+1beqk
fQvZOwZ5gTKuHnQeFgTDr+uFKOtEZ6P5lHLj2YTKuPB7OmXMfDZbOmgURj2/NHSSMwCzisDf
y3k/XbmXpeipLW1Tr5hOaSzdeO5M6HsvMMYZdVHG3wuHM8rppTNjrAKqms1ooE3DKABMp/fs
wLW68G8fT09NLAnOCeoLlQ5FwY6VHs7cWiQp36JsxV+mi2RNqAMUHP734/D88LNV7f4LTS09
r6ijwBBtzxoVp/fvp9ffvSNGjfn6gVptuiTP0plH9B/3b4fPEZAdvl1Ep9PLxf9APRjOpmnH
G2kHLfu//bKLRnC2h2zlf//5enp7OL0cLt76jHIVr1kMIvOb761grwoHoziJME5LmMb6Nk9B
1mUndLabjEwG4WER2HwnSsAaRQXgBl2uJ85oJC1eu++GNR7uH99/kIOjgb6+X+T374eL+PR8
fOdnSuBPp6Mp22qTEQsTWUNYbHmxTIKkzTCN+Hg6fju+/7QnS8XOZExj6mxKKhJtPJQI+46K
jZ9aHHrMAnVTFg7lE+Z3bzbLHSUpwksjiJPfDht1q+2GTcDGeUez56fD/dvHq8lZ8AFjwRZi
2FuIYbcQO5XwPi0W0IjBHNjbeD+XbhVhcl2Fbjx15nS+KLR3ngAGVutcr1Z24acI4QSKinju
Ffsh+LlvqnDC+O+ZYTM21TrMg71KvC8w7RMuyitvt4eFKUs3CmO6im9w0QQTDJHjK/OK5YQO
oYYs2cxtxpez3m96krrxxBnTaIMIoEca/GbJSl10T5nx3/MZKWCdOSobUdndQKDpoxHzXW1l
hyJylqOBoMKcSPTs0agxPVXpLT+yfHVrTJankpfNl0KNWWzhPMtHM7bz6ib147xEZT7jIfWj
a5jKqejLDNxpasV6NjDJWCpJ1bgX1S7NyslQZP0M+uCM+uiWU4zHtN34mye9gnv6ZCIuQtgg
u+uwoIPdgvr8oXSLyVSM/64xVN/UDGkJUzmjV00NWPQAl/RTAExn3AByV8zGC0dS7Fy7ScTD
QxsIN7C69uNoPpKFfY1i+Sii+ZjuqDuYFxj7MWUenDkYE4v778+Hd6P1IGyjYwPbxfJSGjuN
oAq97Wi55Pyl1rPFap0M8mZATuTkUmSLYAl+mcY+en9PyAtsHLuTmUOTVNTcU9cpywtNc/ro
Zu7hrjlbTCeDiP7yatB5DEtVOIQaAxVpoP/RBmp+eTzwpHX6prRjFzpGWB+iD4/HZ2v2hMta
4sLNXhhBQmM0vFWelk2oEHLqCPXoFjT+OxefL0ys6cfT84H3YpPXb6CS8jnEGBX5LitldIlP
6/hmzq6adELRX6FBigMvt7A+LJ9BEDMJuJ6/fzzCv19Ob0dtwEL3Qrt9fk3OZOyX0zscz0dB
Gz5zLnnszmIsWxbj1W3K7nZwdRuNmXkygmYDKQPKLELhUzaWk5spdgGGjkpmUZwtxyNZuuaf
mKsQ5ov6eBXuGmqVjeajeM35RuYsxHCr0Qa4Hn+Fywr5hGAnbD9mUDaS3T9DN8OsCmJahSwa
Uznb/O5pwbNoMubatriYzeUEBICYXFrcqWmrAOV1lbPpaMI75YzmMpO9yxQIU3NxEVhT04mR
z2jLI+6DPrKe5NPfxycU9HGHfNOx5x+EKddyEnehDT2VY+AJv7qmS301dng03qwXeLARjQK0
C+NeqkUeiMn+iv1yQsOsw+8ZF3/wSzGPERzR3NT4OppNotG+PRHaIT07EP+/BliGCx+eXlAP
IW4xshNKP2bBkeJovxzNx7LpuUGKnudlDKI10WDp32Qxl8CW6QTr3w4LTiI1mUz0je29FuZX
OpmNEPskv0JjGna3iaoglBQKsfLQDAY+YQdcv+y26Ey522rFI+1gQB6oIMxStxSjpMF29Usx
E7bBrHI3LspVrRenRRs8nopRtZbsvgxBGXZ+vmbzbW4vio+vb9oiohuZ2ga9tgGzgTrxHTBR
il65cbVNE4Uv4E7fegy/qe3XqzLNc9m0gFLxwimmCOHoVwM4FdHIX4gKiggzzC3iK2xZv1Fx
uIcha7sz0KhsrypnkcTVpqCW+QyF3ba6nLkqs0O60PpVlm3SxK9iL57PB2LhI2Hq+lGKWunc
82Ujdj6X5Gu0HYF2iK+2xKgAflRR1mrWs8Mr+vJoHvRktE2SBfU5MrI+ueVFz5Kz2XyJl6c8
FlFr2tmc2zR4lvZW7f00kp0FxMexwtNhsoxi7Obi/fX+QR9GfbZQlKRQ+IFX7RJN1tncdwg0
5Ss5otFTE1CR7nJYoAApUh44kWBbt3FxgoVGNzWgNSu5VBmbvQwE+Kz3aGShtP1fh8eCahNQ
66Mg9/0738LWr38ZXgXcdJcxxqXLy/01CyKYBjJcA70gsiGVCoh9ZFCE7IeOLIPmmknq8SC9
gKujfw1EECEULP4WgSsdd42jChYDUkNWfm10SoCpS8U8jFkDo7Pv7F7I1UyM1bPDF/P15dKR
3CARy939ERLHte2RffuzjO6yuEp52MMiFLVKRRTG3P0BAObd2S1zdhLpmxn8O/FdicXDAklK
tkBg9V/tlAdrh3SkNXQtgSkB7yp3OXsG7tmbmYeaI7rba+7H074qFBRBSIQbX6ZyOWAF4MIU
mDHtir8vnWrArR1wkx6uw0yroOgVNEUbPYzlrUsd/gy4dRHCrLuRVUCAD6DuLg9L2RVKEw1F
stLI7S4JS220S6byy8pj5xb+HiwG2hCvXOVuuBuaH8KoAk4ckC8awaqg/Rz4oukqaWhQtJGu
WFEYwibEoFZS7XurdoRc7dJS2lP7oRlARC7HBkFUmmBAemAL+U4+65HoRuXJIHJoxNdB4fQ6
kLoGJlmulbnV3wZ2dshbIphakFxxF6/r4bcLyncJSFqwlm4ry+mO0VrTZcCqgOUicYeuBj+o
rkHaDFgDkjAa7HngNB2nAFwaNhT+26uyzG0wnfseyl6QGmPGy65Ch1oJky/ABvkZVxcHvFNf
z0PuBdegozvxtGqxU7vEu6Jkp5TUGX+PHgd97mRgdfC9NBOHV4fTB3xIo5KicTMaFN328eQE
rkAwz28zHAWZoeA8s2FtQO3ysRCrXQhnKSzCcJ0oPBvo8BdtKohO3WN7kLbHlcZoC2pShrLS
SdSQOiwM2rzGoZ49UrXmKr2fGKVG+y/ogzFQ3IE3ywFcEyJ76CkqOhMvTTHEIwy2BPGMln0V
xGV1LSmRDMbptdQtqQXhrkyDYsoWtoHxta5PNQJwWfTi2qeTEqQwhZG6HYBhzOIQs2ZU8Nd5
AhXdKJ2gIorSG8YeO+Iw8XxJniEksQ89T7M2wo97//CDpRsprOOuBmnmIu6VGr+BQyld5yqW
Ph4+YQ0+XSHrqKKwINK5RuFWYxu4gw6WSkh4q1p/SN1rMwLe5zyNf/euPS1SdRJVs2WKdAlX
VTaDX9Io9Jkv3R2QiYx65wXNAdVULldoFMpp8Xugyt/9Pf6ZlHKTgh6Xjwv4jkGu+yT4u4mI
5cK1IUM/6+nkUsKHKfpFF9DB345vp8Vitvw8/k0i3JUBU7HrVg+JkElpSUydfHuu2+Z6/nb4
+Ha6+FMaDgy11BMCNOg6HjAv1FjUDJWR9RGI4ZGX+xLz3vp5Qse0d/duw++uw7VKSlQdMUd3
81cnrzQaBbtn5EoUFiZ4AAa68uOBkfXLmzTfDtE1VDQ7OvxoZlGaZEQ3q6SaUgU8w1xOWDAk
jruUTHMZyYLaOvQwziBmNljlYiZnBeFEc1np1COS34l6RNLFpkcyGW7tXFK890hmQ8Mwnw9i
lgOY5WTom+XgRCwnQxOxnC6Huya+hSMJcElcatVioNSxMxsNFgtI6XhHGh2RgpfZVDWWwY4M
nsjgab9RDUI2z6cUcuAfSiGZ8VO8NdBt1+T3OUbyq5kY95bYNg0XVS7AdhwWK7eCY4wGP2/A
ro/RivuNNhiQCne57FHdEuUpXHDFLF0tyW0eRhHVTzaYtfIjuW6M4y8F7WrwITS757zYopJd
KN3f2Dj0co41OBDXt+FA1gqkwTNURHqRFLx0l4RuStOR1IAqQc/KKLzTVgltgBh60DCFkbEm
Pzx8vOILnBW0Zuvfci8p+A2y6NUOyjTSlXSs+nkB0hbMMdKDqL8mJ06JqQl8zyq5vi7VGPHU
hZvRBu5pvknO0m+XCZcTugYpafPqm2zlxX6hn4bKPKSJ6uyrbgNhp31TTH3cCphMlTTjCjrP
gyDl+Qn0Dm9cKHhXGArGrd1SumfpPplsXoeaH1fTYP45k35uwBCvbhIsBEwn9QsiWKhyIvOW
pEzj9Fa6o7cUKssUNCsXxqVBoXS0+RW+lUt+Cs1oKYckf5uy0wIKNUep8rIwEeuqcbBCgzQX
XZZb0lsVK6F0jDgPYjRPhUXKd7deepOgEatsZ9FopSQjj1oEl4a/YyF9ItlRAur/4zc01P92
+ufzp5/3T/efHk/3316Oz5/e7v88AOXx2yeMiPodmcWn+5eX+9en0+unt8Pj8fnj709vT/cP
f316Pz2dfp4+fX358zfDXbaH1+fDo05yeNB2EB2X+UcXTP/i+HxEU93jv+5r54G29zBtsOLd
Lexwmv1SI9DLGjcSD/NLhs7Q4BsOIZFtzuR2NOjhbrR+N3022qpXYflpLRPVGCC3S9vr9+vP
l/fTxcPp9XBxer34cXh8ob4ghhh6ulZZ2C+jBjs23FeeCLRJi60bZhuqC+oh7E/4HiZAmzSn
yrMOJhKSbd9r+GBL1FDjt1lmU2+zzC4B1ZI2KZzmai2UW8PtD7g6jVNXXlioVeT3HyJqqnUw
dhbxLrIQyS6SgXb1+i9hynflxudh5moMNkVSmxisn6zDLoVv9vH18fjw+a/Dz4sHvVq/Y4LA
n9YizWm20hrm2SvFp2+ELczbCK303dwrpGeLptu7/Np3ZrPxsmmr+nj/gVZ1D/fvh28X/rNu
MBoe/vOICdLf3k4PR43y7t/v6aNZU6IryVzNTLmxPfIbkIWUM8rS6LZv8t1uvHWIAUBFFt/s
Nv8qlAL1tAOxUcDRrpturrRX1dPpG9XcNS1a2ePrBisbVtor1hXWp+/a30b5jQVLhToyqTF7
oRIQ425yZe/PZEMGtjesmHip3NlTgo8M7Uht7t9+DA1UrOzGbSTg3nSjP2nXvaw3jUXo4e3d
rix3J44wMQi269uLPHYVqa3v2KNs4PagQuHleOSFgYVZi+WfWcOxJ10jW6Q9O3EIS1ZbGtmd
zmNv7CxEMHWG6cDObC60CRATR7JBbfbURo2t0gBoSrPAs7FwOm7URKi5iCUb5AaJ7xKr1D74
ynU+Xtp13GSmZsONji8/mA10y0MKoR0ArcRshA0+2a1Ce12o3J0KpYGgchMM3VSbJaViH+7d
6jxNUcpaEUIgK0WaU8OXrnE1MtB/2xxko+6UJ02Wigp1bp00LNyefWYG0wLzDC64Njye2jPu
2yciXB1xkIfgnSu5WQ+npxe0PG68avvjFESqlC4mDZ++S62KFlN7DbL31Q62sfdu/ehqjHPv
n7+dni6Sj6evh9fGx5eJ8O06LMLKzSRp0MtX614cVYoR2bHBSBxMY6SDDREW8EuImTJ8tD7N
bi0sinSVJHU3CLkJLXZQsm4ppPFokbUMb63mgTc4IobD3Sfo3y8ej19f7+GO83r6eD8+C4dh
FK5qJiPADb+wEfXBY4dwtmlEnNl55PN+bzuiM2scaVpB8FeFtYTnC/QGhqI5IkHYDe/8P8bn
SM6NypmjtutzJ1Web+zAmbaxZTS0GVRl3I/nZGGNjG6zmwaPNY6mZyYFSftBkwkK9SJ7FmyK
VhFjzmC3Wu9/ie9bTKjiNo591O5pxSDmfxSR2W4V1TTFbjVIVmaxTLOfjZaV6+e13tGv7ezo
mGVbt1igvcM14rGUQVu8ppq2EFLEZRMTewCLF7lqS7MXo40IhjP1jY2KtiqqlaMtU0Dn6D/1
JelNZ956O35/Nj4GDz8OD38dn78T82D9oEjVtzmzibHxBYvfXeP9fZkrOmZD6sY08VR+269P
Ur6ZgoHBYG6pohxsWkeh2aM2MdAtbN7j/4PhaIpchQm2TtuxBM14RoPcNVehN6+yq65NDaRa
wc0cjjeqR0abOpUDSbKm/Ad9K1i/ViHImBihnCzJxlsBxM/EzW6rIE/jnlqCkkR+MoBNfHzX
D+ljsZvmHvMDyMPYr5JdvGJR0o16XrFd68KVGo5ZBhrPOYV9SXGrsNxV/Ct+T4Kf/I2DY2B3
+6tbyT2JEUyFT1V+M7Q6DcVKfAoC3JydkvzMdGnut3BlXwddciHq3/8wZVcpJEpQiZfGfCBq
FAh5rcUdh6LNeh9+h6cISA0oTPagtYhJGn+XCiUjVCoZhEiRGkRLGS63D4ROgVyDJfr9XWXM
qzuLUw2p9gNZWGq09hzJZOfAmiRUc9kNrMarXFbld+hyA/tGMsU1FBiN2+13pVq5X4TuDGjx
uiGp1nchUaoQxAoQjojZ39k8gT5ZNYsPLkdVkUYpC3xFoVgo3eord8N+aN+QUkfzi6kVTVGk
bgis5NqH4cpZLgqlrdaZE0yKcSNJR2KFFp2EQLfIIIDprekDHcKgkZHK0VFlo+8CHJukSYPA
6IrMXB7xKKkPvkStIzNwpMgrwhzXUcrcs/B3u5XFx2Zuw9tOTpnGIWc+0V1VKlZ4mF+h0CmZ
QsdZyDL0wY+A5sNKQ097rsCxQcUMYIMx1djho2qyFh+erfORPw81AoeGvrwen9//Mi6hT4e3
7/bTtD57tzpiOBO4DNjF0JCSlOUaTySMNx/B4Rm17w2XgxRXOzTym7YDVUtiVglTsihuEwWz
cSbvIKOohuLf3carFEVUP8+BnMU5xs/gfzj/V2nBvEQGx67VJRwfD5/fj0+1YPOmSR8M/NUe
aVNXfZ20YGiaunP9XrTnFtswFN+Th6GjLLIolF0NCJF3o/JAZr1rb4WeCGE2kA7HT/TzS7xD
0wU0X5fMUIEJ+dok+Y/xyJnSRZ0BS0I/u5ip4HK4n+tiVSE9GWx8dKBFi1y4sdN3HNOlwpjJ
o3lfrEqXv4kzjG4T+lvc9svQj9JVsEvMByoKMZgH1Q+bTmVpyF2Q6Oc3vtrqgMYmA2snE/+n
i0UvLa37OT40W9o7fP34rlNchM9v768fGH2JLKtY4fUNhPOcyMUE2L7Xmon7Y/T3mBhEEjrj
YCyegLqHhb000RsDDajxzzNLDn05wsJQxujCdaaSukD+Rq1tP7RB6BaWJ20H/pbselYFtx/S
AEwxKzmyGuQKQ/6Ts85A0WTULkgvj7jnh9zS6GukJhRfyP+j+eXjgrayfmRPALbOejSpX+Db
cgmzR4YLd0cM9Mlf+E1xiNeHrNgt/XV6k4gHgkbC5ijShN2uOBwlDOP7M0hx5+cWg9QkuR/0
4cbMvRgAi1caToEGDWcWbkP278qupbdtGAb/lR43YCi6HXbbwfWjCRrbaWzX3ckI2qAbhnUB
kgD7+eNHyraoh4eeWpi0JCt8i6S4l0zkdjCFiEymKHGPSLu0Y4kWWzYJEJIffrGjxjJyeNSa
FlM3m+42GtpkVjJERbbfhiSWO8P/nqMjPf1g9WaQsN3Xm5sbd0Mm3KhVrbCmnJKi8H+sCQsl
JKSbXLbSuoBTXDqYFuGYCOmszGDlVearMGe8x5A+ElBVl2VnypA9GpSu/Zw5Y5mSKVvd9wlk
iB/RFChoSFiFOYW2eEiybGono9NsZiZ3VOJKmk3IKSqQruo/x9OnKzT4vBxF/az2b6+2KYiL
s5HmUyubXz1GPWxnhWoFCP6ou/abRQZNXbTI1em2U4PvyC4DOKw6+uI2aULc0z+Q2iblndWq
OIylrEwRroJY/GrJ2CRd/HKBAraFpUMrUY+Eocae0+94zDcnNwVmdEkOu3mf527fGVdWk+gq
t/61R/hUS6d8OB1/viHBgXbh9+V8+Hugfw7n5+vr649WayXU7vG4fPOVuVvIjlHhJsVAhZ4A
dkkvQ1T0m4TjiwzGvriMsiNfsGvzp9xjIetOJM1aYfS+FwjJv7rXuaNmpr7JS+81XpjjWXIu
Yb71RZEBREWCeI+0gjz2NraXD7QW75zkRRHLoDoxJkLn7w05ie+ggnFAso7IhiW5UWwSO9eY
hSUD52dsR9OuDV2Fg11iBImfBaS3KKxlVaQ8MEtm/RIT6WV/3l/BNnpGHNnzqXSZm2GP0MPm
zn0i2c4q8MpKthqypE3gUKJPnNOZbnFtevyU3DoyE9fSilMOetMuaJsJJ6XW2a1NAMpbIgMC
t//EKANw510Lgupo7owfgMHuYBdrEulfPut5mQ4ic+YPdtH22EpKfa7Dsg/GcdrNLpP2zJkR
yGLFWVXY2EZAtUq/t3WIKytu4kcrtm+XANlNjt4y9I4chlUYZ4w8FA5nyADCSyXbcLTjiPk7
KCiY440GJnuVKr0fr6da+nFEyL13h1uWM74yu+lPi21r+jXcXvcLrKGMw9X0dvjJKBfEuaLr
U/OZB5bmmH6gwiOZWVkmaKnuN/c5/QhxiJZPvpJqVqBdHHhlw+261t2z2OCLqfKsK7dD6rR/
4RgJybcedcAhl4fmI3fmFk3yxMqbaF6t3w7PtYfTGfIYdkiKW8D2r1bjSs6tV94tJ9vzqoPV
sKFkfHmWP/HWeqJDoEx3kd4Lo0REsIybeHpNCLZlGMkKchZM8/Hx7IhyK713FrH8hggzeSXr
TbNJwo0zABTvMe7WMk6Z3OdjRU4ci5uDslyM4xTQyRGw+ogp5BEKr4orQA5AWj8awt+qOMSO
BAvODVuxuLy7jA0auSGuabBIil6avoST/wHYIyG6xIwBAA==

--82I3+IH0IqGh5yIs--
