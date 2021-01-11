Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0BF2F0FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbhAKKVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:21:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45247 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbhAKKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610360462; x=1641896462;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DkO2OCPTtjn/5QkRXeF4F0SW49YkEvvYSjsZSE8LFHs=;
  b=QZ0BexHpJxHXoxXjz3EgseUMeQRE3nofqctw5QyfmQ0MQcje7MhsIP9O
   DnP7VOxZiTKpA3jpf1zi1Rq/N0RHL+nTI1Y+G5e5T9H0dUV1whyZd688M
   ks+ygGLG1Hin8TbSczzJkf4TJE7/YFSE0viIe5vVKTC+iQJ6KwWYNHLUX
   zY0Z/cSqzglV5r4qjO9m7/y9kXnHsBye+aWRxnhvT6FFHSYfShL9tLHoS
   CTDZxaCYfBFczliZdWJNmZdAjZ19/d1AOox16R9xOF02Hgkw2zPH4Y9XR
   nIu40CvTXY74texVOqV/mXS6I1bgAjCzQFjeEvYyLXRQ8vQMi7xAu4rzv
   A==;
IronPort-SDR: 2dfxs7fGr4vAEEc+3MJE8tfegOJNSd6hPeHh7hWacIx39thLtrHYcxUZqRZNLtfTuogMQI1MKL
 5/UmyIW2ORJS2ZsiUc9nPXyjCkntLLYgM7S8RvaSPZWtpHlnBSqvyQWL+PdYCQJ+GNwITIwCg5
 zO0CAf4iKzm9A60gSZ2l7pTjd2ObTIkH+QtV1Z+SawSoCJK9PkGVbZIC2MHlAEVcNQP3dw8Fhu
 FAsXGL+yDZ7QMOIYS/Si6VAtCWrYhgoa3ZQPslwHWeYoXW329UgYhHrrVZJZ8+qVUR/LewYYpL
 XdM=
X-IronPort-AV: E=Sophos;i="5.79,338,1602518400"; 
   d="scan'208";a="157141635"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2021 18:19:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyIjA6dliQVSxqTsbraRxmqxajmKIZzl+GtCgSzkrXRaQW/msQRQkNH77akbsoW3RWfdoIa181PMmPTaBYb8Gh1Tian990nidV9B6A9svlCXAtzwWJixCMcartWlo1nxXeSOKuPOXfKYSdg43OOZltwSnXmgbaZr9YCA2xoYCpzUAw1s8+yNhIa8jEf5bBino32Ox1VQo2eEyHLKBXLOxGEyyNWZrcbGVfQV4WYuThYwRk530eTDqUxjs5+JtiMUY8MRr111pzXc55ZLv8zA/PFoI6KInUWMBxBBerMPzQIfZOEbR9Rnls00AYTfIeEQl4FNzbVaae6PzoILSg7V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkO2OCPTtjn/5QkRXeF4F0SW49YkEvvYSjsZSE8LFHs=;
 b=l1ntUhccUxxUeMbrk7oe7+epxavWvxW6ygcQOrYsGavJHNHZ6DYBeNJJe8xAHAn1MaNCYZirE38/3QVWucrB1Zz7tSHLhwfeZQcFgmK7q13B6kos7GQoRYYuu9WeRYbXE+RjGBl55Hl20IJzHr1X5GPF46aqp0vxet8eRaIu7Lt3lNDltgcnYhYN8hGXOvNXHSLqcAvJr0wNyT+zqQ4u0wxXwkRGeaE/dTvGVlOMqkwCaM+gDT7SSTMb4UvQ5tJBEQ2quSk3xf+a1s6/nvDcEdCp+1Bki1pvAFFApKXf2MyQqXbjezEC6YJq3Ad66dGN9UB/ZAbCkd++re3Yc9qO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkO2OCPTtjn/5QkRXeF4F0SW49YkEvvYSjsZSE8LFHs=;
 b=zrbfr25JND8t21BvTC6aAV8DFKFV8G+AXYr/jLRXes9kgdiAOVtadr5nDH2k2rjyQ6bFmx3vaDP7CXJst7Z03nF0K8lQ03UnSVCLB1B1rWTnJN/ptT6ZONGL822+458KrLcZxPqUV9BvS6TL4fN9rYi4C1yWF2Rcnw60Ef8i4LY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4928.namprd04.prod.outlook.com
 (2603:10b6:805:9d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 10:19:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 10:19:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Duerr <Hannes.Duerr@duagon.com>
Subject: Re: [PATCH] Documentation: document dma device use for mcb
Thread-Topic: [PATCH] Documentation: document dma device use for mcb
Thread-Index: AQHW1VNtJdHAqbA+GUiBSPaNCFHmVg==
Date:   Mon, 11 Jan 2021 10:19:55 +0000
Message-ID: <SN4PR0401MB35985663FE8EFD62AD7B42B69BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <3bdc8f76b30c2b0e2a2bfab06c2e73797ddc9384.1608305690.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:61e7:c51d:aa77:1fcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9ce9ce0-7902-4645-88a2-08d8b61a7136
x-ms-traffictypediagnostic: SN6PR04MB4928:
x-microsoft-antispam-prvs: <SN6PR04MB4928FEFB6F5B27D8C5BABE439BAB0@SN6PR04MB4928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4KntiQBydtUN9amg6dkZKOXRa45CkVeKwCJST6ZbzVl5ESkxOP0pLkmpYkDAg0JWbk4HjXPFCvwqRgFqv+Srln8Lo9DSUl7+VdlqKQg4v5P+Kevam1e9ymSS4DaKzU6BtWOZXZQO6k3JXIfSmYY5z+0ZjSf+5clYh1E1OFz2ThEGE2d2IGg6bS3kKf7L/RSoZ5gWPtmML9TMVyH0829IjOwDT2TXpD8YRTKPvWhML/02CCeK96MzzTg9yEaiwIXCc+Efxa8v/o4gsqbth6hYFlGFvgsEpk4IJFn8n+SXxJpU9xfMj22PxsCCWmpEgVhkoA93xPRqzSFSotOxoU8J5t/Zo0i/5TfJmpKZEOlZYsiJHlenUy+Ie4WDeYCRYk9vbWF5r3KZhlVpoZEj/rYDEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(6916009)(55016002)(9686003)(54906003)(316002)(66946007)(71200400001)(66446008)(5660300002)(8676002)(76116006)(91956017)(4326008)(52536014)(478600001)(6506007)(64756008)(8936002)(66476007)(186003)(2906002)(53546011)(66556008)(7696005)(86362001)(33656002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HmE4Wy6svSFlSXatglpnGbjH/iajeU/rX0ix9zI4XI8ujPCX01dkh6wWnLo9?=
 =?us-ascii?Q?EXlYlw52Z2Jlb8Q3mYq8+nHYwlnNA/linFJQptIUwXo9QTqkjN/kTM0cli8G?=
 =?us-ascii?Q?o6pG9WzR+Ot3Et3PHscn6r+7b4kDacE8mlAy8UtpP9/hJpcWHp9A5cUuCo9b?=
 =?us-ascii?Q?v61zB1o3OSD2aiwMSExiE+aI8/VZevdvncPyyM4RtglCnVF61SGtOWG25HLE?=
 =?us-ascii?Q?QhL+6fau8lpSScuDkV26Im3F3GDw+uB2xR8o5NM6j89fP0D8qrWUDCMLHBEb?=
 =?us-ascii?Q?r7VvX7nFKqBrPLohQ/rTB5/eLMe4xevxhM329pdnpI/cqgz/F1kiAAclJ3ML?=
 =?us-ascii?Q?WSBEcjBsPxV0DcAFmu59mWn5CjiK5i+T0YilN8c0xwCKiNKHyGMPMaeFa5OL?=
 =?us-ascii?Q?j8c+w9V9kbB3cz6bGISbXML9S08Dddlyox691aGxJMYRi4YLNp0BlZ4x2lf4?=
 =?us-ascii?Q?nQ4jQ99FRzahRtCO+QUPhtCliLac47CEP15G9RUqR9Xx1phGlzM1xFtizOwL?=
 =?us-ascii?Q?OwyF3Mikw7nogOAkpPPzIs18PnUBKr/VINViOz6sFYm0N0IdKLCow9pThyRl?=
 =?us-ascii?Q?hCf8lABWOhZgum9hWTXaSVcKQptyAxcBE2qQ0yBml38APn1DI5YeCVNZGEno?=
 =?us-ascii?Q?uBdEOOqnV1FEqDiVOyHMF6OiRXWKAMkRF9SpKakJY09Mwk8PGQ0JZsPNkY+p?=
 =?us-ascii?Q?mW9E2VaGYa4wlgMTm1kwHMfyW0J/wabe8a6mswhTJlblNeG+HJ5lYd535oI4?=
 =?us-ascii?Q?FIr1RMOcA/u9Noj55De2E5eQ4QaneBGaNJhHD+DqgvbQOTBw43jU9d8oj/zw?=
 =?us-ascii?Q?VM3RWbuWVOWZB5jG777JGWeIBAvPgl3kYwZL0RV1ShV6D8WUHFJmoaqaVMiB?=
 =?us-ascii?Q?3Ed6BwgVyzlBNT6i4N9NejZrTXi//zVOHKx4+jxYalVdS5Ur2gmt0yNZBtTR?=
 =?us-ascii?Q?/ZBgHWksPaxhm+bRNeDDLfJqcCUjir+Hy1NpGHWKvjR1EDXLAAfR01i1ejlT?=
 =?us-ascii?Q?Y+YAva/YYS2oqsm/GmN3TS+1pzEJBB7563kyCrw7bpDbuoQZaPUy+9hZ0Xrq?=
 =?us-ascii?Q?/BpcIaV1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ce9ce0-7902-4645-88a2-08d8b61a7136
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 10:19:55.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJM9IW645+PbiTaAx6OJttD6jAGQW4HUveGxebWwS7VFf6D4z4lcqIhUl6sLSf7oiJSpDPiAhMtuKcuKM2VQANHYkbtT42XcTVKxN2PWgMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4928
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2020 16:35, Johannes Thumshirn wrote:=0A=
> Hannes reported a problem with setting up dma transfers on a mcb device.=
=0A=
> The problem boiled down to the use of a wrong 'device' for the dma=0A=
> functions.=0A=
> =0A=
> Document how to setup dma transfers for a IP core on a mcb carrier.=0A=
=0A=
Ping?=0A=
