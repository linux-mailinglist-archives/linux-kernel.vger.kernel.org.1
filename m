Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBDE26C162
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgIPKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:03:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgIPKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:03:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G9iM97064373;
        Wed, 16 Sep 2020 10:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vcNrF7Sq6F2ImPCfjf6RQKmFE7yEZsDh2IYWNQJgSMw=;
 b=XFeYAJoTNyFQWAlAPEq50jQHimi5JFeUc+FtD3lCHmt/qVM+3sfzKkjEdkOufB4grC1i
 o+pjNY0jerL08dmLQf4ul/WnixVY8anGegYN2PgFhyzgCxpjU4tLuOsHa1bMi3yFQwcJ
 EYWekSojw6D/7CzvScLME4vlWjW5j+a1mgKcsocWe6fMNoCyFwCehNyq99JB3xA4efME
 gRsJXeAsT4e6eWMW+heHXsTTio4YTuN2JWTWpUvXFLF6N6SbVF55aa5mYM48Y7IFckmN
 QcHEcAKjoHg0Cb3FtddhhR3C3Yy/DlpWcSBFwf49hkm4UtyrncfS3el+SdLmtyzT54HF ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33j91dkr6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 10:02:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G9jqBj150316;
        Wed, 16 Sep 2020 10:02:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33hm32djg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 10:02:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08GA2fVG012273;
        Wed, 16 Sep 2020 10:02:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 10:02:39 +0000
Date:   Wed, 16 Sep 2020 13:02:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, madhuparnabhowmik10@gmail.com,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
Message-ID: <20200916100232.GF18329@kadam>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=2 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> There is an error when pin_user_pages_fast() returns -ERRNO and
> inside error handling path driver end up calling unpin_user_pages()
> with -ERRNO which is not correct.
> 
> This patch will fix the problem.

There are a few ways we could prevent bug in the future.

1) This could have been caught with existing static analysis tools
   which warn about when a value is set but not used.

2) I've created a Smatch check which warngs about:

	drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'

   I'll test it out tonight and see how well it works.  I don't
   immediately see any other bugs allthough Smatch doesn't like the code
   in siw_umem_release().  It uses "min_t(int" which suggests that
   negative pages are okay.

	   int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);

3) We could add a check in unpin_user_pages().

	if (WARN_ON(IS_ERR_VALUE(npages)))
		return;

It's not possible to pin more than "ULONG_MAX - 4095" because otherwise
returning error pointers wouldn't work.  So this check can't break
anything and it could prevent a crash.

regards,
dan carpenter

