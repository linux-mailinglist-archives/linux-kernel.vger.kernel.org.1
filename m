Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088D2ABD6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgKINpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:45:51 -0500
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:26688
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730096AbgKIM6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXkr2eTiF9VK3kATvnBCq+VKt74dDX2u/3+RxKwNWfdVy0bD7zaqz2LSMYa/EfoErVlKqh7kxti9XamMoTek3nz495yfCM1Nk91BFBAp1/lUb17shP5oGk3vUxGG7N6QGmRiUAb2rxgXw9MeDNJTmCXjXOQd1nNSA5DKUabd0TY605peHxNGHfUnI8cxFTBvRx2pBST1JHnT/rMH15tDx0AzYaAj+QTxWHpFd+DD4zlUfcZ74dr5bFYlr6kn+bsTaoZF/ftNRJi2f4R/Cs91FMPFYW/EObuWXWPAfomdNflVbRrPl1hPgBObgOLP1xfsqv16L/rhSrd0jeVxGwxKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCw6CO1mUtPBefCNLoiLSusUgOWlO9GMEv6OmYWU06o=;
 b=d2R65AGDgJ75fQfo7Ayz7ktGyoJiHaQcca8aWIrq6JNC0lFAwKtKXtHMfjBOAHFITdJlD1Bhjooc2eh8x9PbwABYSIT3C4srX+r+cShfzFIwyPW1JLDVJpBEY+4Jn0gRbfEDuI92TPtzrBKCnY42+V9hFyYTthT1Fbfqo1JDHmdecD9kALZ3qspOMkzqS25Ns+CP2HYcxHnSrvYLlfjmkkwgBL7L1f1mQu3cZ74mr5hzkQJU+15vrwzRC9Fz3kneAHXUFNqauhj+7fv5CReEv4D3ML7aRTBwgNATk+4gn9LAJyS3MNil81C9OuHCo0ykVIfvZwJzGHiY0CJkXkAdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCw6CO1mUtPBefCNLoiLSusUgOWlO9GMEv6OmYWU06o=;
 b=M3o82f48RG2dgWKKql90fvNoi93tqrqox//WG2J3/hHjDfXNssFj94Mx7Zv0YGBbMXDtMX3uK6jee5JGToZhvPgcJ+rolXs02PVW5QsjvbrK+ImBIW2ME+LwxR4BGc4tTXgsCV586DDSHcb1aoeS9ppel/CO45nsm9PiJYG9X1Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3769.namprd11.prod.outlook.com (2603:10b6:5:142::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Mon, 9 Nov
 2020 12:58:04 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 12:58:04 +0000
Subject: Re: [PATCH -next] cpumask: use false and true for bool variables
To:     Zou Wei <zou_wei@huawei.com>, paulmck@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        abelits@marvell.com
Cc:     pjt@google.com, jinyuqi@huawei.com, linux-kernel@vger.kernel.org
References: <1604923190-70981-1-git-send-email-zou_wei@huawei.com>
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <80dd8254-c762-312f-c619-e7fc79673895@windriver.com>
Date:   Mon, 9 Nov 2020 07:58:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1604923190-70981-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.212.229.210]
X-ClientProxiedBy: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.35.34] (24.212.229.210) by YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 12:58:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f700ce84-57d3-45f2-9f4b-08d884af18ee
X-MS-TrafficTypeDiagnostic: DM6PR11MB3769:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3769FA8FDF57A13F6A7FCC1083EA0@DM6PR11MB3769.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAJ90fdiyJUFp7kjb+ExzzL2bSXCw1DEhzIfURrXd4L490qq8iWFhsQCCx1N5tvDn4l58UHBy+QvC1gGYU2UIWI/SyNZAO5c6obH8oHzw/X7jOgYdz22+WLXbXCAtNtGMfK6UI9Y569kEM5/Zi3U4eRXi/SD98fxu4k1bSjEkSaHwoGjnr9tgPYHJkSlun7EMZm7SITkU/Q0iGXSTrfjKW4vm2WehrV5TiSpUhqNRs87rb9SZ2IZDibgUkVGCDh6Pk4qyGtdq20Mi2ziQ1BAFUUl9wtUcB807RQ9ydUr+X9w5IdzaSkHzP0yyIZ2QSQl99pdG6L+IjMx+QLZIxXiZSCsk3y6Qnjs6WDYzwvD8ZrxorNK/syWiNp8Uz//P8bH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39850400004)(376002)(346002)(66476007)(66556008)(31686004)(26005)(16526019)(66946007)(2616005)(186003)(478600001)(956004)(5660300002)(8936002)(36756003)(44832011)(83380400001)(4326008)(53546011)(31696002)(8676002)(86362001)(16576012)(2906002)(316002)(52116002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VbliTmdYd0oUsQlQ8kAS8CzB/S0Jgdbmuf/B0+lN0zhyRuMJT8kgq9ayZtOodRpN8L4ciKaz5Abt1gwU6N5Aj1aXZ6FRbIw4xpvV47ckhxqLa3+C0T24X+jqElMAkG7dCZoGD0EbcwtmCW28sJPrZ8zTOS8kGNMCO1vJVdA1NVQ+YEh6xQi2t4VGVg0MHoGAaFapfHWTvDutIBGSGCLmkZzSC1ulQxLbc8Sb4dG9nqC3XIrZgiAeatq8d5AojFCuToqlPq3mG2rWwi/ezPewbEEC4aw0M4eV9kWFNnAggIuD7ZL3XOEl/RBkZeenemYjAOYzQmTtOmlLw3DArBhbkJdB+BGS6iEHv7ebC5QhqFb0ByLqAM+yYE/hgSeOWtAJlCAXhHHvWF7E4ePiw3IwsXXlD60nLPKgqQycH8+cCUc/mXMLBsff5YrfwPmrNcuSEn4ychJwTdQdgC/iVRyWdFt9fEQ/vYwcRQcJ+pcnaOW0e/4Rm7g2k46GvFA/m8CSBgAenhIy955556IctmrBrbKp3f53RjZeF6fS6NjDXD5XG97g9ZRbAGzZc+/OcI4J734UAtzFDSJyJBOHFVy7oI9pvzt+nY2OmIEY2gHY9710O1596uSaTYlP4W4RkH+OVDzFkJ6lSdr6R6Hnl9sntw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f700ce84-57d3-45f2-9f4b-08d884af18ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 12:58:04.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCqOqJWGh8vmsHQ75+PaPef3JH6jEK8SeNXuEz7DYQqDgzFkccMK/GVcn/WBhiGLwYH52TzL/PPu3q04fDpOBsY2PFGuYDg7J/5KAVQ2fwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3769
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-11-09 6:59 a.m., Zou Wei wrote:
> Fix coccicheck warnings:
> 
> ./lib/cpumask.c:342:6-13: WARNING: Comparison of 0/1 to bool variable
> ./lib/cpumask.c:351:33-40: WARNING: Comparison of 0/1 to bool variable
> ./lib/cpumask.c:406:3-11: WARNING: Assignment of 0/1 to bool variable
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>

It seems "Hulk Robot" needs an AI "tune-up".  I didn't touch any of 
these lines of code - and I'm guessing they haven't changed in years.

Paul.
--

> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   lib/cpumask.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 34ecb30..74d0cf1 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -339,7 +339,7 @@ static int find_nearest_node(int *node_dist, bool *used)
>   
>   	/* Choose the first unused node to compare */
>   	for (i = 0; i < nr_node_ids; i++) {
> -		if (used[i] == 0) {
> +		if (used[i] == false) {
>   			min_dist = node_dist[i];
>   			node_id = i;
>   			break;
> @@ -348,7 +348,7 @@ static int find_nearest_node(int *node_dist, bool *used)
>   
>   	/* Compare and return the nearest node */
>   	for (i = 0; i < nr_node_ids; i++) {
> -		if (node_dist[i] < min_dist && used[i] == 0) {
> +		if (node_dist[i] < min_dist && used[i] == false) {
>   			min_dist = node_dist[i];
>   			node_id = i;
>   		}
> @@ -403,7 +403,7 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
>   							       flags);
>   					return cpu;
>   				}
> -			used[id] = 1;
> +			used[id] = true;
>   		}
>   		spin_unlock_irqrestore(&spread_lock, flags);
>   
> 
