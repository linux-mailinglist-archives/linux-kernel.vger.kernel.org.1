Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317132E9B27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbhADQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:37:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:38050 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbhADQhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:37:35 -0500
IronPort-SDR: SlmnHzossjxN0MkA0zT5uunUOeTwfZyjAGxIUItGXXo2ba+U5I88Kxutqc/fSoCShOxCTuOQXj
 4WTzB4gKYEng==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="176195116"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="176195116"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 08:36:54 -0800
IronPort-SDR: N+mkhNAODPxP9UE0q46ZQnx1alHTCFQWhK0p/3ikPIMn8HhiciueGXhqwWEnSzo6VfuLYMrrtC
 441lse0j6A3A==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="421423006"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 08:36:54 -0800
Date:   Mon, 4 Jan 2021 08:36:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     corbet@lwn.net, davem@davemloft.net, gregkh@linuxfoundation.org,
        alexander.deucher@amd.com, mchehab+huawei@kernel.org,
        lee.jones@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/dax: Update description of DAX policy
 changing
Message-ID: <20210104163653.GG3097896@iweiny-DESK2.sc.intel.com>
References: <20210104024040.5381-1-lihao2018.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104024040.5381-1-lihao2018.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 10:40:40AM +0800, Hao Li wrote:
> After commit 77573fa310d9 ("fs: Kill DCACHE_DONTCACHE dentry even if
> DCACHE_REFERENCED is set"), changes to DAX policy will take effect
> as soon as all references to this file are gone.
> 
> Update the documentation accordingly.
> 
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> ---
>  Documentation/filesystems/dax.txt | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> index 8fdb78f3c6c9..a5af22831087 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.txt
> @@ -84,19 +84,8 @@ Summary
>         described in 6) below.
>  
>   6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
                                                                                  ^^
                                                  I would delete this '.' as well.

> -    the change in behaviour for existing regular files may not occur
> -    immediately.  If the change must take effect immediately, the administrator
> -    needs to:
> -
> -    a) stop the application so there are no active references to the data set
> -       the policy change will affect
> -
> -    b) evict the data set from kernel caches so it will be re-instantiated when
> -       the application is restarted. This can be achieved by:
> -
> -       i. drop-caches
> -       ii. a filesystem unmount and mount cycle
> -       iii. a system reboot
> +    the change to existing regular file won't take effect until the file is closed
                                                                      ^^^^^
                                                                      files

> +    by all processes or all processes referencing the file are stopped.

So how about:

   6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX
      flag the change to existing regular files won't take effect until the file
      is closed by all processes or all processes referencing the file are
      stopped.

I also feel like mentioning the stoppage of process' is redundant as users
should know that will result in the closing of those FDs but I'm ok leaving it
if others like it.

Ira

>  
>  
>  Details
> -- 
> 2.29.2
> 
> 
> 
