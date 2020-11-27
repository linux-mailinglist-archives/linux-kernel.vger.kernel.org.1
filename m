Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527E12C66A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgK0NTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:19:46 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:14689
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730084AbgK0NTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/knZT0tbqHc982X654snIvTvpEJJ7pXGW1wFtvYo/0=;
 b=4WdImfM5JyGtag5ojQrMrgh93PAtgjKQp0RsJoIZXDy/RrrsA/QTx+LvoCmRfGMgBSXdE7w0Di8sCubqNjssckUs7j2A5an7Q6eabdVJWbP6GMGMEz4JtRel25l9yqBnOOn5nCcIYHuooyu+pabjK9GV1cmEJWEKlAGwAafiS9I=
Received: from AM6P194CA0081.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::22)
 by VI1PR08MB5325.eurprd08.prod.outlook.com (2603:10a6:803:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:19:39 +0000
Received: from VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::90) by AM6P194CA0081.outlook.office365.com
 (2603:10a6:209:8f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 13:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT032.mail.protection.outlook.com (10.152.18.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.26 via Frontend Transport; Fri, 27 Nov 2020 13:19:38 +0000
Received: ("Tessian outbound 082214a64d39:v71"); Fri, 27 Nov 2020 13:19:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7b3d5f400398f0a8
X-CR-MTA-TID: 64aa7808
Received: from 292f3841bc57.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C35904F9-82A5-47A6-B577-EE1B8B7E4772.1;
        Fri, 27 Nov 2020 13:19:31 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 292f3841bc57.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Nov 2020 13:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmQEE6t6TmWWu5XztU3ebmuO3XpdhpHc/q4nSet2xJoEEXTrGpLkD+GotUysLbXtIUTo65lq8CKYfqXRXtj7UIwkwKqWXVJi1mcJS8H8+Cb6/whF7Rn1S2sgky4rrwxWZyEYE0xzUJsTk/UitxQYwl+KX3mgefNhCZV6TWJpptIQCHu6WNRH4Q6qN3zagR67ov9JY3AFwYAC1zqPvL4VavEW3hluu/K4mBVigwfpW6PSRY45bk5PHaAoXXP6tW/4mjQyXmX1Svqkv9Psvfpesok45NziaICKyyrTqU4CLvGOMMemD8OvbQW7VgKswrKcWi7zjgILkrmmHttzUzxiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/knZT0tbqHc982X654snIvTvpEJJ7pXGW1wFtvYo/0=;
 b=mzRbEr+ju619tETtDMEH92TTeyhKbwl7ZuYAkxvVDYe6mApFbHu1vFYEU4S6OyLVpcsa2zgsFZYRkbX8/rzPZQq1ksAhNbfRgh5ig/OcNJm7Ae4DQ0iY+jwwiOrEzmcAB+r/QncXp6ggcfWQN7yiz5KK5yK1b2uRlYGbSxPZvjwXWj3lrR8hx0gV4B4xAwVGSg4oSzJ4EVJH6S0OzXEF7plS0gTY0WSN5eUpBtHgrmnNIgqR9py2Aa5IjuDPQc1aRq9LbO7Z8ON8qt+hXve6XyqOHqSk9uJpiji159tJ9o1Cku0WMP6OTlBx8qB0VQ5T0uFN7dOnM28A0Mif3bZEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/knZT0tbqHc982X654snIvTvpEJJ7pXGW1wFtvYo/0=;
 b=4WdImfM5JyGtag5ojQrMrgh93PAtgjKQp0RsJoIZXDy/RrrsA/QTx+LvoCmRfGMgBSXdE7w0Di8sCubqNjssckUs7j2A5an7Q6eabdVJWbP6GMGMEz4JtRel25l9yqBnOOn5nCcIYHuooyu+pabjK9GV1cmEJWEKlAGwAafiS9I=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6014.eurprd08.prod.outlook.com (2603:10a6:102:ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:19:30 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 13:19:30 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     libc-alpha@sourceware.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ #26831]
Date:   Fri, 27 Nov 2020 13:19:16 +0000
Message-Id: <cover.1606319495.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41)
 To PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 13:19:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08170bc6-7633-40b4-6088-08d892d717fe
X-MS-TrafficTypeDiagnostic: PA4PR08MB6014:|VI1PR08MB5325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5325D155ECE74B3F627F550BEDF80@VI1PR08MB5325.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Fv43eJzM4mdyZwcQKFdb3c0wVNZpD5sMyGtfsYrkdESnWrbdINIHm3huULZEAov9YHaf+HubfIXqjQKrjr+OvxKl4ZqtidSrWUcsiIk0EmS8al0xf70LFcp1APs5q0CJm3YxSFxGUABJsXU2gE3GzXN+b7wfSn4nuOELhnunRDhmOuK5qUytDnT2YzqhCtXzUQpZMIFG53V6Lcli6FTwh6WQuf4L6JY2VEG/N9VVevxFCDPQf8kgZ3k2rX7aAfhaTJfnxWFFaxpg//WT0GGBOEGhHLoS+NAIzD3aJzKjFnj+nYOcGPaTiFtJYOgHFQ0Q13grYmx8mA6UnAXOqhj3a1xvE7bTGMQVIAtNDu2KKRhyq7lYFcVeHwzmplUxAztpjhukdOb58Q3q/OUhT913tNLlkdBBLBI8Ue0mbahFj3s8lBDyuHIcerTHADuntZM8aLJRjIHkKIcWSHQMJOk2A1cY0NIaFcwOY0+HNdyqy50=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(54906003)(69590400008)(6916009)(6512007)(36756003)(6486002)(6666004)(316002)(966005)(478600001)(5660300002)(2616005)(86362001)(44832011)(2906002)(956004)(8936002)(16526019)(186003)(26005)(8676002)(66476007)(66946007)(6506007)(66556008)(52116002)(83380400001)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K+eTd/WjbBgN6mLAEPorLFO9DUoRWNK0xFQ7TzOpr1HpPaYwasDen1b15lC6?=
 =?us-ascii?Q?8zXmNQzs1mxQuutCTBrWmdxFx8NHwALCYqWnkWTgVIzUb5SALWREOM2OlV94?=
 =?us-ascii?Q?qRH5uoSD6UteharbNMb3bEnnUb9nohPrgAKmGADw02A9Pf8opMsC5WLk6gfp?=
 =?us-ascii?Q?/S+VakM43PiqcS71L8m9/iu4OPipOQUxSGni++j3/Zo2rmAu3xDbjnIFZw/W?=
 =?us-ascii?Q?keN+3un0Vhb0iL8voVLaFoE0C1kykC7r6uQ0W4885nYHtRtUSWqacNu4TRt7?=
 =?us-ascii?Q?mXEw2EsNM36GJ+EVdPOQFelexwdZgJOMj4uywOYRVjTHutqK8FiCmP4EeUo3?=
 =?us-ascii?Q?io/ps6j2JXNUnPhQ+af5WGoW+QK5j9gIN4ahKPOBPlDgalI2YQu0sRrBP0nq?=
 =?us-ascii?Q?VE8+jpzeBUdX7asE+ymMXK5GEWyjmLQ1maQaqhoRDWxDazn8aUdqOIvnrS6r?=
 =?us-ascii?Q?tYJHndG7RLaeaZLA9EeAEyGu587tg8lg3v/GRMj7xaWWZxPokN1ekX3EieOQ?=
 =?us-ascii?Q?Buhj8jU/DVeWi9dlkwjS6OTqIpQBt8BA5MlpfUGTM1ZBsejqRBsyiH14UAVR?=
 =?us-ascii?Q?FiRsf0pCzQh8CBDKi3DQxBIl5QtvAZtTkOI3FKR3yfhG91BwhIRP47R4XSz7?=
 =?us-ascii?Q?1rHtDBgzlr6ykQGvpP9l1RPX2LomUoGgeJfVxEPZ4ymbIej5Zecxw6FqWoUN?=
 =?us-ascii?Q?/ESva0qomQo5CeSogPAj7CVVvFnHOrcoLYbkexXRa1FpXsnW0kQbSm1HDeeS?=
 =?us-ascii?Q?dDkcBJysROTLttKxK4T5oOxE4hwm7DoEnW+IZxufhZ03NxY9+WZUpO9IRY1L?=
 =?us-ascii?Q?+22suhFEPr7Wcd66gEP2bDVXeNx2BCp8oOBghLpVWmWwqtzREspLQL1dnNzQ?=
 =?us-ascii?Q?bqPEZkWlheEgza7JFNUfeLS4Ne+Awk+U+IHQm8/sY1EKcUWYj177DAbhHcAh?=
 =?us-ascii?Q?H0JtLk7ho5LWjspSn9UCnjojiLFVcRHwsdJCv4gk8gpR/a+KLuWL8fNvCMSe?=
 =?us-ascii?Q?8i2V?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6014
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7a8468b1-be2f-4801-3887-08d892d712a5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3e0eqi+K11xGHkmvsM9FkBxNBTG0cjRWvgcFDcpjcwHrTwwbcKbpQ7A+ViRSwVVDdPPSMe7dyuMvTktXFIp+YWThzeLzae8BwJgVOlsTizQJUcFosrkNjpRh0MFsV3Jp/kGcX1Ni3qClfcmVopjZobf3sr8kat+qNxVg+TeMr6bKCn8jxil7naY7mQ37lDY+WeT6DB9pmcHwbjWRkZIWrX0+AD80LXZk+komFg9QDWmwlOT4+wcXz/MQhRU2PjLrTOKlHN88P/M/rPUjQX7HJvz2NwIv3wg/UjMpWW0r3Otcv4lTuZ78GgOehH4r6E4i+BJTUV9nTsmzXRVboGTSJS4tLfheYFQeGCc1qWyqbSpdCwdiiZp+xKG+7Pw8x4v6hwqGF5STzCg4kYoWwm3z+YmHC7jB7nwsqhHjoyisC0pcoT3lXKogXDW1mWPe80mZvtrUF5BdbBlRo9tqjVK3wc190lG6JJS9zRaLvmWip/2XcTaoniWih/x12v6p7B9Rz41W+HeCGyY60lSc7EyLg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966005)(8676002)(8936002)(26005)(83380400001)(5660300002)(16526019)(6486002)(336012)(478600001)(2616005)(69590400008)(956004)(966005)(34206002)(2906002)(81166007)(6666004)(54906003)(6512007)(47076004)(316002)(86362001)(44832011)(4326008)(82740400003)(82310400003)(107886003)(6506007)(36756003)(70586007)(186003)(356005)(70206006)(83133001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 13:19:38.9736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08170bc6-7633-40b4-6088-08d892d717fe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5325
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of
https://sourceware.org/pipermail/libc-alpha/2020-November/119305.html

To enable BTI support, re-mmap executable segments instead of
mprotecting them in case mprotect is seccomp filtered.

I would like linux to change to map the main exe with PROT_BTI when
that is marked as BTI compatible. From the linux side i heard the
following concerns about this:
- it's an ABI change so requires some ABI bump. (this is fine with
  me, i think glibc does not care about backward compat as nothing
  can reasonably rely on the current behaviour, but if we have a
  new bit in auxv or similar then we can save one mprotect call.)
- in case we discover compatibility issues with user binaries it's
  better if userspace can easily disable BTI (e.g. removing the
  mprotect based on some env var, but if kernel adds PROT_BTI and
  mprotect is filtered then we have no reliable way to remove that
  from executables. this problem already exists for static linked
  exes, although admittedly those are less of a compat concern.)
- ideally PROT_BTI would be added via a new syscall that does not
  interfere with PROT_EXEC filtering. (this does not conflict with
  the current patches: even with a new syscall we need a fallback.)
- solve it in systemd (e.g. turn off the filter, use better filter):
  i would prefer not to have aarch64 (or BTI) specific policy in
  user code. and there was no satisfying way to do this portably.

Other concerns about the approach:
- mmap is more expensive than mprotect: in my measurements using
  mmap instead of mprotect is 3-8x slower (and after mmap pages
  have to be faulted in again), but e.g. the exec time of a program
  with 4 deps only increases by < 8% due to the 4 new mmaps. (the
  kernel side resource usage may increase too, i didnt look at that.)
- _dl_signal_error is not valid from the _dl_process_gnu_property
  hook. The v2 set addresses this problem: i could either propagate
  the errors up until they can be handled or solve it in the aarch64
  backend by first recording failures and then dealing with them in
  _dl_open_check. I choose the latter, but did some refactorings in
  _dl_map_object_from_fd that makes the former possible too.

v2:
- [1/6]: New patch that fixes a missed BTI bug found during v2.
- [2-3/6]: New, _dl_map_object_from_fd failure handling improvements,
  these are independent of the rest of the series.
- [4/6]: Move the note handling to a different place (after l_phdr
  setup, but before fd is closed).
- [5/6]: Rebased.
- [6/6]: First record errors and only report them later. (this fixes
  various failure handling issues.)

Szabolcs Nagy (6):
  aarch64: Fix missing BTI protection from dependencies [BZ #26926]
  elf: lose is closely tied to _dl_map_object_from_fd
  elf: Fix failure handling in _dl_map_object_from_fd
  elf: Move note processing after l_phdr is updated
  elf: Pass the fd to note processing
  aarch64: Use mmap to add PROT_BTI instead of mprotect [BZ #26831]

 elf/dl-load.c              | 110 ++++++++++++++++++++-----------------
 elf/rtld.c                 |   4 +-
 sysdeps/aarch64/dl-bti.c   |  74 ++++++++++++++++++-------
 sysdeps/aarch64/dl-prop.h  |  14 +++--
 sysdeps/aarch64/linkmap.h  |   2 +-
 sysdeps/generic/dl-prop.h  |   6 +-
 sysdeps/generic/ldsodefs.h |   5 +-
 sysdeps/x86/dl-prop.h      |   6 +-
 8 files changed, 135 insertions(+), 86 deletions(-)

-- 
2.17.1

