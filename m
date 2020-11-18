Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE62B850F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKRTqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:46:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgKRTqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:46:37 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIJk9N7032336;
        Wed, 18 Nov 2020 11:46:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CfUD+0abmPB2nkNrwxpNP+gYlaUI208jCKYcbtDjHgs=;
 b=ZbGpvQG69U5DZ7lebmPiAaHNTDCNR/ZOlOrtOg75/JlTHm6vxzY0NUjf61GW67e1Htkk
 XBBxtim/8lXlOBwUSBH/5/i3oB03R4Ijp2YBrqEQsQ5REpMruqJXheV6Tyo9hzprA+Gb
 prPuFHeK8CYaa6gnXKCfc3RUKsvXvnsLqUc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34w2mk2vgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Nov 2020 11:46:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 11:46:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFTxaO8R/MIq0z4iA2fp5IlErfpCLqSIfQCZOqweSnVc2T++pXbIL1v+Q+9Xyz/gUpo4BOppC6Aov/FZr677Ydu0Xt/BEjZdWcczSy5x1vy1Yk9PapO1bZIOMiLstYKjAgwGMtGRBqf8Cp6pDQYvh5fI5fpO0WiJMgTpT8815VZoZS3UEBOsEu4kOnZautxcfHKkVwNB2tI2B3ZIQCp4bRQWML/d4u+axXGQf6/oqmpgQ1+57hT0I6SvRUE8oWi2aeBMjLhdhWzATjjJJ0yosQ/LuBTYIuabB7KK+Wb2Zi6XMbdADuQfQDJ1NKTlz5Jb1Yh10ztqkiZ9kqO+2/qv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfUD+0abmPB2nkNrwxpNP+gYlaUI208jCKYcbtDjHgs=;
 b=lq/FchFKhtKXNOSWNalxcxyv/InRHxgKhFERRptrWoM1LVoLx37gFXEhXGLHMb822winOA1JnQ5dHhjmaSkG78dNBsnvPdefENhjT0Yy1NgmwBu4nf44BoEHXbOXbIpN8FvqSr36U5sHXKWhJujhlC8Q8qZfEb5WRfI8SvDXhbLlhcwV2WjhspqChI8wzbIc9pLmJuNctLJQRhkRvFf08CpVwz2uF9IB4n5ZTqpuPIn4/6vF2e1dliSKN07t/HE5cztlwvTGpAy89oKH3NG9e2uP+o3kOsH8b+KvXJgmtL7Uk9zAE2km+koc94UOpCwdfd6F7Dhf04czqXoCq8KB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfUD+0abmPB2nkNrwxpNP+gYlaUI208jCKYcbtDjHgs=;
 b=VPjc7pj1TnGbJglgOvOCyUxmzp2g911sHlAjAdGvXLAote8I6Gv+xPJdPvzj0C3muaTKRAbo4B0SMVBX1o8ft4uQyHJds3IBaRytuRz3+uyvS1EXEgGKJ/X+8gLC2hvyibdOajadMTDoro+plvtNgKcnTAcgZZuol/M6eU2DYq8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 19:46:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%7]) with mapi id 15.20.3589.021; Wed, 18 Nov 2020
 19:46:24 +0000
Date:   Wed, 18 Nov 2020 11:46:20 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, kmem: further deprecate kmem.limit_in_bytes
Message-ID: <20201118194620.GD186396@carbon.dhcp.thefacebook.com>
References: <20201118175726.2453120-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118175726.2453120-1-shakeelb@google.com>
X-Originating-IP: [2620:10d:c090:400::5:438f]
X-ClientProxiedBy: MWHPR22CA0069.namprd22.prod.outlook.com
 (2603:10b6:300:12a::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:438f) by MWHPR22CA0069.namprd22.prod.outlook.com (2603:10b6:300:12a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 19:46:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe23841-3a24-49b9-4af3-08d88bfaa1d2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2759379677D5634153843DF3BEE10@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58K2Wbex9ZLF4KLAU0zRFmT21oBIhyyRTD6FxCxC0MlvdO+mrnDG0HPUtneo5GQ5FLkvxKboSOpKAL4957PT9UW3f+KFjKk7auv7uj5GKwfzRTxyPNRbD84Ne93IpP6WnV36YvWhbLtE6J0PYv663+Bcb3iwYzzpMTG7EH6VgdDR/F0E9w8gDMK/GjZ//Zfh+/vereCbn37q4nTn9OlFzX3ZHb+nWl3geqN4ZHXTpQLHwtfeKfvsfK4+LTSAi1Lb8C2Yx4P+mqED0GWpwB/Dfg7M1SDOU47n0twbEh7eUD1H9A0/gWUf5+skg2hpaYfBUfHd3/qqz/hFJWD9QSl03A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(316002)(8676002)(6506007)(4326008)(6916009)(8936002)(54906003)(66476007)(66556008)(33656002)(1076003)(5660300002)(52116002)(7696005)(66946007)(86362001)(478600001)(186003)(55016002)(16526019)(9686003)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rzKxCUSzAI6KRFck7waoerbTvV5u6udCbh/MXnriUn6ugbmP6zVlC7g7zbqcjTdX5AIFDt9S+281p16dssi4Bq2RwC7olnjwkOghUPzYRHUxGYz5giSo2bnFLaPv0mx/TIW1OpHHSCHfrgaFXRzNvPXEIAnPPDoWzg0gRGYZhSg7QxKLOg2n4pvzD2QBOVoclh0M7lr6vz1TjX+humd/E0DDkl/wBct0qrZuNVP8pploSxiVTe9lj2ntSz3rip4YUf4KlIn6CsTXALfU22SaedpH1AoxGGZUFWQrLBQV9IlP45Mv2NZtDlMsIUsUqDvX9EPsfmrHUJ95KpNwqT4BlPLqTVGz7LoV4HlG2I1LBK3rkJPRN7oOnE5t8YM4GQlwMqnf094HDEouCQFapDdbORpgZ9ATS35mxf/mFtyl4o+rL8h5UgEOu8feZPLRCWjK32OPT5CH7NtvhdIBu0Sm4jFhdCu1eL3cBVG2n2z+TVko+bangciueMU8mHSn7AUOPyP1KGJjUuSG/vo7p1GbyFpAvpOb+OFvFdGZqdr3zcGPPEJmxmaIxx9CUzQQblUhAYFRHVGAAZ0SjPvCz1qC6UP7KcnK+HKC5F9Bz1eVQYsdTxtDLcU7/58/Ac+bBLNQ3zsW2vqCTlurBedm+SHcBb0aVW1UQFaU6TgRXKzRN/I=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe23841-3a24-49b9-4af3-08d88bfaa1d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 19:46:24.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1vb9MMLnUBdQ7sReI+Ot23HNeYUPlXpfZUJx7cZyUP2lUJx34U9ikaZ3xiWCK2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_08:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:57:26AM -0800, Shakeel Butt wrote:
> The deprecation process of kmem.limit_in_bytes started with the commit
> 0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
> explains in detail the motivation behind the deprecation. To summarize,
> it is the unexpected behavior on hitting the kmem limit. This patch
> moves the deprecation process to the next stage by disallowing to set
> the kmem limit. In future we might just remove the kmem.limit_in_bytes
> file completely.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

The first stage was done over a year ago, so if there were no complains
it feels like it's a good time to move forward.

Acked-by: Roman Gushchin <guro@fb.com>

The only question I have is if it's better to return -EINVAL or -ENOTSUPP.
The latter option could be more convenient for userspace, because it will
be clear that the kernel is not supporting the functionality, rather than
the passed value is incorrect (e.g. if the value is read from a config, provided
by a user). I'm not sure though, just an idea.

Thanks!
