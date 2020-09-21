Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6392736F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 01:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgIUX4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 19:56:48 -0400
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com ([40.107.21.101]:12897
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgIUX4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:56:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDEX8XzilvLFHu98E5xAjznJoCwTCaM4E8XC9+Pc06uH8alblUi+BiHGenf4vrrj02w+e/lzhtsFmg9cumW7M6K7GB+ABDgV4DfylnwgncFLNvVl5XZ4lZUfzJSagtIVhkYpds64t2W7pW7u7a5LLqFneN5TGOSl92VrreihPuoAIYSr6GclO/PgUZ2WkB4YWZmEcGuOsb8Tebf7woynYayOp0slPA/znYdtTyRR4w4+QuwLlTIRsWAFyXqxEIPGWaME2gBGrroipAubNcQ4MCf/k+ZCTclRBAOYqG0N0EUPvrl98RuLRNuh5vXFon0YzFauUMuLs/bhoCbB0dFSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhQ/fZD7K5ZgTaNPde5CnW6yqKwBJ1uvQDOV9O+2GUw=;
 b=DM0spwW+0G3Nt/unYf2dPNBlYalBzq7nGC6YwO3GD+OZE4htDvgd03kN3IKRMbZV9XjJ1kaFxzGQfeqPkpKIe9mBhG/UxTCp/Y4slHQfxBYl5PfjGYm82SawLXn1EmIhML9OVfvJvLxHtF62es8tg5TTw/7psTQ12drdYSRLJvAra8eFLXyHXwrnGmNocFSiTpNamVak2Vz70p/MR/4yPa14bSo5BBK2+xvZKdKVH+0GLJ8K3EQRp1j4xH7GLMIltHF6d+bOKB0rVrkt5wK554+8qx7jy0wOddLxfqhA9pHsYpGjCKcy6QI+V+8/X6o+KRhH+RmdmaiiMI35xNb7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhQ/fZD7K5ZgTaNPde5CnW6yqKwBJ1uvQDOV9O+2GUw=;
 b=inzI/ySXTPJSgo3th651jcp2zNtcmoRbFFad+I5Pypd0cos1kaescBj1aWTORVWTT69oG6mr6al/9/U1F0/X/ppv4yo6CzcaZBmIuagQ6zCJij4ceK3wAoa6LtJbh42DWcjSJF0lkpGlBpEzioYAKmp2ObYvq5P3W/ybhyXDRhY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0299.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:55::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 23:56:44 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 23:56:44 +0000
Date:   Tue, 22 Sep 2020 02:56:41 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] nvmem: add ONIE NVMEM cells provider
Message-ID: <20200921235641.GI31031@plvision.eu>
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915124116.7196-1-vadym.kochan@plvision.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6P192CA0101.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::42) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6P192CA0101.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 23:56:43 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1afb8514-6e5a-4e5a-143b-08d85e89fe1a
X-MS-TrafficTypeDiagnostic: HE1P190MB0299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB029903373F68A326C779C2AE953A0@HE1P190MB0299.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUBOIG0AZx4vsBBLGi1rvYwhHHQ1T5syf77fVRA8L47s6LCbyJyGOG5I+v4I/qU0FpSe80GF1s80zg0ciMPkOT0DcHquu0OJ65dIfRNw8WN/kO0zDQttysWQrLBxZWQT6TghTPX+aXrVTIZ6jqBdd+UsSU0uzc3Th8rY8SVJafm9Z00UiisSipknNv3STYLEUGufPLbcpiSjYuiDUSOwvQPtTeePX2b1toBHIpqu/MikRzjvfTe35S1BxAlyK7NVimSsFjFc+6yZE/ioo1TMHySdWdqD/UxNHhP3xOfVdxGgyd+bvU73/4ByRKIIuC4Mc9Jg19vlEO3iEvvetxAquA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(376002)(346002)(136003)(8936002)(8886007)(2616005)(110136005)(316002)(8676002)(44832011)(956004)(7696005)(52116002)(55016002)(478600001)(66476007)(66556008)(36756003)(2906002)(1076003)(5660300002)(33656002)(16526019)(186003)(66946007)(86362001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nSOPST6vgGBAumzlZyIZKZrSQTrmseLS4jUs6323Y6XsH7hHLl2oAeW1FvU9ShyHT8Rch1+ylym0itJXOJYXEs9N+Q3vjZvYtEAIiSptjNfGpCGx+ALQdySnNgRZyF5CeviOSFP97TcTdnBxKP8Pz/ABT5onRrl6HdE5UN6NzloSM5S0RORsEP1veggOdNp0AUIXCoGDYsB32JmxBnPDIxitM/cyRkW6cA92UvtJuDhHW4zyIarewl6Ci9MiKZ1JZR6Sve9dW/Z7gRAI4/grDigcgslkI0fm1Fk9J7+66VfMyDNS60l1fsikR71Xe6f1QvsUJSYxslttL+4EOMOYSSDS0ihgIGeasl26N1ji0Xzr06P4VkTNsvJgCATYUeIrDtgpUiL9nJf01csmQtg8tiGUTUTf55gRfEw/J04zIFl3uhgtUOez57mbp09gP5QXEtpBm0nbE7jIme1DSqtQKPS1+TNePxV4hPePSkEi1gyUcUZRzWJoO0kI3bWVvc+UyzSNNNGn4Pwqdi5TzktF2FdlmI/E0a/fpMb1462y4AFS7i+tygySmMopdjDYi5q38Yh/jHcP+/dMFjWNdNxUu008uPDBPUPKsyBY7WjeQsDU1uWttSDLUlLPnu+5eUhqtD35AqthuO4oYofog2rqGw==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afb8514-6e5a-4e5a-143b-08d85e89fe1a
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 23:56:44.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6f52gc1DXq6Z1/dZLoX2d3IEDnqbrlVmVV0mUztsBXVymb+DQsmcmYNzHRQrQ0DtZowkALfLha8a7EefKZ2BG244xqhtl0HzBUFgUWX8Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Tue, Sep 15, 2020 at 03:41:13PM +0300, Vadym Kochan wrote:
> This series adds cells parser for the ONIE TLV attributes which are
> stored on NVMEM device. It adds possibility to read the mac address (and
> other info) by other drivers.
> 
> Because ONIE stores info in TLV format it should be parsed first and
> then register the cells. Current NVMEM API allows to register cell
> table with known cell's offset which is not guaranteed in case of TLV.
> 
> To make it properly handled the NVMEM parser object is introduced. The
> parser needs to be registered before target NVMEM device is registered.
> During the registration of NVMEM device the parser is called to parse
> the device's cells and reister the cell table.
> 
> Vadym Kochan (3):
>   nvmem: core: introduce cells parser
>   nvmem: add ONIE nvmem cells parser
>   dt-bindings: nvmem: add description for ONIE cells parser
> 
>  .../bindings/nvmem/onie,nvmem-cells.txt       |  11 +
>  drivers/nvmem/Kconfig                         |   9 +
>  drivers/nvmem/Makefile                        |   3 +
>  drivers/nvmem/core.c                          |  80 ++++
>  drivers/nvmem/onie-cells.c                    | 370 ++++++++++++++++++
>  include/linux/nvmem-provider.h                |  30 ++
>  6 files changed, 503 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/onie,nvmem-cells.txt
>  create mode 100644 drivers/nvmem/onie-cells.c
> 
> -- 
> 2.17.1
> 

I sent a newer version than this one which actually registers nvmem provider
and does not require changes in the core.c

Thanks,
Vadym Kochan
