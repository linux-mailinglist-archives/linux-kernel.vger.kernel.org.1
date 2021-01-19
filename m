Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38A2FBFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbhASTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:08:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbhASRyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:54:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JHmVmM044996;
        Tue, 19 Jan 2021 17:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DBGDjuMUpyBBHdC5/Rdc18iIbLT7DJ6jf6RzJ/ym8dg=;
 b=PnjzT+T663G8SJqA+R5l0Y8KDbjDHyMsRUcdyVsGWzwyiP1ta2kfFC00Tz7Yp8uYHu5x
 PItdQe1CMeFqkpWDgifKKuzgF9pQWFIQneXeB1/S8QKSvMaJ9wLyca9rn3jgqWYs14rB
 JQLwWxoExrndk4RkY3lM88TioaPnUhKtFiVyGOLqGX51yI4FkEZxh6O1uu1R2M64wu6t
 7yu6wSP7Rqr+V6cZOyFKWk+CpTKYjV9Qtw7bMWjUqxuqfw9QRehaitbMuAu6uh4IxQBU
 xnl1msIvWTGoPnJ/Uwdy7lFuqwd/8YP4IUBpx/8Ot1eyu5p2I8ujc966oAcgzQA88ton MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 363nnajfsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 17:53:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JHnj36054222;
        Tue, 19 Jan 2021 17:53:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3661er361p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 17:53:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7AFDJpokQhO2wYS2Nf7M+FaJgdwfd7vaRmiEkTXYBax9Npe689XQnaZM0NKdac0kIRnJuPzwP2iQqS0+e6oFfe5bTgzKwMTdwSCO/i7nGPopOWMbqA6QSeoO4l4F+8xhvG2ueOCeKVoI/O1AqG/jl3oAz6VmhVsyO3wLdFf8qXgBveydp133CswexFadxO2+XuHJHvJixUedfJkfBYw79TV5Z7KgsTdSPYDbJhxre92OGnDJR6vRm6/TqIvp5hGZNTHM0tTRTBDnrx5uyfq4Inas9m8lNlyr6LUhVZVERqa5NOzoRvDCHM3jQfgBQvVJN8L/8v3IeEVhem9dKhc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBGDjuMUpyBBHdC5/Rdc18iIbLT7DJ6jf6RzJ/ym8dg=;
 b=Mh9ZnCKnPUQcs2ceUtBY95W6bSKafAP4yRB5is52HdjDV1PZp3ksHVSBIatZU4Z2KHsiZjJhg0stOb7G0YIMTLEkBXuflso8kKMb/woeehdbxKrzublSZnqE6y0njAerusHa2nEweQQx1nwPbCn1WoYviDocfs0lPMFL6MlFXORhcfUEpEoWpVP2be7BkYFASTyDJYI8YTyYMokG+Nly0XfcjCDpgumF/P1ftVzOhIkIQZErYgh7ArMyr8lxwVz3dA8Fwv9JcZs6dGkrLITLobqwFr/mD21veOtKaFgq7VFXHktWY5NlhG4+h+xkkTpCJWmACUWM+kq5pCt6eTn6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBGDjuMUpyBBHdC5/Rdc18iIbLT7DJ6jf6RzJ/ym8dg=;
 b=LNT88tke9OXMku4dwhEnmhLvJN86SOwNq9ZcORl3bir5lPBrvQMOCk3tobVQ++bEHytrdxZHf7bR1ko5ua31I4RP2Vm13xWjVyzfTAVdZQbDNOGm9QaYxOyMrrun7JvndoiRLadvfNc7ygALTuqZGJD/5ARpoIqR4mXrouWtLR8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB2045.namprd10.prod.outlook.com (2603:10b6:300:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 17:53:19 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 17:53:19 +0000
Subject: Re: [PATCH] hugetlbfs: Use helper macro default_hstate in
 init_hugetlbfs_fs
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210116091827.20982-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0aa2f156-a2c9-3b2e-4244-ecf68208b4a0@oracle.com>
Date:   Tue, 19 Jan 2021 09:53:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210116091827.20982-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:303:b4::16) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Tue, 19 Jan 2021 17:53:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8939c53c-7fd8-4bfb-d816-08d8bca31abd
X-MS-TrafficTypeDiagnostic: MWHPR10MB2045:
X-Microsoft-Antispam-PRVS: <MWHPR10MB2045DF53AF677A59FF9E89BEE2A30@MWHPR10MB2045.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puR+bgtemTXLY7dEHi1Xfq7GIJKya9zwNXOz7Ph3ZW+Ng7Y2GS98zdj2eperz5AAU98ARMQbEIebnWtvT8f9sbWn7fKSgYlQ9kXAwa6OgiPnfES2dQET9f/FKifz+bo6wKqob996uVwEwWheiPRs9paOO/N06u1cRLHlerrtuurqaZrOPGEQcyiRf5b9Pqg470hxURYMvsGL1DXkrzG+XyblxcCsqgRK+j+Ys5JFmJKf68nqNDrrR0yUUphnxIhVWhaxqGE+DYLZYq1R794pOW8oUsbsWGv4HTqBZfXN2wq+F/+Wed0rVbcDEk5Q5p42MFSKKr379LkyC6O0SXDm8XKXxWj1/n24YqXTH6hmdUHYdJ8WWxuXdnliFvHo1n24+Hw99rLAF9a85kyTW/wb2AA+Xvb1m7fyGTqGJ9XmWOWZvdh3V10044N14GG703zh5cyzzsLhI3prEu8zrJGhZ/vvJolqMyIot388Y1mjIv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(346002)(366004)(52116002)(186003)(8936002)(53546011)(16526019)(6486002)(31696002)(83380400001)(26005)(4744005)(316002)(2906002)(5660300002)(86362001)(16576012)(66476007)(66556008)(36756003)(66946007)(6916009)(478600001)(31686004)(4326008)(44832011)(8676002)(2616005)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SlNBTVlmOVp4djJKNzd3ZE1Oc0lFZWZiU1dObVA2ZE5QODhZbjFHWEJUN1d1?=
 =?utf-8?B?RFlZUmVrZzNDOGZJNWc4VG9aallxdEpLbFBpRjBybzRwOSszNWJ2dzZtM21u?=
 =?utf-8?B?dHc5TUJZc0RUMitpUFFCSzZWaG45QkhTMU13K3pyU0FSdTQ0T1hlbWkzd0dk?=
 =?utf-8?B?TGwraUl2aW1ockRNWlpwQ1M3bVVsbGQzWm0rcDZMTFd4NGZlK2YrK09HNVhX?=
 =?utf-8?B?Y3N3UXdDUTFUNy90ajdkZmxSb0s3M3VBTjR0Ylh6VkU5ODlPeE5OTnZOekc1?=
 =?utf-8?B?alhPSjdyQ2J1LzFzZk9janBoT2k5aUtPcUV3WW1hTGRVUks2UjJrUkVIOEN6?=
 =?utf-8?B?MEQxdkZ5NGYvU1V5MjRreWRvL3F3OXN2L1V6RUlDWFhlQjU4NnY0L1pEVHU0?=
 =?utf-8?B?YWdlc0RDWmdkclpUaTRsbDlhSlVodmpGTXFLa0wwR25TVHZ1Qk1qaDVPUHlq?=
 =?utf-8?B?d0hsZCtFOVJSdkplWU9YY2VRWW9lZFdDYVpPTEI3Y2l4TFBITkN6K05NVWtr?=
 =?utf-8?B?UUUwaVFuck0rRjNnakpXM09FMllKbkhzQU1zalF2SndJb29rekRKbjZmVWdF?=
 =?utf-8?B?RlZyV0dPZTBEazFkckxIblV6UG12eER0cm9lQXFGYjFWeGFjMTd1YWkxV1du?=
 =?utf-8?B?NXN0bWkrM3ZrdW5SNGlOdVNUaE9reklZYVNjY0tNWFVYaUd4SW1kb3pmSHJL?=
 =?utf-8?B?NmdnaGlzUEZCd3B1WUNJbHU3ZkZUdW9KTkVITjNmdXpPVXFlR2taOUJHU2Q5?=
 =?utf-8?B?YWMzb0hLU1pNS3laUzdtVFEwQ0hKQ1pJTW9sWm80T3Y3MVpVbzlXODVwL3NG?=
 =?utf-8?B?VmFqUzNjMWNWNnBIVUdXbFdRbUVSRzZjaDdXd01yQzFXdWl0azJzTmVERll6?=
 =?utf-8?B?NEYyZWZSMTlsZlZ5Q0FrdEh3WStCU2pCL0JKU2tPYjZlM2s3anE3U2lBazJN?=
 =?utf-8?B?STVocm1vNXBOTXJQMEU0dlViOWRkRWRERytpbEpUMHljWEFDS0tZM3czV2tB?=
 =?utf-8?B?MHJkNHVLRFFZQ0Z6YXVoZ2hRSHVqdFpvdnFxTG5OemFiVXY5MGFzd3VDQ1lY?=
 =?utf-8?B?eG8xSE5JRXZVY3pPMnFEbC9TWGRWQ2dodkF3RVdMd2J4RDNyK2V1Nkg3OW9q?=
 =?utf-8?B?K2w0U1NyTlpCRHVCeStKWXJhVmQ4cENUdFY1Nkx6VjdOWlZsQkkxT2JybGZS?=
 =?utf-8?B?REJCSEptOXFFRDRxb2dTWENMOWp2UVFXN0xpVWljS3djcFNUZnJEdVduMEJv?=
 =?utf-8?B?QW05TllQNmlVV1hOVTk5d1VFUTFqdDh6VlFzdkhIK0JEWlFLTUU3K3ZLTVAz?=
 =?utf-8?B?eGxWa2hSLzQ4WGVUU3laU2lzV2R3QTlPU1hWOXRUUVlpNXFnaGliYVFSZFNj?=
 =?utf-8?B?Zm5nakZULzI2Z1o3R2FqRmpJZjRGWFBxNm5td1NSangzaERRd3VpWFkweFhH?=
 =?utf-8?Q?GrvHhM/X?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8939c53c-7fd8-4bfb-d816-08d8bca31abd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 17:53:19.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KrIq9rhc8bEAbOZREEEwyMRGNik1BQCMkw4E1Oxief4PbXKjEWGdCwje50Jo9qYJOLqmccds99DVrTiXJ8KFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/21 1:18 AM, Miaohe Lin wrote:
> Since commit e5ff215941d5 ("hugetlb: multiple hstates for multiple page
> sizes"), we can use macro default_hstate to get the struct hstate which
> we use by default. But init_hugetlbfs_fs() forgot to use it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9b221b87fbea..88751e35e69d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1544,7 +1544,7 @@ static int __init init_hugetlbfs_fs(void)
>  		goto out_free;
>  
>  	/* default hstate mount is required */
> -	mnt = mount_one_hugetlbfs(&hstates[default_hstate_idx]);
> +	mnt = mount_one_hugetlbfs(&default_hstate);
>  	if (IS_ERR(mnt)) {
>  		error = PTR_ERR(mnt);
>  		goto out_unreg;
> 
