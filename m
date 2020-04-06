Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78819F1B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgDFIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 04:39:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:3160 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgDFIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:39:54 -0400
IronPort-SDR: 8uyouLB70ldJPHpKI1k8yDZz7c6svAAGObK62Q/ZLMNvprjvynVWuL79SvZE1QOb/K+0VfFbo2
 t3UMeQRxrT+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 01:39:54 -0700
IronPort-SDR: qt9AlbJY6pdhpLaYacPMLu1YOp/T1isBbqlT1hpkWNEgvNo42KAQXDNde9k4PqIQiYNcKFw8Vs
 B7ycFdQOG5Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="424287561"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2020 01:39:52 -0700
Date:   Mon, 6 Apr 2020 16:39:30 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [non] 2aa3847085: will-it-scale.per_process_ops -32.0% regression
Message-ID: <20200406083930.GV8179@shao2-debian>
References: <20200406012539.GR8179@shao2-debian>
 <20200406020451.GQ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406020451.GQ23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 03:04:51AM +0100, Al Viro wrote:
> On Mon, Apr 06, 2020 at 09:25:39AM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -32.0% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd ("non-RCU analogue of the previous commit")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Arrgghh...  Could you check if vfs.git#fixes recovers that?  FWIW, proposed fix
> is this:
> 
> commit d98d78cd6ac9eb5ed0506140cc43432d7c7dd480
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun Apr 5 21:59:55 2020 -0400
> 
>     fix braino in legitimize_path()
>     
>     brown paperbag time... wrong order of arguments ended up confusing
>     the values to check dentry and mount_lock seqcounts against.
>     
>     Reported-by: kernel test robot <rong.a.chen@intel.com>
>     Fixes: 2aa38470853a ("non-RCU analogue of the previous commit")
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 61fdb77a7d58..a320371899cf 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -610,7 +610,7 @@ static bool __legitimize_path(struct path *path, unsigned seq, unsigned mseq)
>  static inline bool legitimize_path(struct nameidata *nd,
>  			    struct path *path, unsigned seq)
>  {
> -	return __legitimize_path(path, nd->m_seq, seq);
> +	return __legitimize_path(path, seq, nd->m_seq);
>  }
>  
>  static bool legitimize_links(struct nameidata *nd)


Hi Al,

Yes, the regression can be fixed:

7ef482fa65513b18  2aa38470853a65dc9b1b4bd098  d98d78cd6ac9eb5ed0506140cc  testcase/testparams/testbox
----------------  --------------------------  --------------------------  ---------------------------
         %stddev      change         %stddev      change         %stddev
             \          |                \          |                \  
    449960             -32%     306036                      450924        will-it-scale/performance-open2-ucode=0x21/lkp-ivb-d04
    449959             -32%     306035                      450923        GEO-MEAN will-it-scale.per_process_ops

Best Regards,
Rong Chen
