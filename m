Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467632C40D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgKYNCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:02:43 -0500
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:47841
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbgKYNCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:02:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIae5iSPcNst1y+4H+QwqDD4V7wW7juKvJHWLCyp7/I4RKRVTezqwagXRuNBgRMWuTxWaHg76WEhIJsP5JbGEixuUMnLeRvyOW3I6NwPBKA0BlWDImlQit47b3lD0IIMyc5bO0K0NGKw60P9Uj/QUnb6UvHGui0daaDbrON17KNLq7aLXPtrtZRbhg8+gT4IMd1vBNo8ZwPKTTL1J9vZMOgRxLXKdbYjtM54IEzSarNjRX2/7ZAQr+9fbPFGVpsSDoVJTFBju+tXxttL2n5afuritx6XTXKLVlvK/pHH6iIpWR4rkLqy9Es1GIma1q8TTL1C3jPwBDCv4imxgwbSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb0GRQbCEqJDo2sz3keuBy2IOyovdrCGE3Of1n9IpAQ=;
 b=RF8/ZCQx049gp30PzkxSq2pf4XcHKiaLSaqsnGnLC1vbiz1d95aKHTRILQgij3aKI7pMF0gJUiXzdj9dEdlffO9vsIqjQvpuoKQxWeRB2LzWMiH+AttqOVguC2JJ69l4Q50kP5sBz5g5TCAoOMcDlCjGodIwSyj8XpBpc/b8olYcFeDL7HVYH5pyyqMcldQPs9EXcoQCW9+ChNUrnbBgfLV5498yAJilo8XbQ95lGFZc9hAU+ZOOYumELHAnwbqHuxiYnDYS6cY6EL+F7DYY+POh0WN9dw4Vh4m2DAWn6ryOqlqog6wvUKhx50nSCuSKqv+DX/+lnnH3LbdmQSs/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=suse.cz smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb0GRQbCEqJDo2sz3keuBy2IOyovdrCGE3Of1n9IpAQ=;
 b=LHOZqRiKmfJrFdraL256k0ZEXXBH2Qa2mUZuIa57PuxHXEHPDdaak6HtjuvicEGhdFKrKhUZ/8avqY2ejuDgaWQgmlUfW/EosDIItSDv52aamVn++Uei5SJ7aiTdtrQt+p/vEdZtxr0rPANIGcuIRtfuHfMKJH03vBD8iPX/XMA=
Received: from CY4PR13CA0024.namprd13.prod.outlook.com (2603:10b6:903:32::34)
 by SN1PR02MB3855.namprd02.prod.outlook.com (2603:10b6:802:31::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Wed, 25 Nov
 2020 13:02:38 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::ef) by CY4PR13CA0024.outlook.office365.com
 (2603:10b6:903:32::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6 via Frontend
 Transport; Wed, 25 Nov 2020 13:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 25 Nov 2020 13:02:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 25 Nov 2020 05:01:24 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 25 Nov 2020 05:01:24 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 stefan.asserhall@xilinx.com,
 vbabka@suse.cz,
 rostedt@goodmis.org,
 shorne@gmail.com,
 bigeasy@linutronix.de,
 robin.murphy@arm.com,
 robh@kernel.org,
 rdunlap@infradead.org,
 peterz@infradead.org,
 penberg@kernel.org,
 oleg@redhat.com,
 keescook@chromium.org,
 joe@perches.com,
 axboe@kernel.dk,
 ira.weiny@intel.com,
 herbert@gondor.apana.org.au,
 gustavoars@kernel.org,
 geert@linux-m68k.org,
 ebiggers@google.com,
 0x7f454c46@gmail.com,
 christian.brauner@ubuntu.com,
 bhe@redhat.com,
 nivedita@alum.mit.edu,
 anshuman.khandual@arm.com,
 akpm@linux-foundation.org,
 arnd@arndb.de,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 rppt@kernel.org,
 arnd@kernel.org
Received: from [172.30.17.109] (port=45816)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1khuQF-0007Iv-JE; Wed, 25 Nov 2020 05:01:23 -0800
Subject: Re: [PATCH] microblaze: Remove noMMU code
To:     Arnd Bergmann <arnd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Baoquan He <bhe@redhat.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <caa5c3cbe6253d67fed83c4351d85224f8cf226c.1606303816.git.michal.simek@xilinx.com>
 <20201125120739.GO8537@kernel.org>
 <7217421a-c4de-0bd1-3231-17563e51e3c9@xilinx.com>
 <CAK8P3a3QkWTCDg+v9qtW0aG7ndhmSukuZG-znS_NzRHyoZLQhw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5947a4da-a08f-049b-9162-628e42980b33@xilinx.com>
Date:   Wed, 25 Nov 2020 14:01:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3QkWTCDg+v9qtW0aG7ndhmSukuZG-znS_NzRHyoZLQhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 969e41e9-bfd9-4d15-88b8-08d8914262d4
X-MS-TrafficTypeDiagnostic: SN1PR02MB3855:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN1PR02MB3855B78E30F446CFE0347615C6FA0@SN1PR02MB3855.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGFyLhCrl3fpigCDKhYGrR3aJQ1ge5k6E4RUIyqe0tBj7799MrFjAi4X7oP1+FPszIDNdzRdWY+8L6tUVuicnR2J8V3f8YKSNkjffSAyvtgUtXemkDGUL7ySqhiBvsD1N+3x7XHuw35ZFwv8C1i96VKwJD3zCHdurJl386sZpCfFutBQwcYpGKYYIOcCx3oAZjo6tj7Ly2U8IRY1cuua6gV4+cfYRWHPSBpty1dMHe9RX/RJ+QktOd+zvyl230xWfcSRcLP26G4Ft7tOnpIvZwEXowE2wMzB1ZeGwKA3v5XXQUyJ/R3N+ex3f2Zwkr9gHDKYZziwX4lUqw/pkYnCZFO/4Q3bdAd4bOAhpvUkZg9a7gK9bzTrmkogZ6JaGzn9iisjgxa6BCn4287BMwc7TqmgLPCCOQ/H4EZT0duvHwxF03ogad2FBfZFlstL9CuHadohv7mvUpw22TvaKcI9qw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966005)(82310400003)(7416002)(82740400003)(336012)(31696002)(6666004)(4326008)(7636003)(70586007)(70206006)(47076004)(8676002)(186003)(110136005)(53546011)(8936002)(316002)(26005)(54906003)(356005)(36906005)(36756003)(426003)(5660300002)(2616005)(9786002)(31686004)(2906002)(478600001)(44832011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 13:02:38.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e41e9-bfd9-4d15-88b8-08d8914262d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3855
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25. 11. 20 13:57, Arnd Bergmann wrote:
> On Wed, Nov 25, 2020 at 1:14 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> And second part. I know I removed that Kconfig macros for it but maybe
>> good to talk about what needs to change to support different page size
>> for systems with MMU.
> 
> I would recommend just leaving it hardwired to 4K. The benefits of larger
> pages are rather questionable, especially on systems without tons of
> RAM, and it's an endless source of problems.
> 
> The commit that added the option, ba9c4f88d747 ("microblaze: Allow
> PAGE_SIZE configuration"), was rather nebulous with "can improve
> performance on some workloads".
> 
> On PowerPC, the benefits of larger pages are mainly for the hashed
> page table code, which I don't think exists anywhere else.

Is there any standard benchmark to see if there is really any benefit?
Exchanging tbl is quite expensive operation that's why there could be
good improvement.

But not a problem to remove it for now and get it back when this is
properly tested.

Thanks,
Michal
