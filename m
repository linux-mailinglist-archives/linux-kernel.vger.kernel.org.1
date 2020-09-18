Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3236A27000F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIROnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:43:24 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33542 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgIROnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:43:23 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08IEgkAK022815;
        Fri, 18 Sep 2020 09:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ssI/732VEZUr/3qAlcw4WHDhTvSa0K28hMQBQscGkzk=;
 b=bstOsfCt1xZ4exo5tgRuKot6/yj7YymerJucX+9iovsI0PJvbIdkYzNyn3TcGQO/Kp8k
 gbWHfFFtfSdyGn9c52BX5KfkFNSKtmXwmLcEhYZC6XJ+8Uon5j76upcqDCRYm6GwLVNL
 JMQj3qROM4QEuSfYpn/OtVFukAAvb8V52dCumWFW5Ozhzw0JuDLfzYdWn4ku1/Fm4Osp
 wyQIvv8ZL9imJt8NlVMXu2gsdm3OOGptP5qEh9iDV9ZDgUsY1Hzo8Wcr4MX5ad9Vqnq5
 bxQm3OAUmF5bKzEwBa+GHH+QrQxoGK9OUQd/fMCVYAA8X0sL/JYx9s+/rCtRGnpVe0Dn 5Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 33k5prmsu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Sep 2020 09:43:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 15:43:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 18 Sep 2020 15:43:13 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9E0632A1;
        Fri, 18 Sep 2020 14:43:13 +0000 (UTC)
Date:   Fri, 18 Sep 2020 14:43:13 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: debugfs: Add back in erroneously removed
 initialisation of ret
Message-ID: <20200918144313.GO10899@ediswmail.ad.cirrus.com>
References: <20200918112002.15216-1-ckeepax@opensource.cirrus.com>
 <20200918123843.GS18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200918123843.GS18329@kadam>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 03:38:43PM +0300, Dan Carpenter wrote:
> On Fri, Sep 18, 2020 at 12:20:02PM +0100, Charles Keepax wrote:
> > Fixes: 94cc89eb8fa5 ("regmap: debugfs: Fix handling of name string for debugfs init delays")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/base/regmap/regmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> > index d0f7cc574ff34..b24f14ea96d8a 100644
> > --- a/drivers/base/regmap/regmap.c
> > +++ b/drivers/base/regmap/regmap.c
> > @@ -706,9 +706,9 @@ struct regmap *__regmap_init(struct device *dev,
> >  			     const char *lock_name)
> >  {
> >  	struct regmap *map;
> > +	int ret = -EINVAL;
> >  	enum regmap_endian reg_endian, val_endian;
> >  	int i, j;
> > -	int ret;
> >  
> >  	if (!config)
> >  		goto err;
> 
> Hi Charles, this isn't enough.  There are several goto err_map; paths
> were "ret" is zero.  That will result in an Oops in the caller.  It has
> to be an error code.
> 

Aye, sorry thought it was just cause I removed the initialisation
but yeah there is more fall out. Apologies for mucking this up,
third time lucky hopefully.

Thanks,
Charles
