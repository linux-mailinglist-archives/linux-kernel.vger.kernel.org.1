Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5C2B2BA6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 06:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgKNFsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 00:48:37 -0500
Received: from m12-16.163.com ([220.181.12.16]:49014 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgKNFsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 00:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Yf5KW
        EBlfPvY8UckWvudcwjucfSNaBU4AKahUmFqssw=; b=QkHRXbqeoYY95xp26u3pf
        f+eSoD1rIVspusLI0lxyGE00YcNkiV2TCLxg+cY6rK9i7KCujTOHTB+hNW0eHyaE
        88aNwDmTb86csVZSiRXhekOJOi8em5KLBEdW1/DQD0CHKmkhv/l5+T3htNj+GWVu
        WFlyaAIQ5wgvUSJPCtbYY8=
Received: from localhost (unknown [101.86.213.176])
        by smtp12 (Coremail) with SMTP id EMCowACXRmOOb69f3D00Lw--.16686S2;
        Sat, 14 Nov 2020 13:47:58 +0800 (CST)
Date:   Sat, 14 Nov 2020 13:47:58 +0800
From:   Hui Su <sh_def@163.com>
To:     kernel test robot <lkp@intel.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH] mm/shmem.c: make shmem_mapping() inline
Message-ID: <20201114054758.GA185928@rlk>
References: <20201113135427.GA167783@rlk>
 <202011140010.ETcSkyze-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011140010.ETcSkyze-lkp@intel.com>
X-CM-TRANSID: EMCowACXRmOOb69f3D00Lw--.16686S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykCF48Jw4rZF15Gr4fGrg_yoWrWry7pa
        4qyw1UKrs5JrW0vFWxZay0v34Yqrs5Jry8tFyfGr9IyF1qqry7KwsIkFyY9ryYkrWkWay2
        vFyUG3sY9w4UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqApOUUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWQ-cX1WBtZx2uwAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 12:54:47AM +0800, kernel test robot wrote:
> Hi Hui,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mmotm/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Hui-Su/mm-shmem-c-make-shmem_mapping-inline/20201113-215549
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: arm-randconfig-s032-20201113 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-107-gaf3512a6-dirty
>         # https://github.com/0day-ci/linux/commit/0434762d5523a3d702cd589a7f8e3771fee7b3b2
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Hui-Su/mm-shmem-c-make-shmem_mapping-inline/20201113-215549
>         git checkout 0434762d5523a3d702cd589a7f8e3771fee7b3b2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
>    mm/filemap.c: note: in included file:
> >> include/linux/shmem_fs.h:66:33: sparse: sparse: marked inline, but without a definition
> >> include/linux/shmem_fs.h:66:33: sparse: sparse: marked inline, but without a definition
> >> include/linux/shmem_fs.h:66:33: sparse: sparse: marked inline, but without a definition
> --
>    mm/truncate.c: note: in included file:
> >> include/linux/shmem_fs.h:66:33: sparse: sparse: marked inline, but without a definition
> >> include/linux/shmem_fs.h:66:33: sparse: sparse: marked inline, but without a definition
> >> include/linux/shmem_fs.h:66:33: sparse: sparse: marked inline, but without a definition
> --
>    mm/memfd.c: note: in included file:
> >> include/linux/shmem_fs.h:66:33: sparse: sparse: marked inline, but without a definition
> 
> vim +66 include/linux/shmem_fs.h
> 
>     48	
>     49	/*
>     50	 * Functions in mm/shmem.c called directly from elsewhere:
>     51	 */
>     52	extern const struct fs_parameter_description shmem_fs_parameters;
>     53	extern int shmem_init(void);
>     54	extern int shmem_init_fs_context(struct fs_context *fc);
>     55	extern struct file *shmem_file_setup(const char *name,
>     56						loff_t size, unsigned long flags);
>     57	extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
>     58						    unsigned long flags);
>     59	extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
>     60			const char *name, loff_t size, unsigned long flags);
>     61	extern int shmem_zero_setup(struct vm_area_struct *);
>     62	extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>     63			unsigned long len, unsigned long pgoff, unsigned long flags);
>     64	extern int shmem_lock(struct file *file, int lock, struct user_struct *user);
>     65	#ifdef CONFIG_SHMEM
>   > 66	extern inline bool shmem_mapping(struct address_space *mapping);
>     67	#else
>     68	static inline bool shmem_mapping(struct address_space *mapping)
>     69	{
>     70		return false;
>     71	}
>     72	#endif /* CONFIG_SHMEM */
>     73	extern void shmem_unlock_mapping(struct address_space *mapping);
>     74	extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>     75						pgoff_t index, gfp_t gfp_mask);
>     76	extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
>     77	extern int shmem_unuse(unsigned int type, bool frontswap,
>     78			       unsigned long *fs_pages_to_unuse);
>     79	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Thanks for your test.

I will resend a PATCH V2 later.

