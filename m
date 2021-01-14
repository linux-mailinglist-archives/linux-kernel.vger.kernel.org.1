Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571482F561F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbhANBmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:42:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:41684 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbhANBmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:42:04 -0500
IronPort-SDR: t7LzWjxzgGjXV9CzQYV5r5cbkF46WfGz3svUrj8pOlesL+4MdPTOizKJbmde9O6BwHRUHdABGM
 /Q4EePl9IIWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="174786268"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="174786268"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 17:39:41 -0800
IronPort-SDR: 0BkYX5jK0E3kilrf+IMgbL7cjkhVULdzerXkz0PKJysUlFZQPEMjzVCh5YZ8Ve1W+O/qQzp1nG
 v6aFRE5LnKkQ==
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="382080036"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 17:39:40 -0800
Subject: Re: [rcu:rcu/next] BUILD SUCCESS WITH WARNING
 f81f6edb74f27c5c8917d20a2bc128aca39aae11
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <5ffee678.hGIGL5g5dXHl2qP9%lkp@intel.com>
 <20210113151417.GT2743@paulmck-ThinkPad-P72>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <2277b94b-e705-c1d3-6d6f-8a877f08c330@intel.com>
Date:   Thu, 14 Jan 2021 09:38:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210113151417.GT2743@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/21 11:14 PM, Paul E. McKenney wrote:
> On Wed, Jan 13, 2021 at 08:24:24PM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
>> branch HEAD: f81f6edb74f27c5c8917d20a2bc128aca39aae11  rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()
>>
>> Warning ids grouped by kconfigs:
>>
>> gcc_recent_errors
>> |-- h8300-randconfig-c003-20210112
>> |   `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line
>> |-- i386-randconfig-c001-20210112
>> |   `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line
>> `-- powerpc-randconfig-c004-20210112
>>      `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line
> OK, I will bite...  At which line?
>
> 							Thanx, Paul

Hi Paul,

It's a coccinelle warning, it seems Julia Lawall didn't forward it to you,
it maybe not a real problem.

https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/message/ZN45D2QHCG5W4KMOGVBLUCUOKH32LFHE/

Best Regards,
Rong Chen

>
>> elapsed time: 722m
>>
>> configs tested: 164
>> configs skipped: 2
>>
>> gcc tested configs:
>> arm                                 defconfig
>> arm64                            allyesconfig
>> arm64                               defconfig
>> arm                              allyesconfig
>> arm                              allmodconfig
>> arm                         shannon_defconfig
>> powerpc                       maple_defconfig
>> arm                              zx_defconfig
>> mips                            e55_defconfig
>> arm                       spear13xx_defconfig
>> arm                  colibri_pxa300_defconfig
>> sh                           se7206_defconfig
>> arc                 nsimosci_hs_smp_defconfig
>> powerpc                   lite5200b_defconfig
>> sh                  sh7785lcr_32bit_defconfig
>> mips                       lemote2f_defconfig
>> sh                      rts7751r2d1_defconfig
>> m68k                        m5272c3_defconfig
>> sh                            migor_defconfig
>> powerpc                        icon_defconfig
>> sh                               alldefconfig
>> mips                     cu1000-neo_defconfig
>> arm                       cns3420vb_defconfig
>> mips                 decstation_r4k_defconfig
>> arm                           corgi_defconfig
>> arm                     eseries_pxa_defconfig
>> ia64                          tiger_defconfig
>> powerpc                      pasemi_defconfig
>> mips                         bigsur_defconfig
>> mips                       rbtx49xx_defconfig
>> c6x                              alldefconfig
>> mips                     decstation_defconfig
>> sh                   sh7770_generic_defconfig
>> arm                            hisi_defconfig
>> c6x                        evmc6472_defconfig
>> microblaze                          defconfig
>> xtensa                  cadence_csp_defconfig
>> powerpc                    mvme5100_defconfig
>> m68k                         amcore_defconfig
>> mips                        bcm47xx_defconfig
>> mips                        workpad_defconfig
>> h8300                     edosk2674_defconfig
>> powerpc                 mpc8313_rdb_defconfig
>> mips                           xway_defconfig
>> arc                           tb10x_defconfig
>> sh                           se7721_defconfig
>> arm                         axm55xx_defconfig
>> m68k                            q40_defconfig
>> arm                        mini2440_defconfig
>> powerpc                     tqm8560_defconfig
>> sh                         ecovec24_defconfig
>> c6x                        evmc6457_defconfig
>> arm                        mvebu_v7_defconfig
>> mips                      pistachio_defconfig
>> m68k                          multi_defconfig
>> s390                       zfcpdump_defconfig
>> xtensa                    smp_lx200_defconfig
>> h8300                    h8300h-sim_defconfig
>> arm                       multi_v4t_defconfig
>> arm                     davinci_all_defconfig
>> sh                          r7780mp_defconfig
>> arm                        keystone_defconfig
>> ia64                            zx1_defconfig
>> mips                      maltaaprp_defconfig
>> sh                           se7724_defconfig
>> sh                          urquell_defconfig
>> sparc                            alldefconfig
>> arm                        multi_v5_defconfig
>> powerpc                      pmac32_defconfig
>> powerpc                     ksi8560_defconfig
>> powerpc                    amigaone_defconfig
>> arc                     haps_hs_smp_defconfig
>> csky                                defconfig
>> um                            kunit_defconfig
>> powerpc                 mpc832x_rdb_defconfig
>> powerpc                      mgcoge_defconfig
>> ia64                        generic_defconfig
>> powerpc                      bamboo_defconfig
>> arm                      pxa255-idp_defconfig
>> sh                           se7705_defconfig
>> parisc                              defconfig
>> m68k                        m5407c3_defconfig
>> m68k                          atari_defconfig
>> powerpc                 mpc832x_mds_defconfig
>> powerpc                        fsp2_defconfig
>> m68k                       m5275evb_defconfig
>> powerpc                      ppc44x_defconfig
>> arm                            qcom_defconfig
>> sh                ecovec24-romimage_defconfig
>> arm                          tango4_defconfig
>> mips                          ath25_defconfig
>> sh                           sh2007_defconfig
>> arm                         socfpga_defconfig
>> m68k                       m5249evb_defconfig
>> mips                  decstation_64_defconfig
>> ia64                             allmodconfig
>> ia64                                defconfig
>> ia64                             allyesconfig
>> m68k                             allmodconfig
>> m68k                                defconfig
>> m68k                             allyesconfig
>> nios2                               defconfig
>> arc                              allyesconfig
>> nds32                             allnoconfig
>> c6x                              allyesconfig
>> nds32                               defconfig
>> nios2                            allyesconfig
>> alpha                               defconfig
>> alpha                            allyesconfig
>> xtensa                           allyesconfig
>> h8300                            allyesconfig
>> arc                                 defconfig
>> sh                               allmodconfig
>> s390                             allyesconfig
>> parisc                           allyesconfig
>> s390                                defconfig
>> i386                             allyesconfig
>> sparc                            allyesconfig
>> sparc                               defconfig
>> i386                               tinyconfig
>> i386                                defconfig
>> mips                             allyesconfig
>> mips                             allmodconfig
>> powerpc                          allyesconfig
>> powerpc                          allmodconfig
>> powerpc                           allnoconfig
>> x86_64               randconfig-a006-20210113
>> x86_64               randconfig-a004-20210113
>> x86_64               randconfig-a001-20210113
>> x86_64               randconfig-a005-20210113
>> x86_64               randconfig-a003-20210113
>> x86_64               randconfig-a002-20210113
>> i386                 randconfig-a002-20210113
>> i386                 randconfig-a005-20210113
>> i386                 randconfig-a006-20210113
>> i386                 randconfig-a003-20210113
>> i386                 randconfig-a001-20210113
>> i386                 randconfig-a004-20210113
>> i386                 randconfig-a012-20210113
>> i386                 randconfig-a011-20210113
>> i386                 randconfig-a016-20210113
>> i386                 randconfig-a013-20210113
>> i386                 randconfig-a015-20210113
>> i386                 randconfig-a014-20210113
>> riscv                    nommu_k210_defconfig
>> riscv                            allyesconfig
>> riscv                    nommu_virt_defconfig
>> riscv                             allnoconfig
>> riscv                               defconfig
>> riscv                          rv32_defconfig
>> riscv                            allmodconfig
>> x86_64                                   rhel
>> x86_64                           allyesconfig
>> x86_64                    rhel-7.6-kselftests
>> x86_64                              defconfig
>> x86_64                               rhel-8.3
>> x86_64                      rhel-8.3-kbuiltin
>> x86_64                                  kexec
>>
>> clang tested configs:
>> x86_64               randconfig-a015-20210113
>> x86_64               randconfig-a012-20210113
>> x86_64               randconfig-a013-20210113
>> x86_64               randconfig-a016-20210113
>> x86_64               randconfig-a014-20210113
>> x86_64               randconfig-a011-20210113
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

