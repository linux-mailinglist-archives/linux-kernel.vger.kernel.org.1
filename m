Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844EA2C3FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgKYMPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:15:21 -0500
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:9568
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727626AbgKYMPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:15:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA2UrNgy9PkN/64Q0kPy+ZZcXJP41QKcQklvmePd0c+7AM71CbQjIa0sWK6yAQFzlGNevp+5BNraPfBxx0AFNJszo3ZxuiOHWK2CjkBI16tAOEoW5Zjd6KwWImNAHcrSkFvkdxgzdGREaM+UTjE/iLKtF+jtZ11fGFkBJk03a1dBJ0+ZfShxd6K8JKy9X/g1Wfl1LW4OZng0v9NA0rX+kcfNYxNqmoOL4TUQ5WOSNjZg9XJqTG+9C+VG5WAG57D40QSqZpJHBx+wuUx9sNn9Scgt/Dmk/I24praztv2ujMOSniWb2mAWz50xiPpKLFUMtR+mpXHVcXY35rWP1qPySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud7Xh92+sQlpr+iS6kb+GeeoX8lSpzbHYrMJUsY2Tcg=;
 b=GfaAnGr8D6XJeegA3/RMYRFyUG6rXYb245D3D3f5SiwGpg/0YyxU9sEq4sQdpPglOSosusfgGycUCJVomgm8tDKG2RpKDLgaIb4o0wbufEAkNG12dVg00KPI8dkKbVoHullccaIIo1Qio7jQBszA1NcrgDKkzArNiG6Ji2sblskbtVmGVO+Qsu9rE9oKcgorje1tFFTm9dsN8RB0DxTasJCGlxYbB69uA9f7j650SPexFxPkkigGJAY1b9Ls7HFoHDqsujH0DKMBSu3W5qqsq9keVzOEkZn3MBhneEs+RHLLtXRGFAai1FKfAMzRHPhUQVtEzY7Uss64N+v+sNvAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=suse.cz smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud7Xh92+sQlpr+iS6kb+GeeoX8lSpzbHYrMJUsY2Tcg=;
 b=YN4ID+yU6iJp8Xbg4HEYea7i9ayODP11iW7A2SuuOtww4O9MSXdnFxRbIVvU/MjvqZ6kSUJmT6KidZYeOfOHfPWXV2oJpRkvdjyp+y0D3iHh3weZPJ+Utg/mUWnN/Pe2UTFubNODeoBdS5KMQ88lGUeps45Lig5IbmdpOvyJhp4=
Received: from CY4PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:910:16::29) by DM6PR02MB5353.namprd02.prod.outlook.com
 (2603:10b6:5:46::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 12:15:10 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:16:cafe::75) by CY4PR1201CA0019.outlook.office365.com
 (2603:10b6:910:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Wed, 25 Nov 2020 12:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 25 Nov 2020 12:15:09 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 25 Nov 2020 04:14:58 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 25 Nov 2020 04:14:58 -0800
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
 rppt@kernel.org
Received: from [172.30.17.109] (port=41668)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1khthJ-0006Wc-AF; Wed, 25 Nov 2020 04:14:57 -0800
To:     Mike Rapoport <rppt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, "Arnd Bergmann" <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Baoquan He <bhe@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric Biggers" <ebiggers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Manish Narani <manish.narani@xilinx.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <caa5c3cbe6253d67fed83c4351d85224f8cf226c.1606303816.git.michal.simek@xilinx.com>
 <20201125120739.GO8537@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] microblaze: Remove noMMU code
Message-ID: <7217421a-c4de-0bd1-3231-17563e51e3c9@xilinx.com>
Date:   Wed, 25 Nov 2020 13:14:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125120739.GO8537@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7fa6f1a-bcb9-48aa-df26-08d8913bc0ec
X-MS-TrafficTypeDiagnostic: DM6PR02MB5353:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR02MB53534A64F20D95E445B3DCC3C6FA0@DM6PR02MB5353.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nmPCFG0bUxCZ0ssTiYRwHMyKb13onzdNujGdjNbdQUcElZJbdJbYxqw82Um4bK2WMTD6W7X7Rm6O753CEw5titqcgZvf4MClwguWxQV8n/lHtbnNth8uasY4zPknh9wM7/I0sZgvDw6a4wzZC43beAfr6XJDbp0skS/8LHF38tRRbPLte7RjhW+bNv3OXqrJBOqk/TpE1kQXO4c8X8/v02KCZrn+9/GNRENJxzsWceMiViJwsZDaxsVFXzsaiTLcUDUmrpSC8djC7q1ddg+NIm4SF4mJ/TTELAmUMXjGCSNQYpJdHiqm3pOPslKr1+F56gYfvDEvfPlLhWe2ZNVVMvCMGu8iazXrg+L+VmEFWUdjKS4GorV/rsq/yvglO9OLJ9y0dUBMfsxCT8iTd6xPa1j2QlU0/0erONBG2acTa1Z1eU8SKknrVdTMHpjLD4oqfmsitd3NXFY2CTD1+IeCQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39850400004)(46966005)(36756003)(70586007)(478600001)(82310400003)(4326008)(316002)(36906005)(31696002)(2906002)(31686004)(70206006)(44832011)(7416002)(356005)(9786002)(2616005)(6666004)(54906003)(7636003)(186003)(8676002)(82740400003)(26005)(336012)(426003)(8936002)(47076004)(110136005)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 12:15:09.8102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fa6f1a-bcb9-48aa-df26-08d8913bc0ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5353
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 25. 11. 20 13:07, Mike Rapoport wrote:
> On Wed, Nov 25, 2020 at 12:30:32PM +0100, Michal Simek wrote:
>> This configuration is obsolete and likely none is really using it. That's
>> why remove it to simplify code.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
> 
> Looks ok to me except several leftovers:
> 
> $ git grep CONFIG_MMU arch/microblaze/
> arch/microblaze/kernel/hw_exception_handler.S: * STACK FRAME STRUCTURE (for CONFIG_MMU=n)
> 
> $ git grep -E 'MICROBLAZE_(64|16)K_PAGES'
> arch/microblaze/include/asm/page.h:#if defined(CONFIG_MICROBLAZE_64K_PAGES)
> arch/microblaze/include/asm/page.h:#elif defined(CONFIG_MICROBLAZE_16K_PAGES)
> arch/microblaze/kernel/hw_exception_handler.S:#ifdef CONFIG_MICROBLAZE_64K_PAGES
> arch/microblaze/kernel/hw_exception_handler.S:#elif CONFIG_MICROBLAZE_16K_PAGES
> drivers/net/Kconfig:                 IA64_PAGE_SIZE_64KB || MICROBLAZE_64K_PAGES || \
> 
> 

I left it there intentionally. First one because there is description in
that comment which references noMMU. If this should be removed the whole
comment should be tuned to make sense. It is better to do it in separate
patch.

And second part. I know I removed that Kconfig macros for it but maybe
good to talk about what needs to change to support different page size
for systems with MMU.

Thanks,
Michal
