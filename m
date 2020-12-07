Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE32D1A37
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLGUEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:04:48 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:35296
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgLGUEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa6Sb1BQTbIK2NlQmdxTgQ0S2oifo8J2K70H4M9tzhQ=;
 b=tfOqdjOZDqILO3HHbidQfr9xEXTLbrnWzwz0MuvSaxZGvjQRvSgs0q1UMRkg+grX1HyAUxvzXvyG1bA2wUzXWhQvB7vVQSFCw4q8H+uDhczGQ4Z9lkFILEacoJsBQ6vPhFvQMLTs85sR3IzNHam3NHeKKJ8MTrn1GhEmMh94UEs=
Received: from AM6P193CA0136.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::41)
 by AS8PR08MB6165.eurprd08.prod.outlook.com (2603:10a6:20b:29a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Mon, 7 Dec
 2020 20:03:58 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::9f) by AM6P193CA0136.outlook.office365.com
 (2603:10a6:209:85::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 20:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:03:57 +0000
Received: ("Tessian outbound 8b6e0bb22f1c:v71"); Mon, 07 Dec 2020 20:03:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 62f5874024543cbc
X-CR-MTA-TID: 64aa7808
Received: from 9935a9f0dc8c.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E86A938E-9841-460E-8C35-882C232F7E09.1;
        Mon, 07 Dec 2020 20:03:41 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9935a9f0dc8c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 07 Dec 2020 20:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf+bue57AaLQ0crJvGiZ15AXGuVIR2UQwTMuXa0CYi4QXcCDfhYbwrU6eKI7/jqSyNJuGCyrfCCsLhf+MVDQMFZNUieHVwQ5DMx4HijPe+uRct5R5n/gxX4th/9NFH6+dwaRBa08LXxk9Jd1FA/47rci/z+81QFcN9ZLQWKKJ4Jvetf0v3y7o7DbGqXdbbFTFv2CXOgNbqblcIGrgIMZjSZWm5goJ/l0xXFRf5GRNGR2o1f6ERpirRNHUYyqLTTAFR4MVzVry7t0Ed4bCrfzS6Ms0u5EcavBaoLaPJ/af49dIOW7d9idZASnSFAIB3JbsQy3+i22f1QTWzx6aM1kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa6Sb1BQTbIK2NlQmdxTgQ0S2oifo8J2K70H4M9tzhQ=;
 b=kO6uQ3bVCthiEpJ9J8wm4Ev6ShOkc+SWRY2kksYS4VWCOCWMtOGxsOVltf8k4vGq7GCmREC6QHwnsrF0Zlgtm5dUKzONhS4porTbdUe6T9oX+YRetpcgxu5KMN/Qbw09B3J1UPEKz/PrKLgRle62cXuT0XYgmBGO6Yv6pzSWHo7nlJytqX81F3Wl82NQBBI5LfCwnQ1rSfK0XWRRaV63a5BPVMn1bKh5PaHL4tY8EraRlwzjnwZoiymJ6Au3ksgNzXPSRLpJVF8YYP7jcuNWt5n6DT35jNXth3qukvcnt1THQTf+O/+AUEqdL6JkeOB6s3QpeGQZ3VRs8rYE+cY3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa6Sb1BQTbIK2NlQmdxTgQ0S2oifo8J2K70H4M9tzhQ=;
 b=tfOqdjOZDqILO3HHbidQfr9xEXTLbrnWzwz0MuvSaxZGvjQRvSgs0q1UMRkg+grX1HyAUxvzXvyG1bA2wUzXWhQvB7vVQSFCw4q8H+uDhczGQ4Z9lkFILEacoJsBQ6vPhFvQMLTs85sR3IzNHam3NHeKKJ8MTrn1GhEmMh94UEs=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR3PR08MB5658.eurprd08.prod.outlook.com (2603:10a6:102:88::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Mon, 7 Dec
 2020 20:03:40 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:03:40 +0000
Date:   Mon, 7 Dec 2020 20:03:38 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
Message-ID: <20201207200338.GB24625@arm.com>
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
 <20201203173006.GH2830@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201203173006.GH2830@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LNXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::32) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LNXP265CA0044.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95a811bf-7a1b-4417-d59f-08d89aeb3b6d
X-MS-TrafficTypeDiagnostic: PR3PR08MB5658:|AS8PR08MB6165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB616549B0A1286C5942FA9815EDCE0@AS8PR08MB6165.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pIie1k0poU1jSwHWwOVN5Ce6hZA0irwTl9Ktt5U6GRz/3qzDrJdT8LsI0qtgsDyPBmqZ1O+uhPpfhH0QDf1B7x/QN6jRPQSyXgePJPwlf6rdEk2/qERnPIdT6zbfeuetiBjA/YuJVjrthePKQpvFZDckYzOAjDRQbtmO1qqMSei7jUtdkMr5+Fwd5Z09DOOweuFwm57nESTyjMnLsk1nTCgsFxLBAyp1OMjiK7D7iSkB6WECGkdpSdC2dbw7LlQh29Z/kRPzV1MpvZGjygvmXjQg4egWrusdKp8YtUGs1eVWbQ2hdephE73ApL4XxjzyAWNc03tegKl//VSZbeJFT30bsL8yPWorl1J61dM7GuhXbstaXH1trv85WE2Kr5E1YraoVd9h3Gld7mjXg1H+PTtn4ef60+6FRtErLDl3hr+OYw0zGt8dpU44DsYOVnYZozKSs/I+1WWX02QNSi7FKw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(16526019)(55016002)(36756003)(66946007)(52116002)(186003)(33656002)(26005)(4326008)(2906002)(66476007)(1076003)(66556008)(316002)(5660300002)(478600001)(8936002)(6636002)(8886007)(37006003)(956004)(6862004)(44832011)(54906003)(966005)(8676002)(83380400001)(2616005)(7696005)(86362001)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzRqbkRJQVNGdDJQWGNWamNmYnJFcytQaXJUMTJ3UXpCbGR3TnlRb2lzdWpp?=
 =?utf-8?B?SG94U0xKK0ZHTnVTYk9zcWZJMVVtU2tLNUpyZDlhbVRVOGJ2aVdoRzh0V3ZG?=
 =?utf-8?B?LzVMQmVDWW5iT0dLcXlaU1B1TG5HdWlOQmVwdFVpZUl3YWxpZ2FMMXlJVnYr?=
 =?utf-8?B?enQ2eHBqMUhST2NjWFBTK3NFajB3aHo5Z1Y3eEVEdUxoQmRZQlp6UlZBejF4?=
 =?utf-8?B?NnlBeXJGcC84UFdYRWFCWnpSRG1xM0E0dFRLRWJyM0dCZElseDh3T3JNWmQ0?=
 =?utf-8?B?L3NtUUM0TnBYU3dKVndxV0plVFVobFF0R3VDQnBNSUpadGhzajdzTVMyTk1Z?=
 =?utf-8?B?S3hyTmx3Tk9QUGdjWCtrYUpLUS90WDVXNWtVbTU0WXFrOU9JZjRFbTZoS3JX?=
 =?utf-8?B?SXVoMzFCd09YWmJGbG93enBQY2haOWxmaGhiTkR5bUtsS3MrRXBaUWZHcW94?=
 =?utf-8?B?Nm1ZSnJINVA3RlJRcnRvNXNtblRDbUNMM3NrM2Q3SFhSaWhyTWUyYXRBMStU?=
 =?utf-8?B?Mk53TFZ6eFVpdUZjYnhZZzhYNlJUNVB2aU5LN3VyRmZLZWkydFI5M3lDbnRR?=
 =?utf-8?B?a210ank0RUhWc0lmcnp2RzNlYmxlNHJyRERoSmI1NHZmbTRMMkt3RElTTG15?=
 =?utf-8?B?Z3RNUUE4anQvc0NxdW1pdTZrdGRWaGwzTElMMFU5WG1kZ05RdXluUHFZRG9s?=
 =?utf-8?B?d3lKRmxwMmlubklRRjNQVnlISHJrbGlYRVdhOVJSREZzV2pHQjd6L05TZ0dw?=
 =?utf-8?B?NEx1RW5Bd1VIRTVVSkJCU1BGeTQ4cUNNWjBDZXhaN09tOWNvclJudkZzMjBL?=
 =?utf-8?B?aWxJNk0zL2E0TkZhTTNOeTFFZmxOQjFUTmdCRThHeHVxb3cvUFRpblJyN01t?=
 =?utf-8?B?M0NVSzB0V0JzODRBYk1QUTdyd0tqVkhLakRGdXJlbmJJT1JHdlpBSUFZL2ow?=
 =?utf-8?B?dy9XaUxjdHkzcktTdngwUHZmbmNqQXBMd21HN2tYSTY5N0l2MGU5ZHNmTkgx?=
 =?utf-8?B?bm9VK3BFTWdhc05XMno3WWIxaFI4WTdmdjNaZmlHYmJqN2l1V1NZejFKcGxh?=
 =?utf-8?B?SG9BTWJUV0xPVnhXcW9TS2I0YXlOc0YvTm1zSWFSanNxd3lxcWtXWW5JbWMx?=
 =?utf-8?B?OFg2UDkvNTNyR09ZNFpkbWNxWlZkY2xJNVpDZkxyLzJBM0dMQTV2WWoxQlFW?=
 =?utf-8?B?V1JNU3d3Y2VYNlhDOWlya1QzMzBVTzJ4cHYrL25OT3RHRWNlMEJsRXFLeCtw?=
 =?utf-8?B?cUs2ZTBjWXZmbFJnOFBSdnB4bzlIekk5Vmh5anVTNjFLa0RqcWphR3pDQjV0?=
 =?utf-8?Q?4sLmq/U2437lpnwP55+CVgyCLpy0st9iFW?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5658
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 86ace2e3-5323-4ddb-4047-08d89aeb30d7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jzTKMlqn0uxHM1MpMACe1vNHrCF4SG+9OmnDMjNAOwGrK/JYanv1EkZSsqZXqCYEifR4J6iL7DOXcQUjiwv4ZVm/tW/xuIKkP885MrcGLNKRitYg85YpLVYChcEbMh5/SCVp2HSdz/2jMK+XcWRojXs6G5jPckrkRgUFh/XmXlee88CT3NKHyGsAChgoOFhsX5MYl0OWi1t1I1bjB6uBMqtd1MafW7H/FHlD+HakdBSEvkTXfqGl+bmS5uunSILeYC5GQ/i3K7033/nWhmjbzs2RpEobw2Y+q/8l9RKmXklOJz/IHqFYsdvsTEIBu8Sk7UpaAIEhDiPquK6Kkdvf+pxAcs46VrM+dKrEhVDTqaZ/03SA+mHTm/Q/m4JUTWZSQuQWZoRAy551n3fReAwY3vzGxt7OIbOunbjlqgVvwTk6FlolNr0GA4ioTBjJWMRp6v4JZcw8o9EoCgTTOKndu6lILNfx9vv0vMY83N4caBiuf3hNwGwGQP6cwlEBkd+
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966005)(8676002)(7696005)(8936002)(37006003)(70586007)(81166007)(5660300002)(26005)(82740400003)(33656002)(316002)(6862004)(956004)(186003)(70206006)(44832011)(356005)(54906003)(4326008)(6636002)(2616005)(478600001)(336012)(86362001)(36756003)(47076004)(1076003)(83380400001)(55016002)(8886007)(2906002)(16526019)(966005)(82310400003)(107886003)(83133001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 20:03:57.6711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a811bf-7a1b-4417-d59f-08d89aeb3b6d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 12/03/2020 17:30, Catalin Marinas wrote:
> On Fri, Nov 27, 2020 at 01:19:16PM +0000, Szabolcs Nagy wrote:
> > This is v2 of
> > https://sourceware.org/pipermail/libc-alpha/2020-November/119305.html
> > 
> > To enable BTI support, re-mmap executable segments instead of
> > mprotecting them in case mprotect is seccomp filtered.
> > 
> > I would like linux to change to map the main exe with PROT_BTI when
> > that is marked as BTI compatible. From the linux side i heard the
> > following concerns about this:
> > - it's an ABI change so requires some ABI bump. (this is fine with
> >   me, i think glibc does not care about backward compat as nothing
> >   can reasonably rely on the current behaviour, but if we have a
> >   new bit in auxv or similar then we can save one mprotect call.)
> 
> I'm not concerned about the ABI change but there are workarounds like a
> new auxv bit.
> 
> > - in case we discover compatibility issues with user binaries it's
> >   better if userspace can easily disable BTI (e.g. removing the
> >   mprotect based on some env var, but if kernel adds PROT_BTI and
> >   mprotect is filtered then we have no reliable way to remove that
> >   from executables. this problem already exists for static linked
> >   exes, although admittedly those are less of a compat concern.)
> 
> This is our main concern. For static binaries, the linker could detect,
> in theory, potential issues when linking and not set the corresponding
> ELF information.
> 
> At runtime, a dynamic linker could detect issues and avoid enabling BTI.
> In both cases, it's a (static or dynamic) linker decision that belongs
> in user-space.

note that the marking is tied to an elf module: if the static
linker can be trusted to produce correct marking then both the
static and dynamic linking cases work, otherwise neither works.
(the dynamic linker cannot detect bti issues, just apply user
supplied policy.)

1) if we consider bti part of the semantics of a marked module
then it should be always on if the system supports it and
ideally the loader of the module should deal with PROT_BTI.
(and if the marking is wrong then the binary is wrong.)

2) if we consider the marking to be a compatibility indicator
and let userspace policy to decide what to do with it then the
static exe and vdso cases should be handled by that policy too.
(this makes sense if we expect that there are reasons to turn
bti off for a process independently of markings. this requires
the static linking startup code to do the policy decision and
self-apply PROT_BTI early.)

the current code does not fit either case well, but i was
planning to do (1). and ideally PROT_BTI would be added
reliably, but a best effort only PROT_BTI works too, however
it limits our ability to report real mprotect failures.

> > - ideally PROT_BTI would be added via a new syscall that does not
> >   interfere with PROT_EXEC filtering. (this does not conflict with
> >   the current patches: even with a new syscall we need a fallback.)
> 
> This can be discussed as a long term solution.
> 
> > - solve it in systemd (e.g. turn off the filter, use better filter):
> >   i would prefer not to have aarch64 (or BTI) specific policy in
> >   user code. and there was no satisfying way to do this portably.
> 
> I agree. I think the best for now (as a back-portable glibc fix) is to
> ignore the mprotect(PROT_EXEC|PROT_BTI) error that the dynamic loader
> gets. BTI will be disabled if MDWX is enabled.

ok.

we got back to the original proposal: silently ignore mprotect
failures. i'm still considering the mmap solution for libraries
only: at least then libraries are handled reliably on current
setups, but i will have to think about whether attack targets
are mainly in libraries like libc or in executables.

> 
> In the meantime, we should start (continue) looking at a solution that
> works for both systemd and the kernel and be generic enough for other
> architectures. The stateless nature of the current SECCOMP approach is
> not suitable for this W^X policy. Kees had some suggestions here but the
> thread seems to have died:
> 
> https://lore.kernel.org/kernel-hardening/202010221256.A4F95FD11@keescook/

it sounded like better W^X enforcement won't happen any time soon.
