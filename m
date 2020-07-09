Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB41219C85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGIJoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGIJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:44:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC58C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 02:44:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so1138547wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PLl8OGvUeLOUUHW/T0CxgP8wd4Pzfx4sJngI6R0Dk2g=;
        b=RCWQxaOwpdUwdEFhduGiA6uwtsGwtdmZmu/w2hP7tQ/eos6XNZ/YlES+c4PwzEKj+Y
         HQkos90UhTQasFzNe/cDxsHfeoGRKNVhLdznUCEVYfDUT7E3jRkULn72PsOU0lvjAntJ
         Ma6SaS+g2yKKTYX09rwBQQ2IPFgTl+ifezp4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLl8OGvUeLOUUHW/T0CxgP8wd4Pzfx4sJngI6R0Dk2g=;
        b=oejnJhdTRPIvcEjotJKPuxQ7LZnxWIiAAHmlczLhVyVNAlXTf7WXzF7bCm8UWMVBsg
         IaHgCvQcKziWOhOwyrPwsRzNvDeW4vbuBmyW/TJaTDwZXWMiv+APGqGUZrvXzZcWgyba
         B01ciUezE6grpgAdsOJl3yXYEmiITWmBqYoRJZcyo+dw/f0GS/+altBdA6B71DO+qPNr
         ZRWlZgNL1MaiN9nwusDYivS6cxNR2U3p+HyvDEpJVEYiroWrPH70qCGjUZqYAuYXzY+T
         JG/qXLzrmlDvtmjg7hlcIx9aQ6sWUVzYRXyeMK7H6RQUGs8eVvGwIV/MR7T4olttUvMx
         9EeA==
X-Gm-Message-State: AOAM530s2G8C+NAyZ42Fw+t4Oo2ZSlqb02s+wraiN5HqIC9O9G7mtDrd
        FMjTft+AcDjkscQ6IeFaWzGj8Q==
X-Google-Smtp-Source: ABdhPJyRm2EixjAzjNZ646eajs00dz37zv870XnIyWv48JP6xCPL/xdYrDA1J4Cc5c8ZCKytU4546Q==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr12801199wmx.62.1594287856715;
        Thu, 09 Jul 2020 02:44:16 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id w17sm4761445wra.42.2020.07.09.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 02:44:16 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 9 Jul 2020 11:44:14 +0200
To:     kernel test robot <lkp@intel.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200709094414.GB3743174@google.com>
References: <20200709005654.3324272-3-kpsingh@chromium.org>
 <202007091250.vqzrSanp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007091250.vqzrSanp%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-Jul 12:37, kernel test robot wrote:
> Hi KP,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/KP-Singh/Generalizing-bpf_local_storage/20200709-085810
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/bpf/bpf_inode_storage.c:274:17: warning: no previous prototype for 'inode_storage_map_alloc' [-Wmissing-prototypes]
>      274 | struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/bpf/bpf_inode_storage.c:286:6: warning: no previous prototype for 'inode_storage_map_free' [-Wmissing-prototypes]
>      286 | void inode_storage_map_free(struct bpf_map *map)
>          |      ^~~~~~~~~~~~~~~~~~~~~~

Thanks! Should have been static. Fixed these. Will send a v4 with
these fixes.

- KP 

> 
> vim +/inode_storage_map_alloc +274 kernel/bpf/bpf_inode_storage.c
> 
>    273	
>  > 274	struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
>    275	{
>    276		struct bpf_local_storage_map *smap;
>    277	
>    278		smap = bpf_local_storage_map_alloc(attr);
>    279		if (IS_ERR(smap))
>    280			return ERR_CAST(smap);
>    281	
>    282		smap->cache_idx = cache_idx_get_inode();
>    283		return &smap->map;
>    284	}
>    285	
>  > 286	void inode_storage_map_free(struct bpf_map *map)
>    287	{
>    288		struct bpf_local_storage_map *smap;
>    289	
>    290		smap = (struct bpf_local_storage_map *)map;
>    291		cache_idx_free_inode(smap->cache_idx);
>    292		bpf_local_storage_map_free(smap);
>    293	}
>    294	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


