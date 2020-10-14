Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDECA28DFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgJNLMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:12:55 -0400
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:14387
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387430AbgJNLMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m69MXDP2ungBsBLAgTJiVVr8/he1GTFIIjMLtlqdmoJZxEn8NlFxJ+Hrk14ivv2HA3kFhtBRTB0SAvLBvyW+V0vJ0fO1mpzKnrDJnb1g5rFZ9Zedi59+hgi2KHlT3MIBv0cI/LhuP7dv6tebXofLrjM+88YXxVS0J9NSofRnIEM4beszAZw3a2EZe3adIGXj6UBMGwFKvDplma2N8rCe49XGyHOM4iqs1ChcmwyW+3Te3kIlfx63NawVSYmWPJNlflGNiUbqc7L+waEO+lS5AtFChfQIXmvVaDXB5+cEeISJ0Ciq3kf//2RfqRSVdiQiTfBusPWi1pg0lTzSsqqIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXfuCj/xEVQrpyam8EKiGCzWtYoMghqAIDXBNHoHefw=;
 b=BcI5AehPDRheUzh3P1MyEww3ta8kWwRptP+P1JxtWuor/LIATnPnHcBf6GmihQ6fK9do0dKbVEYMar3CFJdAVeSwvWY20yS/UE2XGiN38ezeDZG6qSzHghLu1iTa7ACHKo08GXsUHMkf69JuCYBObX2dsLNzT1H68mLuSSOUrBjJzd2PVwpQvdGuAo7EDP4/EuWxP+PH3xPVn6hYwvQVlBMR5bdJwi36J+SOF0fXr6EK3bXF5zoV927udfLq2mDCL7FPe3oGZBY1mysQPppmjh36pa+eqcgATFNR5OwCDd+YI1gtaY7EvuwOxEsOPJibCHhoiWw07KaV9zNKBzldBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXfuCj/xEVQrpyam8EKiGCzWtYoMghqAIDXBNHoHefw=;
 b=VWfrJhodGx/VUJLOXNlEQipWw2TvvvMiMVSXL2lQRhJI7wORZcoaqk1/wriaWP0o7ARwoAMMraya+6MtJmy16YthEpnxh8SKH1RB1VN/Pn9eXOdpkZ08H9E4bilaXb8hsop5q3kGsmv2mWwrNzQbg7jis7eZFyazhZycIbHwRcY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5589.namprd03.prod.outlook.com (2603:10b6:5:2cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 11:12:49 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 11:12:49 +0000
Date:   Wed, 14 Oct 2020 19:12:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: fw_devlink on will break all snps,dw-apb-gpio users
Message-ID: <20201014191235.7f71fcb4@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: PH0PR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:510:e::15) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.15) by PH0PR07CA0040.namprd07.prod.outlook.com (2603:10b6:510:e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 11:12:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb4a743-b937-4486-5ac8-08d87032159b
X-MS-TrafficTypeDiagnostic: DS7PR03MB5589:
X-Microsoft-Antispam-PRVS: <DS7PR03MB5589316CAA2E2AA7441EC5FEED050@DS7PR03MB5589.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qkER46E1WMz5UC6oc/n3fXMVftMwJUVOdqbX8LPg5DjF/HZrDXQuJ2j6vMalKhXq5rHvSqciXIn+gHh2DGBnkOY9KBWYlPQKv89ML5bybAIKmP+EkrEcumvrwzvOYS7+72IAAXp5Nk7+j4rABHAxyKz8WJtV7r1ur45GKEkf7PvUovPfeuEpPczRCPAXyqmjW5iksJhRtK5JXnJoDhTZunV3lsjFxWFCLnGnQvAuBtMVLDjy2Woch4k6KdnNSEZ1AmFtlKQhVBWYSleLqjTm+SmWZyOKY3ljGSMxeP+lwxQOFHENbEkJ6zOUwtzrHyoE1gREFHi+6yIsJHU3axmvY2eGAetidFOdolCg+T3TGLCwaWAxpjqH9ZzwPD7jHr0UV8QcdhDTKYv+AsP9WO19iIkvGUCFNRBQnqBPTX8rbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(52116002)(9686003)(316002)(66476007)(110136005)(478600001)(6666004)(16526019)(8676002)(6506007)(66946007)(8936002)(66556008)(26005)(86362001)(186003)(1076003)(55016002)(5660300002)(2906002)(956004)(4744005)(7696005)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AS6m7IF1w7CSZh8I5o5AkMVVqGoEinaqAjJ8ZkoAI9mMYnTlBu/rDubegnfZUAXwY75q4rMrWJus3/lOUFBu2yDqJ7lrtw4VXxQ4eYRAe89KujtrYQRkoTszhM1eTHw4jFiutHYr0Y7loD+f8iaLzaczLchgKfrSLAnwFWVxo7cs59xcbKRY3iuKc2sOcfguk1bhGuRs3ESKJR2/7mkPVplyVmpovRBkcw/AGQU7odPbAo8jFkpGfTwuJN/2/bfjcV0pZx1Wj8lnC/RtlkId08/oaQN26mx6Ktrsas4Hv2Jmk94+58kB5/cV6S0i3MMzCGhnbuL3brRFScv5XB5D0tD1AIl1QKo3skBgv6yKDwXa6dMWqk8PuQibenRQz2wfX+RGuuX1ALuSbBnmTQfcFknnzAVxn2UXnHV4dUMIvShhEicc0D9nDRk8wdsLEaDf+LJ1veAaAFbFgS6LKjAWrxOLYDzWqF9oDSl7LGcHC8MPaXkRdzfJm29b+dCo0CwZ4dmJPOz5l2MdDFHxWV6tNk+Wf/5INIlJ55d6fFZTiPzqPjhFFsDp1+TPnWSk+QQjEr1yQfcW3qztIGHvbtfflHSJyscEmkF43MUIn5aWWL1QEHhy2Qs3xMYwFY9cjzA8tDl1D6/PYImB1YgqPhXfuw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb4a743-b937-4486-5ac8-08d87032159b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 11:12:48.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azTxEFQhbGB+xvzFykgF+OnmEn3tSOcNzWbE88OH2ta+xUjmnyFumsM4hmes4mrgrNcATna/J87Q40T57BdH9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5589
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If set fw_devlink as on, any consumers of dw apb gpio won't probe.

The related dts looks like:

gpio0: gpio@2400 {
       compatible = "snps,dw-apb-gpio";
       #address-cells = <1>;
       #size-cells = <0>;

       porta: gpio-port@0 {
              compatible = "snps,dw-apb-gpio-port";
              gpio-controller;
              #gpio-cells = <2>;
              ngpios = <32>;
              reg = <0>;
       };
};

device_foo {
	status = "okay"
	...;
	reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
};

If I change the reset-gpio property to use another kind of gpio phandle,
e.g gpio expander, then device_foo can be probed successfully.

The gpio expander dt node looks like:

	expander3: gpio@44 {
                compatible = "fcs,fxl6408";
                pinctrl-names = "default";
                pinctrl-0 = <&expander3_pmux>;
                reg = <0x44>;
                gpio-controller;
                #gpio-cells = <2>;
                interrupt-parent = <&portb>;
                interrupts = <23 IRQ_TYPE_NONE>;
                interrupt-controller;
                #interrupt-cells = <2>;
        };

The common pattern looks like the devlink can't cope with suppliers from
child dt node.

Any suggestions?

Thanks in advance,
Jisheng
