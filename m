Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851552B9FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKTBdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:33:12 -0500
Received: from mail-eopbgr1410085.outbound.protection.outlook.com ([40.107.141.85]:23168
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgKTBdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:33:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHib0YQN1vL/GOdXwF9smnrg1038E2L07PcHWRfSHpLPP2uQV7+GzB3Oe+3wTGRRCWZkz8ILyNcRJ0fS7GVhtLtUsbcry+43ciP9Ce53pT+boXntGiAWUEWfYQZ0bQV7wLKbWqV9Jx17oIi9MCC7wPfaFMWYdFs+mdy6u23WcbBTIpPfy+qoyxtmnYqqydXMGm5nIn7Ns8YGmMxPpTlkh//EjvM/DtBuoXgTo50XxHPHa2y5IcgkpcKbETJUYCngiEW3XSytD2gytomnEl5KgH/1FTO9T5lCK3Fk6Rp213WNS+hjl3/F8j4R+UPCoSbPvpX0hfImGBuWwMM12MZKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI6Nqy/7JXCX3VUuKLV+s0kh8QDezBEt9nyR5oSsVsk=;
 b=iTCkpGJHR3IISJGUGr+YDajJT52sjFASuUukN+ydqzlmIai5Dj1tgvdQzWvH39Ork6FsrAIw+/LPitdGrNbxFgkKWfZHOEGwLpq+B6e/NcJTrppsxtozh32h10adDgkCmMuOwQCEdKote9gbJroSt8WoEHPJRhGOC2s43zfGPUkaFvUTuvMV0deJms53NzjvOj4aHZgosyggcjiKxWubAxt+so0jakjB1XdFvbSK0/QvWSjpPw2dYB9T3CkM2HBtMQyDGbZBZ8CeUdvVpywtyzoSjOjrQIYdsWzZErtnHTOYiKLSJSNrc3TwZczIfWBXKFdt8D6/LwtccsVLyn/tmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI6Nqy/7JXCX3VUuKLV+s0kh8QDezBEt9nyR5oSsVsk=;
 b=N9scqievk783hLmF+xEVtzvtcHMQ2AiE1tNrCTAlT3X+sRodgZ54QDiqwo70Q6fl7tR1z0J5F/jsGXjfsta7Qdttp8jSqQL5I1381AsDMzTJ8a5ZhdDWFY3VYLBCYooZYn12kDgV4Ze7wr7pkBWZtgFiut3lCzClRhHloPfO3eY=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 01:33:09 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 01:33:09 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm,hwpoison: Drop pfn parameter
Thread-Topic: [PATCH 2/7] mm,hwpoison: Drop pfn parameter
Thread-Index: AQHWvmLKcVXIMMvwYkmGpg0Ig9qt+KnQPW0A
Date:   Fri, 20 Nov 2020 01:33:09 +0000
Message-ID: <20201120013308.GB26144@hori.linux.bs1.fc.nec.co.jp>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-3-osalvador@suse.de>
In-Reply-To: <20201119105716.5962-3-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd9cc772-1a07-40dc-fc9c-08d88cf43cdb
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB5936CD359B1870280A75192DE7FF0@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:311;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L4p6UeBAdy3Qvo3G97L1ovmkOPASBkwswRUgndSuEUrLQkTORcv7z7AHncL/kDZEf4wdfhsHcq+Y4kWvCI6bIbIxUfFNILnPye4uEjHXGVLxjlJpSJK0uUSh2nFx+H1JgksWNO5sLt5bWgStgfbOhKVzLANRK7/z+E7Cgeu5vOFQ2T15Vanaffx0rFYO3530tVW3T6XPaF+SkKwXCK4KEDLkO3lwV2N3MbiSSPFlDCUis2sLtIUWI8LzgVX3z2IYevysfX0xHhY7ujf0QS1KVK77ZDuMf+DapXqTj3Cb3ysGhvKnjKZK+DHddx6s8OAkaJn87j9W2YZERyPngMPIMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(4326008)(86362001)(85182001)(8936002)(2906002)(33656002)(558084003)(9686003)(71200400001)(54906003)(316002)(8676002)(66476007)(5660300002)(6512007)(6486002)(76116006)(26005)(55236004)(6506007)(186003)(66556008)(66946007)(66446008)(6916009)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YNVOBCwPM+4tLDC48pDO4R0rYd0omy8ner5ahzdvLE/QLvMniniCsoJZ27yRU0n9shBLYm/CkodxhVrsW8LUnYl60D3UWMhDBm+tdsCZaF7viyDTb1cdnneVZhwZVp8JtdgCwNPpha37phJshPoZ+qS1jSPQ0mKuCbZ5PGBLneuj1lV8fE7L5VffPwyoTv0/Fv1ckvWNusTN1rxZzlg6P84davYLw/4YhNoee+dHZQzRF5EWf+kpyag8/uLPWcW8ZxoCv3YyFnEalD43HLIZBRj2TnRxGVzIEJuvQjJVpNsQYg9IiQ6cOmQUL4AqkICBMaIUTqD3rIJvTGC4paZyWkxbVhI78rYxUAJ15iM1zXb1QrMCoV/6M0yzowHvjWmKThxsxhR7TFrcLj6PlmXdTnmd3qstvqyxseuqX5tDeALmy3ijfuJVtpFQ24QBHRDavEDCeU/OoizgKCXoLbYpuM126PhBhsrMMgGC5H5NuH5fFEMR1332wHPXwXexsQlPFFQAqpXITj6NTVjgD4zmXOTG7WpFrW2tkjrCaWah4SaeGN8YLwqDVClLlDw1SGR9vG/7/6sFEHP9wV33rXJRnh4+c69+DugoI/o/COro4kMF0vJk/KYA/FW9+h7e45N7Y/bGIgVYnWUQojv7qpsZnA==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D414574263CCC44C877C87E390B05D9B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9cc772-1a07-40dc-fc9c-08d88cf43cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 01:33:09.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kBjdttco3CLJeRcv2hJT45rB+J+0MXeL3l7UsxxfJDwvCpH7H2fheTOOt7M8C/vsX0RcGu7EJAk2BwM60sHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:57:11AM +0100, Oscar Salvador wrote:
> pfn parameter is no longer needed, drop it.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
