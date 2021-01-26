Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10DC303DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392672AbhAZNCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:02:43 -0500
Received: from mail-eopbgr700072.outbound.protection.outlook.com ([40.107.70.72]:22625
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392631AbhAZNBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:01:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLBhICyTTjYgTxtHe1GkHzyaDJ0eqnWMYVw6j4awsGTEkStF9jQ406KmP9MBih7smZ5unXRT4ciD9vO7iBLZj9Nw7tGcSHRhAOVpT0FQ+4Vb9swSVCfsGxf7yRa1kOZdWhVA3n1+Y/hzf3haasyKU2QhQKmc+ixKUBO2Efqk5yu6Ka7b9msp3OJhTXHbo0/GGt+p4puZ8CT1nLBhYLAYMisiAOQLsfWwRf04vG9G52Bw8iFKoYSDFPXGgNLOzMbWQSMLzBuyOcs2A8cKKT07B/+JDsE3ytYA0XOPp8oMfCrTSVhuSii4VMBXvQzTX0Ghhs4zkf/C0/OaSf8UikMZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c2aPdXc5+EyvCEAA6JNwodBr1t3O7v7H4/cUqKoJ2k=;
 b=c9kvxcj6qWqP6DR1G60Cjng0gCtv1+f1syES13E8qGTQFfi59U7lhRfOAa1GbmaWGBiZMZljNFlHqq/vEos5dS1WrIH9SkDm3wYuP6hZ6sZWitks8QNKb1/DF1v1SQaOB1N6oieKQvsDRaVgSB1vjhwkwaxVrwGxcLTOpcAsrC8wtkzQWjpJoUNP+jzOzhrrmDBLJbI8Y2TZw0iXVPAEyn95rBoPx5ideBXZkIufurY8sQxi0CnmTPZJ9SXiiQO7F3Y2sQSddhA0Hxi6zYhTkQgRhioMFiPWlqkwn7LgmG42llX7TNQlMNsEUWnWqwIaH3r2XDV7FF6f173gCAlh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c2aPdXc5+EyvCEAA6JNwodBr1t3O7v7H4/cUqKoJ2k=;
 b=nd8E1+cb3dcCB7mCv2VylhIM6lqBq8QmrPNWRGdQbZdx3aFRbJsXAjDGIzvNHb0vsfLwCpRQIiXlH/l0EmNAbEET4kNn6qAENJSDbDuumyQMGuf3O/H+BD2c1V5dNhZw5hhWfDqc4sIPJX+Db69dyXLviul5yMjDMqRuBbCZnGI=
Received: from SN4PR0401CA0016.namprd04.prod.outlook.com
 (2603:10b6:803:21::26) by SN6PR02MB4029.namprd02.prod.outlook.com
 (2603:10b6:805:2c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 13:00:32 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::4a) by SN4PR0401CA0016.outlook.office365.com
 (2603:10b6:803:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Tue, 26 Jan 2021 13:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 13:00:32 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 26 Jan 2021 05:00:30 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 26 Jan 2021 05:00:30 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org,
 sboyd@kernel.org,
 mturquette@baylibre.com,
 linux-kernel@vger.kernel.org,
 lee.jones@linaro.org
Received: from [172.30.17.109] (port=55672)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l4Nvm-0004rw-N5; Tue, 26 Jan 2021 04:58:51 -0800
Subject: Re: [PATCH 01/21] clk: zynq: pll: Fix kernel-doc formatting in
 'clk_register_zynq_pll's header
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-2-lee.jones@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <8ef46e68-6ee1-1101-81f3-1436965b53d0@xilinx.com>
Date:   Tue, 26 Jan 2021 13:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126124540.3320214-2-lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a98bf146-78a0-4ea9-659c-08d8c1fa5d26
X-MS-TrafficTypeDiagnostic: SN6PR02MB4029:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4029FD64EBA36AF60C5A408FC6BC9@SN6PR02MB4029.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgDROOPn+zinqoCeYkb21HM49H3sJVssmDQifg3fthk7ZqjPwARvuCqatJnIkgmQMqBtzu8r8580zfQSU2wWYzxIJyziIH267Bk384IeD75/KFi5erbtM3xr+GkCkC5VPnUAzhxrbxwPPiDLn6YE2CZyFM5LmFfoSIuYScKNb8lDKz/9clfTtUk10CGIuJ2QFYakfx8cq7DV6VMje+JIKQQT/NEKuLSKIgTk/pnhjy6MnXOGcAYZiG4V3dpnHLFCGlP+nfus1w1wNU3Dvr7KuVOt9BOBsstIjVUZFXs5on+zSWpj/lNyND5RSOBM7h5h2OsHwsgtS/Zso0mMVmYgM8yj6vKDmxyZtFjDql76BOts/914IsMj9Igif+v4eK16UICC2imUmRSG++mzPD+DICTGImZGjoKqCDN2XYTuVz+GA1YnOjajjmoetR3cAitHq7CQlPmQLKOK2XA59FdtDwLcQLP7DGvshEaNPavi7fOAerqwGVeBR3lh22JR+y8vjvwYizspr7blQIsixNTavw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(54906003)(83380400001)(36906005)(316002)(26005)(31686004)(7636003)(66574015)(6916009)(82310400003)(31696002)(8936002)(478600001)(8676002)(6666004)(356005)(4326008)(9786002)(5660300002)(186003)(2616005)(336012)(426003)(2906002)(82740400003)(36756003)(44832011)(70206006)(53546011)(70586007)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 13:00:32.0907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98bf146-78a0-4ea9-659c-08d8c1fa5d26
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/21 1:45 PM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'name' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'parent' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'pll_ctrl' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'pll_status' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'lock_index' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'lock' not described in 'clk_register_zynq_pll'
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/zynq/pll.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
> index dcb2037a95964..54f4184de89af 100644
> --- a/drivers/clk/zynq/pll.c
> +++ b/drivers/clk/zynq/pll.c
> @@ -173,12 +173,12 @@ static const struct clk_ops zynq_pll_ops = {
>  
>  /**
>   * clk_register_zynq_pll() - Register PLL with the clock framework
> - * @name	PLL name
> - * @parent	Parent clock name
> - * @pll_ctrl	Pointer to PLL control register
> - * @pll_status	Pointer to PLL status register
> - * @lock_index	Bit index to this PLL's lock status bit in @pll_status
> - * @lock	Register lock
> + * @name:	PLL name
> + * @parent:	Parent clock name
> + * @pll_ctrl:	Pointer to PLL control register
> + * @pll_status:	Pointer to PLL status register
> + * @lock_index:	Bit index to this PLL's lock status bit in @pll_status
> + * @lock:	Register lock
>   * Returns handle to the registered clock.
>   */
>  struct clk *clk_register_zynq_pll(const char *name, const char *parent,
> 

When you are on this we should also fix that Returns which are also
reported by kernel-doc

When your patch is applied:

[linux](master)$ ./scripts/kernel-doc -v -man drivers/clk/zynq/pll.c >
/dev/null
drivers/clk/zynq/pll.c:15: warning: missing initial short description on
line:
 * struct zynq_pll
drivers/clk/zynq/pll.c:15: info: Scanning doc for struct
drivers/clk/zynq/pll.c:45: info: Scanning doc for zynq_pll_round_rate
drivers/clk/zynq/pll.c:53: warning: No description found for return
value of 'zynq_pll_round_rate'
drivers/clk/zynq/pll.c:66: info: Scanning doc for zynq_pll_recalc_rate
drivers/clk/zynq/pll.c:73: warning: No description found for return
value of 'zynq_pll_recalc_rate'
drivers/clk/zynq/pll.c:88: info: Scanning doc for zynq_pll_is_enabled
drivers/clk/zynq/pll.c:96: warning: No description found for return
value of 'zynq_pll_is_enabled'
drivers/clk/zynq/pll.c:111: info: Scanning doc for zynq_pll_enable
drivers/clk/zynq/pll.c:116: warning: No description found for return
value of 'zynq_pll_enable'
drivers/clk/zynq/pll.c:141: info: Scanning doc for zynq_pll_disable
drivers/clk/zynq/pll.c:175: info: Scanning doc for clk_register_zynq_pll
drivers/clk/zynq/pll.c:187: warning: No description found for return
value of 'clk_register_zynq_pll'
6 warnings

Can you please also fix it? It can be done in separate patch if this is
not reported by W=1.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal


