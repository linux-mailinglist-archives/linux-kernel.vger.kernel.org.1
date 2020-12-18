Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651FF2DEA43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgLRUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:33:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51190 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgLRUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:33:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIKU9j8080499;
        Fri, 18 Dec 2020 20:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HFbuznatVGjBL5fQc775ihF3yH3VtHWOJZWPjh0mMbw=;
 b=Hr8v9OBA5wGVN0MRKOiF3bLUsZfyLVpIgGJcb4KBKJ23Y5itqItR0wkk4ed3CG1lgrdg
 ZOzEUSqmQZrjLbunzos0mvdYFeP+dNugLV4OC2SgTJK9A0Y+5kVwLpeM6Kdqpv2hCx/Z
 tlKZOH0CMwHe4UPR11uvha2E1bB4iv8SzMXJrtx8x4dhSpQEOU2XXhu2qwbBvRjRAS+l
 OrQmoFCbYwSTPQRUOQY5jjUashwy9glaleFNjCMbbPwGj75t1Z08ix52kAp3AeCSzY65
 +cTdqdfqma9tD7DSqtdfTa0Dowx+ZleRCDsLfoEW8R0hxCs8xoR9/rGT6Mx90h6B/wQj Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35ckcbvay9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 20:31:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIKVNbj026269;
        Fri, 18 Dec 2020 20:31:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35d7esqf7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 20:31:53 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BIKVpUE023714;
        Fri, 18 Dec 2020 20:31:52 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 12:31:51 -0800
Subject: Re: [PATCH v2] JFS: more checks for invalid superblock
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     syzbot+36315852ece4132ec193@syzkaller.appspotmail.com,
        kernel test robot <lkp@intel.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
References: <20201218201716.26613-1-rdunlap@infradead.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <285a8ede-c901-7d8c-bd3a-e9ce8962e714@oracle.com>
Date:   Fri, 18 Dec 2020 14:31:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201218201716.26613-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! This looks good and reasonable. I'll try to get it pushed out to 
-next in the next few days.

Shaggy

On 12/18/20 2:17 PM, Randy Dunlap wrote:
> syzbot is feeding invalid superblock data to JFS for mount testing.
> JFS does not check several of the fields -- just assumes that they
> are good since the JFS_MAGIC and version fields are good.
> 
> In this case (syzbot reproducer), we have s_l2bsize == 0xda0c,
> pad == 0xf045, and s_state == 0x50, all of which are invalid IMO.
> Having s_l2bsize == 0xda0c causes this UBSAN warning:
>    UBSAN: shift-out-of-bounds in fs/jfs/jfs_mount.c:373:25
>    shift exponent -9716 is negative
> 
> s_l2bsize can be tested for correctness. pad can be tested for non-0
> and punted. s_state can be tested for its valid values and punted.
> 
> Do those 3 tests and if any of them fails, report the superblock as
> invalid/corrupt and let fsck handle it.
> 
> With this patch, chkSuper() says this when JFS_DEBUG is enabled:
>    jfs_mount: Mount Failure: superblock is corrupt!
>    Mount JFS Failure: -22
>    jfs_mount failed w/return code = -22
> 
> The obvious problem with this method is that next week there could
> be another syzbot test that uses different fields for invalid values,
> this making this like a game of whack-a-mole.
> 
> syzkaller link: https://syzkaller.appspot.com/bug?extid=36315852ece4132ec193
> 
> Reported-by: syzbot+36315852ece4132ec193@syzkaller.appspotmail.com
> Reported-by: kernel test robot <lkp@intel.com> # v2
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dave Kleikamp <shaggy@kernel.org>
> Cc: jfs-discussion@lists.sourceforge.net
> ---
> v2: fix sparse __le32 warning (lkp robot)
> 
>   fs/jfs/jfs_filsys.h |    1 +
>   fs/jfs/jfs_mount.c  |   10 ++++++++++
>   2 files changed, 11 insertions(+)
> 
> --- lnx-510.orig/fs/jfs/jfs_mount.c
> +++ lnx-510/fs/jfs/jfs_mount.c
> @@ -37,6 +37,7 @@
>   #include <linux/fs.h>
>   #include <linux/buffer_head.h>
>   #include <linux/blkdev.h>
> +#include <linux/log2.h>
>   
>   #include "jfs_incore.h"
>   #include "jfs_filsys.h"
> @@ -366,6 +367,15 @@ static int chkSuper(struct super_block *
>   	sbi->bsize = bsize;
>   	sbi->l2bsize = le16_to_cpu(j_sb->s_l2bsize);
>   
> +	/* check some fields for possible corruption */
> +	if (sbi->l2bsize != ilog2((u32)bsize) ||
> +	    j_sb->pad != 0 ||
> +	    le32_to_cpu(j_sb->s_state) > FM_STATE_MAX) {
> +		rc = -EINVAL;
> +		jfs_err("jfs_mount: Mount Failure: superblock is corrupt!");
> +		goto out;
> +	}
> +
>   	/*
>   	 * For now, ignore s_pbsize, l2bfactor.  All I/O going through buffer
>   	 * cache.
> --- lnx-510.orig/fs/jfs/jfs_filsys.h
> +++ lnx-510/fs/jfs/jfs_filsys.h
> @@ -268,5 +268,6 @@
>   				 * fsck() must be run to repair
>   				 */
>   #define	FM_EXTENDFS 0x00000008	/* file system extendfs() in progress */
> +#define	FM_STATE_MAX 0x0000000f	/* max value of s_state */
>   
>   #endif				/* _H_JFS_FILSYS */
> 
