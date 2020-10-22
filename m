Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46B2959DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894704AbgJVIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:08:10 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:25313
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894373AbgJVIGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moodLqzxpY/5sqpLhc88iZmQIQFazuYysUoavXiFw8A=;
 b=0DUSct4D6o0n0AQc9Hsx/Qi18PzTzOQYviXRO+4q8C5CpuNb0p64BF6n2OGIDlaIjBUvNz26f0oq5TCMyjEhRr/QC3c9rpLIkoKZ7bvchMGhdR4vD2VHNK9jnSUxZYKyDBhLj/9n2t4OQjTzJwcQ0hq5RRcDOlD+gHKL9Fp9qsc=
Received: from AM6PR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::36) by VE1PR08MB5005.eurprd08.prod.outlook.com
 (2603:10a6:803:111::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Thu, 22 Oct
 2020 08:05:59 +0000
Received: from AM5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::e0) by AM6PR01CA0059.outlook.office365.com
 (2603:10a6:20b:e0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 08:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT024.mail.protection.outlook.com (10.152.16.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 08:05:58 +0000
Received: ("Tessian outbound 68da730eaaba:v64"); Thu, 22 Oct 2020 08:05:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b711339ed140d80d
X-CR-MTA-TID: 64aa7808
Received: from 5e9621e74271.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E462F09C-6D21-42D0-ACF0-639DB746697E.1;
        Thu, 22 Oct 2020 08:05:53 +0000
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5e9621e74271.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Oct 2020 08:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLiukWhi3X2RuurgUhs5/wyQrzccYDAWUGa9cb4cyqJMO07Xnctv4Du1dDFiUwSwirCwqoBC99hMUFsc4atEevMkZnUpXvK47rt0c0hHbf8IX6TTnQfQZc/Of3tFbpE5YwxwnQu/Mne+CTKirL2UL1t9i/W+gZavvrX9cnPN/yhD0h2vc8nWDtrT+HPggh0vNmhN4tMcAhilWw/r26OZtsAQogmz3o9mzA92IDolRV8EJiqEkZ75AK4Otv2R+YA6dMSO1DmcgkJvFLPIAA63Pm3F6/r8yFu9uxjNDK07HyyUULDRbkCoy4ZtwYsiJDuOJdCP9UspCUQjv+XzHcSpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moodLqzxpY/5sqpLhc88iZmQIQFazuYysUoavXiFw8A=;
 b=J66muKfXQuo2SPSLvrZSxSbnHKwJ/g2lM8jFToBLtuhxjN0pcL97cWsrABd3zdW9hyDyaaiuRWKDBsTd1mW+KDq7v1nokRb2ryB2AwpH1CCn9Xv3b8epmiIZN8hSnng3bQ3biffAaVA9OgZP8+l0YaKoBmGTBArsBw6iQezH6pGO3kOdCpas9JN3wmulnKkmEErAjWscPyfATyWDFJwtL9t4SjASYG3zgaYV9asVo4c61Hsjsk41xz/+u5P46SCR0QW5JTwK6NbD3Jd+cuJhUaUJTaeZJbetz/Ti+bGkQn0m6xEG84AErWS5QZLiL8kuQT8J88AflprhPigCsSdnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moodLqzxpY/5sqpLhc88iZmQIQFazuYysUoavXiFw8A=;
 b=0DUSct4D6o0n0AQc9Hsx/Qi18PzTzOQYviXRO+4q8C5CpuNb0p64BF6n2OGIDlaIjBUvNz26f0oq5TCMyjEhRr/QC3c9rpLIkoKZ7bvchMGhdR4vD2VHNK9jnSUxZYKyDBhLj/9n2t4OQjTzJwcQ0hq5RRcDOlD+gHKL9Fp9qsc=
Authentication-Results-Original: 0pointer.de; dkim=none (message not signed)
 header.d=none;0pointer.de; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR2PR08MB4732.eurprd08.prod.outlook.com (2603:10a6:101:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Thu, 22 Oct
 2020 08:05:51 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 08:05:51 +0000
Date:   Thu, 22 Oct 2020 09:05:48 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201022080548.GP3819@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022071812.GA324655@gardel-login>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: CWLP123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:87::14) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by CWLP123CA0122.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:87::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 22 Oct 2020 08:05:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94720a68-54ef-40f0-7fbc-08d876614f6e
X-MS-TrafficTypeDiagnostic: PR2PR08MB4732:|VE1PR08MB5005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB50054966201DF26542D7C7AFED1D0@VE1PR08MB5005.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BXtuRMwmm5wwCQvRenHJEBjmL8zITIoOUmYKj99pu4izVjLC2CPtAr/Q4sseO/afPgfF62n9mVZxbdgJknY1sKG4xer9nzxc27PWaCX5kx4vXMxwjdlVqBl7W3Ed97dR4HfLEKZXcnl9utW3p2yynXYYpNNWuEUKd0Zk/Gc+FW5eV2bBsQJ/jubG8F4l0mflRMNbz2mQhwSuWzzoOhYC+e0/YRMM/0Aii0H45DIn+3ZHzX+HQYmlHiFukIW3gxUpVQek+kKXCsWibIqLRGSG+t6OQFtZdc7BGiqeKk5n6Nf2l9hzp6jq/CPgDnbB+HRnMd0J6wvTZkxe4ueoZJJcHjig+zkyZkvkypTVZNQ63kb1R8kj1CGcC52U5hyDOteZZrZV6jeRWG4EP/DxZTjTAg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(316002)(1076003)(186003)(956004)(44832011)(2906002)(7696005)(8886007)(33656002)(55016002)(8936002)(2616005)(66476007)(66946007)(26005)(478600001)(52116002)(8676002)(66556008)(54906003)(4326008)(16526019)(6916009)(83380400001)(86362001)(36756003)(966005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kM6b/caVl3Os7P+84JdbHEu4FbBZB0AU1O7gwnRJx2IS8hEJXaBoeMNVKNlOKrrrW9CK8ajGE0Avw36GPpdxTgojwakTk+fGZXndaLoorznGpadNjItwvQqBVzieyeAwGnlrTaTOG7bgr8mGjIctcX+rERdMMwvutltXkCHrDFx0dmTQFLS+jJldHMrOQpurzWyH+AAOS/Y5DJLqA6w3dUh4MYA3uYKYcLCFtEj1DrKWuDXgVkZQIMprLTbnGv6LjUbTELiFvqPpSEVw/dyQu/F5uVd2rogtkjtenOpcHjNNV63F3jADdYVT9F/7VMYBWJJ+JBJA5x1DDXWRGT8ULtnSCUDImf6jO5A0yxwBURw2IkYnQ7Y0t+DrIGdrF41ihNrHLe2Wwa1AG+SZo3LUYN5IqIQJF2D9ShVUPs5/yyVjZ3a5GYkcjrBHvfm1jjlEw12xokuuHfaEnKtQT8pZItASRrCNQoqQM3y1GsrY115ky3H8dCSYbKA6Cye8Ik10IHYeDTHJDtwXM1gCf7npvnRiGuXVHeLkvyiJQdTnIiboK4iUjSmZoN2mljhiyO82BUqNFu3OqkHtKTAt4UwUVCA6cFjSOwg491tbA/m2QIwrXk9zO7TyuliYYpFMcdEobFynliD1HQYdoozsnaf86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4732
Original-Authentication-Results: 0pointer.de; dkim=none (message not signed)
 header.d=none;0pointer.de; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 838653a4-520e-4a1c-613d-08d876614a90
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GlJompxfywok06PNrq4QByeau9FUVmp7snN8QCApAKfZFiNvdL/HkVSJMHQZlyb8hG6g9hH4Jk0LKRnwAMf6rlXFoNQGpxUfjJUqbZrae2Ew4wjsCpnf7VvREUeitOWVG5jlYUgPw255r9UImQLzQ++F7AG9V4zWNoiyneXWzGb/l2T2YfDJGjOqiUhgz0BqfOMCqjNHSwdAW1ADPKZnQptF9KB+dDe3umXYCZw9kcvooTFzeziIplByiR16WnUPYVK7VVJZDqIzZQg1f2TSgfHcKpmpdzAOfHaXzBQvMxUMgR1ges8vJ1VcCUy9oehmYtJvqKI/1Vs6X8g1/O67mHJwfyX+tpuBAFS7uWqf+BdxHCNHIWEh3/dtpRjXE6BeNEvkVzPKwT2BLHmZUipZx8FWyeNVS1hgxAphhxDwDhbR0YEeVPv/k85ApdHZmPmDBObnwB8ZZ3yWDkKW1SwbZ7sQo+Re0QzLlfCEbvVvlU=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(26005)(2616005)(16526019)(956004)(336012)(6862004)(8886007)(70206006)(86362001)(4326008)(70586007)(186003)(33656002)(2906002)(8676002)(1076003)(55016002)(316002)(47076004)(8936002)(36756003)(356005)(5660300002)(44832011)(7696005)(83380400001)(966005)(82740400003)(478600001)(54906003)(82310400003)(36906005)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 08:05:58.8882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94720a68-54ef-40f0-7fbc-08d876614f6e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/22/2020 09:18, Lennart Poettering wrote:
> On Mi, 21.10.20 22:44, Jeremy Linton (jeremy.linton@arm.com) wrote:
> 
> > Hi,
> >
> > There is a problem with glibc+systemd on BTI enabled systems. Systemd
> > has a service flag "MemoryDenyWriteExecute" which uses seccomp to deny
> > PROT_EXEC changes. Glibc enables BTI only on segments which are marked as
> > being BTI compatible by calling mprotect PROT_EXEC|PROT_BTI. That call is
> > caught by the seccomp filter, resulting in service failures.
> >
> > So, at the moment one has to pick either denying PROT_EXEC changes, or BTI.
> > This is obviously not desirable.
> >
> > Various changes have been suggested, replacing the mprotect with mmap calls
> > having PROT_BTI set on the original mapping, re-mmapping the segments,
> > implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
> > and various modification to seccomp to allow particular mprotect cases to
> > bypass the filters. In each case there seems to be an undesirable attribute
> > to the solution.
> >
> > So, whats the best solution?
> 
> Did you see Topi's comments on the systemd issue?
> 
> https://github.com/systemd/systemd/issues/17368#issuecomment-710485532
> 
> I think I agree with this: it's a bit weird to alter the bits after
> the fact. Can't glibc set up everything right from the begining? That
> would keep both concepts working.

that's hard to do and does not work for the main exe currently
(which is mmaped by the kernel).

(it's hard to do because to know that the elf module requires
bti the PT_GNU_PROPERTY notes have to be accessed that are
often in the executable load segment, so either you mmap that
or have to read that, but the latter has a lot more failure
modes, so if i have to get the mmap flags right i'd do a mmap
and then re-mmap if the flags were not right)
