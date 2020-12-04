Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC592CEC6D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgLDKpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:45:15 -0500
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:39560
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728879AbgLDKpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:45:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1xNnYjBdbtFzwdSKrV5zOB+OgwirtDqeOvyPW+uenrSG1fqDZ+BwTXyiQgTPIwT8Y6w1Pz0/t45fbD6x/cPsKP+H6Lr2kFsLMPa9eSYXffj+jnrfs5wOw5mz7Q1Uk+QDkUuHSE3Ofrd/I3tsGETieIPmIMnxm2gFxeBAddPrHWlM8o7LkIsSGOHiQ/gV0mZqVpPZdMQycsvqhgcGyxJfENmThMmC79TdAmRB+90aL5IzAOxK87AyS2VJQqiF3qDSavf7pLaAMygDWBbtFewV1P4TCt0So0YGIT8Ld8GhfGt5abEZJ+gCFs5j4oB1FJGA9JE6WrQDGI6LTnjgcB8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POqAsD7sJHVTgu0OkFWkUTP2Z2RbNxRmXeRVVnLmBKs=;
 b=YDhyHwg6fBi/y1hXKBceJmoF4EolR0Ij2qHmMvVYwJt/IPoSXMrMMPyQIVPfFVRyf+3/uMnORkrNUG/RVXRUUBjFUtXDyYxQZBW1sGYp2YyBRkSsz2JCfrsKKDRmA+WNjNNPPvctrN9nV0qOPesLuCLEWKn/P3FZ4mUHXBTePmqvUe8oMKpVbPUf26+TR86UnxaeJNLYloFUFhljYnKYoLE2Mpa80V6xpWYLcQ09nxKp8CzFLwWn6XZStwhn33uqQXOr3uM9hoyJKwdYZFBXUasfGYjj9Y8LiQJ0/1foRpunmntUfxXJ3ASmC1GoOzUTd5udVxF4t0EYFU4UT9ajyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POqAsD7sJHVTgu0OkFWkUTP2Z2RbNxRmXeRVVnLmBKs=;
 b=g37R5ZU20DzAna3npyoa+pj99HTxfe9vG/GOQn9wp9azp8sap+LeFqHiisXz5gN3nd3B0IHTDdH0k/E38chgA8/pwGGP54A84CzKjfJBAtxWsA4UKDXKaCx+jigLykmkxAXyeAl5fGCkZ+G3R+wBihtGPmakZ71WHQYkUfqkPSg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3424.eurprd04.prod.outlook.com (2603:10a6:803:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 10:44:23 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2%7]) with mapi id 15.20.3611.034; Fri, 4 Dec 2020
 10:44:23 +0000
Subject: Re: [PATCH] bus: fsl-mc: fix error return code in
 fsl_mc_object_allocate()
To:     Zhang Changzhong <zhangchangzhong@huawei.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Alexander Graf <agraf@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <1607068967-31991-1-git-send-email-zhangchangzhong@huawei.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <b395e683-9ac1-55d1-319f-69a47d83d2aa@nxp.com>
Date:   Fri, 4 Dec 2020 12:44:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <1607068967-31991-1-git-send-email-zhangchangzhong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.120.184.91]
X-ClientProxiedBy: PR3P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::13) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.104] (86.120.184.91) by PR3P189CA0008.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 10:44:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e15886a2-760e-413a-6292-08d898418fd2
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3424:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3424ABA8420456106E9BF5B3ECF10@VI1PR0402MB3424.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1tFEve3MS80/yH5APpKzTYY3ARuQiOMh2uhM4u/x1SEnf3CtQ4ppg1tmg2J8ugahk3JjkrnQSxyoieMD0gZFO82EftG5IKmGq37KBR8f3Xa/hfQLylORcl68N8a40tkm5A6bL4ty9v7+Ff2/mvKV5ynmjkQSMZYFhajyeo6L/sROpiyYe5db7kzo0ww/KKzWVEngqiRdsmvzKJl5hMksT2GLZvs1GRcrUzpMaCoSuuHzOp8erG0vj6Xigb/CrGXsLQyGl527SfBQcJ2hWVuHVQ1WSEqJg0XOd74nKV+TiDKJLB6McIGohUAIMzVhZWXq2xkMqZEPlLGeknfQzgd3bLmRGm/VtRlxILaVLPzPHklWC9sYEKVXImeVn5eyn04SBvWY0bcpHbJ0LHt1FGosSJ2r72VFsUWzRL8OhoWUTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(478600001)(66946007)(66556008)(66476007)(86362001)(44832011)(316002)(53546011)(26005)(5660300002)(16576012)(2616005)(52116002)(83380400001)(956004)(110136005)(16526019)(31696002)(8676002)(4326008)(2906002)(31686004)(36756003)(6486002)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZjNBMmxvY2ZlSVVXRW1ITS9zZkdtUGZQL0N4cVVPQW9ONlJHSnllTHVwRmlL?=
 =?utf-8?B?N0VIQ2VqalRjWDNxQWJVdG9JL29RNGFTMTduNGdxR1kybXEyUUE0eWpSUUxC?=
 =?utf-8?B?cVJPVW11eWVqVXloeEo0Y1JIZGltZEs1c055MEVuczhjeXl1cnY3VkVBVDN1?=
 =?utf-8?B?YS9ZaVgySjMyYWltWXkzUUw1S2w2RGFVeDN4K2FtcHVUZW1Fc0VVVnJuaFFs?=
 =?utf-8?B?QzZudUFDTS9jNjcybnZBT2M5cmVwN2VseENHZ0YvMnZiQ05TNk1hdFA3a1ZK?=
 =?utf-8?B?b3JJWWVwc1hRcU5pb0E1KzhTQXFaL2JzYno1Q0tGQWVId3JVUnVyZWdFR0gz?=
 =?utf-8?B?eVJRbk1pWkk5UkJaVUdZMk9HZkl6RFp4cHNDaHdnZ08zc2JGeU5CK3dWV0Ju?=
 =?utf-8?B?L25RWGR0ZTRON2RIMzFHSSs3NEJrRkVwMGxjbFAzamROL1hZUG1XK2pZQ2xj?=
 =?utf-8?B?OUd3WU5TVkxzTXpGSEdZZ2hkWGZ1MkRwWlhVbTFyd1VLVHpUMnRvOVVUc1lm?=
 =?utf-8?B?UUp1MWhDbTA4M1dqR1NJWGhhVHRMWHVZd2VBcFZiNGZGb2g2eWk5SDJ2ZWdt?=
 =?utf-8?B?SkFLd2VWUGhhampIVkNGSG92eU9ENEE1TGdaWFlBNHVCYXBFZTRaemZic251?=
 =?utf-8?B?ekVZRGw1b1VqWkZtTHJOdzhpQVhsZFVmWDZqRllueUJiNTZRM2huRDVoTUd2?=
 =?utf-8?B?RXVCbG1JS3ZtbnFWOERuZXBMaEpCZjFCTGxpb01PUkVodG5CcmovNVJRd2Fn?=
 =?utf-8?B?d1lvUlg1Sks5L0czM0NwNVhBTUxKSExnKzVjUmdpeHordTY0VXJCY1RSR3Qw?=
 =?utf-8?B?M2hUUXVTU25EUGZEYUR2cEEyb0U2alFjZy9YN3BSanplSzZPQUozaEtSZkFk?=
 =?utf-8?B?K3UzNzFLSUo0UitNYVlMam80OUw3aUFDWlg3NGFKTG9QNVd4cmNlOXRjTERa?=
 =?utf-8?B?TjRESzBGTHA5cmhDQ3o0bVQxQURKeUlySEVlbVRlT21LcGFyTWpVREhObUZM?=
 =?utf-8?B?OTU1OWpsdGVKWFNNMnZXU2pDaEl2Z3Ivb2o3TFZndERIdUo2WkJYeTBqSGRR?=
 =?utf-8?B?TXRSUzMrVWhFS1J6TWQrcmFLK3lGVG9ScFpQbDkwNldVMFRmTEl6MUJFUFVT?=
 =?utf-8?B?VUZ4dTdoSTJ6K3Z2T2lURUdsUlpDbWsvYWUwVDlYNWtGVUhPUGhrVnRDRVN1?=
 =?utf-8?B?REErdFVhMm1Ic09pVGp6MlNlVEg4ZHVVRUtLYmh6a1NpaVNueFVibUI3SjVt?=
 =?utf-8?B?a1BCRFJDMXltYS90bjhBL1kwdUFEalQ3NzV1dFVaZng2UTVQREQ2NWFIYXVG?=
 =?utf-8?Q?DWAZzIg7CBZAIhMUSplLNWBnlUAsTBFGck?=
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15886a2-760e-413a-6292-08d898418fd2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 10:44:23.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNOA2st9oyEd19LJGne2mPjtsV+x4Z9E/uYK1CDCynfo4mnGy3uMyy2j3kMwcV+TRgf6z2iHbwXewyhyKL+v6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3424
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2020 10:02 AM, Zhang Changzhong wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 197f4d6a4a00 ("staging: fsl-mc: fsl-mc object allocator driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>  drivers/bus/fsl-mc/fsl-mc-allocator.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> index e71a6f5..2d7c764 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -292,8 +292,10 @@ int __must_check fsl_mc_object_allocate(struct fsl_mc_device *mc_dev,
>  		goto error;
>  
>  	mc_adev = resource->data;
> -	if (!mc_adev)
> +	if (!mc_adev) {
> +		error = -EINVAL;
>  		goto error;
> +	}
>  
>  	mc_adev->consumer_link = device_link_add(&mc_dev->dev,
>  						 &mc_adev->dev,
> 
