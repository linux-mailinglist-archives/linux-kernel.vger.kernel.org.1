Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C412FD87F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391876AbhATSY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:24:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37684 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391850AbhATSRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:17:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KIDwxg016702;
        Wed, 20 Jan 2021 18:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DCDZ9hZ1hIttdKTE24l5wiPcF2y01aFfxv3e5ZJprUc=;
 b=rWTnpRIzAfpGAjaezapdQx5zKN4egVzAf5tAx2m+qkUDHEb3uuhWwiTHleulXxHvGTKT
 BJAReSx6MzppxAuO4QnCfN7FjhH3ZQkyLXPNgLBUiHoxyL+7io6lLl5gQIbAnLTgN6Bv
 5LqBrwQ2en4T2o1qGbyPvUtHr5FQwPeny+Kr2wnXCI/wjwCiDnbkIldFyc0YOZ6706aO
 u6mrz8yD7TRioSmIn0ousNnsX3Y2YeffceBvkjVqBjCJx27c7t5Ba6Tk/YNRML7vjvOP
 JoLZdmnBb6JRvreWsuuMOzy6mcWKNdLsFrbQ293/oSQMWE1hw8bszp+YIlua7GdGhZfQ sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qabt4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 18:16:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KI5iT1114190;
        Wed, 20 Jan 2021 18:14:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3668rdk778-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 18:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6IwQAqoEeR9D/eK3DhZn2bpTJ5t+5TzmFlajbPcf+tNvj74FHIfdbTs8Z6fIA5Z84lo4mG559eOKGkTFzEu1kbkLHWt96rZRo6Ybup7fGOGlnGQz6C1f5Y8+5LuYMUmefNxtCvK/HDydO/Fmdk8PnRTg+OApWyPa7QERZBRxcpaha6HVo1mUky3YLK8OyvAx7rJSrS2LIniVErEXYwTaxooo2d4PfmkSE8C2BfZ+xorCc0QebEhGApd+DDs4YGUie0YTOxEVAnfP1mORlrJh+rqvIR8T4Ox/PKUTJlsF6/PNzyUzDZl9AMv6d0m3kB/tYF4K8ijm5GQW5Sr482XbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCDZ9hZ1hIttdKTE24l5wiPcF2y01aFfxv3e5ZJprUc=;
 b=HTBBPTyEC47yHeoh4ayWcFp8LOSZFATPTh8ncSCa7IIVKsVHV43KNCBCHRmInNiSBrS+fnXRGW9RzS6D6Lk++nsPjzbp1B1IK8DsukChiqkClH69XnTWh2xv52AZsv9pcP+xn7ioWZR3dwgOQ2oC/VVP+yvnU3YHECIhBLIzRmMTCyXYpEnr425h8FxOzdcjbRqZV1BABpzcVTGMHeeeDn88n2qDnVJvcvo17+TRYJlAKPnnW/rNy+mk0UCcpszPShAJOGkjFrglbTBVSV4XmWZh3wQXYZxgqSRLf4b94S/mdA2yRWzBuuDMuRzDIzRw166Yo4ttztVUDJOrGHMPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCDZ9hZ1hIttdKTE24l5wiPcF2y01aFfxv3e5ZJprUc=;
 b=ZVIY9A8Ogze6AIzz+K+YNtgM5RuO5BAGMd8gzZJb22GcL+k2j968ZdLlJ+3jKJqyDZ8ZuaiX9+ifE4lP8EUeufav24nzKpGQVBXf94f5Boo53l89BsTvNvZoJhGuRE1mQwW5bA4GP6/Lt9Jcgrc/S+mA5habJsZZBo4uf4zVFz0=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2286.namprd10.prod.outlook.com (2603:10b6:301:2d::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 20 Jan
 2021 18:14:31 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 18:14:31 +0000
Subject: Re: [PATCH v2 4/5] hugetlb: convert PageHugeTemporary() to
 HPageTemporary flag
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-5-mike.kravetz@oracle.com>
 <20210120100913.GC4752@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <25c437c9-cb99-e7fd-e657-48e77b4c63e9@oracle.com>
Date:   Wed, 20 Jan 2021 10:14:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210120100913.GC4752@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0416.namprd04.prod.outlook.com
 (2603:10b6:303:80::31) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0416.namprd04.prod.outlook.com (2603:10b6:303:80::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 18:14:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32f83867-a374-4cd9-dad7-08d8bd6f3bdb
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2286:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB228664ACA61D061690EFC9C6E2A20@MWHPR1001MB2286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7r8nrgRcb2Q1N24O3ks/7gTU2ySjM2iaQhGCTy/jBtKL3Aiu1yEPgYfrWlHFq2ewxV66ZxtY1B4NqJWDBEOTWClwAwHRFEaN+43duhjEOMxpvpyfbwsGxtDYUx+EJ0zCGnxc83nXzjC54KbqGaPFCdrUdwhTrYtOzGgODtJxQtWfAKl8FyskFZPxzM851kWly2IwYqrYGF7aEbfv1qChLYr+WMbfoI+q7qF/n0XOP50geXKbS4JocTG84zMBj2jJu9bNO5OB14h35kLJp2MAY9NMFH8pb9JbClO9tiq3vLk03WrtyLokqDPk4cfO/68SepF4jxgUFR1ie/kvizVVslPic1MC7Fvj7OhA7hG8QgpJlooIHzFThk4S8FtaH+VD1s0mvSGdBMPrVZcNT/wo4Tpv14IejpnkQU5U8hDfscf/8b2OKJPgROAGdz4N/6LjCmz0SJ6TZkMdvKApYJZh9D/TxBhh5+re0cZ1f5Tdgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66476007)(16526019)(31696002)(66946007)(6916009)(52116002)(66556008)(8676002)(4326008)(16576012)(31686004)(956004)(53546011)(2616005)(6486002)(498600001)(2906002)(54906003)(26005)(44832011)(8936002)(86362001)(4744005)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzhBaW01M1hteWRVNzB3WWZPcm5qMys4dEEzU0VtRVBJaEZlTkswOTdkUTFo?=
 =?utf-8?B?SFBUbVh2TUJXT09ORHUwdnVNTjBVbTB3eFY0enFmSlNZT3dwSHdrcVgyeHlu?=
 =?utf-8?B?SGxwcGd1Q1ZXejdDQUdqR3A0dmE2aXpZYTVEUnQvV2lUelBVOWxHQ0F5UkRi?=
 =?utf-8?B?Q1JPZHFNMElPZjFPTVR0cmJvb0FIN0RIckx3OUNNZWdXaFZoSXBVbnBMV0dR?=
 =?utf-8?B?RVBjOTBpUUFlcjMzaDhzdEh2ekVmWUw2UUc5em1LL3ZYVnljVWhEZVJVeDFv?=
 =?utf-8?B?Q3pBNXRubFRNYStoYTRsZ2hwZ20rVEt3M01ZbnRVOTJHSEFKbzY0V1JwbEZV?=
 =?utf-8?B?YVdmSHBZQUVtbEprR3QwSUFxN2Jad2pxc2NIVW5uMG1vQlpWdjc5UXM1QzU0?=
 =?utf-8?B?Y1NzNEJjYjh0eE8wVHZwRXpzdG1RaE1rYnhmY01hV3hkdnFxNXhwaEFvbFdT?=
 =?utf-8?B?eFVOU3F2TVFzY1dNMFBQcnZqb2c3STVKL2ZXaTVyL2ZCeTd0aUxvZjJEMm5F?=
 =?utf-8?B?RlhCU2VYaWNnRzNhUkEvSzBaMVppaWJVeldPRmQreFV5WXhldFNuNGJjRWVK?=
 =?utf-8?B?SFVZdTd3RHQyTzNzV3N0eEMrU0pwVXFSczdxbmJBK3A1UFdDRmd4ZlYzWWZ1?=
 =?utf-8?B?WFN6M1lIMjRHbWhZUXMvZStJclU2K2tVVHBxTTdTUit1M1RwVlQ0RXQ4b21i?=
 =?utf-8?B?TVNiOGVFTEM2aVUxU2lzcmhYQmI3bmpCRFhyR3NYZVIxVzBIaXZhWjFudnRT?=
 =?utf-8?B?S3B1ZlAycHk4MFFtVFYzSkNDdzhKdTJDY2dMQlpycU95eGcrU2JINzEwR25D?=
 =?utf-8?B?UHJrS0JURUtTY3NNTTZpejRibitYbE5lczF5eWRxR1gxbytjM2lzVTlCTXRT?=
 =?utf-8?B?NHhKNU55Zy9VVFgrS2JPVm9hOWluWVVIMmVHU3lIVTE1VXZNUDBGakRYd2ZE?=
 =?utf-8?B?WXlxU3JBSGFGNjhraFEwbnFlY0RaZTBUaVBaUXptMjIxd01wRHB6QzRpd2pU?=
 =?utf-8?B?dU9VcDhNNUEvM28yWmxsQWxkV1V3RkZVampYMzdJVWV5QzY2czd5S2Y4am1V?=
 =?utf-8?B?cXErR1RNOXAzRlVhdFJoWWZ2K2hNZ2VnMmxyUWRGc2xLc0tQZmRzTk0yTUJ6?=
 =?utf-8?B?N2g4SnEzMk9OMzk1cm1nVk5BSnRRb1dGU3lqaXJOSFFOUk1KczZkNitEVVRG?=
 =?utf-8?B?OXA3NjZhRkZzb2J4aEVSdDlWNW1PVW0rcjNZeTBOdjNUbWF0RlZ0bkVlZm4r?=
 =?utf-8?B?V21vVDNyYmlaUzlRRUZ6dk1jMSs3M29BMSs5WlZCNm05d3ovWnQ4aDJSN1NT?=
 =?utf-8?B?Y1NiNW5CYXZhQXc2L0JCb2p6aHZwdVQzckgvdHBuRXJJc3MzUnVJdWFtRytj?=
 =?utf-8?B?ckl6TWVYdVNDZDFVWCt6cXpLRU4vUFFpYUE2a0JWeE5ZOFdFbSt6UEVBMno4?=
 =?utf-8?Q?cvhDPeEA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f83867-a374-4cd9-dad7-08d8bd6f3bdb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 18:14:31.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUAjfa2ePUqHRGeiaegV6IJeETXcFLGyziUbdcTxSdRMEGMDlvFmoJeg8EujHCnD9jMhobQYjnMYpjln++i/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2286
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 2:09 AM, Oscar Salvador wrote:
> On Tue, Jan 19, 2021 at 05:30:48PM -0800, Mike Kravetz wrote:
>> Use new hugetlb specific HPageTemporary flag to replace the
>> PageHugeTemporary() interfaces.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> I would have added a brief comment explaining why it is ok to drop
> the PageHuge() check in PageHugeTemporary.
> AFAICS, the paths checking it already know they are handling with a 
> hugetlb page, but still it is better to mention it in the changelog
> in case someone wonders.

Thanks.

Since I have to do another version, I will add this.

-- 
Mike Kravetz
