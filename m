Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D269277308
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgIXNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:47:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40148 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgIXNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:47:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ODdGog075670;
        Thu, 24 Sep 2020 13:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=II2vJVmC5zG0R5CMLcfuYnwOeV3MsHQw7NMx8DI8AOg=;
 b=TG0YJydhqajhhsaXLePT8faqf2HXfVXu/PROxzLnkjjT4NpSOtSG5Gc37b1XapP3a6sR
 RNei+W4kzn6XYfTkmc1Szxzew4/WvOcm0ZI8LBxquUQAx00cAdlCQ+TEbXTQVYtHKY96
 Ajd+9OlqXZigdmzV5tN1IgC1IGg9vwlYtU5uPQZmM9Ov92jDSuI5Zsm6B1CXYLDqK06J
 x6lW8CPTtylSHtHodPtpRbhCeXgMoLeLWiOgSvGi/LM2mVsB9hm5qBTrq2XZGBRvRoLE
 3+Pe5BWrvHpOyawi5uDFxhmVsNwJ7kbT76jHa40sPw3sc1c4N4HWZqXUDhzSdbdM1e41 WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33q5rgpphf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 13:47:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ODeBgD013387;
        Thu, 24 Sep 2020 13:47:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33r28x1cc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 13:47:18 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08ODlGYu002389;
        Thu, 24 Sep 2020 13:47:16 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 06:47:16 -0700
Date:   Thu, 24 Sep 2020 16:47:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/hmm/test: use after free in dmirror_allocate_chunk()
Message-ID: <20200924134709.GK4282@kadam>
References: <20200922081234.GA1274646@mwanda>
 <c25729e4-8a53-07e3-ae98-d77919f3ac21@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25729e4-8a53-07e3-ae98-d77919f3ac21@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:31:01AM -0700, Ralph Campbell wrote:
> > @@ -471,30 +487,16 @@ static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
> >   				sizeof(new_chunks[0]) * new_capacity,
> >   				GFP_KERNEL);
> >   		if (!new_chunks)
> 
> Need to call mutex_unlock(&mdevice->devmem_lock).
> In fact, why not make this goto err_unlock and add
> err_unlock: mutex_unlock() before the err_release:.

Ugh...  Thanks for catching that.

regards,
dan carpenter

