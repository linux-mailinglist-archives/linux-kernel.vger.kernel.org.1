Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB32A278A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgKBJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:56:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:16223 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgKBJ4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:56:07 -0500
IronPort-SDR: grDGWWhcVMS3rGLrHTS4gecCUjgfHBtGpvcqbpoNZWkXu/EsEvu6d2OvwXxGYQINlIWvgBeTk2
 9eV7CgTmLUcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="165356670"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="xz'?yaml'?scan'208";a="165356670"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 01:56:02 -0800
IronPort-SDR: /ftunJvgOshS8mEs/IR9HaoVd+L8M1rbLTXyRw6ieshk6ke4m43RppuZOivySQmOlimbT8U0mG
 Y2fddvg3kCWQ==
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="xz'?yaml'?scan'208";a="537957423"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 01:55:58 -0800
Date:   Mon, 2 Nov 2020 17:55:08 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, lkp@lists.01.org,
        lkp@intel.com
Subject: [xfs] 79da637e32:
 kmsg.XFS(sda5):Internal_error_cur->bc_nlevels==#at_line#of_file_fs/xfs/libxfs/xfs_btree.c.Caller_xfs_btree_lookup[xfs]
Message-ID: <20201102095508.GN31092@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XLWMkxR+mZNQ4WTO"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 79da637e3252ae12dc67971a454f622370982f25 ("xfs: repair inode block maps")
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git widen-efi-and-bui-formats


in testcase: xfstests
version: xfstests-x86_64-d41dcbd-1_20201027
with following parameters:

	disk: 4HDD
	fs: xfs
	test: xfs-group14
	ucode: 0x21

test-description: xfstests is a regression test suite for xfs and other files ystems.
test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git


on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


user  :warn  : [   76.203986] run fstests xfs/262 at 2019-02-14 10:12:51
kern  :notice: [   78.130609] XFS (sda5): Mounting V5 Filesystem
kern  :info  : [   78.263102] XFS (sda5): Ending clean mount
kern  :warn  : [   78.357528] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
kern  :warn  : [   78.808229] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :warn  : [   78.861416] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :alert : [   78.872359] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :warn  : [   78.882188] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :warn  : [   78.882681] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :warn  : [   78.882725] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :warn  : [   78.882764] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :alert : [   78.882766] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :warn  : [   78.882784] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :alert : [   78.882785] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :warn  : [   78.882796] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :alert : [   78.882797] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :alert : [   78.893678] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :warn  : [   78.905185] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :warn  : [   78.916916] XFS (sda5): Injecting error (false) at file fs/xfs/scrub/scrub.c, line 544, on filesystem "sda5"
kern  :alert : [   78.922165] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :alert : [   78.922178] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :alert : [   78.922194] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :alert : [   78.928332] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :alert : [   78.928369] XFS (sda5): Corruption not fixed during online repair.  Unmount and run xfs_repair.
kern  :alert : [   79.060921] XFS (sda5): Internal error cur->bc_nlevels == 0 at line 1826 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.075480] CPU: 1 PID: 5039 Comm: xfs_scrub Not tainted 5.10.0-rc1-00023-g79da637e3252 #1
kern  :warn  : [   79.084785] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [   79.093547] Call Trace:
kern  :warn  : [   79.096975]  dump_stack+0x57/0x6a
kern  :warn  : [   79.101305]  xfs_corruption_error+0x85/0xa0 [xfs]
kern  :warn  : [   79.107043]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.112741]  xfs_btree_lookup+0x340/0x4a0 [xfs]
kern  :warn  : [   79.118297]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.123995]  ? kmem_cache_alloc+0x35a/0x460
kern  :warn  : [   79.129168]  ? xfs_buf_item_init+0x1ad/0x240 [xfs]
kern  :warn  : [   79.134970]  ? xfs_trans_add_item+0x6b/0x180 [xfs]
kern  :warn  : [   79.140743]  ? xfs_rmap_btrec_to_irec+0x80/0x80 [xfs]
kern  :warn  : [   79.146823]  xfs_btree_simple_query_range+0x69/0x200 [xfs]
kern  :warn  : [   79.153341]  ? xfs_trans_read_buf_map+0x228/0x480 [xfs]
kern  :warn  : [   79.159575]  xfs_btree_query_all+0xa5/0xc0 [xfs]
kern  :warn  : [   79.165209]  xfs_rmap_query_all+0x31/0x60 [xfs]
kern  :warn  : [   79.170736]  ? xrep_bmap_from_rmap+0x140/0x140 [xfs]
kern  :warn  : [   79.176674]  xrep_bmap_scan_ag+0x81/0xe0 [xfs]
kern  :warn  : [   79.182096]  xrep_bmap_find_mappings+0x38/0x60 [xfs]
kern  :warn  : [   79.188029]  xrep_bmap+0x87/0x100 [xfs]
kern  :warn  : [   79.192851]  xrep_attempt+0x36/0x160 [xfs]
kern  :warn  : [   79.197892]  xfs_scrub_metadata+0x2c0/0x4c0 [xfs]
kern  :warn  : [   79.203552]  xfs_ioc_scrub_metadata+0x50/0xa0 [xfs]
kern  :warn  : [   79.209413]  xfs_file_ioctl+0x9cc/0xc00 [xfs]
kern  :warn  : [   79.214699]  ? __generic_file_write_iter+0xf9/0x1e0
kern  :warn  : [   79.220490]  ? generic_file_write_iter+0x68/0xc0
kern  :warn  : [   79.226019]  ? new_sync_write+0x11f/0x1c0
kern  :warn  : [   79.230935]  ? vfs_write+0x187/0x260
kern  :warn  : [   79.235399]  __x64_sys_ioctl+0x83/0xc0
kern  :warn  : [   79.240022]  do_syscall_64+0x33/0x40
kern  :warn  : [   79.244477]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kern  :warn  : [   79.250434] RIP: 0033:0x7f23d106f427
kern  :warn  : [   79.254889] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
kern  :warn  : [   79.275621] RSP: 002b:00007f23cf44b448 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
kern  :warn  : [   79.284224] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f23d106f427
kern  :warn  : [   79.292365] RDX: 00007f23cf44b450 RSI: 00000000c040583c RDI: 0000000000000004
kern  :warn  : [   79.300460] RBP: 0000000080000001 R08: 0000000000000000 R09: 00007f23cf44e700
kern  :warn  : [   79.308587] R10: 000000000000000a R11: 0000000000000246 R12: 00007ffe31779340
kern  :warn  : [   79.316705] R13: 0000000000000004 R14: 0000000000000002 R15: 00007f23cf44b450
kern  :alert : [   79.324836] XFS (sda5): Corruption detected. Unmount and run xfs_repair
kern  :alert : [   79.332600] XFS (sda5): Internal error cur->bc_nlevels == 0 at line 1826 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.347148] CPU: 0 PID: 5039 Comm: xfs_scrub Not tainted 5.10.0-rc1-00023-g79da637e3252 #1
kern  :warn  : [   79.356485] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [   79.365213] Call Trace:
kern  :warn  : [   79.368619]  dump_stack+0x57/0x6a
kern  :warn  : [   79.372917]  xfs_corruption_error+0x85/0xa0 [xfs]
kern  :warn  : [   79.378608]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.384306]  xfs_btree_lookup+0x340/0x4a0 [xfs]
kern  :warn  : [   79.389872]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.395567]  ? kmem_cache_alloc+0x35a/0x460
kern  :warn  : [   79.400735]  ? xfs_buf_item_init+0x1ad/0x240 [xfs]
kern  :warn  : [   79.406517]  ? xfs_trans_add_item+0x6b/0x180 [xfs]
kern  :warn  : [   79.412260]  ? xfs_rmap_btrec_to_irec+0x80/0x80 [xfs]
kern  :warn  : [   79.418295]  xfs_btree_simple_query_range+0x69/0x200 [xfs]
kern  :warn  : [   79.424782]  ? xfs_trans_read_buf_map+0x228/0x480 [xfs]
kern  :warn  : [   79.430972]  xfs_btree_query_all+0xa5/0xc0 [xfs]
kern  :warn  : [   79.436595]  xfs_rmap_query_all+0x31/0x60 [xfs]
kern  :warn  : [   79.442080]  ? xrep_bmap_from_rmap+0x140/0x140 [xfs]
kern  :warn  : [   79.448015]  xrep_bmap_scan_ag+0x81/0xe0 [xfs]
kern  :warn  : [   79.453449]  xrep_bmap_find_mappings+0x38/0x60 [xfs]
kern  :warn  : [   79.459408]  xrep_bmap+0x87/0x100 [xfs]
kern  :warn  : [   79.464213]  xrep_attempt+0x36/0x160 [xfs]
kern  :warn  : [   79.469328]  xfs_scrub_metadata+0x2c0/0x4c0 [xfs]
kern  :warn  : [   79.475001]  xfs_ioc_scrub_metadata+0x50/0xa0 [xfs]
kern  :warn  : [   79.480857]  xfs_file_ioctl+0x9cc/0xc00 [xfs]
kern  :warn  : [   79.486092]  ? __generic_file_write_iter+0xf9/0x1e0
kern  :warn  : [   79.491876]  ? generic_file_write_iter+0x68/0xc0
kern  :warn  : [   79.497407]  ? new_sync_write+0x11f/0x1c0
kern  :warn  : [   79.502338]  ? vfs_write+0x187/0x260
kern  :warn  : [   79.506803]  __x64_sys_ioctl+0x83/0xc0
kern  :warn  : [   79.511450]  do_syscall_64+0x33/0x40
kern  :warn  : [   79.515927]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kern  :warn  : [   79.521877] RIP: 0033:0x7f23d106f427
kern  :warn  : [   79.526332] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
kern  :warn  : [   79.547097] RSP: 002b:00007f23cf44b448 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
kern  :warn  : [   79.555732] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f23d106f427
kern  :warn  : [   79.563915] RDX: 00007f23cf44b450 RSI: 00000000c040583c RDI: 0000000000000004
kern  :warn  : [   79.572045] RBP: 0000000080000001 R08: 0000000000000000 R09: 00007f23cf44e700
kern  :warn  : [   79.580215] R10: 000000000000000a R11: 0000000000000246 R12: 00007ffe31779340
kern  :warn  : [   79.588379] R13: 0000000000000004 R14: 0000000000000002 R15: 00007f23cf44b450
kern  :alert : [   79.596555] XFS (sda5): Corruption detected. Unmount and run xfs_repair
kern  :alert : [   79.604394] XFS (sda5): Internal error cur->bc_nlevels == 0 at line 1826 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.618961] CPU: 2 PID: 5039 Comm: xfs_scrub Not tainted 5.10.0-rc1-00023-g79da637e3252 #1
kern  :warn  : [   79.628267] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [   79.637130] Call Trace:
kern  :warn  : [   79.640578]  dump_stack+0x57/0x6a
kern  :warn  : [   79.644930]  xfs_corruption_error+0x85/0xa0 [xfs]
kern  :warn  : [   79.650710]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.656464]  xfs_btree_lookup+0x340/0x4a0 [xfs]
kern  :warn  : [   79.662038]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.667768]  ? kmem_cache_alloc+0x35a/0x460
kern  :warn  : [   79.672974]  ? xfs_buf_item_init+0x1ad/0x240 [xfs]
kern  :warn  : [   79.678801]  ? xfs_trans_add_item+0x6b/0x180 [xfs]
kern  :warn  : [   79.684606]  ? xfs_rmap_btrec_to_irec+0x80/0x80 [xfs]
kern  :warn  : [   79.690681]  xfs_btree_simple_query_range+0x69/0x200 [xfs]
kern  :warn  : [   79.697230]  ? xfs_trans_read_buf_map+0x228/0x480 [xfs]
kern  :warn  : [   79.703402]  xfs_btree_query_all+0xa5/0xc0 [xfs]
kern  :warn  : [   79.709039]  xfs_rmap_query_all+0x31/0x60 [xfs]
kern  :warn  : [   79.714498]  ? xrep_bmap_from_rmap+0x140/0x140 [xfs]
kern  :warn  : [   79.720453]  xrep_bmap_scan_ag+0x81/0xe0 [xfs]
kern  :warn  : [   79.725862]  xrep_bmap_find_mappings+0x38/0x60 [xfs]
kern  :warn  : [   79.731791]  xrep_bmap+0x87/0x100 [xfs]
kern  :warn  : [   79.736593]  xrep_attempt+0x36/0x160 [xfs]
kern  :warn  : [   79.741619]  xfs_scrub_metadata+0x2c0/0x4c0 [xfs]
kern  :warn  : [   79.747210]  xfs_ioc_scrub_metadata+0x50/0xa0 [xfs]
kern  :warn  : [   79.752974]  xfs_file_ioctl+0x9cc/0xc00 [xfs]
kern  :warn  : [   79.758164]  ? __generic_file_write_iter+0xf9/0x1e0
kern  :warn  : [   79.763935]  ? generic_file_write_iter+0x68/0xc0
kern  :warn  : [   79.769415]  ? new_sync_write+0x11f/0x1c0
kern  :warn  : [   79.774283]  ? vfs_write+0x187/0x260
kern  :warn  : [   79.778717]  __x64_sys_ioctl+0x83/0xc0
kern  :warn  : [   79.783330]  do_syscall_64+0x33/0x40
kern  :warn  : [   79.787732]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kern  :warn  : [   79.793653] RIP: 0033:0x7f23d106f427
kern  :warn  : [   79.798101] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
kern  :warn  : [   79.818868] RSP: 002b:00007f23cf44b448 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
kern  :warn  : [   79.827474] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f23d106f427
kern  :warn  : [   79.835564] RDX: 00007f23cf44b450 RSI: 00000000c040583c RDI: 0000000000000004
kern  :warn  : [   79.843710] RBP: 0000000080000001 R08: 0000000000000000 R09: 00007f23cf44e700
kern  :warn  : [   79.851792] R10: 000000000000000a R11: 0000000000000246 R12: 00007ffe31779340
kern  :warn  : [   79.859885] R13: 0000000000000004 R14: 0000000000000002 R15: 00007f23cf44b450
kern  :alert : [   79.868043] XFS (sda5): Corruption detected. Unmount and run xfs_repair
kern  :alert : [   79.875796] XFS (sda5): Internal error cur->bc_nlevels == 0 at line 1826 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.890404] CPU: 0 PID: 5039 Comm: xfs_scrub Not tainted 5.10.0-rc1-00023-g79da637e3252 #1
kern  :warn  : [   79.899770] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [   79.908610] Call Trace:
kern  :warn  : [   79.912117]  dump_stack+0x57/0x6a
kern  :warn  : [   79.916511]  xfs_corruption_error+0x85/0xa0 [xfs]
kern  :warn  : [   79.922309]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.928100]  xfs_btree_lookup+0x340/0x4a0 [xfs]
kern  :warn  : [   79.933714]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   79.939480]  ? kmem_cache_alloc+0x35a/0x460
kern  :warn  : [   79.944744]  ? xfs_buf_item_init+0x1ad/0x240 [xfs]
kern  :warn  : [   79.950619]  ? xfs_trans_add_item+0x6b/0x180 [xfs]
kern  :warn  : [   79.956522]  ? xfs_rmap_btrec_to_irec+0x80/0x80 [xfs]
kern  :warn  : [   79.962669]  xfs_btree_simple_query_range+0x69/0x200 [xfs]
kern  :warn  : [   79.969150]  ? xfs_trans_read_buf_map+0x228/0x480 [xfs]
kern  :warn  : [   79.975393]  xfs_btree_query_all+0xa5/0xc0 [xfs]
kern  :warn  : [   79.981011]  xfs_rmap_query_all+0x31/0x60 [xfs]
kern  :warn  : [   79.986572]  ? xrep_bmap_from_rmap+0x140/0x140 [xfs]
kern  :warn  : [   79.992555]  xrep_bmap_scan_ag+0x81/0xe0 [xfs]
kern  :warn  : [   79.997995]  xrep_bmap_find_mappings+0x38/0x60 [xfs]
kern  :warn  : [   80.003958]  xrep_bmap+0x87/0x100 [xfs]
kern  :warn  : [   80.008810]  xrep_attempt+0x36/0x160 [xfs]
kern  :warn  : [   80.013888]  xfs_scrub_metadata+0x2c0/0x4c0 [xfs]
kern  :warn  : [   80.019538]  xfs_ioc_scrub_metadata+0x50/0xa0 [xfs]
kern  :warn  : [   80.025345]  xfs_file_ioctl+0x9cc/0xc00 [xfs]
kern  :warn  : [   80.030621]  ? __generic_file_write_iter+0xf9/0x1e0
kern  :warn  : [   80.036398]  ? generic_file_write_iter+0x68/0xc0
kern  :warn  : [   80.041926]  ? new_sync_write+0x11f/0x1c0
kern  :warn  : [   80.046836]  ? vfs_write+0x187/0x260
kern  :warn  : [   80.051299]  __x64_sys_ioctl+0x83/0xc0
kern  :warn  : [   80.055951]  do_syscall_64+0x33/0x40
kern  :warn  : [   80.060396]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kern  :warn  : [   80.066372] RIP: 0033:0x7f23d106f427
kern  :warn  : [   80.070845] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
kern  :warn  : [   80.091609] RSP: 002b:00007f23cf44b448 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
kern  :warn  : [   80.100197] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f23d106f427
kern  :warn  : [   80.108356] RDX: 00007f23cf44b450 RSI: 00000000c040583c RDI: 0000000000000004
kern  :warn  : [   80.116534] RBP: 0000000080000001 R08: 0000000000000000 R09: 00007f23cf44e700
kern  :warn  : [   80.124731] R10: 000000000000000a R11: 0000000000000246 R12: 00007ffe31779340
kern  :warn  : [   80.132895] R13: 0000000000000004 R14: 0000000000000002 R15: 00007f23cf44b450
kern  :alert : [   80.141073] XFS (sda5): Corruption detected. Unmount and run xfs_repair
kern  :alert : [   80.148894] XFS (sda5): Internal error cur->bc_nlevels == 0 at line 1826 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   80.163445] CPU: 1 PID: 5039 Comm: xfs_scrub Not tainted 5.10.0-rc1-00023-g79da637e3252 #1
kern  :warn  : [   80.172775] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [   80.181568] Call Trace:
kern  :warn  : [   80.185031]  dump_stack+0x57/0x6a
kern  :warn  : [   80.189375]  xfs_corruption_error+0x85/0xa0 [xfs]
kern  :warn  : [   80.195121]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   80.200919]  xfs_btree_lookup+0x340/0x4a0 [xfs]
kern  :warn  : [   80.206498]  ? xfs_btree_lookup+0x315/0x4a0 [xfs]
kern  :warn  : [   80.212233]  ? kmem_cache_alloc+0x35a/0x460
kern  :warn  : [   80.217439]  ? xfs_buf_item_init+0x1ad/0x240 [xfs]
kern  :warn  : [   80.223268]  ? xfs_trans_add_item+0x6b/0x180 [xfs]
kern  :warn  : [   80.229131]  ? xfs_rmap_btrec_to_irec+0x80/0x80 [xfs]
kern  :warn  : [   80.235184]  xfs_btree_simple_query_range+0x69/0x200 [xfs]
kern  :warn  : [   80.241628]  ? xfs_trans_read_buf_map+0x228/0x480 [xfs]
kern  :warn  : [   80.247802]  xfs_btree_query_all+0xa5/0xc0 [xfs]
kern  :warn  : [   80.253373]  xfs_rmap_query_all+0x31/0x60 [xfs]
kern  :warn  : [   80.258886]  ? xrep_bmap_from_rmap+0x140/0x140 [xfs]
kern  :warn  : [   80.264824]  xrep_bmap_scan_ag+0x81/0xe0 [xfs]
kern  :warn  : [   80.270239]  xrep_bmap_find_mappings+0x38/0x60 [xfs]
kern  :warn  : [   80.276144]  xrep_bmap+0x87/0x100 [xfs]
kern  :warn  : [   80.280947]  xrep_attempt+0x36/0x160 [xfs]
kern  :warn  : [   80.285986]  xfs_scrub_metadata+0x2c0/0x4c0 [xfs]
kern  :warn  : [   80.291605]  xfs_ioc_scrub_metadata+0x50/0xa0 [xfs]
kern  :warn  : [   80.297427]  xfs_file_ioctl+0x9cc/0xc00 [xfs]
kern  :warn  : [   80.302655]  ? __generic_file_write_iter+0xf9/0x1e0
kern  :warn  : [   80.308387]  ? generic_file_write_iter+0x68/0xc0
kern  :warn  : [   80.313845]  ? new_sync_write+0x11f/0x1c0
kern  :warn  : [   80.318723]  ? vfs_write+0x187/0x260
kern  :warn  : [   80.323146]  __x64_sys_ioctl+0x83/0xc0
kern  :warn  : [   80.327733]  do_syscall_64+0x33/0x40
kern  :warn  : [   80.332177]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kern  :warn  : [   80.338066] RIP: 0033:0x7f23d106f427
kern  :warn  : [   80.342497] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
kern  :warn  : [   80.363220] RSP: 002b:00007f23cf44b448 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
kern  :warn  : [   80.371747] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f23d106f427
kern  :warn  : [   80.379888] RDX: 00007f23cf44b450 RSI: 00000000c040583c RDI: 0000000000000004
kern  :warn  : [   80.388007] RBP: 0000000080000001 R08: 0000000000000000 R09: 00007f23cf44e700
kern  :warn  : [   80.396109] R10: 000000000000000a R11: 0000000000000246 R12: 00007ffe31779340
kern  :warn  : [   80.404245] R13: 0000000000000004 R14: 0000000000000002 R15: 00007f23cf44b450
kern  :alert : [   80.412405] XFS (sda5): Corruption detected. Unmount and run xfs_repair



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Rong Chen


--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc1-00023-g79da637e3252"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_VIRTIO is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=y
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
# CONFIG_USB_VL600 is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# CONFIG_MST_IRQ is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='xfstests'
	export testcase='xfstests'
	export category='functional'
	export need_memory='1G'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d04/xfstests-xfs-part1.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-ivb-d04'
	export tbox_group='lkp-ivb-d04'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5f9f75c51bbc183e7c04b390'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-d04/xfstests-4HDD-xfs-xfs-group14-ucode=0x21-debian-10.4-x86_64-20200603.cgz-79da637e3252ae12dc67971a454f622370982f25-20201102-15996-1mo212l-16.yaml'
	export id='ca48af21a5b449d3d48f6d7155229e2f856bf22e'
	export queuer_version='/lkp-src'
	export model='Ivy Bridge'
	export nr_node=1
	export nr_cpu=4
	export memory='8G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2KB240G8_BTYF836606UQ240AGN-part1'
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part2 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part3 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part4 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part5'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part1'
	export brand='Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_F2FS_FS=m
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_FS_ENCRYPTION=y
CONFIG_EXT4_ENCRYPTION=y ~ "<= v5.0"
CONFIG_F2FS_FS_ENCRYPTION=y ~ "<= v5.0"
CONFIG_XFS_RT=y
CONFIG_XFS_DEBUG=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_DM_LOG_WRITES=m
CONFIG_XFS_ONLINE_SCRUB=y ~ ">= v4.15-rc1"
CONFIG_XFS_ONLINE_REPAIR=y ~ ">= v4.18-rc1"
CONFIG_XFS_FS'
	export need_modules=true
	export commit='79da637e3252ae12dc67971a454f622370982f25'
	export netconsole_port=6676
	export ucode='0x21'
	export need_kconfig_hw='CONFIG_R8169=y
CONFIG_SATA_AHCI'
	export enqueue_time='2020-11-02 10:58:14 +0800'
	export _id='5f9f75ca1bbc183e7c04b39e'
	export _rt='/result/xfstests/4HDD-xfs-xfs-group14-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='58cdbc2e9b1a74decce9bc4a65da9324eb2c23ea'
	export base_commit='3650b228f83adda7e5ee532e2b90429c03f7b9ec'
	export branch='djwong-xfs/widen-efi-and-bui-formats'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/xfstests/4HDD-xfs-xfs-group14-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/8'
	export scheduler_version='/lkp/lkp/.src-20201030-151109'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-ivb-d04/xfstests-4HDD-xfs-xfs-group14-ucode=0x21-debian-10.4-x86_64-20200603.cgz-79da637e3252ae12dc67971a454f622370982f25-20201102-15996-1mo212l-16.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=djwong-xfs/widen-efi-and-bui-formats
commit=79da637e3252ae12dc67971a454f622370982f25
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/vmlinuz-5.10.0-rc1-00023-g79da637e3252
max_uptime=3600
RESULT_ROOT=/result/xfstests/4HDD-xfs-xfs-group14-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/8
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/xfstests_20201102.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/xfstests-x86_64-d41dcbd-1_20201027.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20200610.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=18
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/vmlinuz-5.10.0-rc1-00023-g79da637e3252'
	export dequeue_time='2020-11-02 11:40:37 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-d04/xfstests-4HDD-xfs-xfs-group14-ucode=0x21-debian-10.4-x86_64-20200603.cgz-79da637e3252ae12dc67971a454f622370982f25-20201102-15996-1mo212l-16.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=4 $LKP_SRC/setup/disk

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='xfs-group14' $LKP_SRC/tests/wrapper xfstests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper xfstests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time xfstests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--XLWMkxR+mZNQ4WTO
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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

--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xfstests

2019-02-14 10:12:19 export TEST_DIR=/fs/sda2
2019-02-14 10:12:19 export TEST_DEV=/dev/sda2
2019-02-14 10:12:19 export FSTYP=xfs
2019-02-14 10:12:19 export SCRATCH_MNT=/fs/scratch
2019-02-14 10:12:19 mkdir /fs/scratch -p
2019-02-14 10:12:19 export SCRATCH_DEV=/dev/sda5
2019-02-14 10:12:19 export SCRATCH_LOGDEV=/dev/sda3
2019-02-14 10:12:19 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
2019-02-14 10:12:19 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
2019-02-14 10:12:19 sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group14 | grep -F -f merged_ignored_files
2019-02-14 10:12:19 sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group14 | grep -v -F -f merged_ignored_files
2019-02-14 10:12:19 ./check xfs/015 xfs/045 xfs/075 xfs/110 xfs/150 xfs/185 xfs/262 xfs/300 xfs/375 xfs/405 xfs/454 xfs/490
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 lkp-ivb-d04 5.10.0-rc1-00023-g79da637e3252 #1 SMP Mon Nov 2 10:05:33 CST 2020
MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda5
MOUNT_OPTIONS -- /dev/sda5 /fs/scratch

xfs/015	 10s
xfs/045	 5s
xfs/075	 1s
xfs/110	 11s
xfs/150	[not run] Assuming DMAPI modules are not loaded
xfs/185	[not run] Assuming DMAPI modules are not loaded
xfs/262	_check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//xfs/262.dmesg)
- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/262.out.bad)
    --- tests/xfs/262.out	2020-10-27 06:25:55.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//xfs/262.out.bad	2019-02-14 10:13:05.558003014 +0000
    @@ -1,3 +1,33 @@
     QA output created by 262
     Format and populate
     Force online repairs
    +Repaired: AG 3 superblock: Repairs successful. (scrub.c line 829)
    +Repaired: AG 1 superblock: Repairs successful. (scrub.c line 829)
    +Repaired: AG 2 superblock: Repairs successful. (scrub.c line 829)
    +Repaired: Inode 128 inode record: Repairs successful. (scrub.c line 829)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/262.out /lkp/benchmarks/xfstests/results//xfs/262.out.bad'  to see the entire diff)
xfs/300	[not run] SELinux not enabled
xfs/375	 104s
xfs/405	 11s
xfs/454	 10s
xfs/490	[not run] Require XFS built without CONFIG_XFS_DEBUG
Ran: xfs/015 xfs/045 xfs/075 xfs/110 xfs/150 xfs/185 xfs/262 xfs/300 xfs/375 xfs/405 xfs/454 xfs/490
Not run: xfs/150 xfs/185 xfs/300 xfs/490
Failures: xfs/262
Failed 1 of 12 tests


--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/xfstests-xfs-part1.yaml
suite: xfstests
testcase: xfstests
category: functional
need_memory: 1G
disk: 4HDD
fs: xfs
xfstests:
  test: xfs-group14
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d04/xfstests-xfs-part1.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-ivb-d04
tbox_group: lkp-ivb-d04
kconfig: x86_64-rhel-8.3
submit_id: 5f9f66c71bbc183bef983fdf
job_file: "/lkp/jobs/scheduled/lkp-ivb-d04/xfstests-4HDD-xfs-xfs-group14-ucode=0x21-debian-10.4-x86_64-20200603.cgz-79da637e3252ae12dc67971a454f622370982f25-20201102-15343-yifp26-0.yaml"
id: 8b0d86f6836bce94b8857d5fbb7ca1000e4e175d
queuer_version: "/lkp-src"

#! hosts/lkp-ivb-d04
model: Ivy Bridge
nr_node: 1
nr_cpu: 4
memory: 8G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2KB240G8_BTYF836606UQ240AGN-part1"
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part2 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part3
  /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part4 /dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part5"
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part1"
brand: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_F2FS_FS=m
- CONFIG_F2FS_FS_XATTR=y
- CONFIG_F2FS_FS_SECURITY=y
- CONFIG_FS_ENCRYPTION=y
- CONFIG_EXT4_ENCRYPTION=y ~ "<= v5.0"
- CONFIG_F2FS_FS_ENCRYPTION=y ~ "<= v5.0"
- CONFIG_XFS_RT=y
- CONFIG_XFS_DEBUG=y
- CONFIG_FAULT_INJECTION=y
- CONFIG_FAIL_MAKE_REQUEST=y
- CONFIG_FAULT_INJECTION_DEBUG_FS=y
- CONFIG_DM_LOG_WRITES=m
- CONFIG_XFS_ONLINE_SCRUB=y ~ ">= v4.15-rc1"
- CONFIG_XFS_ONLINE_REPAIR=y ~ ">= v4.18-rc1"
- CONFIG_XFS_FS

#! include/xfstests
need_modules: true

#! include/queue/cyclic
commit: 79da637e3252ae12dc67971a454f622370982f25

#! include/testbox/lkp-ivb-d04
netconsole_port: 6676
ucode: '0x21'
need_kconfig_hw:
- CONFIG_R8169=y
- CONFIG_SATA_AHCI

#! include/fs/OTHERS
enqueue_time: 2020-11-02 09:54:16.565313415 +08:00
_id: 5f9f66c71bbc183bef983fdf
_rt: "/result/xfstests/4HDD-xfs-xfs-group14-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 58cdbc2e9b1a74decce9bc4a65da9324eb2c23ea
base_commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
branch: linux-devel/devel-hourly-2020102920
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/xfstests/4HDD-xfs-xfs-group14-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/0"
scheduler_version: "/lkp/lkp/.src-20201030-151109"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-ivb-d04/xfstests-4HDD-xfs-xfs-group14-ucode=0x21-debian-10.4-x86_64-20200603.cgz-79da637e3252ae12dc67971a454f622370982f25-20201102-15343-yifp26-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020102920
- commit=79da637e3252ae12dc67971a454f622370982f25
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/vmlinuz-5.10.0-rc1-00023-g79da637e3252
- max_uptime=3600
- RESULT_ROOT=/result/xfstests/4HDD-xfs-xfs-group14-ucode=0x21/lkp-ivb-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/xfstests_20201030.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/xfstests-x86_64-d41dcbd-1_20201027.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201030-112225/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.20.0
schedule_notify_address: 

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/79da637e3252ae12dc67971a454f622370982f25/vmlinuz-5.10.0-rc1-00023-g79da637e3252"
dequeue_time: 2020-11-02 10:22:36.174410563 +08:00

#! /lkp/lkp/.src-20201030-151109/include/site/inn
job_state: failed
loadavg: 1.11 0.82 0.36 1/136 2774
start_time: '1550139138'
end_time: '1550139312'
version: "/lkp/lkp/.src-20201030-151142:e3501b91:90ebc7619"

--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda2
wipefs -a --force /dev/sda3
wipefs -a --force /dev/sda4
wipefs -a --force /dev/sda5
mkfs -t xfs -f /dev/sda3
mkfs -t xfs -f /dev/sda2
mkfs -t xfs -f /dev/sda5
mkfs -t xfs -f /dev/sda4
mkdir -p /fs/sda2
mount -t xfs -o inode64 /dev/sda2 /fs/sda2
mkdir -p /fs/sda3
mount -t xfs -o inode64 /dev/sda3 /fs/sda3
mkdir -p /fs/sda4
mount -t xfs -o inode64 /dev/sda4 /fs/sda4
mkdir -p /fs/sda5
mount -t xfs -o inode64 /dev/sda5 /fs/sda5
export TEST_DIR=/fs/sda2
export TEST_DEV=/dev/sda2
export FSTYP=xfs
export SCRATCH_MNT=/fs/scratch
mkdir /fs/scratch -p
export SCRATCH_DEV=/dev/sda5
export SCRATCH_LOGDEV=/dev/sda3
export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
export SCRATCH_XFS_LIST_FUZZ_VERBS=random
sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group14 | grep -F -f merged_ignored_files
sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group14 | grep -v -F -f merged_ignored_files
./check xfs/015 xfs/045 xfs/075 xfs/110 xfs/150 xfs/185 xfs/262 xfs/300 xfs/375 xfs/405 xfs/454 xfs/490

--XLWMkxR+mZNQ4WTO--
