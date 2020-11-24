Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6572C2997
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbgKXO2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:28:15 -0500
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:14432
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388848AbgKXO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:28:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpZX9WFjma5ILJMOplUkQrLOC4inbxqCwPf2/VhJCTpcb2Q/5ubKZ5K8opOHbFLtzht97Hp96cve9TSWWiVaj4aO8wga+JWQJbWgbpcCqy/TnfPeRlnTC8U7/BEdwiKmyOv+O3LK0nTwp2pKfCf5luZuq9dvXwozxjH4Yf9hYCJ+1Xn1KK5mjiXZ5LTLXxYJ75FlFNWu44AHc2zNfm9yrXmnitKRVOLAIcxp3BwzshDk2/SO92QWLEtuh7FB1mW2d4R/SYG2hQC/Q/X+lxsltHHLfRqhp75TrfIXvu1IXlPXuWUQ1NXwhuzD0PDaJ5yqAOdRZYIdSwlcM5cC4L663A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdvj8RYq0ocIGOAULsFLyldQo2gur5dJRYF5p+IfCNg=;
 b=JANtVmlsFdTw/XA+KUm7y0K0GC51i2VYSf7GR5oliVTatCWwY1dT0v+IxjuuGlhv5OfNmp7DAmvKv/3uBxZobquHl5RclmH0LHmD/SdlTJqdi4nTscLp1d0BXF5NXAAWJ4GmhB0AejK+se3rtA9HX4Niyzqph2z+GMtsBDUUOq+ikSjShvhLZFdLylmCpzSLY5CP7lwwAZz+t77z4iyoSAa5ydPI5buT1hjFccMztoKimdk98sXemN7alhhXkpaDCsfX/HrZmgxu0ZYoZmd9beu523ZCzL/itkjLoGQKWa6A5arZU1lQvaUVh0qBCcQr6BUeZiWP2Y0ScCvOFLRylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdvj8RYq0ocIGOAULsFLyldQo2gur5dJRYF5p+IfCNg=;
 b=VFVSPV6eJOsC0NdJOOg32hAaptCoQItLB90QStmx+j+ldvjAZ33v3kjE82le44Z4ZLnSn7O42N9X7dC/m9hhI6/isRE+S1pGijeiK5iEDawFi9Rx1qsboOjSUFKh+uiOGRkrruN9eJahwFqgo/WrC/46dR260giC3q5r5ohixgY=
Received: from SN4PR0401CA0012.namprd04.prod.outlook.com
 (2603:10b6:803:21::22) by SA0PR02MB7177.namprd02.prod.outlook.com
 (2603:10b6:806:ec::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 14:28:11 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::b4) by SN4PR0401CA0012.outlook.office365.com
 (2603:10b6:803:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Tue, 24 Nov 2020 14:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 14:28:10 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 24 Nov 2020 06:28:10 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 24 Nov 2020 06:28:10 -0800
Envelope-to: manish.narani@xilinx.com,
 tejas.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 wendy.liang@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org
Received: from [172.30.17.109] (port=59778)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1khZIf-0001mJ-Uq; Tue, 24 Nov 2020 06:28:10 -0800
Subject: Re: [PATCH v2] firmware: xlnx-zynqmp: fix compilation warning
To:     Wendy Liang <wendy.liang@xilinx.com>, <michal.simek@xilinx.com>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <tejas.patel@xilinx.com>, <manish.narani@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1606205898-12642-1-git-send-email-wendy.liang@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2be02353-6782-6552-98a5-743b3fec00e9@xilinx.com>
Date:   Tue, 24 Nov 2020 15:28:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606205898-12642-1-git-send-email-wendy.liang@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a83ac83-60fa-43ed-15f8-08d890852b91
X-MS-TrafficTypeDiagnostic: SA0PR02MB7177:
X-Microsoft-Antispam-PRVS: <SA0PR02MB7177882ECC2555FDAA11B8BAC6FB0@SA0PR02MB7177.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLx2YsqzJsm75DBBay4Xgu1q41BH46nosKiPJTa8igG/je6LCRoa44bGCD3WhSPCcIr1Niw3OydFTy099DhWFpkHMBtplivXHXuQwDCkCY7dI58G007l9uv0tEH9vc2phqm09B4Yn91uQI0Yl381L5dV9IRpX4brJ/VYTCMEnLtgAnPDb9O1exAlu8VgBvlAWjuB2zb1nClQO9uCGQELuTWjK6yHgSWa7NaVhwHJbh3r079wqpc6lyfSEcq/7K+2EtN333WTkuMH73NFN3eIMEGiepCUWSNNqqDzIGzNS3+kzaASf9b/PDnouMkz3Fz8zmx1xQwIv/US/ia/E6dO55gJJhOOhBvOth+NyRaNCqJrAmBiNoK3Dvcr6eFA+D09Q52gdLDqC4dTQ1hy4/g6EzuOO7UECDZvG3cnn+fjixh8zxboKbM0mgADJh1aLOAXkf+p3xrXml7XT740YIbuAw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966005)(110136005)(6666004)(36756003)(5660300002)(70586007)(70206006)(54906003)(47076004)(2906002)(82740400003)(336012)(356005)(186003)(8676002)(426003)(7636003)(4326008)(44832011)(36906005)(9786002)(2616005)(83380400001)(31686004)(6636002)(31696002)(8936002)(26005)(82310400003)(478600001)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 14:28:10.8104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a83ac83-60fa-43ed-15f8-08d890852b91
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24. 11. 20 9:18, Wendy Liang wrote:
> Fix compilation warning when ZYNQMP_FIRMWARE is not defined.
> 
> include/linux/firmware/xlnx-zynqmp.h: In function
> 'zynqmp_pm_get_eemi_ops':
>  include/linux/firmware/xlnx-zynqmp.h:363:9: error: implicit
>  declaration of function 'ERR_PTR'
>  [-Werror=implicit-function-declaration]
>      363 |  return ERR_PTR(-ENODEV);
> 
> include/linux/firmware/xlnx-zynqmp.h:363:18: note: each undeclared
> identifier is reported only once for each function it appears in
>    include/linux/firmware/xlnx-zynqmp.h: In function
> 'zynqmp_pm_get_api_version':
>    include/linux/firmware/xlnx-zynqmp.h:367:10: error: 'ENODEV'
> undeclared (first use in this function)
>      367 |  return -ENODEV;
>          |          ^~~~~~
> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> ---
> v2:
> * Always include linux/err.h
> ---
>  include/linux/firmware/xlnx-zynqmp.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 5968df8..f84244e 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -13,6 +13,8 @@
>  #ifndef __FIRMWARE_ZYNQMP_H__
>  #define __FIRMWARE_ZYNQMP_H__
>  
> +#include <linux/err.h>
> +
>  #define ZYNQMP_PM_VERSION_MAJOR	1
>  #define ZYNQMP_PM_VERSION_MINOR	0
>  
> 

Applied for next.

M
