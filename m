Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D464F267A88
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgILM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgILM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 08:57:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A0C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 05:56:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m15so2230527pls.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bKN1gzc5M31KhBRyyjS+gpE1kjkO5QGdwGNN+jpv9fg=;
        b=WdE9zB+jKNkPyrg8XDUs60ThfcJ6ptio2uLFAPX3xoHIL83eN+npWt38cstAQe6YK4
         NBTk3Wb5FcSLnoBQ4nKGwPLzmm5ATTIsg5kjVJu0AmEMQlRsJjnyoZB2ja2BZbN79Qbf
         1V7oI+TwCbupQPbgux8GYMq96S3dHV50rGkQm92U9vwoAqPDLFGgwiQc8+3viwlkZSNg
         ydhHKJ3ZCJkv+Za1DBnMUT2bwtc8Ej7cFCUYHNsssMWLsdVcVhhGab5jopJIi2psBTDd
         xEUiaY6igM4oe2j9rFQBAJTbe1RIKCueU+PxUv6WiSbTp0UtzgCNMJo06eFBFFxhkM0M
         lvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bKN1gzc5M31KhBRyyjS+gpE1kjkO5QGdwGNN+jpv9fg=;
        b=h667IysgAQcImZSydX3k91if/bv2IVoPb5gmTCtXL7cmWTIoux7Gcml2nO7bqqdXjE
         /iFZePD6mtB/mQ7TGrMyOKlDrbYs4mI9cACF0yXublg5RYv6NG7awqIJsF0RfcmPGbNS
         bafsSrbJJ1B0TB7xHIqoZOgUTYOm35ngOWngPO9vXLihnLqlp+uVLa4PtxgPymNfj/2F
         5i3TN8pPNDwInGQfR56SCR0mHwvpvgK7MU5gOpSbLhX75Y1r1I94KKFk8BZOIc8BTSFL
         HbFLyj1+I7/mqD0v0eXIuz2GNYJnb1HThBDtnNiqUo9+mAeKp8cWsEUm5FonfkHLT6AG
         bDtQ==
X-Gm-Message-State: AOAM530nihC9C/baSiHiAjxf74/Y+GqyZRQi6gU45azh2F1OaofZB4e8
        RvGVRSH5nUTNFh6Gv4mZh3k=
X-Google-Smtp-Source: ABdhPJxDXcoR0QkGxx1hYndeXXzGaRiflrH1XNLGO9dYJbA/Q42vk8pWy+4zZ9BmJFauftJzf2eBrg==
X-Received: by 2002:a17:902:24c:b029:d0:cb2d:f270 with SMTP id 70-20020a170902024cb02900d0cb2df270mr6704264plc.9.1599915415245;
        Sat, 12 Sep 2020 05:56:55 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id p190sm5489228pfp.9.2020.09.12.05.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 05:56:54 -0700 (PDT)
Date:   Sat, 12 Sep 2020 21:56:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: drivers/android/binder.c:3689: Error: unrecognized
 keyword/register name `l.lwz
Message-ID: <20200912125652.GS3562056@lianli.shorne-pla.net>
References: <202009111401.bEXTltMk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202009111401.bEXTltMk%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 02:37:14PM +0800, kernel test robot wrote:
> Hi Stafford,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   581cb3a26baf846ee9636214afaa5333919875b1
> commit: af84b16e3423bd9c1c8d81c44bc0a217f763f6b7 openrisc: uaccess: Use static inline function in access_ok

Hello,

I sent a patch series to fix this a few weeks ago, it was reviewed and I hope
the Pull Request will be merged to mainline tomorrow.

Please check after that.

-Stafford

> date:   5 weeks ago
> config: openrisc-allmodconfig (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/android/binder.c: Assembler messages:
> >> drivers/android/binder.c:3689: Error: unrecognized keyword/register name `l.lwz ?ap,4(r17)'
>    drivers/android/binder.c:3694: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout af84b16e3423bd9c1c8d81c44bc0a217f763f6b7
> vim +3689 drivers/android/binder.c
> 
> 44d8047f1d87ad drivers/android/binder.c         Todd Kjos              2018-08-28  3594  
> fb07ebc3e82a98 drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3595  static int binder_thread_write(struct binder_proc *proc,
> fb07ebc3e82a98 drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3596  			struct binder_thread *thread,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3597  			binder_uintptr_t binder_buffer, size_t size,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3598  			binder_size_t *consumed)
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3599  {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3600  	uint32_t cmd;
> 342e5c90b60134 drivers/android/binder.c         Martijn Coenen         2017-02-03  3601  	struct binder_context *context = proc->context;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3602  	void __user *buffer = (void __user *)(uintptr_t)binder_buffer;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3603  	void __user *ptr = buffer + *consumed;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3604  	void __user *end = buffer + size;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3605  
> 26549d17741035 drivers/android/binder.c         Todd Kjos              2017-06-29  3606  	while (ptr < end && thread->return_error.cmd == BR_OK) {
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3607  		int ret;
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3608  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3609  		if (get_user(cmd, (uint32_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3610  			return -EFAULT;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3611  		ptr += sizeof(uint32_t);
> 975a1ac9a9fe65 drivers/staging/android/binder.c Arve Hjønnevåg         2012-10-16  3612  		trace_binder_command(cmd);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3613  		if (_IOC_NR(cmd) < ARRAY_SIZE(binder_stats.bc)) {
> 0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3614  			atomic_inc(&binder_stats.bc[_IOC_NR(cmd)]);
> 0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3615  			atomic_inc(&proc->stats.bc[_IOC_NR(cmd)]);
> 0953c7976c36ce drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3616  			atomic_inc(&thread->stats.bc[_IOC_NR(cmd)]);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3617  		}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3618  		switch (cmd) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3619  		case BC_INCREFS:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3620  		case BC_ACQUIRE:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3621  		case BC_RELEASE:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3622  		case BC_DECREFS: {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3623  			uint32_t target;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3624  			const char *debug_string;
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3625  			bool strong = cmd == BC_ACQUIRE || cmd == BC_RELEASE;
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3626  			bool increment = cmd == BC_INCREFS || cmd == BC_ACQUIRE;
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3627  			struct binder_ref_data rdata;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3628  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3629  			if (get_user(target, (uint32_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3630  				return -EFAULT;
> c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3631  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3632  			ptr += sizeof(uint32_t);
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3633  			ret = -1;
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3634  			if (increment && !target) {
> c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3635  				struct binder_node *ctx_mgr_node;
> c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3636  				mutex_lock(&context->context_mgr_node_lock);
> c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3637  				ctx_mgr_node = context->binder_context_mgr_node;
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3638  				if (ctx_mgr_node)
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3639  					ret = binder_inc_ref_for_node(
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3640  							proc, ctx_mgr_node,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3641  							strong, NULL, &rdata);
> c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3642  				mutex_unlock(&context->context_mgr_node_lock);
> c44b1231ff1170 drivers/android/binder.c         Todd Kjos              2017-06-29  3643  			}
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3644  			if (ret)
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3645  				ret = binder_update_ref_for_handle(
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3646  						proc, target, increment, strong,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3647  						&rdata);
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3648  			if (!ret && rdata.desc != target) {
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3649  				binder_user_error("%d:%d tried to acquire reference to desc %d, got %d instead\n",
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3650  					proc->pid, thread->pid,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3651  					target, rdata.desc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3652  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3653  			switch (cmd) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3654  			case BC_INCREFS:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3655  				debug_string = "IncRefs";
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3656  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3657  			case BC_ACQUIRE:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3658  				debug_string = "Acquire";
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3659  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3660  			case BC_RELEASE:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3661  				debug_string = "Release";
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3662  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3663  			case BC_DECREFS:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3664  			default:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3665  				debug_string = "DecRefs";
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3666  				break;
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3667  			}
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3668  			if (ret) {
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3669  				binder_user_error("%d:%d %s %d refcount change on invalid ref %d ret %d\n",
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3670  					proc->pid, thread->pid, debug_string,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3671  					strong, target, ret);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3672  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3673  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3674  			binder_debug(BINDER_DEBUG_USER_REFS,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3675  				     "%d:%d %s ref %d desc %d s %d w %d\n",
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3676  				     proc->pid, thread->pid, debug_string,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3677  				     rdata.debug_id, rdata.desc, rdata.strong,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3678  				     rdata.weak);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3679  			break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3680  		}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3681  		case BC_INCREFS_DONE:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3682  		case BC_ACQUIRE_DONE: {
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3683  			binder_uintptr_t node_ptr;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3684  			binder_uintptr_t cookie;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3685  			struct binder_node *node;
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3686  			bool free_node;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3687  
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3688  			if (get_user(node_ptr, (binder_uintptr_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30 @3689  				return -EFAULT;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3690  			ptr += sizeof(binder_uintptr_t);
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3691  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3692  				return -EFAULT;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3693  			ptr += sizeof(binder_uintptr_t);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3694  			node = binder_get_node(proc, node_ptr);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3695  			if (node == NULL) {
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3696  				binder_user_error("%d:%d %s u%016llx no match\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3697  					proc->pid, thread->pid,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3698  					cmd == BC_INCREFS_DONE ?
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3699  					"BC_INCREFS_DONE" :
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3700  					"BC_ACQUIRE_DONE",
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3701  					(u64)node_ptr);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3702  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3703  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3704  			if (cookie != node->cookie) {
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3705  				binder_user_error("%d:%d %s u%016llx node %d cookie mismatch %016llx != %016llx\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3706  					proc->pid, thread->pid,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3707  					cmd == BC_INCREFS_DONE ?
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3708  					"BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3709  					(u64)node_ptr, node->debug_id,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3710  					(u64)cookie, (u64)node->cookie);
> adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3711  				binder_put_node(node);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3712  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3713  			}
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3714  			binder_node_inner_lock(node);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3715  			if (cmd == BC_ACQUIRE_DONE) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3716  				if (node->pending_strong_ref == 0) {
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3717  					binder_user_error("%d:%d BC_ACQUIRE_DONE node %d has no pending acquire request\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3718  						proc->pid, thread->pid,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3719  						node->debug_id);
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3720  					binder_node_inner_unlock(node);
> adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3721  					binder_put_node(node);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3722  					break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3723  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3724  				node->pending_strong_ref = 0;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3725  			} else {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3726  				if (node->pending_weak_ref == 0) {
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3727  					binder_user_error("%d:%d BC_INCREFS_DONE node %d has no pending increfs request\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3728  						proc->pid, thread->pid,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3729  						node->debug_id);
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3730  					binder_node_inner_unlock(node);
> adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3731  					binder_put_node(node);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3732  					break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3733  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3734  				node->pending_weak_ref = 0;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3735  			}
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3736  			free_node = binder_dec_node_nilocked(node,
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3737  					cmd == BC_ACQUIRE_DONE, 0);
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3738  			WARN_ON(free_node);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3739  			binder_debug(BINDER_DEBUG_USER_REFS,
> adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3740  				     "%d:%d %s node %d ls %d lw %d tr %d\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3741  				     proc->pid, thread->pid,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3742  				     cmd == BC_INCREFS_DONE ? "BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
> adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3743  				     node->debug_id, node->local_strong_refs,
> adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3744  				     node->local_weak_refs, node->tmp_refs);
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3745  			binder_node_inner_unlock(node);
> adc1884222276d drivers/android/binder.c         Todd Kjos              2017-06-29  3746  			binder_put_node(node);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3747  			break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3748  		}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3749  		case BC_ATTEMPT_ACQUIRE:
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3750  			pr_err("BC_ATTEMPT_ACQUIRE not supported\n");
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3751  			return -EINVAL;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3752  		case BC_ACQUIRE_RESULT:
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3753  			pr_err("BC_ACQUIRE_RESULT not supported\n");
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3754  			return -EINVAL;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3755  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3756  		case BC_FREE_BUFFER: {
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3757  			binder_uintptr_t data_ptr;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3758  			struct binder_buffer *buffer;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3759  
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3760  			if (get_user(data_ptr, (binder_uintptr_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3761  				return -EFAULT;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3762  			ptr += sizeof(binder_uintptr_t);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3763  
> 53d311cfa19ad3 drivers/android/binder.c         Todd Kjos              2017-06-29  3764  			buffer = binder_alloc_prepare_to_free(&proc->alloc,
> 19c987241ca121 drivers/android/binder.c         Todd Kjos              2017-06-29  3765  							      data_ptr);
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3766  			if (IS_ERR_OR_NULL(buffer)) {
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3767  				if (PTR_ERR(buffer) == -EPERM) {
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3768  					binder_user_error(
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3769  						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3770  						proc->pid, thread->pid,
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3771  						(u64)data_ptr);
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3772  				} else {
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3773  					binder_user_error(
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3774  						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3775  						proc->pid, thread->pid,
> 7bada55ab50697 drivers/android/binder.c         Todd Kjos              2018-11-06  3776  						(u64)data_ptr);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3777  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3778  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3779  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3780  			binder_debug(BINDER_DEBUG_FREE_BUFFER,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3781  				     "%d:%d BC_FREE_BUFFER u%016llx found buffer %d for %s transaction\n",
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3782  				     proc->pid, thread->pid, (u64)data_ptr,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3783  				     buffer->debug_id,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3784  				     buffer->transaction ? "active" : "finished");
> 44d8047f1d87ad drivers/android/binder.c         Todd Kjos              2018-08-28  3785  			binder_free_buf(proc, buffer);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3786  			break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3787  		}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3788  
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3789  		case BC_TRANSACTION_SG:
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3790  		case BC_REPLY_SG: {
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3791  			struct binder_transaction_data_sg tr;
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3792  
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3793  			if (copy_from_user(&tr, ptr, sizeof(tr)))
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3794  				return -EFAULT;
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3795  			ptr += sizeof(tr);
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3796  			binder_transaction(proc, thread, &tr.transaction_data,
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3797  					   cmd == BC_REPLY_SG, tr.buffers_size);
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3798  			break;
> 7980240b6d63e0 drivers/android/binder.c         Martijn Coenen         2017-02-03  3799  		}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3800  		case BC_TRANSACTION:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3801  		case BC_REPLY: {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3802  			struct binder_transaction_data tr;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3803  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3804  			if (copy_from_user(&tr, ptr, sizeof(tr)))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3805  				return -EFAULT;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3806  			ptr += sizeof(tr);
> 4bfac80af3a63f drivers/android/binder.c         Martijn Coenen         2017-02-03  3807  			binder_transaction(proc, thread, &tr,
> 4bfac80af3a63f drivers/android/binder.c         Martijn Coenen         2017-02-03  3808  					   cmd == BC_REPLY, 0);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3809  			break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3810  		}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3811  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3812  		case BC_REGISTER_LOOPER:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3813  			binder_debug(BINDER_DEBUG_THREADS,
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3814  				     "%d:%d BC_REGISTER_LOOPER\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3815  				     proc->pid, thread->pid);
> b3e6861283790d drivers/android/binder.c         Todd Kjos              2017-06-29  3816  			binder_inner_proc_lock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3817  			if (thread->looper & BINDER_LOOPER_STATE_ENTERED) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3818  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3819  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called after BC_ENTER_LOOPER\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3820  					proc->pid, thread->pid);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3821  			} else if (proc->requested_threads == 0) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3822  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3823  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called without request\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3824  					proc->pid, thread->pid);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3825  			} else {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3826  				proc->requested_threads--;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3827  				proc->requested_threads_started++;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3828  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3829  			thread->looper |= BINDER_LOOPER_STATE_REGISTERED;
> b3e6861283790d drivers/android/binder.c         Todd Kjos              2017-06-29  3830  			binder_inner_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3831  			break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3832  		case BC_ENTER_LOOPER:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3833  			binder_debug(BINDER_DEBUG_THREADS,
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3834  				     "%d:%d BC_ENTER_LOOPER\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3835  				     proc->pid, thread->pid);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3836  			if (thread->looper & BINDER_LOOPER_STATE_REGISTERED) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3837  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3838  				binder_user_error("%d:%d ERROR: BC_ENTER_LOOPER called after BC_REGISTER_LOOPER\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3839  					proc->pid, thread->pid);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3840  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3841  			thread->looper |= BINDER_LOOPER_STATE_ENTERED;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3842  			break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3843  		case BC_EXIT_LOOPER:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3844  			binder_debug(BINDER_DEBUG_THREADS,
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3845  				     "%d:%d BC_EXIT_LOOPER\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3846  				     proc->pid, thread->pid);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3847  			thread->looper |= BINDER_LOOPER_STATE_EXITED;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3848  			break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3849  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3850  		case BC_REQUEST_DEATH_NOTIFICATION:
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3851  		case BC_CLEAR_DEATH_NOTIFICATION: {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3852  			uint32_t target;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3853  			binder_uintptr_t cookie;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3854  			struct binder_ref *ref;
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3855  			struct binder_ref_death *death = NULL;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3856  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3857  			if (get_user(target, (uint32_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3858  				return -EFAULT;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3859  			ptr += sizeof(uint32_t);
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3860  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3861  				return -EFAULT;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3862  			ptr += sizeof(binder_uintptr_t);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3863  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3864  				/*
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3865  				 * Allocate memory for death notification
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3866  				 * before taking lock
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3867  				 */
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3868  				death = kzalloc(sizeof(*death), GFP_KERNEL);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3869  				if (death == NULL) {
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3870  					WARN_ON(thread->return_error.cmd !=
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3871  						BR_OK);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3872  					thread->return_error.cmd = BR_ERROR;
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3873  					binder_enqueue_thread_work(
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3874  						thread,
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3875  						&thread->return_error.work);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3876  					binder_debug(
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3877  						BINDER_DEBUG_FAILED_TRANSACTION,
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3878  						"%d:%d BC_REQUEST_DEATH_NOTIFICATION failed\n",
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3879  						proc->pid, thread->pid);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3880  					break;
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3881  				}
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3882  			}
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3883  			binder_proc_lock(proc);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3884  			ref = binder_get_ref_olocked(proc, target, false);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3885  			if (ref == NULL) {
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3886  				binder_user_error("%d:%d %s invalid ref %d\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3887  					proc->pid, thread->pid,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3888  					cmd == BC_REQUEST_DEATH_NOTIFICATION ?
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3889  					"BC_REQUEST_DEATH_NOTIFICATION" :
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3890  					"BC_CLEAR_DEATH_NOTIFICATION",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3891  					target);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3892  				binder_proc_unlock(proc);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3893  				kfree(death);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3894  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3895  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3896  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3897  			binder_debug(BINDER_DEBUG_DEATH_NOTIFICATION,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3898  				     "%d:%d %s %016llx ref %d desc %d s %d w %d for node %d\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3899  				     proc->pid, thread->pid,
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3900  				     cmd == BC_REQUEST_DEATH_NOTIFICATION ?
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3901  				     "BC_REQUEST_DEATH_NOTIFICATION" :
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3902  				     "BC_CLEAR_DEATH_NOTIFICATION",
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3903  				     (u64)cookie, ref->data.debug_id,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3904  				     ref->data.desc, ref->data.strong,
> 372e3147df7016 drivers/android/binder.c         Todd Kjos              2017-06-29  3905  				     ref->data.weak, ref->node->debug_id);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3906  
> ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3907  			binder_node_lock(ref->node);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3908  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3909  				if (ref->death) {
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3910  					binder_user_error("%d:%d BC_REQUEST_DEATH_NOTIFICATION death notification already set\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3911  						proc->pid, thread->pid);
> ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3912  					binder_node_unlock(ref->node);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3913  					binder_proc_unlock(proc);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3914  					kfree(death);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3915  					break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3916  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3917  				binder_stats_created(BINDER_STAT_DEATH);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3918  				INIT_LIST_HEAD(&death->work.entry);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3919  				death->cookie = cookie;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3920  				ref->death = death;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3921  				if (ref->node->proc == NULL) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3922  					ref->death->work.type = BINDER_WORK_DEAD_BINDER;
> bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3923  
> 1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3924  					binder_inner_proc_lock(proc);
> 1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3925  					binder_enqueue_work_ilocked(
> bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3926  						&ref->death->work, &proc->todo);
> bb74562a7f8398 drivers/android/binder.c         Martijn Coenen         2017-08-31  3927  					binder_wakeup_proc_ilocked(proc);
> 1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3928  					binder_inner_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3929  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3930  			} else {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3931  				if (ref->death == NULL) {
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3932  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification not active\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3933  						proc->pid, thread->pid);
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3934  					binder_node_unlock(ref->node);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3935  					binder_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3936  					break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3937  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3938  				death = ref->death;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3939  				if (death->cookie != cookie) {
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3940  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification cookie mismatch %016llx != %016llx\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3941  						proc->pid, thread->pid,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3942  						(u64)death->cookie,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3943  						(u64)cookie);
> 673068eee8560d drivers/android/binder.c         Todd Kjos              2017-06-29  3944  					binder_node_unlock(ref->node);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3945  					binder_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3946  					break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3947  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3948  				ref->death = NULL;
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3949  				binder_inner_proc_lock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3950  				if (list_empty(&death->work.entry)) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3951  					death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3952  					if (thread->looper &
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3953  					    (BINDER_LOOPER_STATE_REGISTERED |
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3954  					     BINDER_LOOPER_STATE_ENTERED))
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3955  						binder_enqueue_thread_work_ilocked(
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3956  								thread,
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  3957  								&death->work);
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3958  					else {
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3959  						binder_enqueue_work_ilocked(
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3960  								&death->work,
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3961  								&proc->todo);
> 1b77e9dcc3da93 drivers/android/binder.c         Martijn Coenen         2017-08-31  3962  						binder_wakeup_proc_ilocked(
> 408c68b17aea2f drivers/android/binder.c         Martijn Coenen         2017-08-31  3963  								proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3964  					}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3965  				} else {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3966  					BUG_ON(death->work.type != BINDER_WORK_DEAD_BINDER);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3967  					death->work.type = BINDER_WORK_DEAD_BINDER_AND_CLEAR;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3968  				}
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3969  				binder_inner_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3970  			}
> ab51ec6bdf0b7a drivers/android/binder.c         Martijn Coenen         2017-06-29  3971  			binder_node_unlock(ref->node);
> 2c1838dc6817dd drivers/android/binder.c         Todd Kjos              2017-06-29  3972  			binder_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3973  		} break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3974  		case BC_DEAD_BINDER_DONE: {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3975  			struct binder_work *w;
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3976  			binder_uintptr_t cookie;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3977  			struct binder_ref_death *death = NULL;
> 10f62861b4a2f2 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  3978  
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3979  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3980  				return -EFAULT;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3981  
> 7a64cd887fdb97 drivers/android/binder.c         Lisa Du                2016-02-17  3982  			ptr += sizeof(cookie);
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3983  			binder_inner_proc_lock(proc);
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3984  			list_for_each_entry(w, &proc->delivered_death,
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3985  					    entry) {
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3986  				struct binder_ref_death *tmp_death =
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3987  					container_of(w,
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3988  						     struct binder_ref_death,
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  3989  						     work);
> 10f62861b4a2f2 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  3990  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3991  				if (tmp_death->cookie == cookie) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3992  					death = tmp_death;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3993  					break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3994  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3995  			}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3996  			binder_debug(BINDER_DEBUG_DEAD_BINDER,
> 8ca86f1639ec58 drivers/android/binder.c         Todd Kjos              2018-02-07  3997  				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3998  				     proc->pid, thread->pid, (u64)cookie,
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3999  				     death);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4000  			if (death == NULL) {
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4001  				binder_user_error("%d:%d BC_DEAD_BINDER_DONE %016llx not found\n",
> da49889deb34d3 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  4002  					proc->pid, thread->pid, (u64)cookie);
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4003  				binder_inner_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4004  				break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4005  			}
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4006  			binder_dequeue_work_ilocked(&death->work);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4007  			if (death->work.type == BINDER_WORK_DEAD_BINDER_AND_CLEAR) {
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4008  				death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4009  				if (thread->looper &
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4010  					(BINDER_LOOPER_STATE_REGISTERED |
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4011  					 BINDER_LOOPER_STATE_ENTERED))
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  4012  					binder_enqueue_thread_work_ilocked(
> 148ade2c4d4f46 drivers/android/binder.c         Martijn Coenen         2017-11-15  4013  						thread, &death->work);
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4014  				else {
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4015  					binder_enqueue_work_ilocked(
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4016  							&death->work,
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4017  							&proc->todo);
> 408c68b17aea2f drivers/android/binder.c         Martijn Coenen         2017-08-31  4018  					binder_wakeup_proc_ilocked(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4019  				}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4020  			}
> 72196393a5e3d2 drivers/android/binder.c         Todd Kjos              2017-06-29  4021  			binder_inner_proc_unlock(proc);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4022  		} break;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4023  
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4024  		default:
> 56b468fc709b2b drivers/staging/android/binder.c Anmol Sarma            2012-10-30  4025  			pr_err("%d:%d unknown command %d\n",
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4026  			       proc->pid, thread->pid, cmd);
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4027  			return -EINVAL;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4028  		}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4029  		*consumed = ptr - buffer;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4030  	}
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4031  	return 0;
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4032  }
> 355b0502f6efea drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  4033  
> 
> :::::: The code at line 3689 was first introduced by commit
> :::::: 355b0502f6efea0ff9492753888772c96972d2a3 Revert "Staging: android: delete android drivers"
> 
> :::::: TO: Greg Kroah-Hartman <gregkh@suse.de>
> :::::: CC: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


