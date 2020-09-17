Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15E126DAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgIQL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:58:40 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:9825
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgIQL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlACktM+RzCbiHIAvu2vDks3GGiiqT4wEptIBOfW7aqFULR+SbHtzs8TUek+irGrzRlFCqJhSWOX2id6uBP+VsOPMfaiHl/JKio2d+8wJ01oGkfxVbUs3+pkq2wUdchZJl0DHcZVl4KiRtgdQyv5y1vQLiD3bgpKLcRjQHC02IAd1euxnxMs6meXONfKHgg55TwZn85AwbgutShBWy8s6e6CvF7UfbMUtV38ymN+WIUaRttvbl9p+IDza5sxC1D11NPSMcmrPT0VCAWT0LnWI38PcJITktaJIECir750k0ZQo1ePjAx+v4X7K3LcS7Ts26RPtTFe6L/n47dTjSzPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9TMCTF2NL79IPMiBgTFU1ihOq5tg8q69j9hsFpjHqk=;
 b=ifoQaM82+79PL76LESLBU5sCPPMhlPc68MrCC63VerXWucapyZEkY9+kHyXgjwvDPhkomLZT83Op3Wfb9whUoxzEbLRnJpGYCUCbQjEI2PJDTh+QbEgrDOLib8ipve0FkQIuypBIm7fw/4WenlUhZeqlPqbfdV5gWlpDPFXI9X75yaq9+s2uo6ejJJowO9mRzp9ybQUFeFH08PDhQ/hugTsGJrZpoSi6fR/7/iZeff7P85nCY2wSqrVzv3v73J9h/VLiITsx7LpfcZSz/P/RE0SY2q351+I2ArzQYTYHf43H8scf4yEnnWiTsQG16YjgVn60RnTDi6EniHxVJwf2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9TMCTF2NL79IPMiBgTFU1ihOq5tg8q69j9hsFpjHqk=;
 b=1jg1GOaBXgiKWpOgFV1KDpEJaPaNsRaIJneeIYTWAjilnbbIvBgJB8tFFkWL19YdRAmPNruxltjYq/irjKnZO6Z3mvNOVPGFfyCk9LpOfyrHwF4aFL0Pw4AP58mdJ6hf1yz3iLt6t2qLlHDPS7AS8mCIURh9JH1eMN0gdGy9sGY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 11:56:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 11:56:20 +0000
Subject: Re: [PATCH] drm/ttm: remove redundant initialization of variable ret
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, ray.huang@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200917114246.93291-1-jingxiangfeng@huawei.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d7d1403a-acdb-e823-e7ba-e973860e3e4b@amd.com>
Date:   Thu, 17 Sep 2020 13:56:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200917114246.93291-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0111.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 11:56:18 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41b71631-cfd5-45b8-b678-08d85b00b0da
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3792D9C008BE7A8CCE63788F833E0@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ghg3C3IJfVa54+wkTpxag+HyoAIN+xJqcBzEERfmJ8asAnd2aKRcyz2raHXoX52TFWo//A3OKBjwkurSut06Yql2ODoWglEZyNoXFx7u2jxctqIpsuntEgUSA/SfSvwG5jI97pF7L2taGSlfvRXhw5mkzS+nz6xLGjFmVHIROOxlN9lvTcMjhUNriNl9fydDKo7RLKtppjQQZZnouKS7ufblobPr9DFeRS/WudrtjciiAFbIkNx+VpoXa40cWJFebiTt4GyCAeHD6xwaLrniWVrT+9xCz3sriVP/WFJd6uUuHszbwLfWUXgZl2B62nxb7zza1MTkqIVaDw2aSdOKGCHSSCqPnZVaKR9sCrjFvN8/+V4YEiv0P7r8W/2w3pPh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(6666004)(31686004)(2906002)(66946007)(83380400001)(52116002)(4326008)(6486002)(86362001)(16526019)(36756003)(8936002)(186003)(2616005)(31696002)(316002)(4744005)(66476007)(66556008)(478600001)(5660300002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YtYxhfCM+W6EzbvuizTiay150+VSmQmG24tYCqlaLSM5n2w5oQ14kcfPu9CoQY2n66bFoenkhNCUt/W1932lZi7JUAqEGrCVdKILhf9hBANuVIST2WrwoWOEpuihPNs34cnkSNBv3LfDNm+WUPLZfyb0xRyRZnT6u5iMeSo1jAdRCB4G7M1vhYWEuhXvFm0ijtMEkBXNhkX9rrldP67r8rTR4XH0snzp0mg/lb/N6fI5Ahn8lYIAPBtD0Lqg0f3mPN4EgfpmWuh7/7PZnt7Ic4AWHQEFEqb3PJHTK6MwCbBQ46tCxYmlOF9H6rCgg4Pd11KRjAQLEgsuUy15aU2QTGtfmzIxpxjgDe4sMYvyAncB9ktGTfwbdUsoclePt6ibmbRELr9KXRrI9xzEg7z5TdrJ94YO7F9JHaSV8Bh7eCyy4LBbHghw+EEcQLNMOzHULM/s2ImPjae97LoQZ9n+/onqdjP/ClwoPoQ6xZK5jRM2F1WPM1qQeOZxNY6oQCqWGC0VGXAOU8FZ7xfV8ovCefRjjYMGa71SId/7y9TXVFb9CEFDQ+ttXF7isfS9IepeZ3Jjin67MJEx9wuDfu5rcTWIGGGsj97zQ7iNahxPmGYlCXW9hZsLhR0L6bKUcfoQq1tFYPPzY4erWTVthmjdZmQNe5mwCPCKXTTaW1gZelNMyPUmL/wnjJkoML1LeBqZLMLVA/cviIJN3Uk8TnEObA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b71631-cfd5-45b8-b678-08d85b00b0da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 11:56:19.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFu1wsO4igYrEkYZIKm5c0AkrD6La2fsIkEfoKSYbtAfl0eHENV9RueMWro7mudH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.09.20 um 13:42 schrieb Jing Xiangfeng:
> The variable ret is being initialized with '-ENOMEM' that is
> meaningless. So remove it.
>
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Stumbled over the same thing just a few days ago, so this is already 
fixed in my branch.

> ---
>   drivers/gpu/drm/ttm/ttm_tt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index 3437711ddb43..4db87b9b57a8 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -388,7 +388,7 @@ int ttm_tt_swapout(struct ttm_tt *ttm, struct file *persistent_swap_storage)
>   	struct page *from_page;
>   	struct page *to_page;
>   	int i;
> -	int ret = -ENOMEM;
> +	int ret;
>   
>   	BUG_ON(ttm->state != tt_unbound && ttm->state != tt_unpopulated);
>   	BUG_ON(ttm->caching_state != tt_cached);

