Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94053275D43
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIWQXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:23:21 -0400
Received: from mail-vi1eur05on2131.outbound.protection.outlook.com ([40.107.21.131]:44705
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIWQXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/G8QBzeducLOOMkH6FbDF4gDSGb16+U/KHOJNoA2i4mFPf1EcnZmNQxuNjNzrR1hC7H8zpTer786bGpbzKbN9qfGKXA6nZYAslg2JXYK5Q8DEJq/2ignBCdsHle9HSLZkl2Lsojoh/z39gk9IvF64M0PzclxmctirJyZtxYBd+M5e/hlN8JgOM3BOEEgSVQI8VbQ0KTfI9Q7mIfhGCfpOej8ptQ2YT4aXXb30FImUYMQI6WqUU160wshrJDOkQ4xaCFrhi4aLdYLRVqUwyFAMqN8/iJ9Y3cPK/ikGIboGfcH3A+l54qhukBeMYnEcBS9ruTcF6w4r2pGEk8gVuM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bHqMzSrpHQJKkWYMK8b5GB7MJEPgh0QFfKOiRaRTms=;
 b=XWEMplGeIqzimMcdXjlrQbsKB5x7CP32o342jPMKz8jFz5jQkUdbQCxK0X5AFz+akn0C9Nd8uibhJAM+QyPncBVZ2cQwCIx29SHMxZyDqEiDW7cjPSnmb87b6nePCV60aa4pfZJNoDOmBbPqH2jJD4PoAlN/EYRLrlSOSkWDXiUbkSPv8RlVhZvqgd5Q9+xom0Xg2QxR/CZizKNVcXotTn6nAyQcq2f+04CsVoXHQWDhRAu5L48ErYLYPm0bsL6vo7BPasRRTM41BlAOxLsDbBSAP/EIvVf1TR/IouPKtUxFSrgAd/Ac/ILAHjtPE1+SS+dUSlv4b8KcpXDTQwLKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bHqMzSrpHQJKkWYMK8b5GB7MJEPgh0QFfKOiRaRTms=;
 b=XcHhU5qzo1aJC3+L6YmSZKTH5S1rEW5epzTeCBKkuBpwW3pmqDuLjmJoilfYAJpNfc0hjBRBTK8XxaWuLuD7HONKQkeyvH2eNgYEQZm5BAc6rqR0CId2fCpOEa4Yk3ZRsfZCvJNhR2EP+HLfRtuVuGW3FIDrg8/v+H6Rg39kzSE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0330.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:61::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Wed, 23 Sep 2020 16:23:17 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 16:23:17 +0000
Date:   Wed, 23 Sep 2020 19:23:14 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
Message-ID: <20200923162314.GF16798@plvision.eu>
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
 <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
 <20200923141334.GA16798@plvision.eu>
 <1f65dc6a-50f3-d4e5-f1ce-7a68fddde287@linaro.org>
 <20200923145107.GB16798@plvision.eu>
 <19c5fa23-41c9-f5c7-beaf-aeb9655bfefd@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c5fa23-41c9-f5c7-beaf-aeb9655bfefd@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6PR0502CA0064.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::41) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6PR0502CA0064.eurprd05.prod.outlook.com (2603:10a6:20b:56::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 23 Sep 2020 16:23:16 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 480125a0-fc24-43ed-6684-08d85fdcfa40
X-MS-TrafficTypeDiagnostic: HE1P190MB0330:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0330E43436A2E732A30631AA95380@HE1P190MB0330.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tr+6fVJldDYIjY9AS7fTdCcHD5KqRyDnfLBHhrDpJ37SDdF76EhLj2bbbj7I8K6NCOzu3zkWdEyRRg5bsL2wc+45Z1LpDKOiTvVZBGcFn2QYkhe2vxBX4KyNJnaZedodd9CGC/BDZWVSwpz2u8yg8UCAZce/gGDvS4CXdhaT7/Ca/Rx2cCTFTmXgdcUDCc+hdp5/SAD9WjlDheCsvR8Ig/iB8aXJs5xB7+X14anwQKmpoB7JUR83J+cLOiHV8ihB+tXaEXydMK+kRsKiAE2IuGYtxDClwKspRVdCwaMCyGLVYbjUau52DyP88SNbTG49xesDf55wk+daI5VXo7MATA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39830400003)(7696005)(6916009)(26005)(33656002)(83380400001)(55016002)(316002)(8936002)(16526019)(53546011)(186003)(8676002)(86362001)(36756003)(478600001)(2616005)(5660300002)(956004)(8886007)(52116002)(66556008)(66946007)(4326008)(44832011)(1076003)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tzaYts4S1Y7skxgfl7hxCMOmHj8cr0vypGkAXfIkMvOKIJ37I3AdgfmgoMIbA9tOjSUNsAY7JCfRQ3Iofg+4YwJCj1i5ypvSIKM0RlC7cBmL4K3VddH4c19AuQKfJzOPPlUPChZ21HpQX/z4md0c1RUZyGaCWbJTF7yvW/GkyFmVLaQ0F8Ull4A5SpooyuaUXx6nXPk++t4hLZ5MJwJtlejhlqJzAM5/1wADsPLkqXBPEhZ3CRWv8wydDqcGfZyD7+Q/Nzfe3p8UAkSeOukHVR5AfiCBjHIoCC7bYzX7eLtAtv6n1KIJaP+WOBRUkY0IDb6N0xcNhY8wQTj1GtUg4yInkY4x9ElKqPLQxyAQ24w/q/3sS30G7XSdFt7KmVexKITCcUnzjGM8ObgE2ZorVDYEbfbLqUhVZySPIq0CW0KFMx9+uZSFyoYZirzwHXDy7ZmcgkXYnWv62shpsPVfiPhY1FUhk85Ad910rZqNCKRN0Qo545TLnFEoiQmhB0amE4EjRpKvRaCev0/sqIl85Z3MfqGLU47pb/hc2NdcWgBWH8OslyQHXy5fIYP2jPl4hWYIhDjXrRQabrVmCSZCc3H9u7DZ5FuashDzf8nK8tuBOyvTVu5G0VsX0y0iLfhQpgVzvEO6Erzh0g4q5PS41A==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 480125a0-fc24-43ed-6684-08d85fdcfa40
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 16:23:17.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVinOTX6huMuPzm/3BkuzC5ChUn9wYEZw99lTIjOFDMTm1F/OHpKGh3XmD/+JeMC6W5yL0IqB9Kzo49QsBW7Oe+Z+XRxXdZLMDU2ju56zmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 04:51:06PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 23/09/2020 15:51, Vadym Kochan wrote:
> > > -       return nvmem_cell_write(&cell, buf, cell.bytes);
> > > +       rc = nvmem_cell_write(&cell, buf, cell.bytes);
> > > +       if (rc)
> > > +               kfree_const(cell->name);
> > > +
> > > +       return rc;
> > >   }
> > >   EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
> > >   ------------------------>cut<---------------------------
> > > 
> > > --srini
> > > 
> > But is it really needed to kstrdup(cell->name) for nvmem_device_cell_{read,write} ?
> This boils down to if we want to use same api to parse nvmem_cell_info or
> not!
> 
> If we want to keep this simple, we can either explicitly add free for
> successful caller to nvmem_cell_info_to_nvmem_cell()!
> 
> Or
> 
> use something like what you did, but new api needs more clarity!
> May be renaming __nvmem_cell_info_to_nvmem_cell to
> nvmem_cell_info_to_nvmem_cell_no_alloc would clarify that a bit!
> 

Naming is most difficult thing, what about __nvmem_cell_info_to_nvmem_cell_{unsafe,nodup}() ?
At least this is an indication to be carefully here.

> Also can you make sure that linewrapping on function names be inline with
> existing code.
> 
> Please send v3 with that changes!
> 
> 
> --srini
> > It is used only for log error in case the unaligned access did not
> > pass the check
