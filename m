Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F528012F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgJAOX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:23:59 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:6735
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732096AbgJAOX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN81EstMRSywW6IQ9hrADci0BQ8q68vwCrx9KDm04Nrhx/lL/pPom4mPC95lGuz037uuAaRUBg7R0ANNDLSM4LvDIhFQ4zfRvbfMvI38aNUvQfACqIB/FxDXGB/J9iXbRsPG3jgAknSh1Qof4/phL/k7F4nTAupK0vp5SuasybNYf6KaoewjOqHt9sEdcZo8CDGz/508CFT20gxhaF90faojZe2GwCrkv8uKQNIuMBJ3dC+1MEM6cnSA6Sc8T7R/U/w74aiMaoogK+Ga3uVwupLafxBeXkbrX1g7OdnA8EHRX8c4e1xMxh0XPqEfKZj6TWT7NEqEW+odA8PCBZbrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbrJSI60KKsjbjHdjiZ3+XzAM9lr23WVTk0NI5nwc50=;
 b=RyfnhmDEN/yr0nQm3H6XmSirV8hgkmyHs7RAeuWvojGGVX0SfndTcYPaW+gCqU+cIembDs5e4YKjVVo8PRAU+Uh3YmYo6T5+gXg4UqhULe0t4KMLnNTgZafDPpq9QF53nERr7HRkCx9uHJ73FMr0Lvmm7yTfDuj/RXhsTcm7swM8X+y/vv/4WejoAzkXArxGyD5JQh51PgeJCsofZIi2taiVMb1xgoc4G847qk3erSAUVPxpQ8u8/vZ2OVjdpW4oAy2ZzJ+cNZYGl+se3ydvo/2Wr3PlrXbhUPf5XGm2TYTLZDnM1z/X1Qs8qpSliU2sc2BRRpfPr6oLSTNslCNNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbrJSI60KKsjbjHdjiZ3+XzAM9lr23WVTk0NI5nwc50=;
 b=P5QO28cuDZ8Yc/pG9Dzn04Fo/KDQ79zitWl+WxwQP0BM6X8nWMl+MRhWNWbIMssfp1QZsL3FxErJnAYDL+Cd2yFGD/Oc+Y+WCq5u8/T0fXrMqwLI7KQlXTb2bQTOgnuMcG9qoJpXzmkL0nKyaRobgADPxSxKd8UOCpeCviyAOfI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3441.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 14:23:53 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:23:53 +0000
Subject: Re: [PATCH v3 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
 <20201001125722.GA6082@kozik-lap>
 <985c5eb3-3f8a-2b70-8831-b7b52671ee4f@kontron.de>
Message-ID: <6f2b294f-9f28-fe1b-bd1a-d32cbdb86e00@kontron.de>
Date:   Thu, 1 Oct 2020 16:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <985c5eb3-3f8a-2b70-8831-b7b52671ee4f@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM6PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::28) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (89.247.42.197) by AM6PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 14:23:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae8b4bd2-bafb-42fc-d270-08d866159fd4
X-MS-TrafficTypeDiagnostic: AM0PR10MB3441:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3441C1706447A8925BA08CEEE9300@AM0PR10MB3441.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHPzSV7EEDt+FyuITa0GeJE1Wr8iAHi9qU8WSHG/LmmPKRHPCp6bCD+/AqW6XifusjQVTwN0xxaw3TBbwsezC259T+y+S0BopT9ZiSYyXBviFtDOdPpqU4dirleDUBYxt6SFHOEl0EXWSAAV1XhD4uiaSqcjefZ5/L7+6iwqzf1FFD5dh5VFqXPAHbLM/fcyxu7Zvdt3d44CR3s4PG2Mz5CZx+FQNeIcCZtRTOT/X9sDy9/Ktgv5lxqDO9TL/ITIdNmRPEgD1NVskDnXzOoOf7HU0L8is3l0XqKPpQ4WPuETZ/aShGflIsrZHBW/ZgV0h9vtlTA+a47I+BtumGlWiB1OEt9n2pEOMtFmcg32tieiPAhwbodB+JaMxK2C9QA/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(396003)(136003)(39850400004)(346002)(366004)(376002)(16576012)(54906003)(2616005)(956004)(26005)(16526019)(186003)(7416002)(2906002)(83380400001)(31686004)(86362001)(6916009)(36756003)(6486002)(4326008)(478600001)(66946007)(66476007)(52116002)(66556008)(53546011)(31696002)(44832011)(8676002)(5660300002)(8936002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: o99n7febhSFMlh3ogXEqxeh/5Euyrbd488cZAcODzHm7e52h5BGOfRAVA9KgGAFx9jHxpO1Y/mf0clX6vtTiEvoyiIVJtqHrkkIRs0WBkkyD/myhpe7WMPtTeSJwaHhX/+d8Wk974V9EJL51r4PDqcswm0zElbj8//rvm3cMYW6/ka6791aaLRzoffe4YjcDARMCQdBlpY9vZaQ1EGboe6h6cabefuidQrHsaWT0sfdjjpIzto9kDM4Bdfg0SLHf640+oHt42mtEQNGIu1TWyGHbF7x3mtvvIAQIicTpn1RAzaeZZUrTas+qFfr+8fzujLf8X0IPcmHnJNxu+YiQZV+xqf4J+GHAm+ljL9Nnaih0EAzoC3vYOIMrbEdlbUIcyy2jzVeEMmVXVk7u74q+khiW5RxVNfNlC0Y/XcnJLmdtSRfSspxwK2i8H+enjhiK346quJsU0aCLwN0aINycXho8ANG8NShhWbMX3ZzEgTgqtR3sSaYCOZVDMeqWNguaqlpIel3mv/KPS7+hXMfhTlIQu/1HgTyymsW5Aftd6yWYXvOkUV8Kml5B3JGb9ipJ7gcKnR44yaGOOjcGR3/bP0RpJ8oMKAt/fzAPeo3kOh5o+vq0TcLC41u1biQseCI+2chiNtsFU3h0GwLO0ZUB/A==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8b4bd2-bafb-42fc-d270-08d866159fd4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:23:53.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I53VfmQlbAubjUWhYX5Hd0zQkgK1GpzkCXQxYjutOM+f2JAh3YMcqmTAahlJOQ1F0DB9h34S9Ui80XtJYZSGez33vE496cXkcSx9+En3UTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3441
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.20 15:30, Frieder Schrempf wrote:
> On 01.10.20 14:57, Krzysztof Kozlowski wrote:
>> On Thu, Oct 01, 2020 at 02:06:58PM +0200, Schrempf Frieder wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> Kontron Electronics GmbH offers small and powerful SoMs based on the
>>> i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
>>>
>>> The matching baseboards have the same form factor and similar interfaces
>>> as the other boards from the Kontron "Board-Line" family, including
>>> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
>>> RS485, CAN, LVDS or HDMI, RTC and much more.
>>>
>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>> ---
>>> Changes for v3:
>>> * Remove needless status properties
>>> * Remove needless regulator properties for reg_vdd_5v
>>> * Use proper PHY reset properties in PHY node
>>> * Use phy-connection-type instead of phy-mode
>>> * Adjust PMIC node name and label
>>> * Add over-current-active-low to usbotg1 node
>>> * Remove redundant bus-width property from usdhc2 node
>>> * Remove needless regulator-compatible from reg_vdd_snvs
>>> * Set minimum voltage to 85mV for reg_vdd_snvs
>>>
>>> Changes for v2:
>>> * Make the licensing less strict (GPL-2.0+ OR MIT)
>>> * Merge the SoM and baseboard DTs for N8010 and N8011 into one as
>>>    they only differ in DDR and eMMC size.
>>> * Change compatibles and model strings to "n810x" and "N8010X".
>>> * Only use a common memory node that will be updated by the
>>>    bootloader reflecting the detected DDR size.
>>> * Improve naming for 16MHz CAN fixed oscillator and set
>>>    "clock-output-names".
>>> * Consistently use "reg_" prefix for regulators.
>>> * Remove "userspi" node.
>>> * Slightly improve commit message.
>>> ---
>>>   .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 323 ++++++++++++++++++
>>>   .../freescale/imx8mm-kontron-n801x-som.dtsi   | 293 ++++++++++++++++
>>>   2 files changed, 616 insertions(+)
>>>   create mode 100644 
[...]
>>
>>> +
>>> +        regulators {
>>> +            reg_vdd_soc: BUCK1 {
>>> +                regulator-name = "BUCK1";
>>
>> All regulator names should be lowercase, as dtschema asks. Node names
>> can stay uppercase, although I guess it would be better to have them
>> lower as it is also naming convention for device tree.
> 
> Ok, I will change the regulator and node names to lowercase.

I just found out that the pca9450 driver actually uses the upper case 
node names for matching. So I will keep the upper case node names for 
now and only change the regulator names.

Afterwards we can fix the node names in the driver and in the DTs in a 
separate patch if required.

> 
>>
>>> +                regulator-min-microvolt = <800000>;
>>> +                regulator-max-microvolt = <900000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +                regulator-ramp-delay = <3125>;
>>> +            };
>>> +
>>> +            reg_vdd_arm: BUCK2 {
>>> +                regulator-name = "BUCK2";
>>> +                regulator-min-microvolt = <850000>;
>>> +                regulator-max-microvolt = <950000>;
>>> +                regulator-boot-on;
>>> +                regulator-ramp-delay = <3125>;
>>> +                nxp,dvs-run-voltage = <950000>;
>>> +                nxp,dvs-standby-voltage = <850000>;
>>> +            };
>>> +
>>> +            reg_vdd_dram: BUCK3 {
>>> +                regulator-name = "BUCK3";
>>> +                regulator-min-microvolt = <850000>;
>>> +                regulator-max-microvolt = <900000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_vdd_3v3: BUCK4 {
>>> +                regulator-name = "BUCK4";
>>> +                regulator-min-microvolt = <3300000>;
>>> +                regulator-max-microvolt = <3300000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_vdd_1v8: BUCK5 {
>>> +                regulator-name = "BUCK5";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_nvcc_dram: BUCK6 {
>>> +                regulator-name = "BUCK6";
>>> +                regulator-min-microvolt = <1100000>;
>>> +                regulator-max-microvolt = <1100000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_nvcc_snvs: LDO1 {
>>> +                regulator-name = "LDO1";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_vdd_snvs: LDO2 {
>>> +                regulator-name = "LDO2";
>>> +                regulator-min-microvolt = <850000>;
>>> +                regulator-max-microvolt = <900000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_vdda: LDO3 {
>>> +                regulator-name = "LDO3";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <1800000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_vdd_phy: LDO4 {
>>> +                regulator-name = "LDO4";
>>> +                regulator-min-microvolt = <900000>;
>>> +                regulator-max-microvolt = <900000>;
>>> +                regulator-boot-on;
>>> +                regulator-always-on;
>>> +            };
>>> +
>>> +            reg_nvcc_sd: LDO5 {
>>> +                regulator-name = "LDO5";
>>> +                regulator-min-microvolt = <1800000>;
>>> +                regulator-max-microvolt = <3300000>;
>>> +            };
>>> +        };
>>> +    };
>>> +};
>>> +
[...]
