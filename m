Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02126B98C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgIPB5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:57:00 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:11264
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbgIPB4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:56:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgXaDC+mXVvoLUSYLRhFRRoBtelK0vIH95qsMd43TW9oQhcWrY0mxN7L1Mt/bcAYcctM1tWjXEHf13z0xLjp3yFUIYXn4v1/LKR7BxXxzbD3Xf2ncW5f0v6rBcldSiE54kUCeIPqrESp/+XWBY+7Nj4tjIkX+VmyU9/LAUSM6cE8hXhsrGg33qmwXaZTXjBUuIbZJUSKpjvTqTx0iG1FUSe7W1se2HnucVRGbd6q+xMlZeTuNBTLSv/lGONKFetcuc3MEeKlNG+9x+n2GQWSy0gAVCM5p4Sh7XufH4AiLXZ5iMp9k/WG7Z2hljz8RciFlkEhOKTR1frN17B1JGnr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvjjxZtHsj5RQO1YafX/vacruVcVPLniMUZc7PaIDTk=;
 b=ftTB0yySbUj++a6Wy7vmaakRhoyEuJeujre8AwO+P/1JRx4KLxVHWFuPOdFpkO92QDPtghjNv8Ccb92NWIBPCWimJrKnFoAW1A0Zlm+2YpxSJEr/KNaxXNceoqxE2OaNhIG5fqnsutG/WqA8E/KkM1Y2JhZHojquO/fUqo/N2VXwJwzuaKS5CfThYq9jKKZLlrEPDwJ4a6v9074m8RE+Oaq5E4184BFJc9lXFmBxcDoFWFd0TES/UVDfIGuK8uSV71BkE79zOPTUWYHSo9mAi8zzuX00EJg15F11QDVn1o5s88BG6M+0zlBHED0L0oyfhNWUeFYHy/fM2VPWYFRchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvjjxZtHsj5RQO1YafX/vacruVcVPLniMUZc7PaIDTk=;
 b=ZSdmzUq4LahdldLzbFCWkCJ5MKdFm1AF5x/PIqvH6hqxe1BaO5QsYW4Ypjozy424e3ZgjW7QuF5BcwYhmdKv9dUDS18hYPpo++KCbMyq8skP25Cp2xMTzXdBI7aKgx/g9ZQ+DzuIMdOabrcAiNQvw5aQj3ugJLnJlxQPbW/xIM4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 01:56:50 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 01:56:50 +0000
Subject: Re: [PATCH] mm/page_alloc.c: variable type of 'progress' should be
 'unsigned long'
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200915104620.20582-1-yanfei.xu@windriver.com>
 <20200915174855.822d866316948aadb8193e9b@linux-foundation.org>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <3d7dde64-826d-e449-0ca3-6521619cdf32@windriver.com>
Date:   Wed, 16 Sep 2020 09:56:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200915174855.822d866316948aadb8193e9b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 01:56:48 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9cbe1c2-2c5f-4ef9-cc08-08d859e3c6a0
X-MS-TrafficTypeDiagnostic: BYAPR11MB2805:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2805049F04AE0CE75D44FB5DE4210@BYAPR11MB2805.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyNggX6Jifq3QpEGHh01zf9oGB8GdwjXH6x1BeVAFNIZESVrpwSpcQJZ1MbGixZA5HSFNvTsMe0H2JAU/3LdIfWgeafnx5naC732N3qLSmk9I2SxKqkZ+BHGhPODsLsK7EkP77knrcC0Drrnl5i1nkyyGBAkCfptnLoR7OMYAHTsou4s7i6L9rmn2Y+VD+W2NA0y7qd9G9ug5S3O/DwNLEcd+7LBJXSNWRhDaGO/CJ2PTclOW3zrPxdsN7baEaVN5I2nkoCDvoJFSmmvceh8jb3hRgBOcH+60blZK8YXDYF22sh5Gj6SscSuFHV9EqFddQdVulVbYr5RdvpjLMzl+M8sHA3pgHLq2essOFnRgQ6/ygqRHaafXJy06Y6GySKHY4IGguTC4OaLdq19SepUww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(366004)(346002)(136003)(6486002)(6666004)(956004)(66476007)(66556008)(66946007)(8676002)(2906002)(4326008)(6916009)(53546011)(6706004)(4744005)(26005)(2616005)(52116002)(31686004)(86362001)(8936002)(186003)(16526019)(31696002)(478600001)(5660300002)(316002)(36756003)(16576012)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B33DOD54D3t2vWql/uZSHuu982gCCs+kH+YQQAU775oSjEAJC8+3eUWHQ/hE2aUYYyjp6D97CwidiqCfbkRlPyD+fVGG+TtCPLFRuS+VzXr6xDkGZGytIBjNUE/6XVo0bOBNYN+piZnbFWTp6q0yB/4jJNHZAtKYnIveH7TBILNu/Il5U3/pkHhIqqMGQEE0/HkoVliutdElsraRrM9SjUSSpwE7g2d7LndlXJFm1fei6csi8bPhgkY1eJXvonp39ALTV2rH5HL7CL/wHi5R2L3rj8GM8nlXjBw0m+gmstlKlkyhfh9wHMF2aP5S0AHe58hZazMcKokmjXZw/nnx4ZnS2teteAiVgIe2iKtR6ju2sXAXBi2e9MuFCdkR4FgE+Y+uD+MSd2Cw3mhU8xRp58DywHo0bdtHKTUydOVvAcFjGDE+eHjL8cucXpRA+apQToAzUfU7UwHwuYIsDPiLl+6viWX+untI5MEn1xjzA3gGohv8woiwSc47srzWaBdexM3nJVkHwg+2nEFDh1SW5H3bK1nKe6ADsv7y5kCj07YYDRYVeRXnu1RsTtRwIwE1NSSlLAngsHM1K2R9Rd5Nem7VbpdPRSX8UvOBag0vAu1AdGEcewG2/ZsJhGr3ITMH5PDY77yggOefhWu1CFGovA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cbe1c2-2c5f-4ef9-cc08-08d859e3c6a0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 01:56:50.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYG2prD3btB7GHdGN+XNTDwzMw5fPPNM/pu5V17YSCpzVyva9eMs9YxIrXcSPvlIg5WrDFlj8DTg+JSyJchO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/20 8:48 AM, Andrew Morton wrote:
> On Tue, 15 Sep 2020 18:46:20 +0800 <yanfei.xu@windriver.com> wrote:
> 
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> try_to_free_pages returns the number of pages reclaimed, and the type of
>> returns is 'unsigned long'. So we should use a matched type for storing
>> it.
>>
> 
> __perform_reclaim() returns an int, so this change is fairly pointless.
> 
> However __perform_reclaim()'s single caller expects it to return
> unsigned long, so including that change in this patch would make more
> sense.
> 
Yeah, thanks for reminding. I will add that and send a v2. :)

Regards,
Yanfei
