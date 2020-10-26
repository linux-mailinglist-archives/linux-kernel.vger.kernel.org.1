Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03C5299325
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786824AbgJZQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:58:36 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:48339
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1786818AbgJZQ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/k+UcEzsTrvmqtUfqxFVVGx5DU78FEVIKQfFVMu5PA=;
 b=AtmXmgUs1F8ZxopKMEB4JHj+91/0Ad98u2e0i9lXCKR+vhNqtWG0V1OJeX5HAieFa2bPXtAQndJBW8wpA+OLTXrUxh+7ieaCVaRhH0eiCWqjf1NMCoYUGnnQpRAcHP5K0sbfiy/QgBg+IbiLwZFCdaG0YYrIQ8u0x5a2L24eZak=
Received: from DB6PR0801CA0047.eurprd08.prod.outlook.com (2603:10a6:4:2b::15)
 by DBAPR08MB5861.eurprd08.prod.outlook.com (2603:10a6:10:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 26 Oct
 2020 16:58:31 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::d3) by DB6PR0801CA0047.outlook.office365.com
 (2603:10a6:4:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 16:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 16:58:31 +0000
Received: ("Tessian outbound d5e343850048:v64"); Mon, 26 Oct 2020 16:58:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a73894805e56f838
X-CR-MTA-TID: 64aa7808
Received: from e9f84d7674bf.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1E08B8A8-2C5B-4432-932C-1C93D8323F6C.1;
        Mon, 26 Oct 2020 16:58:06 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e9f84d7674bf.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 26 Oct 2020 16:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zipzml+HZMmbLGOtAV1D8+PnTY6I6mnEiLGJzGINrzPkyIvLXAzh+pPTxefjGWSGzPheNmoIdjSAXHwXM7sPSH2/1JfJ1d79blLXvCSzwdxOPitBoc3TEIT2y4EdwAAIquHbU5DLeQ1p+OAD8+uKW8ZLtQOc6WaHdqNoWPtHclOpz7dgS/Kn6B/3WE1FYe29euEfWsg3vjRiUJCvuIXFjHoudKF6L5DM0h9XkwjKSj9GI6+DBxnB6sHHsQQO9IWp7ikHYBKxwuNnXUrqTtJaTGPAYqC/YPGZ0s1Voc5dsZNSkxERUmfL6LmsX7kibR/PkPARIkbxoMZZt0CGlM8/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/k+UcEzsTrvmqtUfqxFVVGx5DU78FEVIKQfFVMu5PA=;
 b=LLd4ZgsSyiiLnulG4DgqOiLekkXAOrE97UmssUvoGNKC1WDEiLF/PY9YP84XRmPXxw4TvBCi7jW7gthwfT83tpMdqmHf6NdIJDKbJJeKD1o+rcH6UnR6h0fNm1/g9KJX5G0UfC5t1O3b6PomS0RgufCgh5kNz4QzPTR0/E6DGg7MrZ0h0drHxeVZYnopS4PYSavALA6WewK5rz2sbxTZZ9ppsEVCf2p5pHITPXofwlLvY9oFGT6ybntmwDumoOUShDuV+2oHnV99QkzOY5Wlu5c9o2oBYYpLcuKFAP9r6NlOKYGRvY4RJ+hTzoYlrc0Uth2T5KDMpQOn/MrUzp9Agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/k+UcEzsTrvmqtUfqxFVVGx5DU78FEVIKQfFVMu5PA=;
 b=AtmXmgUs1F8ZxopKMEB4JHj+91/0Ad98u2e0i9lXCKR+vhNqtWG0V1OJeX5HAieFa2bPXtAQndJBW8wpA+OLTXrUxh+7ieaCVaRhH0eiCWqjf1NMCoYUGnnQpRAcHP5K0sbfiy/QgBg+IbiLwZFCdaG0YYrIQ8u0x5a2L24eZak=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR3PR08MB5705.eurprd08.prod.outlook.com (2603:10a6:102:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 16:58:04 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6%6]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 16:58:04 +0000
Date:   Mon, 26 Oct 2020 16:57:55 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        libc-alpha@sourceware.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201026165755.GV3819@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026162410.GB27285@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: SA9PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:806:a7::14) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by SA9PR10CA0009.namprd10.prod.outlook.com (2603:10b6:806:a7::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 16:58:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19df4a05-6440-4c16-5137-08d879d05e2e
X-MS-TrafficTypeDiagnostic: PR3PR08MB5705:|DBAPR08MB5861:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR08MB58613AFAA129866727230168ED190@DBAPR08MB5861.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CHl7rYt9hLJUYshV641rMMEBL37Nda1Qa593n639+GtnmEb136toEXhW7Yx0DHkZX5HU9Ta5qQvxwo3/LhaVf02LFsk0wJNK2MluO7+aZvlOOfX9d6Zl9zTieNfDHwqtWfvMBGk9S1XwS18v6DxHwAOUMzcQ5PgjKIz5cE3jQZ7l0a+itTvqgJzIOEpoGNZxKqDKe1gfGSZn2giXfE32Qc0xNOtC6Z+kCKLQ7Boe222F1OhHF8++CUAn7HHlLhJHC/2FHNH6RU5791qy8GwMQURNLBu/ySsl8ItfHMSb+PFAIM3l5k8sS2aGnM6kOeAW
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(5660300002)(316002)(6862004)(1076003)(37006003)(26005)(7696005)(16526019)(8936002)(186003)(66946007)(8676002)(52116002)(66556008)(66476007)(4326008)(478600001)(54906003)(55016002)(36756003)(6666004)(44832011)(8886007)(86362001)(956004)(6636002)(2616005)(33656002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fBQUkg5Cf8PksUQMBnAGxtPlxuK2qysCyIE6H64LXfvv7zcIpSFHNXawxxLINgdRGBZCas2uSWldzwco8Q38zoHwcQQ5GLyym1BtRZU4bdndmS98nziQ1lnEey2mUYANARZknhXpda+cvLvR7YZ+9TPbER+gi7zCI99a+HsaQ+hmSjK6dP+3ksdcM8SakUTQcb2LyN5Cb1AnVeVelk3c0TWFWBr5rlMw/zWRrHYiKal0Ft+jktfKftkgZ8NYe2VOfJm/sZEKt4HZ6Q9Ddm/eZn0Jsd+BdG/GLuaTY46Xmu6WXQJrmaPpz7QWjtWCaP4Q9ElLNcF1mHJ/kEuSctTNFsHIFIe6hnL1OcRh+fc5EzZqy5GuBVWhOIiw7LLENZuan9xhElxla3m6LeQm/71p5uWZVSTGHa/W85AXev3Wq/deGr9jPLJEf372XiD+UPpdc+AuzXG9HPCmnjfuT4/tllhhWdTLnhpVstzC0e7JShXqZru3Dl8XIdnl/PH9Dxt0+iSXe8gzM//WC1GlA5WTAWipFWISs/i++Qapd5NFUsw8QQ5qxJw6eW1VCcnAinzFJazVHFrN03ET4wM/WXuNDNukDkJtpHHnp2Zow3+CxuLD7t7AHUbCElN+ce9NRhf2BmvzbO+VCFg0EkVFt8QvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5705
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 48265055-e3a4-4ef3-e441-08d879d04de2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/VieUqvFGXu0/4t1Fz4bwt0qoedgNKwnzuWr/0E0Mtfs71LpzlebyS+wZf86KZ2UcyWa4MUj6LoJg7U0wE65suHM60mjGkkmTCCrE4sBXDwqIJsocJtIjo/vFCkI7I6TYZPp2uHa+c/ioDHoXYq2Q1v3BvnX9JXKF1diXLelVSAGT8R8qTU/j4KRm4GSNLbPbjYFYv5ndlbhgMhGU67f+w1yigz2cmex3+6YjEbi7FUxOwnwYaS3fUcITMDHXWaI12uBLXyn2Zo25bPp8L9QN2SPPjSFZ5PkAu/vcG19WVfCL74urZmeQJPzRoHAne16HRagnD+VUNcXPHhgSTV2YeO5p9of8+iKQyZtbpTNpM3aZhgXJ9/t3rnOx7Tb9x75PdWUe8UnLWPJKChKYaAjA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966005)(16526019)(37006003)(55016002)(26005)(8936002)(186003)(6636002)(8886007)(2616005)(8676002)(336012)(54906003)(7696005)(356005)(1076003)(956004)(83380400001)(6666004)(2906002)(478600001)(82310400003)(316002)(36756003)(33656002)(86362001)(6862004)(4326008)(107886003)(70206006)(70586007)(5660300002)(47076004)(82740400003)(81166007)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 16:58:31.3057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df4a05-6440-4c16-5137-08d879d05e2e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5861
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/26/2020 16:24, Dave Martin via Libc-alpha wrote:
> Unrolling this discussion a bit, this problem comes from a few sources:
> 
> 1) systemd is trying to implement a policy that doesn't fit SECCOMP
> syscall filtering very well.
> 
> 2) The program is trying to do something not expressible through the
> syscall interface: really the intent is to set PROT_BTI on the page,
> with no intent to set PROT_EXEC on any page that didn't already have it
> set.
> 
> 
> This limitation of mprotect() was known when I originally added PROT_BTI,
> but at that time we weren't aware of a clear use case that would fail.
> 
> 
> Would it now help to add something like:
> 
> int mchangeprot(void *addr, size_t len, int old_flags, int new_flags)
> {
> 	int ret = -EINVAL;
> 	mmap_write_lock(current->mm);
> 	if (all vmas in [addr .. addr + len) have
> 			their mprotect flags set to old_flags) {
> 
> 		ret = mprotect(addr, len, new_flags);
> 	}
> 	
> 	mmap_write_unlock(current->mm);
> 	return ret;
> }

if more prot flags are introduced then the exact
match for old_flags may be restrictive and currently
there is no way to query these flags to figure out
how to toggle one prot flag in a future proof way,
so i don't think this solves the issue completely.

i think we might need a new api, given that aarch64
now has PROT_BTI and PROT_MTE while existing code
expects RWX only, but i don't know what api is best.

> libc would now be able to do
> 
> 	mchangeprot(addr, len, PROT_EXEC | PROT_READ,
> 		PROT_EXEC | PROT_READ | PROT_BTI);
> 
> while systemd's MDWX filter would reject the call if
> 
> 	(new_flags & PROT_EXEC) &&
> 		(!(old_flags & PROT_EXEC) || (new_flags & PROT_WRITE)
> 
> 
> 
> This won't magically fix current code, but something along these lines
> might be better going forward.
> 
> 
> Thoughts?
> 
> ---Dave
