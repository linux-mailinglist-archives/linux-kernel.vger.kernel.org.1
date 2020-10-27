Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47E29C94B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372397AbgJ0T4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:56:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11398 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394173AbgJ0T4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:56:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RJf0lJ026286;
        Tue, 27 Oct 2020 12:56:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=IvgwPjueGAjQ1i+b9fUUrs0+hu0UadhWzmZNw76iGYk=;
 b=EC8kwVvJu3wESSczbejwyv60GV1m1lSn78wx1YFd11Ar7xIwiWMyBwB0rNRsvvsftPPF
 y1XcEv3rcSMBA2L9tnI/T19U0/uaoVpOHLCEv90SficVRY9p+af9fGKhQaQHiCSVl009
 GG+O7BN3rsKa0ao9jyosx4VZIsUe3lqjxoc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34egnf3e4y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 12:56:28 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 12:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfzTQvr3Ksdijf+RrjIgt6NpcZDzGGGo1v6+/xhDG//KfBjxY6sm6/WedTe6/Fb86yF5KyQF5OBGFU2THPDzI5n9q+xSOlnbx2v9cDIWBoih1CG0SPeIk21JrreJZ+7MgB/3FBjXwFjy7RyuIybkd0RB+UW8gHkKVlS/DqVveKpNTj+C+f5JKIDhubRPZCiOHm/XJBfc/J8j5dVf0OReJA6CN05av+1fYWkkojq+ZM5qTKXBvfyofeDW/oJVX9J+f08jxAM6sSUg2WFPqBMvGqNjRFs6cEdRbr5j0jeNDze3jsmcfcUQ8dbU3NgKQpXU/qx7mvmjW0r4bPhwdt4WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvgwPjueGAjQ1i+b9fUUrs0+hu0UadhWzmZNw76iGYk=;
 b=HfyRifSqmH21iy+HbOR7ZeNCxh1QL+f6Yqg06CKhVUM8tus/f++6Cmry0D11qF3y9IFPguwsGO48BFGlUSmHH9HiyKe+ebjRDdx9QyniS9rcTOq9lZRIOF9BKECqDocRo9un1iS0F9k3KT/KCbYy6fVJdlVvyXON3q0wSlbR1SBuAyTXrK5XHhzjqkqt+xKjvQ9jwYzFy+VSkslLeaQF0Aaell3hMVm4q/Xjmy4jsh4OgbPAHLZb4errK0tCMSx4IiXmdtqMdoGZJQqcF07S2N1cstjVrGxRZ1/Rk+tobxcjzNGdKCn4q+YP8zAow0wseKD+Tc2KbLZFOqnuQfbrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvgwPjueGAjQ1i+b9fUUrs0+hu0UadhWzmZNw76iGYk=;
 b=GhacB1v7qwHAgkQZVA6oRgrJTjRVHZ4mS8tsvOzB+Ixh4OQhICqrmwXmbUGC5gBzBaXxGpeAMPXTqagFEhe2tGscdwIyqxq6RmjkjSbE1frLNiuU7xbqI3M0nYrDWfVOxNzQQeyBaYKcVq2f70P7I3YhFjOio+LZdeK5KN7xaDU=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3682.namprd15.prod.outlook.com (2603:10b6:a03:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 19:56:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 19:56:23 +0000
Date:   Tue, 27 Oct 2020 12:56:19 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v1 1/2] mm: cma: introduce cma_release_nowait()
Message-ID: <20201027195619.GD827280@carbon.dhcp.thefacebook.com>
References: <20201022225308.2927890-1-guro@fb.com>
 <20201022225308.2927890-2-guro@fb.com>
 <20201024075959.GA4285@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024075959.GA4285@infradead.org>
X-Originating-IP: [2620:10d:c090:400::4:4b8]
X-ClientProxiedBy: MWHPR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:301:2::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:4b8) by MWHPR12CA0031.namprd12.prod.outlook.com (2603:10b6:301:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 19:56:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b47bb1ff-6125-4fed-65c9-08d87ab261c4
X-MS-TrafficTypeDiagnostic: BY5PR15MB3682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3682C05BD0B501BDD6AC3BF5BE160@BY5PR15MB3682.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NI3VIFLBaDMXreEFIZMgVXOd7m3Xf9CfGQ8JCnMglEmhB3PNDNzyXLnheY6/ltddD7FaoHypLX9yn31H5JNkifewoyZyp3x4j/tfM9z5vDRDg06plmfcvdVlKjG34nunavRk2zn+1xp0HreUXOuWvP4y3CFMMdsD8AA2boJj/zxzUVvGY/EtQOMqisc4vcmO2B245uNupZx9lVEDxiBiU1kwuQz4P+ZZNE5u6O6QE2J0Z7RzO/u/U0OyZ1VNQVk2lWO81dewacMnLBGcZI6yWRuLe/jgO4cJtOD7u1rzGvPxkh9tAqUh5vR+v5RHNvlrvHCf5HIUBcoAN0TQzPMPYhW/Hpzre8k+AeKVQDYDMbzfAsC5/vmpmwZqZgZXtf0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(39860400002)(376002)(66476007)(7696005)(6916009)(2906002)(66556008)(66946007)(1076003)(186003)(9686003)(83380400001)(33656002)(316002)(478600001)(5660300002)(4744005)(4326008)(54906003)(86362001)(55016002)(52116002)(16526019)(6666004)(6506007)(8676002)(8936002)(134034003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PCZMA78DfeU5KgmkWQkmrA9vdanxJzcR4pqQb29sW76gHfzdMcSpldGIKA9xRAJ25IY7zuzoAnwQ53o/FjvmGp85s7kHKnv+fOhTIXauvJjE8wnM2QieO9UV4f1e4AkLY8HqAAwOZzJgIzSTSuKPGEaRDRWhgktYS4qSn+6YB5SeBsJmZK82jEJ6n5B0G9t5Jqni6gq953enguMMt+Rg6B/AgqLNoo2VCD20IiyHYmkL4+NKimThxrQOfaFCphBahk7jo2BzwXqsyXH8X6Qkf/SQKlpSNNc89GUl92ua8UcNQ5XO1Y7V+Cnjt8wN54giZiotblrxanhkzBFmBRdwKB4X+eGiEPtdvxNHUBOklnnmbcAqdzpQLnxXTEp7Tue3fmtb4awxpXUvq+aDuUPaA9Pmtj7zK6uTYysVdUtEJLtnYQAYqzI0VTsfjvc2pTSov07SqrRGxRD1sVnGW56s2bjj+UKXAh0uw/b20NB6hw7IchJ5FK/C9sPz4iSbHYfBN9Jn50Ts3+7ldDabidTMHkFoJ2vEPQVFEyxpyn4JUp0KssZ53njv89pr39LAwJrZK5nXGzHcSFgir4VfVDCtKvHg2QqAE7Ma8GABpoPRibvieyrldpJRYQeVRFri6kh+p3f7IlKgkNIjs+k6r9xwGME+lnNv82Zs2mhX+J4xXMo=
X-MS-Exchange-CrossTenant-Network-Message-Id: b47bb1ff-6125-4fed-65c9-08d87ab261c4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 19:56:23.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eAadOjBaEh48DwZnmjMIz+sjfYKa2yxmsFy86bkxMf85si8OM1ghk1SM9EHQWTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3682
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_15:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=736
 mlxscore=0 suspectscore=5 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010270114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 08:59:59AM +0100, Christoph Hellwig wrote:
> Btw, I think we also need to use this nonblocking version from
> dma_free_contiguous.  dma_free* is defined to not block.  In practice
> callers mostly care if they also did GFP_ATOMIC allocations, which
> don't dip into CMA, but I think we do have a problem.

It's a good point!
Do you mind mastering a patch? I can include it into the patchset.

Thanks!
