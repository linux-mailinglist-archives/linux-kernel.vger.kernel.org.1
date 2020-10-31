Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933CA2A13BA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 06:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgJaFt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 01:49:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:41378 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgJaFt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 01:49:59 -0400
IronPort-SDR: 2mGfNuMcxFLdPxY6nihml74+PgqmJ6DYxU4nZJb4359dQs92j1Nc6T0CrD4kOn7Cg4wQMC0mtV
 t8hwbqo8O4zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="168798663"
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="168798663"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 22:49:58 -0700
IronPort-SDR: 4GDfj3e2hcTAKhtdvOdeSCt7aV3ak66e2AsAEL+Z5K53BSgM3eVIZR1a+dH8EbSLcCzqfWhkUz
 PotAQehCcUdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="526109912"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2020 22:49:57 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYjm0-0000RW-VJ; Sat, 31 Oct 2020 05:49:56 +0000
Date:   Sat, 31 Oct 2020 13:49:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/trace/bpf_trace.c:1181:23: warning: Uninitialized variable: t
Message-ID: <202010311312.RRUikhQ7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5fc6b075e165f641fbc366b58b578055762d5f8c
commit: c4d0bfb45068d853a478b9067a95969b1886a30f bpf: Add bpf_snprintf_btf helper
date:   5 weeks ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> kernel/trace/bpf_trace.c:1181:23: warning: Uninitialized variable: t [uninitvar]
    if (*btf_id <= 0 || !t)
                         ^

vim +1181 kernel/trace/bpf_trace.c

  1153	
  1154	#define BTF_F_ALL	(BTF_F_COMPACT  | BTF_F_NONAME | \
  1155				 BTF_F_PTR_RAW | BTF_F_ZERO)
  1156	
  1157	static int bpf_btf_printf_prepare(struct btf_ptr *ptr, u32 btf_ptr_size,
  1158					  u64 flags, const struct btf **btf,
  1159					  s32 *btf_id)
  1160	{
  1161		const struct btf_type *t;
  1162	
  1163		if (unlikely(flags & ~(BTF_F_ALL)))
  1164			return -EINVAL;
  1165	
  1166		if (btf_ptr_size != sizeof(struct btf_ptr))
  1167			return -EINVAL;
  1168	
  1169		*btf = bpf_get_btf_vmlinux();
  1170	
  1171		if (IS_ERR_OR_NULL(*btf))
  1172			return PTR_ERR(*btf);
  1173	
  1174		if (ptr->type_id > 0)
  1175			*btf_id = ptr->type_id;
  1176		else
  1177			return -EINVAL;
  1178	
  1179		if (*btf_id > 0)
  1180			t = btf_type_by_id(*btf, *btf_id);
> 1181		if (*btf_id <= 0 || !t)
  1182			return -ENOENT;
  1183	
  1184		return 0;
  1185	}
  1186	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
