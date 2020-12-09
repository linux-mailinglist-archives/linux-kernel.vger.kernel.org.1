Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FEE2D4225
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgLIMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:30:23 -0500
Received: from mail-dm6nam08on2045.outbound.protection.outlook.com ([40.107.102.45]:38752
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730948AbgLIMaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:30:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeOYtoeB4VFGnxZeCnKMDAo9YsqzSghIWZ59W+UEpODj5RwHHQfwhBh2zXvhGsHnol++Kzp2PWEhIWoQu/eVZ4JC8QKfAc9BTft6D5NWv49ttSOAO8lj1P6VYm1aH1/LEVvcDAPb42+vb6OnDR2vAteNUleXBnQloTPCWpoY3rxcWJJmhCjjOF2T7EdSWPpgfVbpVU17gLQ3FI6rrpVyZ3TGWT7q/atS4CkaBMz35s7gYLQf8K+qsVXiuC5j5+qK2e0zO+Wr2wswQD3c0l7jGoJmfcrivbIm/4vQ4HVILOzYOc4fZJ82GXFx6dsO6z6sqXvo8uSpR/y47nRVLLIPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEH/d06wQJ6q0dMoAP35ugPiuOLw6NSWBxTtycxiJIA=;
 b=T7c4xE3890Bg/q975/biFpIl9xilBLg4HMpsN+vWitp9RmwFVtT5aCABUt6Pt6DF8h5VB1a3TTf2IoWeJBtQGGz44xGMYBCzvrtHvMZM8HHicWzl9JGMYolLNz6JXl4TqkHq9DgZSU42zUCYhATLV7VDO00UPew7z4Qqs6Nv0mMp0IpTPpljuNcHX600y0G6vOmxqn2OL7MDhHqqFr7d1Vfat6U3qAtL0AFIzwSIiz9vE8H3DoiJFc6nkhMXaN6YUAALSFuz2w//XZsLl/I60BHA9ZIm6huSB/J5QlLBoKmMAILu7DQoD2UqNkexbEC6f5TwkUV/VOe4gVWausU+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEH/d06wQJ6q0dMoAP35ugPiuOLw6NSWBxTtycxiJIA=;
 b=C4Z4hxtnWkD1Hr30yq8n+klWRr//af6WAkvFlcDPGJQHk0Lx9gRrQTGCiOwdZ6my2ac7Cvo+3PJMckNnLEi/kAak+E+/TSbxPZMdJKGWRU/NWc2EcZyslj4Yly1s7khKI7lbcW+zjyZAurSoFYEYXcvkMbX3+TeJpyIIVbuHYaA=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 12:29:16 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 12:29:16 +0000
Date:   Wed, 9 Dec 2020 12:29:07 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201209122907.GA6258@ashkalra_ubuntu_server>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201209110115.GA18203@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209110115.GA18203@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by CH2PR19CA0008.namprd19.prod.outlook.com (2603:10b6:610:4d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 12:29:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86272137-7eb8-4d74-8da1-08d89c3e0b80
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512FB660E8F9066774E5F6C8ECC0@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8+i3m+101pJ/m7NX+q6JZ7WEfM76pYtT4UM938JpYkXEMBI0/gBvQ+R8lD1Dm3l8dk0Fm+Fxi4iZAFFSEF3M1/GG1pWA/pwxasDpHSX7FbCAGcX9u+oRJz7Gq/L94J3NMwwTjKTuNs6Yf1Y0KCsUo/s1zGcvD+HDVw4BDJOCGkw3+Pg+h5ky4d+SxOMwx8C7rdgTZ0WbK1vEOcX+oJXtrQz8Kb3uFFN2n8F5XdW+FEY56gEzYbB3YkaUkqp9W9TPKBIPlW/NX3Ar9UwTBiZtkga32zsz8jopcKehYFFOU+rJZWOeCaxSRvd5bHMNEWMqxjp7WAUyKib7pKQBWLj39lHw7JeTbYE2F6UOHM3EE2y3j7BdSK/Yl/py+AsNuoL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(83380400001)(6666004)(8936002)(66946007)(33656002)(1076003)(6496006)(34490700003)(16526019)(6916009)(86362001)(956004)(7416002)(26005)(66476007)(66556008)(52116002)(4326008)(33716001)(44832011)(5660300002)(8676002)(2906002)(508600001)(186003)(55016002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0aq6wGUZWDAiU9ljVMYhyafd6vb1A/0EZ4EVwXcAOSsODRf85Oiz/k9OdUOl?=
 =?us-ascii?Q?xhhESTVdk+QnoEgiuCylqLcWQ1Jb4daVtbqSOtHptKnKuRjNCOnHNc+UFNVH?=
 =?us-ascii?Q?ht7G5ijbPqpWCb2Z+g84ZPskaCL3yI4z1wU5D+jIaxuUzqUrrdwUnh4723Rr?=
 =?us-ascii?Q?amD0uzjmiE8LmO1Trd2yPWs6/UzLsao/T2w3bt0v82/NzuERt4gyrwXUO4R1?=
 =?us-ascii?Q?YJJ62jMBMg8zuPQB5CAv7BnXxtYGGrA9aIdcUZEzibjbeLaFj9rqYvsC8O1v?=
 =?us-ascii?Q?rTqkb2JkC6tMNfJcjnFSEK3k16iboeSL/LZUsrEmxTzsd67hJc2C+Lf+OPMp?=
 =?us-ascii?Q?Q6uyJjmAhlDlH8L+eDRcON+2RciS2SZ3heVas48PGAOlrxJv0Ce6a+x7IDVq?=
 =?us-ascii?Q?W+wbbCFBAaF55mmJ6vmse/SD554wzOL6JfKgi6iD2T/8NkDZ1h3K96KquapQ?=
 =?us-ascii?Q?1YcCiHsmDvz5haW1cV0y68QEOfE+yigfXg/59vepdYuln0yGN5fzaCRGu4Q+?=
 =?us-ascii?Q?aUjuexUxTrrM4WYMEkGjXf9ctEpg0Q8cmzBdycYQAof5OubwHsdiJ8xa7V29?=
 =?us-ascii?Q?UElvB+pRKyNLo70eSON+zHGIM/C0I+qFBdQ/ZWn0ps7brpMNOZdXJB4rqdii?=
 =?us-ascii?Q?QAILBxcq5yM3pZqvq35aS0ijRZvjxnynA01cK5zMa9kZaXn/7O8kx77KCtt/?=
 =?us-ascii?Q?PeJSr40gSfJ/pwIu5uJvi1bPpAIKhoaDAcKaJau/vCyC/QG0NTyh5vntzEYu?=
 =?us-ascii?Q?2wzDsoGEiV1qgs7kmibEkyaasZTWrfA4dJydUvqSMbWnsKgS+u8/CJy8sxDk?=
 =?us-ascii?Q?+Wqc+Fs5VIMItCnL/ts3p+f9UuUTjlwqqG+1ScvWOI9k7Bz2D4Q3E56dC+Ng?=
 =?us-ascii?Q?O1zDx8kfYkdN3vbs9ZoEDv1yoQdi+DYkN6GaTKuOwk+vTZqw/XPku59HpU4g?=
 =?us-ascii?Q?uhEHGRSN9b1uOxYWYh3HMut/BBb7wKl/t2ATPkdV0JdogWdllS9WpFaFOHI7?=
 =?us-ascii?Q?xQka?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 12:29:16.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 86272137-7eb8-4d74-8da1-08d89c3e0b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJW7ZVP13j/e6MTdgYKJl8/cZoLsRBO31+ZaQaTw6sYPW9v7IAKeEcrOi/mHeFtzjP+F8ESLp3vpKHKTShdegQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 12:01:15PM +0100, Borislav Petkov wrote:
> > Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
> 
> Fix subject prefix to "x86, swiotlb: ... SWIOTLB ... for SEV guests
> 
> Fix typo and no fullstop at the end.
> 
> On Mon, Dec 07, 2020 at 11:10:57PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> > SEV uses SWIOTLB to make this happen without requiring changes to device
> > drivers.  However, depending on workload being run, the default 64MB of
> 				 ^
> 				 the
> 
> > SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
> 
> 				s/SWIOTLB/it/
> 
> > for DMA, resulting in I/O errors and/or performance degradation for
> > high I/O workloads.
> > 
> > Adjust the default size of SWIOTLB for SEV guests using a
> > percentage of the total memory available to guest for SWIOTLB buffers.
> 					     ^
> 					     the
> 
> > 
> > Using late_initcall() interface to invoke swiotlb_adjust() does not
> > work as the size adjustment needs to be done before mem_encrypt_init()
> > and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> > hence call it explicitly from setup_arch().
> 
> So setup_arch() is x86-specific and already a dumping ground for all
> kinds of init stuff.
> 
> Why don't you call swiotlb_adjust() in mem_encrypt_init() where it
> already does swiotlb stuff - swiotlb_update_mem_attributes() - and avoid
> all the arch-agnostic function glue?
> 

As i mentioned in the main comments above, this cannot be called in
mem_encrypt_init() as that breaks reserve_crashkernel() which depends on
SWIOTLB buffer size and is called before mem_encrypt_init(), therefore,
it needs to be called from setup_atch() before reserve_crashkernel(). 

> That is, unless Konrad wants to do other swiotlb adjusting on !x86 too...
> 
> > The SWIOTLB default size adjustment needs to be added as an architecture
> > specific interface/callback to allow architectures such as those supporting
> > memory encryption to adjust/expand SWIOTLB size for their use.
> 
> So are other arches wanting this or is this just an assumption? If
> latter, you can do x86 only now and let the others extend it when they
> really need it.

I believe that other memory encryption architectures such as s390 are
also looking for something similar to be available. 

Thanks,
Ashish

