Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA69275ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgIWOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:51:19 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:16100
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbgIWOvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qws8y60bFK56Oz8lNWlxnSk9DTYXPfGyVeJi1WNhNF+zl6/DxHV4Npix83pO5gkk/auXx786N/CkZzgpiVfDexcmai0UpVu0WHWaxCvlkGT0xmbUEzOpDGA4jult1qjzFBO7dLkhnHCktugBCNLJuvLBqdIkTQ1GAUKEUGZIrtZ0m31V9yralCnKSKfAlCMzvcFu2QAi31tyHzNJjyoaQxAziD7k3dnGrvdN4UgEsxxBo6Dmuvadk02MOPmYJECvYHzYmM6NMHu4o10ebi2RdEoXG3F5A/JcvDcYNVllcTgzp+OzHXNZUutJwEdbKQejNzw/LyVVCXgF/NCrSJnfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOPXYCaj1BTly9oDm5Un3k/Dzjn/Th6iLkvUnr8hamU=;
 b=K8drPVHmcgqvi/81LhQLOLuWn7t/k8y4uozgFP4JHbDsyHPJ38ihjwB0Pn9m06N9O6eF4HuMQBrmW4sTmUatPWLRIvUvFzbHRvksBGB85y+kd5AHklL4mX7R2H0trwPscPAPmR6WAwSZpruTSU5Id91j2jLslDlt77szBDO3GWCv0z6rhfoYD4yKCFmJWVPDs9IZX75kFwFedsonb6kd7PUwBPPw6Z9uOGYQ1CcDyeBuPASxeL7rYSGwAhyOjcuoMmym8KFooRzyLoFl4lfgjeD1LyfsL6qmcn0NXUgNzWlLH9TFkyI0yCINvmk3vX+mqrCywJxCsoVxTznTDUaalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOPXYCaj1BTly9oDm5Un3k/Dzjn/Th6iLkvUnr8hamU=;
 b=Xi8eFL/lkXd+RG1FS3mE0hkKpz59idfK/Shaw6qjb69AGLURMJqzBq28BR5NMN/U+2nm2n8TCt8ZqTk/YHPR1UQbvCKT3I4xV0wrX2XSRcQ353QKLZOXd+Jg0MiCO4/cbVslnwxhKPRsXc2A56ndk0UBnBOmwCpNnFvy3x4GgLM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0572.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13; Wed, 23 Sep 2020 14:51:12 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 14:51:12 +0000
Date:   Wed, 23 Sep 2020 17:51:07 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
Message-ID: <20200923145107.GB16798@plvision.eu>
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
 <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
 <20200923141334.GA16798@plvision.eu>
 <1f65dc6a-50f3-d4e5-f1ce-7a68fddde287@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f65dc6a-50f3-d4e5-f1ce-7a68fddde287@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::49) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:20b:92::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Wed, 23 Sep 2020 14:51:09 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f17ccdda-b549-4d8e-4156-08d85fd01bd1
X-MS-TrafficTypeDiagnostic: HE1P190MB0572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB05721CF8C51E3C3E13AC01E095380@HE1P190MB0572.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+0565pcn5wfIKZOj5t/8Wm4yUF7ankoGaJTBPuwbqIjOuAp74y0pbgWiQYaNvzOmvp8QhePbXxLUilliSwgi5DsxAj0UIxNdSnyiiXrhpaLCgsOsTZRvHFAXOv8ZsS9pyl5yFQknNe1XyZ4Unzv+GMH0vEnDbE/jy9dOemkQfPQy2mOilC6y5x3mz4ccsY2Kf+0mW3r5qqp0nz0qQHis5tuArAubhViMr2sAy3yT1JmObNKLnISlZxIJZ6oebKPnuNvWw8lYuN5kGsEIKhitFBewtcC0tC7s/4fK2UB2zy9enZIYEHRTfsKBJ5766XdTq2PVP4KBvkDIFLnW1HM7bCZNrygiTInK69V5kHVTHikHRRP6UVgpE46B3gLSTX4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39830400003)(366004)(346002)(36756003)(8676002)(52116002)(86362001)(5660300002)(7696005)(478600001)(316002)(4326008)(1076003)(2906002)(83380400001)(53546011)(8936002)(8886007)(66556008)(66946007)(66476007)(6916009)(44832011)(33656002)(186003)(26005)(55016002)(956004)(16526019)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: o4Q7YTmwZtOVbNfii1wpwSAV0LwW7uMbU1HnBYiwtGrsZjeQfaGhH1W9Sdq9yosHl+wtE1W0sC+M1Tet8LYg5rmhvcV81jSJr5qGrNwtslAUmJICfC1EbD/doPWvYLbaZTC9b/jR6j3PTkaDUQ8Z9QoHn3SQzvaINEMtbtPHg5tUaTk5K3oEn8mWNeAV4SBZPYfLCUHU3izAj28A4X4GeovCGfsIsadmGUQ7nbz3LJoBcDTObtCuifBPZwUbNwk0GOpGcE0cJ//gYQjwU3q92qGWaYCrjU05o/shBnnc5VNHHYh/o4yGsxGVgTgJXia/Lsxl+/WjtxhkjargYZ6SzJdgixtf4j53ipX7NOXehUhI8SHy5bh0GmZz81CSlBZ1IZlDh4tLSJnDeMC06vmtm5goRy+LyhbMuQbDhuQWZPf3UAJp4L103qGD/DHQri0C83RoS1igoGLkE+FDjy+5f29Y04gJr2fCdWHd84uZ3W13mEz5Ll58LvhwawBkOFKVOFUtyG0Xk2FiLf6cx2pOqXYN76FJpL5OGQ0daKP01ihyaJrY+rHxdg66ujKOl5iNHePzNxDI6ZVyDzJvnARjlOmkYl29Gf3cRd2sYmSWlRMU1IpXoIYXALCe/4HYe8/AQ4XnJ/+bXYhdjo+e0D38PQ==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f17ccdda-b549-4d8e-4156-08d85fd01bd1
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 14:51:12.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzOxnz0Sdb6149qRrmrJbU0vC/por/MYMIWGbALSWFFVkenf5PodKypfGxLcyU3Y8LqIMRYVEzqj5FcIBo7lAi1kcjgXSkntlYS2k8J2MGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0572
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 03:47:14PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 23/09/2020 15:13, Vadym Kochan wrote:
> > On Wed, Sep 23, 2020 at 03:10:36PM +0100, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 23/09/2020 14:53, Vadym Kochan wrote:
> > > > Fix missing 'kfree_const(cell->name)' when call to
> > > > nvmem_cell_info_to_nvmem_cell() in several places:
> > > > 
> > > >        * after nvmem_cell_info_to_nvmem_cell() failed during
> > > >          nvmem_add_cells()
> > > > 
> > > >        * during nvmem_device_cell_{read,write}. This is fixed by simply
> > > >          re-using info->name instead of duplicating it:
> > > > 
> > > >              cell->name = info->name
> > > > 
> > > > Because cell->name is not used except for error message printing in case
> > > > of un-aligned access, the new __nvmem_cell_info_to_nvmem_cell() helper
> > > > was introduced.
> > > > 
> > > > Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
> > > > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > > > ---
> > > > v2:
> > > >       * remove not needed 'kfree_const(cell->name)' after nvmem_cell_info_to_nvmem_cell()
> > > >         failed.
> > > > 
> > > >    drivers/nvmem/core.c | 35 ++++++++++++++++++++++++++---------
> > > >    1 file changed, 26 insertions(+), 9 deletions(-)
> > > 
> > > 
> > > 
> > > Really :-)
> > > 
> > But what about nvmem_device_cell_{read,write} case ?
> > In my understanding the cell is allocated on the stack but kstrdup() is
> You are right!
> 
> That is the second issue where the caller outside would fail after
> successful call to nvmem_cell_info_to_nvmem_cell() .
> 
> Probably we cam free it in failure cases!
> something like:
> 
> ------------------------>cut<---------------------------
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..fb1e756adcee 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -383,6 +383,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct
> nvmem_device *nvmem,
>                 dev_err(&nvmem->dev,
>                         "cell %s unaligned to nvmem stride %d\n",
>                         cell->name, nvmem->stride);
> +               kfree_const(cell->name);
>                 return -EINVAL;
>         }
> 
> @@ -1465,8 +1466,10 @@ ssize_t nvmem_device_cell_read(struct nvmem_device
> *nvmem,
>                 return rc;
> 
>         rc = __nvmem_cell_read(nvmem, &cell, buf, &len);
> -       if (rc)
> +       if (rc) {
> +               kfree_const(cell->name);
>                 return rc;
> +       }
> 
>         return len;
>  }
> @@ -1494,7 +1497,11 @@ int nvmem_device_cell_write(struct nvmem_device
> *nvmem,
>         if (rc)
>                 return rc;
> 
> -       return nvmem_cell_write(&cell, buf, cell.bytes);
> +       rc = nvmem_cell_write(&cell, buf, cell.bytes);
> +       if (rc)
> +               kfree_const(cell->name);
> +
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
>  ------------------------>cut<---------------------------
> 
> --srini
> 

But is it really needed to kstrdup(cell->name) for nvmem_device_cell_{read,write} ?
It is used only for log error in case the unaligned access did not
pass the check.

> > not freed in the end, or I missed something ?
> > 
> > > 
> > > Below change should just fix this the reported issue!
> > > ------------------------>cut<---------------------------
> > > 
> > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > index 6cd3edb2eaf6..9fb9112fe75d 100644
> > > --- a/drivers/nvmem/core.c
> > > +++ b/drivers/nvmem/core.c
> > > @@ -383,6 +383,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct
> > > nvmem_device *nvmem,
> > >                  dev_err(&nvmem->dev,
> > >                          "cell %s unaligned to nvmem stride %d\n",
> > >                          cell->name, nvmem->stride);
> > > +               kfree_const(cell->name);
> > >                  return -EINVAL;
> > >          }
> > > 
> > > ------------------------>cut<---------------------------
> > > 
> > > I don't see a point in the way your patch try to fix this!!
> > > 
> > > 
> > > --srini
> > > 
> > > > 
> > > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > > index 6cd3edb2eaf6..e6d1bc414faf 100644
> > > > --- a/drivers/nvmem/core.c
> > > > +++ b/drivers/nvmem/core.c
> > > > @@ -361,16 +361,15 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
> > > >    	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
> > > >    }
> > > > -static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> > > > -				   const struct nvmem_cell_info *info,
> > > > -				   struct nvmem_cell *cell)
> > > > +static int
> > > > +__nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> > > > +				const struct nvmem_cell_info *info,
> > > > +				struct nvmem_cell *cell)
> > > >    {
> > > >    	cell->nvmem = nvmem;
> > > >    	cell->offset = info->offset;
> > > >    	cell->bytes = info->bytes;
> > > > -	cell->name = kstrdup_const(info->name, GFP_KERNEL);
> > > > -	if (!cell->name)
> > > > -		return -ENOMEM;
> > > > +	cell->name = info->name;
> > > >    	cell->bit_offset = info->bit_offset;
> > > >    	cell->nbits = info->nbits;
> > > > @@ -382,13 +381,31 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> > > >    	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
> > > >    		dev_err(&nvmem->dev,
> > > >    			"cell %s unaligned to nvmem stride %d\n",
> > > > -			cell->name, nvmem->stride);
> > > > +			cell->name ?: "<unknown>", nvmem->stride);
> > > >    		return -EINVAL;
> > > >    	}
> > > >    	return 0;
> > > >    }
> > > > +static int
> > > > +nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> > > > +			      const struct nvmem_cell_info *info,
> > > > +			      struct nvmem_cell *cell)
> > > > +{
> > > > +	int err;
> > > > +
> > > > +	err = __nvmem_cell_info_to_nvmem_cell(nvmem, info, cell);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	cell->name = kstrdup_const(info->name, GFP_KERNEL);
> > > > +	if (!cell->name)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >    /**
> > > >     * nvmem_add_cells() - Add cell information to an nvmem device
> > > >     *
> > > > @@ -1460,7 +1477,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
> > > >    	if (!nvmem)
> > > >    		return -EINVAL;
> > > > -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> > > > +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> > > >    	if (rc)
> > > >    		return rc;
> > > > @@ -1490,7 +1507,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
> > > >    	if (!nvmem)
> > > >    		return -EINVAL;
> > > > -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> > > > +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> > > >    	if (rc)
> > > >    		return rc;
> > > > 
