Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34527599A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIWONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:13:46 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com ([40.107.21.125]:43360
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIWONq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4Ft+/Rxbql8I7dBRlWu+85+1u/RS2ZAo0FxtzPc1yTEsg7JhHbRDWCjViTvPrXSI1Khk8jEW0HxsOLSSrgsnWjvr+SxuSk2s6kKTWMcA9M9DEhMjjbnNL70VK1RMoW4ykjGJ7/1T4fNFm7jp+Iy1TgwI7tNRT+7zhmaFT94v1hu0uzeBhoNVY3gZEho3sHrRkYhVV/w4E/YfmBO7Z7je7GW+d2XsKBQB3xRM2n91VAZlfVr/WiNnf6hPlpxIv6frJAYUW6wLlW1d5NN8ukI7G07ak/1rTthy1atEOp2+Lndg272glsx1KmYI1cWf31M1XbnN8q8nN5QRgKqYCURug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omSpo4ybYPYNWOEwQ1YDyoxCDN15AMvl6fHj9JZE4OE=;
 b=CyUIhMOfC4eZ23zCGtuySlPTuwU4f7AtGAughPDAIIe4c/lAxICYpk3oeM0WBHwDWN4/XlWouTGYfXMKPrtR1VeJkaS5b63LUupPEtGL1O6749UT0PmVbcwPKLwbZ4Xudkcn0lBgyCSoh+SCS3LoyUnlasgTKTGqI5hETT3jU/qQVtFHUXumBei2GeRfFNyBsZpz1Ss6e83JwbE3E+NLa6OPrZtsIkn/SBKmmkvgSfHeCJgNdQaf1yLlI3s3qbBLz7dKg2AOQ++UBbA4t/IyKcDbMC/RrlHUNmeZ+qpylymIFP9I/ReG1OpeGZDL92Wo1qDxgLaJDJmdUh/cLCD0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omSpo4ybYPYNWOEwQ1YDyoxCDN15AMvl6fHj9JZE4OE=;
 b=MaiFnyFfJ7KX00WYSAKQDEdoqUveRnwT1Psg5gcHayvFrRck2RijNNPMPzxGvwVS97xQyXpeGo/qmGediKO+gNiivvIrAjUk2ZJq6GxLG9C0uqTUdJniFEtY3dgU1q4TfHFEOD82dEEArg+fTF6P6p5kjdqymkCpMSX50wsrMfE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0297.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Wed, 23 Sep 2020 14:13:41 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 14:13:41 +0000
Date:   Wed, 23 Sep 2020 17:13:34 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
Message-ID: <20200923141334.GA16798@plvision.eu>
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
 <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BEXP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::28)
 To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by BEXP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 14:13:40 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3a2548-fe2a-4be1-25b3-08d85fcadf5f
X-MS-TrafficTypeDiagnostic: HE1P190MB0297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB02977EAF589E34E0F57EE75F95380@HE1P190MB0297.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVe9RRAlOxtCJw0n8QPd/2UvJNCZIoJI7xStxn8lUxoa63xU544Xoy/MXHhUnEJS3MD4bbDKQrIkXd/nC8+QveObF2oLSCYZyibqytgDqgfiuo8q8Kxstgrd21CYYy7hnSyQk7B8kcPpl7GHhJRr2DVkUYW1jspjqirhgTEp2sRaOpaov/I45Fo6wa42fFL4a2vFwmorUvi6YahzPfmJODQsnSns4/m4tlvW8Q19fEC0HataHvnhyahGreMonHnXhw1DFlBP3+bGghbyfZVmF7KGDNvCqE048lOlDPKUOGL67NNgnSs8lvl3hvOVyiJaYVkGEhyUEMLJ7d3SOSbUNrrqJt6SBF0Cc6vi3vxph4EY8H61zeSl2C0823B7qYUp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(366004)(346002)(136003)(396003)(26005)(16526019)(33656002)(186003)(86362001)(36756003)(316002)(8936002)(55016002)(83380400001)(53546011)(8676002)(4326008)(52116002)(7696005)(1076003)(2906002)(956004)(5660300002)(478600001)(6666004)(66556008)(8886007)(66476007)(44832011)(6916009)(2616005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5YtOoyOOkKBcEnRmP9WFAIY5C64bCJ6rKKPtuz9B+nj3WcXTpxG5j5L5OAnIDSVKzIzzikVxM7NZXi6E4bebPhuFOk3Ln5QnVCB6Lvk5ykI1Jer2/jtLhNOzTYYvQvG1yY4Wlf5LlTKg/DinqjmCQqRuuQ5lyVy/5Uk0+JF+fjwpVsa74gHiIDKcKnHPXSop7lxALB3HkIteSUdd1l7JW7c8eQd8RDrgosbiRk5UmVooAPQKH+OjbpJeevGXILcX8zlRzlDtdm5GK9CB8rdiMJ+n+86/OSwRSkd0spQriLyc4n9nrnDTJl1EX2XNCgJOSSabbSFRw5iWU0+8My64ZrU7xc0XvDhN15V0GwJgso35Fj+2YdYnc/igbpjtOjr+mKI9OsEyZXL/HXcqEP0GUUr0tA7orGP1pJUM/76lLEqWjjgjavHJboyIBoZtnnpX/bNSkVx5oGs4/b2U/gpThJuOwe1/J7vhe/oWmCvt+TKIYL09Kqat2PUoiVM/WQpulHnS6e5kxm5y1euTRjNHeNMkgqBccy4zVFpo6lhWuNT391RaVTFu09h0ZDr3Vq6imVHLY1S7jUhY69aJ7XUpvXFO0T0VWFjgbzRqD+c/XJ2U0QP08mqAN9G5MtcMG5gK6cH3BqwPh9OGyzUToII0gw==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3a2548-fe2a-4be1-25b3-08d85fcadf5f
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 14:13:41.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJ734NWh6HUL18EYyUThLNAu6mtfTTxiPw0w3jJneG7BoX19S6soLtyllM28b+4pHp3e3t4Zn0CuUEvDAToz/Ic0RWeHxSWMhh9qQk50MSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0297
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 03:10:36PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 23/09/2020 14:53, Vadym Kochan wrote:
> > Fix missing 'kfree_const(cell->name)' when call to
> > nvmem_cell_info_to_nvmem_cell() in several places:
> > 
> >       * after nvmem_cell_info_to_nvmem_cell() failed during
> >         nvmem_add_cells()
> > 
> >       * during nvmem_device_cell_{read,write}. This is fixed by simply
> >         re-using info->name instead of duplicating it:
> > 
> >             cell->name = info->name
> > 
> > Because cell->name is not used except for error message printing in case
> > of un-aligned access, the new __nvmem_cell_info_to_nvmem_cell() helper
> > was introduced.
> > 
> > Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> > v2:
> >      * remove not needed 'kfree_const(cell->name)' after nvmem_cell_info_to_nvmem_cell()
> >        failed.
> > 
> >   drivers/nvmem/core.c | 35 ++++++++++++++++++++++++++---------
> >   1 file changed, 26 insertions(+), 9 deletions(-)
> 
> 
> 
> Really :-)
> 
But what about nvmem_device_cell_{read,write} case ?
In my understanding the cell is allocated on the stack but kstrdup() is
not freed in the end, or I missed something ?

> 
> Below change should just fix this the reported issue!
> ------------------------>cut<---------------------------
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..9fb9112fe75d 100644
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
> ------------------------>cut<---------------------------
> 
> I don't see a point in the way your patch try to fix this!!
> 
> 
> --srini
> 
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 6cd3edb2eaf6..e6d1bc414faf 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -361,16 +361,15 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
> >   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
> >   }
> > -static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> > -				   const struct nvmem_cell_info *info,
> > -				   struct nvmem_cell *cell)
> > +static int
> > +__nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> > +				const struct nvmem_cell_info *info,
> > +				struct nvmem_cell *cell)
> >   {
> >   	cell->nvmem = nvmem;
> >   	cell->offset = info->offset;
> >   	cell->bytes = info->bytes;
> > -	cell->name = kstrdup_const(info->name, GFP_KERNEL);
> > -	if (!cell->name)
> > -		return -ENOMEM;
> > +	cell->name = info->name;
> >   	cell->bit_offset = info->bit_offset;
> >   	cell->nbits = info->nbits;
> > @@ -382,13 +381,31 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> >   	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
> >   		dev_err(&nvmem->dev,
> >   			"cell %s unaligned to nvmem stride %d\n",
> > -			cell->name, nvmem->stride);
> > +			cell->name ?: "<unknown>", nvmem->stride);
> >   		return -EINVAL;
> >   	}
> >   	return 0;
> >   }
> > +static int
> > +nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> > +			      const struct nvmem_cell_info *info,
> > +			      struct nvmem_cell *cell)
> > +{
> > +	int err;
> > +
> > +	err = __nvmem_cell_info_to_nvmem_cell(nvmem, info, cell);
> > +	if (err)
> > +		return err;
> > +
> > +	cell->name = kstrdup_const(info->name, GFP_KERNEL);
> > +	if (!cell->name)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> >   /**
> >    * nvmem_add_cells() - Add cell information to an nvmem device
> >    *
> > @@ -1460,7 +1477,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
> >   	if (!nvmem)
> >   		return -EINVAL;
> > -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> > +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> >   	if (rc)
> >   		return rc;
> > @@ -1490,7 +1507,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
> >   	if (!nvmem)
> >   		return -EINVAL;
> > -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> > +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> >   	if (rc)
> >   		return rc;
> > 
