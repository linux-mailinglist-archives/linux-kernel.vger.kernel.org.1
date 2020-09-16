Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6827126C17E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIPKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:08:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45272 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgIPKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:07:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GA5P7S097078;
        Wed, 16 Sep 2020 10:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WMMMFzNtDOILb0KvcMc+mzeor91B41zRmZlAM5dq96g=;
 b=yM5nBpd1SAuYuSKhkXcV8NzSr36UUXX2WWMZZI27nA2aOZTSOZ8xap8EHudELTuyfGzN
 911RrtF6ydX/rUd0F+9hclktrnSkCMlUqtm5w7v6HJKBLSJGxflnV36+Ys7V9NT9ncMX
 DUFmOSgLtmhHdXMNBFKli2nq2mz6C1oatGU7jEx0cOt85m195zWwRAGrgFxkkbhCWGhG
 J9ZmGygVUfvvj/BlJM/t3UKnExHXkjOnJkq+qtZncMOzX12MTWOalvMnLYSOTu4gYoSj
 oTNytzILk+6zLAQf1t/SpaJvud4GVYURN8dwPThMzmTwuoAvSm3dZfl1255P9FvkFZmZ VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91dkrue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 10:07:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GA604I183329;
        Wed, 16 Sep 2020 10:07:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33h7wqjrvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 10:07:41 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08GA7btU032651;
        Wed, 16 Sep 2020 10:07:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 10:07:37 +0000
Date:   Wed, 16 Sep 2020 13:07:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, madhuparnabhowmik10@gmail.com,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
Message-ID: <20200916100729.GG18329@kadam>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916100232.GF18329@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=2 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:02:32PM +0300, Dan Carpenter wrote:
> On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> > There is an error when pin_user_pages_fast() returns -ERRNO and
> > inside error handling path driver end up calling unpin_user_pages()
> > with -ERRNO which is not correct.
> > 
> > This patch will fix the problem.
> 
> There are a few ways we could prevent bug in the future.
> 
> 1) This could have been caught with existing static analysis tools
>    which warn about when a value is set but not used.
> 
> 2) I've created a Smatch check which warngs about:
> 
> 	drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
> 
>    I'll test it out tonight and see how well it works.  I don't
>    immediately see any other bugs allthough Smatch doesn't like the code
>    in siw_umem_release().  It uses "min_t(int" which suggests that
>    negative pages are okay.
> 
> 	   int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
> 
> 3) We could add a check in unpin_user_pages().
> 
> 	if (WARN_ON(IS_ERR_VALUE(npages)))
> 		return;
> 
> It's not possible to pin more than "ULONG_MAX - 4095" because otherwise
> returning error pointers wouldn't work.  So this check can't break
> anything and it could prevent a crash.

Actually pin_user_pages_fast() returns an int.  It's not possible to
pin more than INT_MAX.

regards,
dan carpenter

