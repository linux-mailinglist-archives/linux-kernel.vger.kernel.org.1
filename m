Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9204626FCB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:38:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:38:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ICSvh9016632;
        Fri, 18 Sep 2020 12:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UEm2ZTo86Kk6OxeyyMx5e48e+qu6q7WRIDLHsB3b/wI=;
 b=xXV/7Sv1IqkPgtvBMovQR6maH3T++G3LNdpkSyCyvTaMuTJaUxOxV9UwHXWkgjvkofwF
 KJpPjPTiUUaWdyWu7XG5jXMJ7qlCGG8anmqY9FunqQjr/zmMz9jih1W2KqZumZ1CB6Fe
 LlOir4T/okl/Ko714Lk1iaurhjGRO76S740ZMCu9DupFIUAoPCQK2F59t/Lf0UerpGfc
 MULn/CnOYd1TprjQ6lNGl4kKcnNd4q8KyEtzkPFxnWQlW+NYh4fBHD+1pw37R4dutyh3
 LsI99yNLVDG6O0cj4vSUDYVf+hIeckHuyLljaqR/qy2b3uhzcqHIixdfDJDcUxPjvLQR cQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9mpvm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 12:38:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ICU5Jw011078;
        Fri, 18 Sep 2020 12:38:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33hm36s8v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 12:38:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08ICcoPr019785;
        Fri, 18 Sep 2020 12:38:50 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 12:38:49 +0000
Date:   Fri, 18 Sep 2020 15:38:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] regmap: debugfs: Add back in erroneously removed
 initialisation of ret
Message-ID: <20200918123843.GS18329@kadam>
References: <20200918112002.15216-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112002.15216-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:20:02PM +0100, Charles Keepax wrote:
> Fixes: 94cc89eb8fa5 ("regmap: debugfs: Fix handling of name string for debugfs init delays")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/base/regmap/regmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index d0f7cc574ff34..b24f14ea96d8a 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -706,9 +706,9 @@ struct regmap *__regmap_init(struct device *dev,
>  			     const char *lock_name)
>  {
>  	struct regmap *map;
> +	int ret = -EINVAL;
>  	enum regmap_endian reg_endian, val_endian;
>  	int i, j;
> -	int ret;
>  
>  	if (!config)
>  		goto err;

Hi Charles, this isn't enough.  There are several goto err_map; paths
were "ret" is zero.  That will result in an Oops in the caller.  It has
to be an error code.

regards,
dan carpenter

