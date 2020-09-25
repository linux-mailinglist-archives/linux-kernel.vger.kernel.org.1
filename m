Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E5C278576
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgIYK64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:58:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:58:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PAnLpU148584;
        Fri, 25 Sep 2020 10:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YWYBLQJom0rbcKpapTweEAGh/5w1aYSujhgyoKpy7JY=;
 b=hSFwguCm4/ZHGdmos+q9zlfdpKdMq03tzIHWIS5qMOJtsDuh/HflJzLJizIalvFN8KNE
 eMpjds5UsCUVMUiN5mVHwAHh6wsGcBhdL3E3TA/sL05DQddTPMgA9PxFBXPMAd/Zf8Kg
 yYWJ7wOHtR60hVDqiv1MBW015fmXfXggrLdkWe/a2MT1YxGeR2pVB5ih9aYHr7j37Bqt
 IIBw4Sbx6eI6O/7G92XF4VK5jVsee96QA/EwSb9cWOJTgbpnHzj2DQ18uj6iETCY5zyZ
 o53gVOQsOptLsfeP8IhHia4JyQIcaLMv4J3Ieqxs3nIR2u2Hqdtjq60x4uQAAy/pC8EM +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnuw036-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 10:58:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PAoDtv142757;
        Fri, 25 Sep 2020 10:58:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33r28y8s2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 10:58:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PAw6CV018744;
        Fri, 25 Sep 2020 10:58:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 03:58:05 -0700
Date:   Fri, 25 Sep 2020 13:57:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>,
        chao@kernel.org, glider@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [f2fs-dev] KMSAN: uninit-value in f2fs_lookup
Message-ID: <20200925105758.GN4282@kadam>
References: <000000000000f9f80905b01c7185@google.com>
 <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:06:33PM +0800, Chao Yu wrote:
> Hi,
> 
> I don't see any problem here, thanks for your report. :)
>

I bet the uninitialize value is because "max_depth" is zero.


   352  struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
   353                                           const struct f2fs_filename *fname,
   354                                           struct page **res_page)
                                                               ^^^^^^^^
The stack trace says this isn't initialized.

   355  {
   356          unsigned long npages = dir_blocks(dir);
   357          struct f2fs_dir_entry *de = NULL;
   358          unsigned int max_depth;
   359          unsigned int level;
   360  
   361          if (f2fs_has_inline_dentry(dir)) {
   362                  *res_page = NULL;
   363                  de = f2fs_find_in_inline_dir(dir, fname, res_page);
   364                  goto out;
   365          }
   366  
   367          if (npages == 0) {
   368                  *res_page = NULL;
   369                  goto out;
   370          }
   371  
   372          max_depth = F2FS_I(dir)->i_current_depth;
   373          if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
   374                  f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %lu: %u",
   375                            dir->i_ino, max_depth);
   376                  max_depth = MAX_DIR_HASH_DEPTH;
   377                  f2fs_i_depth_write(dir, max_depth);
   378          }
   379  
   380          for (level = 0; level < max_depth; level++) {
                                ^^^^^^^^^^^^^^^^^
If "max_depth" is zero, then we never enter this loop.

   381                  *res_page = NULL;
   382                  de = find_in_level(dir, level, fname, res_page);
   383                  if (de || IS_ERR(*res_page))
   384                          break;
   385          }
   386  out:
   387          /* This is to increase the speed of f2fs_create */
   388          if (!de)
   389                  F2FS_I(dir)->task = current;
   390          return de;

Which means that we return a NULL "de" and "*res_page" is uninitialized
and that matches what syzbot found throug runtime testing.

   391  }

regards,
dan carpenter
