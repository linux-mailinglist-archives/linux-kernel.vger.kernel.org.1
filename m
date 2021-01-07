Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AAC2EE7B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbhAGVho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:37:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:39655 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbhAGVhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:42 -0500
IronPort-SDR: OtyJv5nmG/0vfkAVB8Z55J2CJhUkyH6lVf3fUc56I1p40l35tFF15xO1UWpqf5xTzGzXvzMtPQ
 aRRcnTEWmeMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="157279973"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="157279973"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 13:37:01 -0800
IronPort-SDR: 2/nT8v7qW4AnwhxgrJxbpoh3/T/eHgdf5EEgbEjFjvJhpt/kZ8i8yT9ptfmLd/JV61/p3vzhWs
 vRBzeB1mDHzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="497654038"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2021 13:36:57 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kxcxk-0009fZ-6s; Thu, 07 Jan 2021 21:36:56 +0000
Date:   Fri, 8 Jan 2021 05:36:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>, Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
Message-ID: <202101080522.92zFZv3G-lkp@intel.com>
References: <20210107200402.31095-3-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107200402.31095-3-aarcange@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master hnaz-linux-mm/master v5.11-rc2 next-20210104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andrea-Arcangeli/page_count-can-t-be-used-to-decide-when-wp_page_copy/20210108-040616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 09162bc32c880a791c6c0668ce0745cf7958f576
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> fs/proc/task_mmu.c:1248:33: warning: Uninitialized variable: tmp [uninitvar]
       for (vma = mm->mmap; vma != tmp;
                                   ^

vim +1248 fs/proc/task_mmu.c

  1183	
  1184	static ssize_t clear_refs_write(struct file *file, const char __user *buf,
  1185					size_t count, loff_t *ppos)
  1186	{
  1187		struct task_struct *task;
  1188		char buffer[PROC_NUMBUF];
  1189		struct mm_struct *mm;
  1190		struct vm_area_struct *vma;
  1191		enum clear_refs_types type;
  1192		int itype;
  1193		int rv;
  1194	
  1195		memset(buffer, 0, sizeof(buffer));
  1196		if (count > sizeof(buffer) - 1)
  1197			count = sizeof(buffer) - 1;
  1198		if (copy_from_user(buffer, buf, count))
  1199			return -EFAULT;
  1200		rv = kstrtoint(strstrip(buffer), 10, &itype);
  1201		if (rv < 0)
  1202			return rv;
  1203		type = (enum clear_refs_types)itype;
  1204		if (type < CLEAR_REFS_ALL || type >= CLEAR_REFS_LAST)
  1205			return -EINVAL;
  1206	
  1207		task = get_proc_task(file_inode(file));
  1208		if (!task)
  1209			return -ESRCH;
  1210		mm = get_task_mm(task);
  1211		if (mm) {
  1212			struct mmu_notifier_range range;
  1213			struct clear_refs_private cp = {
  1214				.type = type,
  1215			};
  1216	
  1217			if (type == CLEAR_REFS_MM_HIWATER_RSS) {
  1218				if (mmap_write_lock_killable(mm)) {
  1219					count = -EINTR;
  1220					goto out_mm;
  1221				}
  1222	
  1223				/*
  1224				 * Writing 5 to /proc/pid/clear_refs resets the peak
  1225				 * resident set size to this mm's current rss value.
  1226				 */
  1227				reset_mm_hiwater_rss(mm);
  1228				mmap_write_unlock(mm);
  1229				goto out_mm;
  1230			}
  1231	
  1232			if (mmap_read_lock_killable(mm)) {
  1233				count = -EINTR;
  1234				goto out_mm;
  1235			}
  1236			if (type == CLEAR_REFS_SOFT_DIRTY) {
  1237				for (vma = mm->mmap; vma; vma = vma->vm_next) {
  1238					struct vm_area_struct *tmp;
  1239					if (!(vma->vm_flags & VM_SOFTDIRTY)) {
  1240						inc_wrprotect_tlb_flush_pending(vma);
  1241						continue;
  1242					}
  1243	
  1244					/*
  1245					 * Rollback wrprotect_tlb_flush_pending before
  1246					 * releasing the mmap_lock.
  1247					 */
> 1248					for (vma = mm->mmap; vma != tmp;
  1249					     vma = vma->vm_next)
  1250						dec_wrprotect_tlb_flush_pending(vma);
  1251	
  1252					mmap_read_unlock(mm);
  1253					if (mmap_write_lock_killable(mm)) {
  1254						count = -EINTR;
  1255						goto out_mm;
  1256					}
  1257					for (vma = mm->mmap; vma; vma = vma->vm_next) {
  1258						vma->vm_flags &= ~VM_SOFTDIRTY;
  1259						vma_set_page_prot(vma);
  1260						inc_wrprotect_tlb_flush_pending(vma);
  1261					}
  1262					mmap_write_downgrade(mm);
  1263					break;
  1264				}
  1265	
  1266				inc_tlb_flush_pending(mm);
  1267				mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
  1268							0, NULL, mm, 0, -1UL);
  1269				mmu_notifier_invalidate_range_start(&range);
  1270			}
  1271			walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
  1272					&cp);
  1273			if (type == CLEAR_REFS_SOFT_DIRTY) {
  1274				mmu_notifier_invalidate_range_end(&range);
  1275				flush_tlb_mm(mm);
  1276				for (vma = mm->mmap; vma; vma = vma->vm_next)
  1277					dec_wrprotect_tlb_flush_pending(vma);
  1278				dec_tlb_flush_pending(mm);
  1279			}
  1280			mmap_read_unlock(mm);
  1281	out_mm:
  1282			mmput(mm);
  1283		}
  1284		put_task_struct(task);
  1285	
  1286		return count;
  1287	}
  1288	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
