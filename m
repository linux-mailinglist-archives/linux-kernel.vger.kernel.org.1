Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97F1CC5BF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 02:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgEJAaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 20:30:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:36672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgEJAaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:30:00 -0400
IronPort-SDR: fKUt2RLY03bS3LykbRas6POfwYpIjMHrU9HlNsPw0yqwH1XIfNoU5nqNBElHttdLYz+J2cI2EQ
 PPSiEMfoTBig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 17:29:51 -0700
IronPort-SDR: L59clIrkYkYF9MiPQwGmcKXRSWHNxjIN1RDRvb0NZh68u0GeVSENVbQ0+NLuds2b0rtTJiax6Y
 bFCRQLbRa+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,373,1583222400"; 
   d="scan'208";a="261378133"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 May 2020 17:29:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jXZqn-000223-KE; Sun, 10 May 2020 08:29:49 +0800
Date:   Sun, 10 May 2020 08:29:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 373b78add5ef0c6fd1154304208252dbf0309114
Message-ID: <5eb74ae8.DCzYxKGUl1CZmvjd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 373b78add5ef0c6fd1154304208252dbf0309114  fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls

i386-tinyconfig vmlinux size:

==============================================================================================================================================================
 TOTAL  TEXT  arch/x86/events/zhaoxin/built-in.*  try_invoke_on_locked_down_task()                                                                            
==============================================================================================================================================================
    +1     0                                                                        353159365e72 rcu: Add KCSAN stubs                                         
     0     0                                                                        4f58820fd710 srcu: Add KCSAN stubs                                        
     0     0                                                                        2f0846956355 rcu: Mark rcu_state.ncpus to detect concurrent writes        
     0     0                                                                        314eeb43e5f2 rcu: Add *_ONCE() and data_race() to rcu_node ->exp_tasks pl 
     0     0                                                                        065a6db12a80 rcu: Add READ_ONCE and data_race() to rcu_node ->boost_tasks 
     0     0                                                                        b68c6146512d srcu: Add data_race() to ->srcu_lock_count and ->srcu_unlock 
     0     0                                                                        5822b8126ff0 rcu: Add WRITE_ONCE() to rcu_node ->boost_tasks              
     0     0                                                                        47fbb074536e rcu: Use data_race() for RCU CPU stall-warning prints        
     0     0                                                                        53965dbe5396 drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compile 
     0     0                                                                        1fca4d12f463 rcu: Expedite first two FQS scans under callback-overload co 
     0     0                                                                        fcbcc0e70050 rcu: Fix the (t=0 jiffies) false positive                    
     0     0                                                                        ddc465936643 Revert "rculist: Describe variadic macro argument in a Sphin 
     0     0                                                                        c28d5c09d09f rcu: Get rid of some doc warnings in update.c                
     0     0                                                                        62ae19511f1e rcu: Mark rcu_state.gp_seq to detect more concurrent writes  
     0     0                                                                        a66dbda7893f rcu: Replace assigned pointer ret value by corresponding boo 
     0     0                                                                        da44cd6c8e88 rcu: Replace 1 by true                                       
     0     0                                                                        29ffebc5fcc0 rcu: Convert ULONG_CMP_GE() to time_after() for jiffy compar 
     0     0                                                                        7b2413111a63 rcu: Convert rcu_initiate_boost() ULONG_CMP_GE() to time_aft 
     0     0                                                                        e2f3ccfa6200 rcu: Convert rcu_nohz_full_cpu() ULONG_CMP_LT() to time_befo 
   +83   +84                                +136                               +83  f736e0f1a55a Merge branches 'fixes.2020.04.27a', 'kfree_rcu.2020.04.27a', 
  -224  -224                                   0                                 0  2d9d829af55c Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                   0                                 0  99a5d03ba959 Merge branch 'lkmm-dev.2020.04.15b' into HEAD                
   +38   +38                                   0                                 0  3123dcd3ef7f fork: Annotate a data race in vm_area_dup()                  
     0     0                                   0                                 0  2ba74f25e0de x86/mm/pat: Mark an intentional data race                    
     0     0                                   0                                 0  cd59625dedde rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                   0                                 0  ca6e49239a17 locktorture: Use true and false to assign to bool variables  
     0     0                                   0                                 0  8c8786cd0247 srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                   0                                 0  a1efc70e9d85 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                   0                                 0  cbabe740e82b docs: RCU: Convert checklist.txt to ReST                     
     0     0                                   0                                 0  e5f9b70676b4 docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                   0                                 0  42c88c9aafad docs: RCU: Convert lockdep.txt to ReST                       
    +1     0                                   0                                 0  aa2b2ecfd164 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                   0                                 0  82eaa2457d7d docs: RCU: Convert torture.txt to ReST                       
     0     0                                   0                                 0  f97ed6bd52ac docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                   0                                 0  8e8a20116e5b docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                   0                                 0  47fc317ece46 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                   0                                 0  9e35d2f33d28 rcutorture: Add races with task-exit processing              
     0     0                                   0                                 0  6e9aecb52ba2 torture: Set configfile variable to current scenario         
     0     0                                   0                                 0  b4ec09e9e3e5 rcutorture: Handle non-statistic bang-string error messages  
     0     0                                   0                                 0  6662e542deb6 rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                   0                                 0  8d6d79f04175 kcsan: Add test suite                                        
     0     0                                   0                                 0  acb3d83582b6 torture:  Remove qemu dependency on EFI firmware             
     0     0                                   0                                 0  21436552afda doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                   0                                 0  b68cb7adad51 rcu: Add callbacks-invoked counters                          
     0     0                                   0                                 0  aef9d8641be8 rcu: Add comment documenting rcu_callback_map's purpose      
     0     0                                   0                                 0  7962e78b46c0 Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0                                   0                                 0  e4c6a5a6a7cd rcu/tree: Add better tracing for dyntick-idle                
     0     0                                   0                                 0  934552d9be4e rcu/tree: Clean up dynticks counter usage                    
     0     0                                   0                                 0  2ff23aee42e9 rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0                                   0                                 0  e32c9b0b3c4c trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                   0                                 0  3ff7cf6d6d90 torture: Add script to smoke-test commits in a branch        
     0     0                                   0                                 0  625810c1f564 torture: Remove whitespace from identify_qemu_vcpus output   
     0     0                                   0                                 0  c1fe153b2a01 torture: Add --allcpus argument to the kvm.sh script         
     0     0                                   0                                 0  d13fee049fa8 Default enable RCU list lockdep debugging with PROVE_RCU     
     0     0                                   0                                 0  3d9e98763d85 rcu: Grace-period-kthread related sleeps to idle priority    
     0     0                                   0                                 0  91f877ab4b94 rcu: Priority-boost-related sleeps to idle priority          
     0     0                                   0                                 0  41e5297889d5 rcu: No-CBs-related sleeps to idle priority                  
     0     0                                   0                                 0  b06eee6cfc49 rcu: Expedited grace-period sleeps to idle priority          
     0     0                                   0                                 0  825613e73129 rcu-tasks: Convert sleeps to idle priority                   
     0     0                                   0                                 0  373b78add5ef fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
   -92   -93                                +136                               +83  ae83d0b416db..373b78add5ef (ALL COMMITS)                                  
==============================================================================================================================================================

elapsed time: 483m

configs tested: 104
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200510
i386                 randconfig-a005-20200510
i386                 randconfig-a003-20200510
i386                 randconfig-a001-20200510
i386                 randconfig-a004-20200510
i386                 randconfig-a002-20200510
x86_64               randconfig-a015-20200509
x86_64               randconfig-a014-20200509
x86_64               randconfig-a011-20200509
x86_64               randconfig-a013-20200509
x86_64               randconfig-a012-20200509
x86_64               randconfig-a016-20200509
x86_64               randconfig-a016-20200510
x86_64               randconfig-a012-20200510
x86_64               randconfig-a015-20200510
x86_64               randconfig-a013-20200510
x86_64               randconfig-a014-20200510
x86_64               randconfig-a011-20200510
i386                 randconfig-a012-20200510
i386                 randconfig-a016-20200510
i386                 randconfig-a014-20200510
i386                 randconfig-a011-20200510
i386                 randconfig-a013-20200510
i386                 randconfig-a015-20200510
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
sparc64                             defconfig
sparc64                          allyesconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
