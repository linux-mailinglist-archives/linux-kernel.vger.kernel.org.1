Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8DE2A8F26
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgKFGES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:04:18 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50003 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604642657; x=1636178657;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=BibtOzRj5RKVl8UeBYbNgJ7/ZJ8vyQN6V1w7SQeokeE=;
  b=Mgbrn0LrJY9o8Oy5etsBt7THIBpmVYnScrQEVGkelWUc0BjVTo9xHQs4
   SjNIdLMZIFgcelv0XQk82KbciTfcvQuN1i6v4jc+FWQueB6Y+ztncU+ck
   uZY8562lg3uTYP2ic4PU1M8r4ukjmS8+RqBktG/lB0kTSXCVyJiYGmDQ7
   L3Kzci8g6u5bVFvTihheHf1cFSMeQYkDMfNrTUwy38WhgpWSy6fyTKISe
   wtWEceN09PzwYUd6Aw+A5vHtxQIh5lnTU2TtWCjq97Jgk2U+fwR20R+5E
   y1+jHnngvVgNAmmBTIVvRWnpUmek7gpv2c3YMZHWdnM/KXV/mH4n0SQ5W
   g==;
IronPort-SDR: eOwAIuwxe6IdcOb/y0UKd2tx9wMDMrM4xz4JLiTfbH7u0gAVAgPX5UHqJrOGLEAw7MtSrQO5N8
 8VCWjun03yifomi+bLaUPgj+cd767ren+GVZr60BUqJuAjD1olbLGsPaD6N0XhG0vwx6iGyoqi
 VBIxn+G5yMaU/pSxrhhkPo+KEzrO+Dmcwmty8sKc/zbmAOzF7dCUpkhYb8T7U7Z7GZtKn7EMF5
 Fa6bwe8rMrVxpbjs90LDbMw8aLmt3XCrAPTNRiP0siC6K0jr4Ix8G0WQ/dmYALGNd6lh2Y5tIx
 vnY=
X-IronPort-AV: E=Sophos;i="5.77,455,1596470400"; 
   d="scan'208";a="153205073"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 14:04:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I57M5V/XmFdp2qsNqJE+JRLNwRyB2mSBr8F07wrBLJjxZ1ffm/PgnkS3o0be9BQ6Rb8aLFjOgNY3rdAtaB75HUdiDmbY/wPt2BBi3XgO6ne5ZmiDAb3ff+fuwwrmk6die10bBAh7zt2n2CfWvgcvb5EQNvbe1Ve/WtxDiedkJ117+Kuq2K3KvW+IYXCjrvyCtugkdcW5/v88k7gac4L3fCt+pvuAKiT7hHKzOQ7fS5al6uK2OCu6ibKg3VOOKEzLFaCkpS1FlR3I1oKR4cSltFRg2Kv+02X6MuRrUzn6GFgvaD6YdV16F8L7wA2M62xCm1sVCcdkbqRJIOV0J91LUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BibtOzRj5RKVl8UeBYbNgJ7/ZJ8vyQN6V1w7SQeokeE=;
 b=kJAk/SLduui9gxl/380QUTcZJX3Jn1zd7avqIawZOdk44/KoWLI1AgJNHczVq3iZ8mDekjylKBVqypQMxJHEc6JdCtdubhBNcOBiblEypIeSL9svVeonr+tD0zkrl2kg3KrdzebDFUDRXPOdVzNFJ1NbUhjDjlrIxgnULUshm+jv8dtYgTot3rO3AiBL2AeyMR2OVgc9OETSlbJdhzTbEZNqJ/kJKv2MYNGMktfaYqvpAfA2kFrk9N3cbGHJagG0dNIR79MD/nfrGU0vXHk/jbu+J+jFYxD9upsHQsgOgAsCGkGul/iuX08E9yRcPhK/EPaoR5iDqNjd0Tcc1g+ufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BibtOzRj5RKVl8UeBYbNgJ7/ZJ8vyQN6V1w7SQeokeE=;
 b=nKgwdNFtOkvseQAKqnj4ey7T7QH9a5HEKBts5X2cyJixqr3rloaPGQzaG/gKpVJ96hwSr/sTaXPQNRW50YatSplUy9uW6lTB5lqdF1zprEL0ewzoVnARv4HyRoIJe1ceUeWxsCj34iphQK+SvM9EVjE2j0QjesLLKz9tmqFmUd4=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BY5PR04MB6963.namprd04.prod.outlook.com (2603:10b6:a03:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 06:04:15 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95%3]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 06:04:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: WARNING: can't access registers at asm_common_interrupt
Thread-Topic: WARNING: can't access registers at asm_common_interrupt
Thread-Index: AQHWtAKoC1N6UC8gbUaAN5Wk5A+R6A==
Date:   Fri, 6 Nov 2020 06:04:15 +0000
Message-ID: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cf427d4-f92c-47cc-34c9-08d88219caa1
x-ms-traffictypediagnostic: BY5PR04MB6963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6963D208EE807C92EF73B2CAEDED0@BY5PR04MB6963.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:110;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KkvcRA5pXOKp0pQjMfQSUyFhoxm8wOyXwsSygBc3w5eX5fz1PvhB+MlfNwfsUL4eJS/zz6Dz9gC1fTN7DNzl4fn3XcJwypAyoDnwGp3qMardD1ojEdCvqrvuWgVpIVgJA3QbE+aNRaECqwetDu5cl9u660NXj8MFzOelUmSl9TBR8ZApRgO9RwQnleceA7YFDkpHs+69TEzUHOhRsME/oDVAR3qYLUJsE4CafgOL+Yh8r+p6v77T8HgqkcWaLtkJYrIMcKIFq0tkLYfASpEi56Od0GNtD1iJKoS08Jlt62LsvmnRUn1/u8z9wU15ubZpjLcL6JQ7q2c/+wfP4TP5t4fI+p/CRyNXWjcoRmqijb2leg5uP4sQFDZaU3ET3qhUrfYzew4a8SWVA6FKikGo50Tkj4wltQhNhxVwYow3iOXac5noY+ZIKxjnCPXxMu4ecH/uWQa/pN42XTTx1G/Nxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(6506007)(9686003)(966005)(6512007)(4744005)(1076003)(186003)(86362001)(4326008)(76116006)(26005)(71200400001)(478600001)(44832011)(316002)(6916009)(6486002)(5660300002)(8936002)(2906002)(66946007)(8676002)(91956017)(66446008)(54906003)(66476007)(64756008)(83380400001)(66556008)(58493002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PWXweTEDHNanGTr27DKnoW1/N2aULbkcxN43xRK0TyykEWoHaT+2NSlCgWUAx1sXiX4PA3FwW2Zd63ZCXTCO1GafZq11nyCvl23Jqec0bs92HmiYjVOXs/Mi7pTKC1gFZNFI+Codg+K1YfLmNI8UL8OGtcbaTIhxHVWTwY1xjb6eC+ygB8hwmzi19e314RoTYRDPR8Y1TbKTwd4twzmYcGYtnmrbgIJmENI5hRb4vHOG4jB9Ls8I3mozXnNtPnRfWLI77fi+31dw1L9YtKDIgy1vYNM+sl99qStOjgWVU9StH2ILf7/bX0WishubKT62x76MfOCQrQFbEw26uUDuGGqB+3xi4eff8ZTM/FfHfNQ9LW6VuqBHz/bp/QTQ45PtIQ5zbb3nrlgIQbGflv1LkVPZiV7sVnFLLAifDqo+zWGlCX/61pPSjA+dYfBm9OZw4GHFITQpSmazXXPKmPqbKTBrpc6U8HiAXsZaYPzYsR10ci75vk4i3OVPg+aRA+lZ7um8cNbxnmtV017A1Beqj4rOvwhyM7u5Y7dAVE/e6FQYQEgNDYVNijz4e0XX6U/V4M+IGrLG/BoOrhBvlrAEjyFPK796783ZJC8tgD2PlOBvIstTkJwzbhoHkrCEbisK70C1+sE3w16qa4smC0rMoA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18FFA4171217B947A68D5837CF588F4D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf427d4-f92c-47cc-34c9-08d88219caa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 06:04:15.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NaFohHhkfV6T61g5YAJQgIfLAMRj30pAIi3kZsg8X9z4DtARiAXX+N7+e78KEJlbfgzWuicoMjOKJy5EbI14whbYfFmalT3aXoxF/e83ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I observe "WARNING: can't access registers at asm_common_interrupt+0x1e/0x4=
0"
in my kernel test system repeatedly, which is printed by unwind_next_frame(=
) in
"arch/x86/kernel/unwind_orc.c". Syzbot already reported that [1]. Similar
warning was reported and discussed [2], but I suppose the cause is not yet
clarified.

The warning was observed with v5.10-rc2 and older tags. I bisected and foun=
d
that the commit 044d0d6de9f5 ("lockdep: Only trace IRQ edges") in v5.9-rc3
triggered the warning. Reverting that from 5.10-rc2, the warning disappeare=
d.
May I ask comment by expertise on CC how this commit can relate to the warn=
ing?

The test condition to reproduce the warning is rather unique (blktests,
dm-linear and ZNS device emulation by QEMU). If any action is suggested for
further analysis, I'm willing to take it with my test system.

Wish this report helps.

[1] https://lkml.org/lkml/2020/9/6/231
[2] https://lkml.org/lkml/2020/9/8/1538

--=20
Best Regards,
Shin'ichiro Kawasaki=
