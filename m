Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240F629442D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 23:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409702AbgJTVBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 17:01:25 -0400
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com ([40.107.237.101]:6593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409676AbgJTVBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDcYgw3dhAG0QK3oKSm4AT3XxIDlGs49V7BCOd57rYEEGV5e3zjuheY9L+T6OIEQUkL1CXF9Dw6s2rYVJMXtgdYqUcx3FpuVxi40XzAs5ZPT0h+wclF0lJyNHepUuoTHE8Y/ZZza+lmII6TSA70rRyX+HonGhoDXrC4+bMwhwcLz7rB/GQ6w2c+PNqF5NRL3OKwABol2FOrCAH2sHnPNSf9ky/6k1fiifh22mWOFx13UTbe3L+UoFPte1B0Qugvs1xIGVGUvLpToBGq5Kh8qbmRCQ5W2bsd9WgLGFQqAz5g8HR317990SD5iLhqpOlyb/dhqNUuoTbiVCVYJF8HplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5XqRGO2XU+6eDMGrcZXWY96UFB67CIDbxFStqSp/l4=;
 b=CE82iT4A7xElFZ1noeXrjatq3bSP7DPImV8zbOjGbtIJ+p0vlyI3mNkGLvqc7iNneNWzu8r/37+x/Zajruu1g4sTJqpxGK+7U5ma+eFKr0Xt5fhYP7WqzOhWLuAwQ+hkAQFaxNj8OHysamA6eNcWQ2FeKCtx/DJkthuN9cOSgrISsWjy/1BRKqwG+Ch157ZvCq7KQhZGmJAIc0lmfFvxYIDJuDE7XAttx1FdZ5ZY1s3xpS+/8nusJCjlQV3TEf/ZYLd8DFdt15q7EhROIDMCdaeY2KNpR6WFb0h87lnp2Izh7lidPy83qAETTGu32H3+t/ABnDzFjVWFGTX2lAJ4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5XqRGO2XU+6eDMGrcZXWY96UFB67CIDbxFStqSp/l4=;
 b=p+RcPQdGS0WLE0GXAzhIBtTOd87PP1wnSu4AUYzkDNutcpmpA0cMlT3+i9uA2OzMjLsfjsTGeqoxIa34TrRANYwT7hB3FttgODJ1M+zLs705vo39YQdZ0C+STDZ8BdTP05oGNdJq4CMbAlEZjzeZxD/ZMlmVjKciGq1BUpm7VDk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BY5PR01MB5810.prod.exchangelabs.com (2603:10b6:a03:1ca::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Tue, 20 Oct 2020 21:01:22 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 21:01:21 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH v3] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <c2a14d58-e18f-ca93-4a56-0de11a41ed73@arm.com>
Date:   Tue, 20 Oct 2020 14:01:19 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Mark Rutland <mark.rutland@arm.com>,
        patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <03C33FD7-EED5-41BE-8EB3-CA2AB46D4143@amperemail.onmicrosoft.com>
References: <1598033450-30145-1-git-send-email-tuanphan@os.amperecomputing.com>
 <c2a14d58-e18f-ca93-4a56-0de11a41ed73@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3654.0.3.2.82)
X-Originating-IP: [73.151.56.145]
X-ClientProxiedBy: CY4PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:903:165::17) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.148] (73.151.56.145) by CY4PR07CA0007.namprd07.prod.outlook.com (2603:10b6:903:165::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 20 Oct 2020 21:01:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5abce23c-20b5-4cb5-0b49-08d8753b4c2c
X-MS-TrafficTypeDiagnostic: BY5PR01MB5810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR01MB581030EE885B94CB9C924633E01F0@BY5PR01MB5810.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H//GYmgXYvYBy6L0vjlkGwGHK96TmpZFvcTWy8Ei+P8gTYl41gzvmsukKUvpFS1rMvPxukCvfJJNYqRx7ZY8rLvA7X+kKG8GCf8HCsG1WrYIPLD/374GabXulBUL9NGm4Y/MtA7kVdfkP9Rtezb8QUqLuZe5Th1W8Bprr2ZLKhFKRZgctLa6mIe/gymuC9lgfWjhqeclTNAig9GqUx5Z3KGVfLHkEICzc5jB5qEdyPb+bsaWNs/mHjPWjHW96p0UYhfeQRgDvhtc+8TYASRrqnpBALvl2F3JeoXPDpUeqOqvXLRGTVvJSGDKv29Mb5jGdXK0ce+Te8C89sZu93w8IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(366004)(346002)(396003)(16576012)(54906003)(4326008)(186003)(16526019)(478600001)(53546011)(26005)(316002)(2906002)(2616005)(956004)(42882007)(33656002)(8936002)(5660300002)(66476007)(6486002)(8676002)(6916009)(83380400001)(558084003)(66946007)(66556008)(83170400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zOvhsm9JKJPqU9jLwK/i2pdWGgtouTDDMSVt6cpRVih01RagpjSRJyLECkvof93sBh4Jr7kBFrr0N1SnZ/piMJXzlC7AOF2YRbE1qhwlKgftFTe1Mm4eYp4bacyOt4TmscF70Uq4kH2qZDYUhaAYJFY8dcSTWZb0iY0RAykdQDvz+EvqT9LwK7R4yyLRQlnfj7XzDYV8LUDiHf5jsV1k6Akbh5vwx0CT+gVSu4TQ/+Cka/xUXyJ/v5faE0RNM1JiACDMAYjCjY9ku8qHbYCouwP0Cjfex6Yf2/UpWyjP8rEcriFYMR1uGtCtuc8BTsybetDqh9wI/yyUYcMrWWh4kR9W78KNel+x6MhEdepL+rfNVJsH+veSx+3iFnu+FQb1wvh+s/V80drsI8uGeQWOw71rpgQGunQNnY79MPlYchbHaOf0+cN7wsw8DbFwSH6Cn6fdyQ7SoiEg/jN6ztBK6VWua5IRW4ShauSJHBPzvtOn5ukcFZ2xDYg+x1JG2Rz6iby2+99BvJ54+bOHqffbUy+4UOYxJJ6LzTYbzsx2EQhIb/mvMI8lJqLiC2xei8QWAVd3IfKXmEZGPnYDFnt1msWBNbmAqG6Xzph0RAyPtb5RqxRhI08eIms3+d1Znudl5OXT5HeOO7AeRgCyJ1IXPg==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abce23c-20b5-4cb5-0b49-08d8753b4c2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 21:01:21.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQO2K8j5Q1Zy7gWjjrmnQC7KPhfww+Mk8K4oVv2AUHCI8l5B6S6iQVjHjYpyhYhvXR6qH2iT5VwWfP8Zwu+hncjVxy2x2c9WPz9frSO4KuC8xhfNUFo16uoukpkfd2Sg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5810
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,
Somehow this email account received no content. However, I managed to addre=
ss your comments and will post another patch.
Thanks for very detail comments.

> On Sep 21, 2020, at 5:57 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>=20

