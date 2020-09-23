Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9115275CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIWQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:02:34 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com ([40.107.22.105]:34721
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgIWQCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:02:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVw/XrCHvaYuJL3I1iyovqu4drOmzn7DegUzUxD77s7FPgYIocnni1/JjFK9EJMTzPk2oulzbnB3oS4AAY7y5fvPf94BTV4q5f3mxloxAkzgmo+fXIocYFySv38isMI1089o1N3XwqmD2xfeZ7d8uFqgLlhQyyK3vbnpNnQPEQ01sECq2pxNc7/Fv5DSZXNaIpwXcISmwh0BRYMwRzbvs0bPhpsUDgVy7LEP5+N5uWpL1/f7Jj968H24bIG8hbzdilgTraIMWvAIx0kTFTetWbvLggJ4cGogaZwottjUQhPgk+G9zjIDgzDeimUR7BwzAysYuk1n1GWNoqhgZEQajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0LHJbCseMohI9vI4QMppmPpruI6ilhWqL+Yifsce1s=;
 b=AkpxfdMJ3UG22RnLPqWAIQ7PWeepMCH3GDgfvsVmVnLYuqDAmIMLXv69niuUmc+sYbWzL0vh6vXcQxmgghZeNH1poTMs0aSf85dDtCZszW4HS7DLB31fdP5vmHqE4X9o+Rqpg6g5ftWI+tBC0HErNjCy0HyhV2mwmSwor9GGj5fgTrQI8O+l9NxSYE6Tbnip7jCq3qCu2Snpvn6P9ymmLuNlsFUz7zAs2pUCiFgRsdDZtM7b5FfNA6mcb2fTyUhjnsotnA0T42Ipy6mvyv4XAO/CjNIxOlQD0Srd2AhCyCOhb4k/lEXToCZo1a14pbMWTsuRyU9GKR4oTpbtGIarcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0LHJbCseMohI9vI4QMppmPpruI6ilhWqL+Yifsce1s=;
 b=tcU3inwD/xZhBzms2McW52HHohpsHRS3uHgIPaL+nKis5OPXajVm3YJzK2A7bd1uDHuHMYRz0iM1UjpbiO1wE8gvAJedx2i2BejCyU92ukhsNsxR57F+ZJSrvXysSL7I/3j9vpPOtgaGmqY1/CWGTJdXbbZgzpdW601prUI2dCE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0267.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Wed, 23 Sep 2020 16:02:29 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 16:02:29 +0000
Date:   Wed, 23 Sep 2020 19:02:26 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
Message-ID: <20200923160226.GC16798@plvision.eu>
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
X-ClientProxiedBy: AM5PR0602CA0015.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::25) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM5PR0602CA0015.eurprd06.prod.outlook.com (2603:10a6:203:a3::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 16:02:28 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f61e07b-1e26-4c23-4430-08d85fda1240
X-MS-TrafficTypeDiagnostic: HE1P190MB0267:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0267899C36350407562BD9D495380@HE1P190MB0267.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cayBP2ch1ywdM/mv4s8EwEbuiFjy1/x/U8M7q1MJu3toseUtlvDY3fm/FX2CT9vLaphrJafTE9anfj195mYRJ8LWurRxmoyDPPzCZzSztVuHlhj+Ikpi/pf1thMeuHRdeOwRnpTd6BwkYvIpx9SWomQe8aio/M3GQRLK1kfdGLrDyluqYGZCVrUjuzwdJtMhxqwzXoVYqUBUN9mS9lxCS5Pmp3H9TOupKwAVOKCDGXjgO2sKyTRtERF8Zei04Z5r3KNONUmaqGmeKkWtKnjh1tjQyjcvd92tRK0Jta0Uwh5lu/9T3Nw6zoNGzzUxJtufyVkAYN2rwPtJ6niz5vEgrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39830400003)(36756003)(26005)(55016002)(83380400001)(186003)(86362001)(53546011)(7696005)(6916009)(52116002)(2906002)(66556008)(66476007)(8936002)(5660300002)(33656002)(66946007)(2616005)(316002)(1076003)(4326008)(478600001)(956004)(8676002)(8886007)(44832011)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kX6eSqaG2y2n6JQ0FYj0d1S3wfI0xjXTOkSUPd/sYiB2ttgheaQgnKQM3W5Fd0jMjWB5Mzorjk0vWcqtB59tC+ruCjxLySuBGS+6jaOesb7SW04wENocQuc+ZWKjCEPS88/wM4iSJ/Zq4gtQbE100DXfBy/FSMNfiI2leqbX0O9EPaa5YLH8wwZMNbfBAMYhEf+Y2WcY8sy9j/WSgQ/c0/uaKgJt3oUXcuKsHcDiMwivuFnxPs1DDHir53X8N/wi3H1cyTi0ujVOniWBMgZSR54YAnxfDjUsVkhA/iVspJLeLYWok2HmI7k5CJwUjXEHt5oz9McG8ALl4d+t+ryam4HyXDM/xapWCfxQhBxRd3VRxmpEqep0I7bjaXhqxN6mhQp03eoGjkI2gDyFYJkjmkhFSKJoYQoEfaAhZdcXDoFwljd87z0dCDq4zV2fwsHSAGfiLqlr6nexp+2lq2CmYfwjY+5kHWw80bKLB2ZlJUgo68hg1dtNzR7q3SgJJgLx/7dyyty0KuQuDRF0TSjpGPMGi6paPOWyZVtdEGCZYBu8uvQDzec5nfsAnTNx8xtjmNzHeftBl3xWkwepTI3OtD+s5B6ONJxDk+nfTKCIBMrQpirqDFYNd+z5CYJwXIFM83r8z9WFu8CUpOL5GLxftw==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f61e07b-1e26-4c23-4430-08d85fda1240
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 16:02:28.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFNtK6456FeGxTxA47AdkbU+/KpTfEaw72joGU0JtdX+3UoVRnAhN+xuR45iXA8FxntJRmPcps+fvgPRq6rJixUnlffcUqQrGBNxx07WSk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0267
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

I think that such additional kfree_const(cell->name) handling adds more
complexity for error handling, also to my understanding usually
resource allocation should be done in the called func in case of error
was returned.

> Or
> 
> use something like what you did, but new api needs more clarity!
> May be renaming __nvmem_cell_info_to_nvmem_cell to
> nvmem_cell_info_to_nvmem_cell_no_alloc would clarify that a bit!
> 

Yes, I agree that naming should be better, actually "__" already points
to it's unsafety (no kstrdup() is used), but of course additional suffix
would be better.

> Also can you make sure that linewrapping on function names be inline with
> existing code.

You mean do not do such func attributes breaking as I did (moved them
line upper) ?

> 
> Please send v3 with that changes!
> 
> 
> --srini
> > It is used only for log error in case the unaligned access did not
> > pass the check
