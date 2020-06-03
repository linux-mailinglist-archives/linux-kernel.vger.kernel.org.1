Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19351EC5F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 01:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFBX5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 19:57:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:18169 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgFBX5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:57:20 -0400
IronPort-SDR: gzS6JhhMcZx851637LVXW+OJty791P92rUYVMqouFOqSqfh6r8mxBQENhlnML8rHBwtzADmgXv
 XaDl/Xz1durw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 16:56:49 -0700
IronPort-SDR: hBdDyEcNNqqHrL2wfr55ofUD2IiCS7QpHdsozN1LXllnfbKjfkRMUYPwYbXma20KEJwo/c4FjW
 eOfroIm7kQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="377921447"
Received: from lkp-server01.sh.intel.com (HELO e5a7ad696f24) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2020 16:56:43 -0700
Received: from kbuild by e5a7ad696f24 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgGlu-0000Fq-Id; Tue, 02 Jun 2020 23:56:42 +0000
Date:   Wed, 03 Jun 2020 07:55:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.06.01b] BUILD SUCCESS
 9c814827af953f2e109feef5272154c00a8f4541
Message-ID: <5ed6e706.ILUFYw6KGqPkZZRL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.06.01b
branch HEAD: 9c814827af953f2e109feef5272154c00a8f4541  refperf: Add test for RCU Tasks Trace readers.

i386-tinyconfig vmlinux size:

========================================================================================================================================
 TOTAL  TEXT  built-in.*  arch/x86/events/zhaoxin/built-in.*                                                                            
========================================================================================================================================
  -233  -233                                                  8747b07d1944 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                                  03e8e094dad9 Merge branch 'lkmm-dev.2020.05.16a' into HEAD                
     0     0                                                  17e0ee2a3ec9 torture:  Remove qemu dependency on EFI firmware             
     0     0                                                  c58148777978 torture: Add script to smoke-test commits in a branch        
   +38   +38                                                  396a79cc6818 fork: Annotate a data race in vm_area_dup()                  
     0     0                                                  8035e0fc710a x86/mm/pat: Mark an intentional data race                    
     0     0                                                  d7a51c24ee4b rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                                  e5efa2f1b7b6 locktorture: Use true and false to assign to bool variables  
     0     0                                                  7514d7f181ab srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                                  9dbd776542e3 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                                  df12d657bcc0 docs: RCU: Convert checklist.txt to ReST                     
     0     0                                                  fdfeb779e1bd docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                                  68b5951f7eb2 docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                                  ce9edc0c8a82 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                                  1bee818b03c7 docs: RCU: Convert torture.txt to ReST                       
     0     0                                                  9100131711bc docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                                  080f194cfa87 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                                  6999f47d8456 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                                  55ce2e8178f2 rcutorture: Add races with task-exit processing              
     0     0                                                  1c60a5e52538 torture: Set configfile variable to current scenario         
     0     0                                                  9969401f1706 rcutorture: Handle non-statistic bang-string error messages  
     0     0                                                  6f099e1b362b rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                                  6816417616c4 kcsan: Add test suite                                        
     0     0                                                  848d16e04f52 doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                                  2364a9f967ec rcu: Add callbacks-invoked counters                          
     0     0                                                  2775724beeef rcu: Add comment documenting rcu_callback_map's purpose      
     0     0     +138684                                      bfd78bca7bdf Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
    +1     0     -138684                                      8903088434e7 rcu/tree: Add better tracing for dyntick-idle                
    -1     0                                                  c0601bb42994 rcu/tree: Clean up dynticks counter usage                    
     0     0                                                  3f3baaf3ac07 rcu/tree: Remove dynticks_nmi_nesting counter                
    +1     0                                                  725e4ad9e020 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                                  a9b73fda34ec torture: Remove whitespace from identify_qemu_vcpus output   
    -1     0     +138684                                      6267bacdff81 torture: Add --allcpus argument to the kvm.sh script         
    +1     0     -138684                                      5c6aa32472cb rcu: Grace-period-kthread related sleeps to idle priority    
    -1     0     +138684                                      f334f4fee6e2 rcu: Priority-boost-related sleeps to idle priority          
     0     0           0                                      d49cb59f19b6 rcu: No-CBs-related sleeps to idle priority                  
    +1     0     -138684                                      4cc4ce9b67ec rcu: Expedited grace-period sleeps to idle priority          
    -1     0     +138684                                      cef0575caddb rcu-tasks: Convert sleeps to idle priority                   
     0     0           0                                      988aef3524e2 fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0     -138684                                      70ca490c7ab3 locking/osq_lock: Annotate a data race in osq_lock           
    +1     0                                                  80fa4f7b355d doc: Tasks RCU must protect instructions before trampoline   
    -1     0     +138684                                      1b397c884f7a doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq      
     0     0     -138684                                      dedad0a2118a tick/nohz: Narrow down noise while setting current task's ti 
     0     0     +138684                                      3055759634b2 rcu: fix some kernel-doc warnings                            
    +1     0     -138684                                      cf10e7d90417 rcu: Remove initialized but unused rnp from check_slow_task( 
    -1     0     +138684                                      af17eef88571 rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() n 
     0     0     -138684                                      55f712e9bd7b rcuperf: Remove useless while loops around wait_event        
     0     0                                                  751538451328 refperf: Add a test to measure performance of read-side sync 
     0     0                                                  8e4ee950aec1 rcuperf: Add comments explaining the high reader overhead    
     0     0                                                  c040f712e88e torture: Add refperf to the rcutorture scripting             
     0     0                                                  008a24414803 refperf: Add holdoff parameter to allow CPUs to come online  
     0     0                                                  dab324f75926 refperf: Hoist function-pointer calls out of the loop        
     0     0                                            +136  5574336c4be5 refperf: Allow decimal nanoseconds                           
     0     0                                               0  aeb173765756 refperf: Convert nreaders to a module parameter              
     0     0                                               0  dae3d17446a5 refperf: Provide module parameter to specify number of exper 
     0     0                                               0  a9390c56b7ae refperf: Dynamically allocate experiment-summary output buff 
     0     0                                               0  e927b546c872 refperf: Dynamically allocate thread-summary output buffer   
     0     0                                               0  95c9ce2c76af srcu: Avoid local_irq_save() before acquiring spinlock_t     
     0     0                                               0  7632b364c6c4 refperf: Make functions static                               
     0     0                                               0  42bb09b5dc6f refperf: Tune reader measurement interval                    
     0     0                                               0  cc8e6d748b0e refperf: Convert reader_task structure's "start" field to in 
     0     0                                               0  e4826529a741 refperf: More closely synchronize reader start times         
     0     0                                               0  6cd8f57628a1 rcuperf: Fix kfree_mult to match printk() format             
     0     0                                               0  3e7ad35e5240 refperf: Add warmup and cooldown processing phases           
     0     0                                               0  f37e98a2f76a refperf: Label experiment-number column "Runs"               
     0     0                                               0  1cb4d7f83ea9 refperf: Output per-experiment data points                   
     0     0                                               0  8762898c1a2f refperf: Simplify initialization-time wakeup protocol        
     0     0                                               0  34c77200c071 lockdep: Complain only once about RCU in extended quiescent  
     0     0                                               0  64e6613bef8b refperf: Add read-side delay module parameter                
     0     0                                               0  b47663597c1b rcu-tasks: Make rcu_tasks_postscan() be static               
     0     0                                               0  623dcb8f7f70 rcu-tasks: Add #include of rcupdate_trace.h to update.c      
     0     0                                               0  e5c48d7e7118 rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads( 
     0     0                                               0  9eef91d82769 refperf: Adjust refperf.loop default value                   
     0     0                                               0  043a9513b559 doc: Document rcuperf's module parameters                    
    -1     0                                               0  0dd4132157c2 refperf: Work around 64-bit division                         
     0     0                                            -136  5bc3e1437d21 refperf: Change readdelay module parameter to nanoseconds    
     0     0                                                  9c814827af95 refperf: Add test for RCU Tasks Trace readers.               
  -190  -189                                                  b1fcf9b83c41..9c814827af95 (ALL COMMITS)                                  
========================================================================================================================================

elapsed time: 485m

configs tested: 82
configs skipped: 4

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
powerpc                          alldefconfig
mips                        maltaup_defconfig
mips                        jmr3927_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
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
