Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A109F26D819
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIQJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:51:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42600 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIQJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:51:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08H7dfBN037005;
        Thu, 17 Sep 2020 07:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gFPfIys6+PJasFVewq/jqD1yD7if0Z8tU612k2cZKJo=;
 b=zQ0O+oBkiu5EURek44YX9wgPk75pHPWeranllkgQmNtPS6+1Z5jhl078QQ54xw3Kn7fq
 drtEyCuHnObclDOufGlyRON4lDxlymqmPs7q1H21U32UXAj8SRVKnHNaZcclu/2QolVd
 +aTn3zJG4qvDN8iWrRTUr4g5NBx7d6rtbR7opJYUXYZAb9d4vYyMA4xf85ZM7n6pqJcQ
 5B7nRfcdKFFNPZmS+yhyAl0koZXEgZ+AYKk+ryXK91ThVHS3c+F6DwE77pEBue0603H9
 Y7i6D/ih5PuiQ5msOrbhsXZkKt1dcw/3U74kC7k2ZeYHGlGc7pRWzfFy67fckXMufUpC 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 33gnrr7f9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 07:41:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08H7dukT157045;
        Thu, 17 Sep 2020 07:41:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33hm34au9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 07:41:16 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08H7f2nR025598;
        Thu, 17 Sep 2020 07:41:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 07:41:01 +0000
Date:   Thu, 17 Sep 2020 10:40:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     akpm@linux-foundation.org, alex.bou9@gmail.com,
        gustavoars@kernel.org, ira.weiny@intel.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, madhuparnabhowmik10@gmail.com,
        mporter@kernel.crashing.org, willy@infradead.org
Subject: Re: [PATCH] mm/gup: protect unpin_user_pages() against npages==-ERRNO
Message-ID: <20200917074054.GO18329@kadam>
References: <20200916100232.GF18329@kadam>
 <20200917065706.409079-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917065706.409079-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:57:06PM -0700, John Hubbard wrote:
> As suggested by Dan Carpenter, fortify unpin_user_pages() just a bit,
> against a typical caller mistake: check if the npages arg is really a
> -ERRNO value, which would blow up the unpinning loop: WARN and return.
> 
> If this new WARN_ON() fires, then the system *might* be leaking pages
> (by leaving them pinned), but probably not. More likely, gup/pup
> returned a hard -ERRNO error to the caller, who erroneously passed it
> here.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi Dan,
> 
> Is is OK to use your signed-off-by here? Since you came up with this.
> 

Yeah.  That's fine.

regards,
dan carpenter

