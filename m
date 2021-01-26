Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF27303DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392385AbhAZMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:53:08 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:60356
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392339AbhAZMwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:52:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ6p/x4FxOkH0KQ+cM3V+3Vu+2QXfPi3cqrQ9Tduq8C82DaObB3IPKzGCqKLIxc3wztFormN48VYpOMqXCiDj79AXDdITiyKLTT2Dt/pWtb0O19g0SAnjEzNCVFMlY9NZBCw25QL5Ua/IM62rH8B/jU4PIuAmqx14q+RBOZpBQAZ1O7qjrQlm7A3MVAUgGiVDBVF5Xrg1ZiylltDs9H8JITlecB9yuaQJye8oa72QRNuBDnNK6OW+24MLWbbDMphwzY6JNIaGS4OqwMf0dCJgwVpFb0cv8g28V1Aj7ftZpXd6Ukq3cUlHjeN5Kv1YrxBx1BEoIn+b3sXGnF1XzMO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmNKu4NpZqDDvtl41HW1oi4HWRLIx3E0dD/E/K7oe7o=;
 b=Ikf7BXM/hXxJ6LQPhEcrGtMmLj9HrwDOLS8TKbnUvud4vqAQcgpmW95JW78JiDOfiul2EGjPuWJJjUZD7xDdmkoWyvc3gMvd0bL9DYgAx1vk5oKzH00Mz+9G6JSP4vpXbNoNjK64HrsfhCK472BwESu0ReMdc81ppywu+fY/oAQnjBBJH9eSi48KRd6ZBtJjq4GeS5qMnyV9xpvSvVCLcCZcTUQ5HEflLOWocIyEf9yFDiShW8iKQ3+xGx2t2jVxEfHU63drj14l2byq+nKbpjCYgrDjdE0dOzmVLtWXzMPR6HQ8XDD3QhJ16Iq8N3GV9kNpPs9OkUW4drIJ2jumyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmNKu4NpZqDDvtl41HW1oi4HWRLIx3E0dD/E/K7oe7o=;
 b=LLMFlBFBGccwC0kMpT6MvguQSgXaKDDDVfRVItjqqFW/3Dmr1tNta28jxviKXpbVsPol7muOS/6xIvcrg9yPhYn7TRsDMH8AiC3WXpCYwOLt4SDQigZrjsdWhvgAIFov2UpWsT1/ut/DH+JU6s8XpHw+38f2otroH1kXlhhqbrQ=
Received: from BL0PR0102CA0042.prod.exchangelabs.com (2603:10b6:208:25::19) by
 DM6PR02MB5850.namprd02.prod.outlook.com (2603:10b6:5:17f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.16; Tue, 26 Jan 2021 12:52:01 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:25:cafe::cb) by BL0PR0102CA0042.outlook.office365.com
 (2603:10b6:208:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Tue, 26 Jan 2021 12:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 12:52:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 26 Jan 2021 04:52:00 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 26 Jan 2021 04:52:00 -0800
Envelope-to: rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org,
 sboyd@kernel.org,
 mturquette@baylibre.com,
 linux-kernel@vger.kernel.org,
 lee.jones@linaro.org
Received: from [172.30.17.109] (port=55072)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l4Np9-0005QF-UT; Tue, 26 Jan 2021 04:52:00 -0800
Subject: Re: [PATCH 21/21] clk: zynqmp: divider: Add missing description for
 'max_div'
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-22-lee.jones@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <bceb3499-4b74-5773-961d-84c66835e13a@xilinx.com>
Date:   Tue, 26 Jan 2021 13:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126124540.3320214-22-lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b245c55-ddf1-4993-2cde-08d8c1f92c7f
X-MS-TrafficTypeDiagnostic: DM6PR02MB5850:
X-Microsoft-Antispam-PRVS: <DM6PR02MB585049BF6E17BE400D4AAF03C6BC9@DM6PR02MB5850.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vU64l/dQ5c2M6vn5Fc+Oo7hX+Rz2CVUFEUDTq14Pp+OUN3bxKyDLLRu5X9VcHjXiQMza3Mem54urD3bvQZPD3jKzHh4MG6KmoaJo/SsPAaL2GY0RthsBJ58hrHW7mr8wX/9W0iZ45sa1bVbXgynah9Nb0Bi1937GeiEFr+ijQOpMYtDtCV+DwY01mqj/gehAJXj79DQjlWSneWgOVRer5mtGyzYhUPuj+2Nm0KLZOXuDvBKjruZr7VqZzwoPeUZcgwthELBs+RkCq6KKPcw2RakNHA5OxVKitpgXI1C5SZTfj4SGAm6wq6AsHxnsJ6G6rX6VbMUXTV39aokIdrCzK/f0zknoJXI+RQ1Av5yXn7qZpo654y/PNT4gVmY0zBv6wvfLUz0kRtX5y+s6jY2zE54pqWxHK+yum1pW5ihvEdPu1D69JwC4XHUMWQpaFTCy7es5+A6252fX9HTnFAMZ+pgoxRm0Pk8m4Uk+Dd67nA6q2xWI2fdUUfmZMy6QlDDsTLAvGwILo7LlxDaBu+g0isd8mP90pxonHQdr6eSo8c43ulidvBL1VOf0bqkBH8ED89+GSQNqja3uNNugMEnJisFJRfB330zLb6OSJjacZzCVrB8w+IExjn9LMrbfk1SDjVYoHiHpLSmNG6VctHry/Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(2906002)(8676002)(478600001)(7636003)(6916009)(36906005)(4326008)(5660300002)(53546011)(316002)(70206006)(356005)(186003)(9786002)(8936002)(70586007)(82310400003)(31696002)(26005)(36756003)(47076005)(31686004)(82740400003)(54906003)(44832011)(426003)(2616005)(83380400001)(336012)(6666004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 12:52:00.9065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b245c55-ddf1-4993-2cde-08d8c1f92c7f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5850
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/21 1:45 PM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/clk/zynqmp/divider.c:46: warning: Function parameter or member 'max_div' not described in 'zynqmp_clk_divider'
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Rajan Vaja <rajan.vaja@xilinx.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/zynqmp/divider.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index 66da02b83d393..e9bf7958b8218 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -35,6 +35,7 @@
>   * @is_frac:	The divider is a fractional divider
>   * @clk_id:	Id of clock
>   * @div_type:	divisor type (TYPE_DIV1 or TYPE_DIV2)
> + * @max_div:	maximum supported divisor (fetched from firmware)
>   */
>  struct zynqmp_clk_divider {
>  	struct clk_hw hw;
> 

In our soc tree we have
 * @max_div:    Maximum divisor value allowed

But your description should be also fine. Rajan please reply if I am
wrong. Otherwise:
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
