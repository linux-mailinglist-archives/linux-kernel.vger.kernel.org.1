Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD726CBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgIPUec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:34:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33158 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIPUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:34:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GFOZrP122146;
        Wed, 16 Sep 2020 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ASgMVDRNkTPzz2/37G9dphhHwoVaVdFB00a6v0PRh+4=;
 b=qnftcqazoZr6ltz7bEzyw6AZP/cCjvGXLHvJjv7OutChtgoIoxxJVaFcQZ2hopthBRVv
 DL40obGBIWCeP35Q6T3Ae+/Iosq82GmTuw59aKJzhX7rIv1Smwk6Ew7Ho9stdJwkdsQq
 0nz4sdHOnlXTHT5d9XpxbU/ET/9T0fbOz3e5b/eXBd9yGWttxPL/383TMYOE/vFkWV3e
 DebgkwENWFx2mpZHVnQr0+OZrCnuFc6MNmi7/spFzfGYvyl7VFRFATzQIys0/3LDZFqL
 z3w324QpdFEMRRSfb7JNQSWPIl2VBSgDCa2e/mU6CrVY7Ztbp6WYsSsz6Jwt5HLbALfv 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33j91dne7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 15:27:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GFL3vh105183;
        Wed, 16 Sep 2020 15:27:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33h891ubnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 15:27:15 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08GFRCZ0026634;
        Wed, 16 Sep 2020 15:27:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 15:27:12 +0000
Date:   Wed, 16 Sep 2020 18:27:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        jhubbard@nvidia.com, madhuparnabhowmik10@gmail.com,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
Message-ID: <20200916152704.GL18329@kadam>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam>
 <20200916151607.GB2485491@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916151607.GB2485491@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=2 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=2 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 08:16:09AM -0700, Ira Weiny wrote:
> On Wed, Sep 16, 2020 at 01:02:32PM +0300, Dan Carpenter wrote:
> > On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> > > There is an error when pin_user_pages_fast() returns -ERRNO and
> > > inside error handling path driver end up calling unpin_user_pages()
> > > with -ERRNO which is not correct.
> > > 
> > > This patch will fix the problem.
> > 
> > There are a few ways we could prevent bug in the future.
> > 
> > 1) This could have been caught with existing static analysis tools
> >    which warn about when a value is set but not used.
> > 
> > 2) I've created a Smatch check which warngs about:
> > 
> > 	drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
> > 
> >    I'll test it out tonight and see how well it works.  I don't
> >    immediately see any other bugs allthough Smatch doesn't like the code
> >    in siw_umem_release().  It uses "min_t(int" which suggests that
> >    negative pages are okay.
> > 
> > 	   int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
> > 
> > 3) We could add a check in unpin_user_pages().
> > 
> > 	if (WARN_ON(IS_ERR_VALUE(npages)))
> > 		return;
> 
> Does IS_ERR_VALUE() work on an unsigned variable?  The issue with adding a
> check in unpin_user_pages() is that npages is unsigned long.

Yeah, it does.  It only works on long and unsigned long.

(Or long long types if they have the same number of bytes as a long).

regards,
dan carpenter

