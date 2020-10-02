Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C56280D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgJBGaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:30:21 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:40166
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbgJBGaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:30:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgyjvebwvxvn/5H2NE9CVsE5Fr2HXTONNXN2HggxKlfZ7PnyZuHtrgCznDCGxP3hbukyazDYNNbY+gqRdLoVbMtm9WC32sM5rXyZYwgvM4XCLhNFX8hh6l8/t01QD+4e9kB/Ceu0uw3/vw0X5Ez66Ee9cU82gkx3qjyb4SqrG5QeaqvMrROw8uE610XEzMAxFsPDu/r0oKskAEiqHPfP8heKAJLefwaA3P7w6ZFeGru364hsLPgd4QilbiRKSz+VCZz4RwkSYf0ohW+eG8nUbVfuNJwA/yNWs7O3nA9ZecyL0SPmH8g5Tio8dWBHhB2h/LWhlC4ILdyeDNm28+P0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZD3k86trrIUaXqiU0ap8g9W2u80SYjtDfICfr/HJ/A=;
 b=XP12DUiqxNvrXUiLyrJpdVuEOuONri9M/De1cGN671hkQ9B5bbiZE6FHVQfnCC2+auww2KNmW8BWMK/P1uQafuvCcSZKRrz2pRhMqwxqlITwsXrro+LYkxChzzesUJ5lyxv1mQnH9T1zhksofTYPcAzukVC4ul5Z0fe5xZO5nrOWqQLmx7opetDVGi5EcIeZXaEwCSfupQbkknDBadxHYeL8pza/8sn9YzZKRvP1ULeIna5EYbe3FOsy3neE/d6NkkSIoFOe5V62ZpZcPpLIx+Da4+KRS0QApD5+gBJRYAMKCw3av8t5ZY+HJUC1D8wqpneAOanLPSdWjKGVgyWxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZD3k86trrIUaXqiU0ap8g9W2u80SYjtDfICfr/HJ/A=;
 b=rouEIhWKdV0t9m4ITE5P2tB0RS10e4qNbNHoHBYBoPjKROmFGVrPn68w+uK4L6NKwJjAkEUnTkpcMa0tuC40VNTqh1AwYdZvKLgWffLT0PCUWMNSjGvW7+D6K/siAciaiGNAxGwkzefgEsdmdACvY+O8XgzpHmffdEDzr4lGt1U=
Received: from SN2PR01CA0067.prod.exchangelabs.com (2603:10b6:800::35) by
 BN6PR02MB2625.namprd02.prod.outlook.com (2603:10b6:404:57::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35; Fri, 2 Oct 2020 06:30:14 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::1a) by SN2PR01CA0067.outlook.office365.com
 (2603:10b6:800::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Fri, 2 Oct 2020 06:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Fri, 2 Oct 2020 06:30:13
 +0000
Received: from [149.199.38.66] (port=33447 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kOEZd-00053t-2c; Thu, 01 Oct 2020 23:29:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kOEa5-00050h-Ci; Thu, 01 Oct 2020 23:30:13 -0700
Received: from [172.30.17.110]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kOEa1-0004mR-CN; Thu, 01 Oct 2020 23:30:09 -0700
Subject: Re: [PATCH] arm64: dts: zynqmp: Fix pcie ranges description
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <f59a63d8cb941592de6d2dee8afa6f120b2e40c8.1601379794.git.michal.simek@xilinx.com>
 <20201002020249.GU3722@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <100535b9-d643-f91c-af46-fb8114d7d6ed@xilinx.com>
Date:   Fri, 2 Oct 2020 08:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002020249.GU3722@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2420b05d-db0f-46c4-6299-08d8669c9ebb
X-MS-TrafficTypeDiagnostic: BN6PR02MB2625:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR02MB26251BBEF880A26822CE673BC6310@BN6PR02MB2625.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRASEek8uIZMbcKgSPcSWBTu5NVUTakcv37rPQ7v3IoJ9sxILuEfzitMZauDmRv3ZlN26ubpo54dAp4CEHWvcLcCgcBG+Ft/lbGKI4267oRYOvsq7RLcCF1fNilUgCLGFmFhsRdIKSGBqwihsKMPJ3npm9oKt5Sbsa+AanBLO5cM7aVJVsHv04lebBPiipLjhA3njrw3OzmCeIy8XeJzJbeMHmdUYffLRTzGyvvj/z0rF+u0QkQLmb3TI+H5mHgViBpzcv8+QpaxW6iQm1VUn97kV3YkdsBDp/m8FtpqWshQsQXjAZ7PShPEcl+t4yIRQguyKJBQN+1GeThpQBT5fPdzvLU5cpOxhfzLHKHuv+UCIajQzGLJH3EBas+26aEhfDUSrS9irNiq4t+wItNfJb0v8FaJHA9ZStBNctIrMUSIpS8rwzeK75sd7wsFwqWR
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(46966005)(47076004)(70206006)(336012)(36756003)(2616005)(9786002)(70586007)(8676002)(426003)(5660300002)(478600001)(8936002)(4326008)(82310400003)(81166007)(54906003)(356005)(83380400001)(186003)(44832011)(2906002)(6666004)(110136005)(82740400003)(26005)(316002)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 06:30:13.6827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2420b05d-db0f-46c4-6299-08d8669c9ebb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2625
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 02. 10. 20 4:02, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, Sep 29, 2020 at 01:43:22PM +0200, Michal Simek wrote:
>> DT schema is checking tuples which should be properly separated. The patch
>> is doing this separation to avoid the following warning:
>> ..yaml: axi: pcie@fd0e0000:ranges: [[33554432, 0, 3758096384, 0,
>> 3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0]] is not valid under
>> any of the given schemas (Possible causes of the failure):
>> ...dt.yaml: axi: pcie@fd0e0000:ranges: True was expected
>> ...dt.yaml: axi: pcie@fd0e0000:ranges:0: [33554432, 0, 3758096384, 0,
>> 3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0] is too long
> 
> I would keep the error message unwrapped as it's a bit confusing to
> read, even if it exceeds the normal 72 columns limit of commit messaged.

From git log I see that both ways are used.

> 
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks,
Michal
