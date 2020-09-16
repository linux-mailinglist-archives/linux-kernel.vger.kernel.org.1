Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757BB26BADB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIPDsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:48:04 -0400
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:63009
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbgIPDr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:47:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2qVge2YcENv5htHFvacfQ+uuOLnvp1ud3X4E5YbxoPtJ6CYAzSYV89NS5HrY3ncKo3usOlMpw1bhOzYMCOMpGfjX6zVB6IGp9IRnNcXrOXUcDCf0dwhoe+xBzf3MlbluZkbc573ZYkc+ArNfQq+XpGjnC9ih8codNx4X1aE+16CbN06fXO9s9o+RYKnzdLS71qJmpjZxxSvlFFYGIcvo9NKBxeKbtvRQ3J8WLozoDo9ySsDQAgujEXhLmlekjPJH9X17R27r5n99zVI4tfDqef7Dp1EaMqkxsG8o3fZCSnJ1e4pWu6PYGX4VZzoxBKq93XhMJbsnr/WVAU/nKrAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzbGHpubkRsMoy2LlSRiRVdcXYNEIuwXQKuBSvL9DmQ=;
 b=EbFvQlk6OmrCaPs6qW2zU5/pDSi2iDS2g98r0sTU9PVo938DRohqdJfVNZW9E2rfDTcItyHzDKfcATeOhz4CH8sJl5YiM5OmS4V0js5/L6RFfpzJtV1EMH34ujyWKRLygbiHlktuF0HCRd5tRf+VVRMFRY4qaojKWaFxWFpjK/vqaZjP7anh9kfI9PwfzyqgY8f95LV5Bzg3jBPeVSsvODoPt/Xp3TjbIEOHq5SPt3jnZN2u/5mZgtm3gzelmUxQg0vJF2kXt3lEhHKLqlfjVplSiKC+oFqJ9OXwxDDXUrzX0fu7LNPl2iQXbhDItLSFyUfNpx7xfE7joFDgxb/LiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzbGHpubkRsMoy2LlSRiRVdcXYNEIuwXQKuBSvL9DmQ=;
 b=Au9oLUKAQTeiTlh+B2hfMojPkavrQLBbowniE6OWbN7XhTBM1te1HTo9D2u23R+TeMcykRjE6nXiftMd+J5O5+2iGxwzMHTPDLl9bUukZE1hguMZx3L1OR791ypseVYMOi9JNdOyUs3cXBQ4HoXZcyTRe9YwknELDcf736vHcq8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 03:47:55 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 03:47:55 +0000
Subject: Re: [PATCH] mm/page_alloc.c: avoid inheritting current's flags when
 invoked in interrupt
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200915075635.1112-1-yanfei.xu@windriver.com>
 <20200915181749.2bb7420e2c7e62267b21a0fc@linux-foundation.org>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <86c342b0-3ed2-71da-a3eb-da73d19d9c6c@windriver.com>
Date:   Wed, 16 Sep 2020 11:47:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200915181749.2bb7420e2c7e62267b21a0fc@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0013.apcprd06.prod.outlook.com (2603:1096:202:2e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Wed, 16 Sep 2020 03:47:53 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fdf4055-af5b-40eb-ac6d-08d859f34b7e
X-MS-TrafficTypeDiagnostic: BY5PR11MB3893:
X-Microsoft-Antispam-PRVS: <BY5PR11MB38935E07B01CED8AC16117E3E4210@BY5PR11MB3893.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVHpXRxkyJ7AKuGt8f0tCxdUQ1nQjf1+3ugYT9zJ0kgZBJU77Av42ByoHJPhZIvObXCIjiCQekAyaqRQ/y6JWgEeVc7K2d7BaJpGTMACZB0L61ttduJ7qNu/uMOuTBiHPmstvwnK2azmcOTHGBxgnYun+d1qmnNGZwl0jZzOjA6LdO0YRuJ9iXHRjUzaykWZC4n2raaGkXagSaWbF8SGwSdTBdCo0XYT1MS8NeBYNcMQD6HKNsaJ5P7X0RSH3Wmq2WT5YrPAHwowU4yazZeIQ5xK4vUWYZes3K5dRdDpKS3+KMkf9eNTn4ed62y0H8TTEowqUOCqPMhRVXUGhJb02SxBXovgf8G7bGd2rk5JOegXerPg4EuukENoo9rJ64V99oQI+mBKue3XHPe4wbcfTO+H+9UGheyZtMHd4oKV+uZeIGPZZlnLxuj7UNqXIENSGan5oGW1CkEI3qzopcNVFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39850400004)(136003)(316002)(6486002)(83380400001)(26005)(36756003)(66556008)(66946007)(66476007)(5660300002)(2906002)(8676002)(31696002)(4326008)(8936002)(956004)(2616005)(16576012)(86362001)(31686004)(6706004)(478600001)(186003)(16526019)(6916009)(53546011)(52116002)(6666004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9I5L2LADoErkL2fTCDaJRcjr22kpNAI/1zsAXXWHhUbCUmfHHlbKvruU/kJe/jg2nM5Ya/yitX6xaIauzjLnu19TkQ3iMLqMwl5skpsbcr8B1bgNeerDu17EQ2BEmcLVoCHfmf/O44DDIKxjvC/Qhi2eWxud2LEnYJAvn9R4a8q1TcaxfA8+/IcfM0TClw8wdivzqkmWP90KnHsqanYude5CIRQMFNYh4ftZhr9iWPrrSJvF7X4/7+Rs1c1w3/hvlcIjnkiVOrNl7gGpD+8wcoqMGFyxJM2wtjVsyd9PYkHb1EFJsnIB3Qvue+r4t3QVo1xSl0IIbReoYRWZ1DlLfRzL4Bm4g47JOcP8ixJE+aGbnPsvUtfvkt1VFefDydSvZfImIT6ApCgu1cFLF7rZ1EhcQNuuM48h9450na+u6/n9IrzfErkZrzB7H8qZmowscQRISrVa+Dv1wbWxj0AsmhMqs9CwjaFqQsx/RVNjr9pP4+9Rd7br1E9CYeB3jevinOLl14YJumL26OzHIbYNS6kH3HOn/IgS018eCMhn6/so/6tDcDIqqYK5PjfRUfoNd91uFP84wu2y/Q+WXXkPwiiIWYb//844o/wTbEqjAY42+2pVAqjycUkavC3/ZXUuW5owS7GDbzcJdcCqh2CxPQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdf4055-af5b-40eb-ac6d-08d859f34b7e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 03:47:55.4571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiANzMJHfgH80ygSOujG8uWG/fQM7EFI4e6Xjcv5DGiNhY8wVSwYE4I+8xmV7m3MTyUOyOn3/XMjGSK+41l01Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3893
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/20 9:17 AM, Andrew Morton wrote:
> On Tue, 15 Sep 2020 15:56:35 +0800 <yanfei.xu@windriver.com> wrote:
> 
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> alloc_mask shouldn't inherit the current task's flags when
>> __alloc_pages_nodemask is invoked in interrupt.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4889,7 +4889,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>>   	 * from a particular context which has been marked by
>>   	 * memalloc_no{fs,io}_{save,restore}.
>>   	 */
>> -	alloc_mask = current_gfp_context(gfp_mask);
>> +	if (!in_interrupt())
>> +		alloc_mask = current_gfp_context(gfp_mask);
>>   	ac.spread_dirty_pages = false;
>>   
>>   	/*
> 
> hm, yes, and perhaps other callsites in page_alloc.c.
> 
> I assume this doesn't actually make any runtime difference?  Because
> gfp_mask in interrupt contexts isn't going to have __GFP_IO or __GFP_FS
> anyway.
> 
Thanks for your reply!

Yes, It doesn't make any runtime difference. Theoretically, GPF_ATOMIC 
or GFP_NOWAIT should be used in interrupt context for allocate pages, so
that gfp_mask isn't going to have __GFP_IO or __GFP_FS.

But if somebody use wrong gfp_masks, __GFP_IO or __GFP_FS will be 
introduced, with the process interrupted has PF_MEMALLOC_NOIO or 
PF_MEMALLOC_NOFS, current_gfp_context may help to hide these wrong 
usages. I don't think it is the original purpose of that piece of
codes.

And how about add BUG_ON or WARN_ON to figure out the situation which
introduce __GFP_IO or __GFP_FS in interrupt context?

Regards,
Yanfei
