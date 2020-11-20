Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F82BA78E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgKTKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:38:06 -0500
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:12129
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725824AbgKTKiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:38:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLvfQGHAF0jn0Ur2oafNckmT6H3ilfbv0Eg1Roudj2FQMR5ct+aOi0nSYxSMS00Ol5ZxWpfp0hSN4P2aNdFuNMqmArh/oSr+VM5vzmGQZOW1S5e+ybKIeiEeKx20xyE5HIv+7kdtw/rRPWZkXhLrAqsVrxkbtM3MG2UbleBK4YOirmK2nYxniwNwGFfY/qH2MDgdJFIxn3FzBDhVcK/mwuceJz23Cdhsu1dVZompSA0mtjiaccBshy6DK0TiFPa/6pUTYWwZGbT47fh4P3vOkwKZqQBtn+hVahhESU34lYQBUcSfLGwDVp1Wb+UNnUk/XvuQV2vMo+/jROYV1bKLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HZ+Xmy0aG64QNyaQwc2lH520uMthFUQLvSfTL9KPdM=;
 b=PGBh45CsKNcx9fJ3agB8fyXQIPlZSz7jpiv3cNZQYI1sswkZhZWeVO5eB/zVFUOfyf3pXOCHxGwwOOXeszduop9E0mLwaFBC1lBlHoI92sSGEdCYfFLWGtZyzPyWoQjjD2i2WL+sbyHjhQAXAn/A0ikmDRjNS28Z/wf907SZ5mkWUSuOi0DaWIx7tUvXWn0r/ePbokAtdxPFdCq1LBn1wVd7u7NwehIzxtrCUXLpJ5yFj+ZHf2foky6n3pwGwe7zJ1b/zKN16KGpJA+eVF/rDwQBHYkMk0myY8VFZyLZderPs3gW+2bU7yoyrl6Q11WPwxk5+I50XA+/GSQMyUsXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HZ+Xmy0aG64QNyaQwc2lH520uMthFUQLvSfTL9KPdM=;
 b=L67Ev+/KlZfW0M/31CZOR26emC9owWErvBF/rHPYo45WTuJFoS1xqIItdYtkcaQn+z1cmBYUyI2e36zjY7ZgCRiO5Glw7diHoVQEhOvFksNzQyo7ihWsWZUXGKV0mNfeNuVAOs+Ovx078lBlufV9J/CafpxbyIuR3NrzAML8cUY=
Received: from SA9PR13CA0150.namprd13.prod.outlook.com (2603:10b6:806:27::35)
 by BYAPR02MB5365.namprd02.prod.outlook.com (2603:10b6:a03:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 20 Nov
 2020 10:38:01 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:27:cafe::80) by SA9PR13CA0150.outlook.office365.com
 (2603:10b6:806:27::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.13 via Frontend
 Transport; Fri, 20 Nov 2020 10:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 10:38:01 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 02:37:47 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 20 Nov 2020 02:37:47 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org,
 p.zabel@pengutronix.de,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org
Received: from [172.30.17.109] (port=43496)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kg3nW-0001A8-AV; Fri, 20 Nov 2020 02:37:46 -0800
Subject: Re: [PATCH v3 0/2] Add a separate DWC3 OF driver for Xilinx platforms
To:     Manish Narani <manish.narani@xilinx.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
References: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e491bc10-96ca-34a9-4e96-ff5701763584@xilinx.com>
Date:   Fri, 20 Nov 2020 11:37:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ed3098-b629-4714-8b50-08d88d405acd
X-MS-TrafficTypeDiagnostic: BYAPR02MB5365:
X-Microsoft-Antispam-PRVS: <BYAPR02MB53650645F64D2CD30EF4086AC6FF0@BYAPR02MB5365.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2CcN+JPRI7Fv/3ptSV81djWpduz/iwEFjioVLGHb3wugRmDgPpToqfU88Uj7JNOqs8ssKaoacLWzdBaTHzw2l1lIiJTCjGz+58C/vu4JMEQzH65cIA2ee3AND7JkRUpxCFJpZs/Tvul+AdCAthk8QNpwhnVrfsbm6W+kqBkomOK8yiCYQg8MUoB0/j+M85DTCZUeLjd+QqjUiqRmfyhCqw95WmlwMeA3BsWX5YM9UhB15qLvS1hzog0YqNsalSfZiRdzPyHWpXA/QwGigImL1J0ht8wdNkOO9gSFVldGOWLc2I4PLj06qwvU7RXkZzlaVg1SiengU/LJ/AbwKV3a8GFrN91xIxeoFfhgAshtsfwp2UjrSfsiWgPx0VeL3ZfAdHwEnBtxhClNImQsuYdfv80aCPAKSXsXsqbjGZstTQaIHA8IM2b5TYwD+MMYEq6NR/fnxxzhJg7cvDGfBsb7g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(2616005)(26005)(186003)(54906003)(47076004)(356005)(44832011)(316002)(336012)(426003)(83380400001)(2906002)(82740400003)(36906005)(8936002)(7636003)(110136005)(9786002)(31686004)(4326008)(478600001)(107886003)(5660300002)(36756003)(8676002)(82310400003)(70206006)(70586007)(31696002)(6666004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:38:01.2958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ed3098-b629-4714-8b50-08d88d405acd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 08. 10. 20 15:06, Manish Narani wrote:
> This patch series documents the Xilinx Versal DWC3 controller. This also
> adds a new Xilinx specific driver for adding new features in the future.
> 
> Changes in v2:
> 	- Addressed review comments from v1
> 	- merged normal and runtime suspend resume functions as they are
> 	  same
> 	- Improved description of some register operations to avoid
> 	  confusion
> 	- Updated commit log for patch 2/2 for better clarity.
> 
> Changes in v3:
> 	- Removed snps,enable-hibernation property from the devicetree
> 	  binding.
> 
> Manish Narani (2):
>   dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3
>     Controller
>   usb: dwc3: Add driver for Xilinx platforms
> 
>  .../devicetree/bindings/usb/dwc3-xilinx.txt   |  17 +-
>  drivers/usb/dwc3/Kconfig                      |   9 +
>  drivers/usb/dwc3/Makefile                     |   1 +
>  drivers/usb/dwc3/dwc3-of-simple.c             |   1 -
>  drivers/usb/dwc3/dwc3-xilinx.c                | 334 ++++++++++++++++++
>  5 files changed, 359 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c
> 

Can you please take a look at these patches?
I see that the first one has been reviewed by Rob already.

Thanks,
Michal
