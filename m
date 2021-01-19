Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3C2FC1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbhASVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:07:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbhASStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:49:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JIZeRW184799;
        Tue, 19 Jan 2021 18:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gBx8qG8qjn77aUJ031uvF0DQA4Zrgnf+eDEhYze2XnU=;
 b=l3fSFOfZ5rU830VERr1X+N3npOYxBQoxlysffEgEGDyRmQ2bRcIToxwi2pnxJjtdONTv
 pTFQZQ4J+kbgGro0ZaimRLUWzExZgxUU64yVWB71KZAX2OBm5kzUtMMg6gJB0nWr8lgL
 UXg2bIiKGpVOZYOVtxUM6TiafrKMDuEuWuRjBO5VrsdHKJ0NuTbwcZDAe4vv2BxkBI+8
 4qJhAVLZLqgoiLdAcQJKWEMkvRLT8SeKEKJuA0yf4WwMNcPjOVTYiswH+AB1hi9LNmhR
 aWja7chZaZL0sUQLVNxC57NYAUW1lhU7D/ccxO6yevEZRrESz7oCjxTdSPyog8nYwn2G tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 363xyhsw5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:48:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JIZdeQ158638;
        Tue, 19 Jan 2021 18:46:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3661njnkn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azWUf/9073RWnU76Z1zuCe+kcsMEyxCHUUbf12jBmkUGqX/MNM7Us0yet7YNMhtMYmNm0N0iTw24sluoZESbGfR+XOSfRRZ/DzpnuxUTMRy3xSQvTdFdtmmnBIyrvdcv9d+IW7QoITpDD4/zt4t8sOEFupqxaf/b01rne4KDLRUsuhp/HDwFUCTkhtZjySxEq7VxnhEBl3gOkYda/NycWAlizZVzq7UYmk4eFsi79EklHFZTDxDuEsQu5+Y3VRUPVTQHI8NDbP8U6/mJd1nOcJFiB6MK3r1rRDZqNrsOeiv8uoliWVzb69VORl9CAfVWb64hVKG50zwXZ1Pmgk+fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBx8qG8qjn77aUJ031uvF0DQA4Zrgnf+eDEhYze2XnU=;
 b=eI+ON/5yG3eEAhMA+iilVjonviaMoXZtEX2fcaL9cPJUZoTWGvaymGAJ/g7hIrLVxgBYYVCwQdxKPj2WLs0nBiviC+YYOlQNOBuki3rbzYQNLjS7pU6m6z/K0r1AGx4xdXSBvlviFHHhSRDd5mmFac2c6oApBxs3Z9l6Xd+hd3xBpJ8deyW7NO7ezeW3EMuKr6+7LijjQ5mNygfVkBRTSlJ8GOC+CTXPTZR5yotOI/EGOTGzjmO7ktk/ECCqUpFsJm2ldDTjuhtWmX1xYNqC9gQmJPSJgmxkoC0HDbxFBITwb3Doi9GMxXutxjP/jZNUw8ChCGIpDRp9x/lj+ig55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBx8qG8qjn77aUJ031uvF0DQA4Zrgnf+eDEhYze2XnU=;
 b=snCbGj+809QKcqCLrRP6Buv0JD8dOFdv05Lgn2Qsbal3Bfb82XUC6V143rLI4ziwLW3GNgKnQuxZiR/CYZrJ20c2d+jAp/bq+gVyhwevaIgkre7FvazyxfuiaUTeflFquAi983Y0IQWBK2w7ZbboexplAiKoY8gxeGGWzCV6vbI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1856.namprd10.prod.outlook.com (2603:10b6:300:10e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 18:46:40 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 18:46:40 +0000
Subject: Re: [PATCH v2] hugetlbfs: Remove useless BUG_ON(!inode) in
 hugetlbfs_setattr()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210118110700.52506-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <98779b7b-757e-3dd7-d3da-8306da4fa9e7@oracle.com>
Date:   Tue, 19 Jan 2021 10:46:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210118110700.52506-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:300:ef::27) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0017.namprd22.prod.outlook.com (2603:10b6:300:ef::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 18:46:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b002336-8884-4f5c-b8e3-08d8bcaa8ee7
X-MS-TrafficTypeDiagnostic: MWHPR10MB1856:
X-Microsoft-Antispam-PRVS: <MWHPR10MB185655E40E2F28C10E4FB986E2A30@MWHPR10MB1856.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zT5Q7q4xAUM8mpHyiyKBqQZ22eMlEL2OIrgBsQp1HjcaGOvmJV0MgCsNcKZdhEpfy5bTiQetBDDIK/Mb7EQji7w8eb800UPqixu7f6Mky8VPzLSQqNA1wrhBILE4CEhdTDFh/VXEcw4K0tZPQ0bK567Ug8RRMQi18pDQYc9Jz/VNz3r5y+5grRSBpmse+WX4cQh/VtUZMLvTE2qphlBIVsJkwEWjBPrGHlNjwG2PJDEM8DOjCVXV/xzJmD2GzwQ8plJ5MSaBXEsxB89z8ynqY6qJ3zBB7nGO7t60u1b2iSHU5x/F2n3EqnmC3fL76KKdLdTemiWGmRDdc5HTnfLMqfKtIMJGo2DUjiHWJOceooJi9KJ16caPTzbMadz2a+3OFolPNi4kK2/Bx4LLO77/vPy5+xl54NvOK8zupBcuEmySzm15BfwmRxJyuKpLY1u0wznDBiJrfrnKgAhRQSiazBZ3cyhyHoQJ7FU709pBHLf7/pwQGHekw8bd8sfOK8AMnbdpPSAsFapLoHrK7lP+epTq0VaDTvBORNv0OyR66Z23zORjrUY6dj+LQ7TgSknxvOqCHc6klfB7/Hdy7tlBAQXaQ68m5NT40eG5B4xfUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(66476007)(6486002)(2906002)(16576012)(316002)(53546011)(956004)(16526019)(66556008)(8676002)(66946007)(4326008)(31696002)(8936002)(478600001)(26005)(86362001)(4744005)(186003)(52116002)(36756003)(5660300002)(83380400001)(31686004)(2616005)(44832011)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDAwMFBBOS9CL2lESGkvY2phejM5ZmxwTG1kSjk2cHZxUDBYZklzZkY2akxj?=
 =?utf-8?B?TmZsOVlESmhjNWNjT0tUOXhjQWVMNFJCS1ZRVldOUXFIY1lLS08ybHNwb21r?=
 =?utf-8?B?V3BRNkhrTEk5VEFTR2RRaXFlL0x1OHVPUTZNa0V5aU5aWW1ZRUVzVm9vN2d2?=
 =?utf-8?B?d2hZOHZjOFptaXo0M3BhdmhZeDd5ZUh4VlRCWXJnRUxPeVF3aytVTGtxaU0y?=
 =?utf-8?B?aXozMG9RRktLK3h5dDZycXpjNTMxVS9ja09QWG51eE43d1JVVTRQelRpc0Zx?=
 =?utf-8?B?L21CU3RjNDZHdkM3SmFoQzdUd1laWU4waWtibHpNOXMvbXI2ZDlzdE92TjBq?=
 =?utf-8?B?R2J0RXpYZE5kTWlYWGpFQVJlamRmSjNOT1hPVUJNa1ZVRDBzNzBLTy9OdFgx?=
 =?utf-8?B?WEdTUXFzcGFzUzZkc2xzd0I5THNBZm9xcXVoUGNkcFRkZDhTbHJLOXVmWTJp?=
 =?utf-8?B?WnpaVkpadHlkWnFFby96ZVk1SStWcjNIZ0JjSU51S3o1cXJrbHhkaXVxVGZD?=
 =?utf-8?B?VnFxTSsxS1RjNkJHdUFna3J5Q2ppTHhIVnJTQ0hWeEhqdTJKLzhVUW10dzlT?=
 =?utf-8?B?TEtlcGUzQllQMDJ1bU1BNkxPTWIvTjN5OHpOOTdMZjVMendsLzFyM2p3S29m?=
 =?utf-8?B?U0VDNlJzWDNma3NlZk96R04wUFMzMWsyZ0xxR2xOeEFVblp1c1hmU1ZOR2Jm?=
 =?utf-8?B?K2cxMUxHdHN3Y2tMS1l5c1lXNkRmSXIxcGNRSTdBTVpmQ2toYVJEY3BybFFP?=
 =?utf-8?B?OUlocVlNUzA1RWNxYkdBeno0dGlxODJzcE9zRUNWQ29JWXJTNXhWUVZkdnpt?=
 =?utf-8?B?TnRBOXNQZFpZaCt2TldQb1BJREo5RWJaM29aRHJOUzVFQzBqZ25UOEF2Ykds?=
 =?utf-8?B?VG1iTFQvQ01uV0gyK0Q1UitGSGdSWUZZT29tVms4Q1FsLzgxV1VWWHFXNE1G?=
 =?utf-8?B?UGh1L1hiVTlSWkJZT1FMZTZiMVN0TWU2ZWpURm93cjI3S01YREFTeHdXZS83?=
 =?utf-8?B?Q0ZFTEI2VEo4a25qdTdWR1kxYjRyNWZrYTdpcjE5KzRnVXl4UjViaEdrcGp2?=
 =?utf-8?B?MEtvRzB6VExMUklJRm01dHp5bUtiSUwvbEZqOG9DM0tVV1dwbFlhbk9xMVox?=
 =?utf-8?B?aXJ4bHBpaW00UTBIV0l4VmUyQzFlSmh5NERLRWtWRVhIT2cxUS8yWjlXbjla?=
 =?utf-8?B?VGN5eHc1ejNIaXVLUnNhUUxtcXBXdG5lZU1FdDAwWktuL0J2SHFGRWc5QlFP?=
 =?utf-8?B?TzZSL2htbDdkdWhKcExZOUNqc0p3TldBVFhaRGdIbnoyQ0RmMmpkeklDWDRn?=
 =?utf-8?B?alkyRFlQbWlXUTBzVEtUR2wxWmlrUWhXcFc1ekd5ZjcySHpxcm5YTERnYlRt?=
 =?utf-8?B?cHNKSFBYMm1Rem8zSlUwL3hhbytpSnJ0M1U0RHZyNTd2d3hWckpWYk92WHl5?=
 =?utf-8?Q?/N1pl6Rn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b002336-8884-4f5c-b8e3-08d8bcaa8ee7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 18:46:40.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cstIXeroS95C3GGcQb4NpcWfWgDGVhBeg9Bhw6yRzH0TxfRrd05a8oEra2Ysw6D6mKjA5dYVFzvliYzEgbZ6dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1856
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Andrew

On 1/18/21 3:07 AM, Miaohe Lin wrote:
> When we reach here with inode = NULL, we should have crashed as inode has
> already been dereferenced via hstate_inode. So this BUG_ON(!inode) does not
> take effect and should be removed.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 016c863b493b..79464963f95e 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -759,8 +759,6 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
>  	unsigned int ia_valid = attr->ia_valid;
>  	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
>  
> -	BUG_ON(!inode);
> -
>  	error = setattr_prepare(dentry, attr);
>  	if (error)
>  		return error;
> 
