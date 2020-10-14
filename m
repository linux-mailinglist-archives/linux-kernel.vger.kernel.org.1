Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D026728D745
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbgJNAFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:05:08 -0400
Received: from mail-eopbgr1410089.outbound.protection.outlook.com ([40.107.141.89]:19263
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389415AbgJNAFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:05:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acmLU1zpA3cH1Wx52mzIbq6zdOmC0VhzRjAzFIUxf3/159agKI+ByAahsx9vetHOvBkdPQPRGDjsW1rAD2oj/AL8pb+aLA9IAfDWkcBW8e039un+rvLj732LmO8gx0wJ4n7CbGbn6j8Pv64IG3FL7oqcyYtZ4J0zJvpw4fjPvurQj+JcOsf9itjG1q7nn4aaHl3JXDsWqvw3/+X7Jw2Om49AI6Z9kNV3WZqoLRbYkk5jA24RDIof1KpA4R3alJWSs/HWrK01xSohZe7+1XHhsS2lFCh/FJxv9i4TJVxl0Rboxbv687A5NqWEF4UI58XUNj02N4qhV0KJgF+r8UowJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcVWKo/ohbic701T4hd8JH7p86nVZLhCt01xiwDvT2g=;
 b=TaatObz2T10uz65vStds74BIF+dn3LRlxvKwfClZ6WhrWEhtCBcq18fGfvJ5PP6fdSWbNcYLpyZgdUnrykM/tMuOGjiDQH7bAFqSi0Gb29Q5IlFX8YfOfln1TZFvtzou+fisn55lo9uvzdDipEEc7YGdqOhjXwc0KLLmBfCb1Zd1WnJvlrG8rsLEVcjDOfd6Kaha+AioXCkwB0K6cQDb5cbrbJLX2xt9AeXTVvhxh0BVDD0OkuVPZom6NRoxhikXboyiTKDp3BEWNLMqhngc4jcDn6QPbWO44a4wdWm6dOvIyqbo48G6s9CqHRrQ6bghSXl2Q1TPkzDmvx3BQ62MRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcVWKo/ohbic701T4hd8JH7p86nVZLhCt01xiwDvT2g=;
 b=U3cDp2VvRzHwomAPVKX15K5NcgRSnFeE41ePGhnOvJ+EenSchIUK8bVxHIrKpKVTsg2beAOdnyuK8a6sno0EhKKTr4ISXJa4neoUdvHdBRnYaESGBpSd8cxpDh9w6oUHz2dXgWphlQe9AaDES3jwLTI0wRsZIRxskIHZLvKpj/s=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY1PR01MB1819.jpnprd01.prod.outlook.com (2603:1096:403:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 00:05:05 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 00:05:05 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] mm,hwpoison: take free pages off the buddy
 freelists for hugetlb
Thread-Topic: [PATCH v5 3/4] mm,hwpoison: take free pages off the buddy
 freelists for hugetlb
Thread-Index: AQHWoW9MC4T4fE14jkiQuxVBWFNHZqmWOHiA
Date:   Wed, 14 Oct 2020 00:05:05 +0000
Message-ID: <20201014000505.GA6087@hori.linux.bs1.fc.nec.co.jp>
References: <20201013144447.6706-1-osalvador@suse.de>
 <20201013144447.6706-4-osalvador@suse.de>
In-Reply-To: <20201013144447.6706-4-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20d404b5-1e51-4aba-2413-08d86fd4ce5b
x-ms-traffictypediagnostic: TY1PR01MB1819:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB18192072DA0DFB5B39E2E622E7050@TY1PR01MB1819.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0tnqVlobO0OUZ7xjSR37lf3RvuQS+td8XeC4r6P0k41bLs3cKhpxWZa51Tx2Mk35/X9ZYSx3Rf9wWdAvLqyx139TU7D04CVCng8bzIyy1YLUVAy7ffYLjxOpmoSfKIH6DqQ5uwgx2bpVlSk2be1sYUX1tYkup1AvEv0thZnajPYevKZtWNwuxvaUvGR5jzlXqQjj84BAZo/WIDoV0Kk+uM1TSapfRONQ2+DwOMtb6en6mW9Q4jezLLbeyf/68RcDQmC7Ox1Yx+fS22nZIK66YGlBmFzloYWFexPNJ0TPaRtnIw2FhDTo5U9tXdjy2ixIHNkGy57SfiHfsufdBWb3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(1076003)(9686003)(71200400001)(6506007)(33656002)(4744005)(4326008)(64756008)(66446008)(66946007)(5660300002)(2906002)(86362001)(6916009)(6486002)(54906003)(186003)(478600001)(26005)(85182001)(66476007)(55236004)(8936002)(8676002)(66556008)(316002)(76116006)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UDYwCJT38Jsp/F344YwucJlM83DAZAvt9DHot2kzGwoik4vroFhmolKBZZohluGxgE2GWqZ+e5QtrlrtUhtuzRPpN8FthOsofm0Yv/kiUaazYlJPi4PJG9jF9qL0njmO0GYMQhK1xsxLXGy8axbAQAnka+6JZTqGro6NxtWBVgPcDzBU9rKdg4AMvAVmcX8YwHkeuuM4RHXkJuRhsmWIZJBZDp/nUfwLfz1h1xnoYdRW+dwOGuaB39QKRWR6vICTiqWbo/eKFbDT07OssoOx9J5qCgzChe5sbEEGMg7uhSAClDREEy9aG9DgoiECDU40OgjKS09zrnE2ql7NLVhvYA49Cul03p2najByvFrh+dGpi4VMNAFfttK/cpfbBpc6yASG/zo5MORed8gSjGbw/DRwcA1xeFnxPls2E/yq7cW8qWGuvUtVwvZEDTwphQw3zKn0uihyunVbFtDKGIijS/3o+qg1g4hAXXZtKCAvecL213a/oFhWfhes4zVdlsEmUP5tA8kKZsSbkoEi7yrVLgxSUaDJvnSdr0F+HOYJ1olQMgHkk/pW/jWgXE2dUVH+6OmerbHv3puz5o4H+ddBlJbPHm0/9I79FjWdB16uq1UkKqdgold6rYLZ+GiB8I5SDJhgEo3ty83xW1uwmTo24A==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <00F851668830004EB05AE29128F7DAFB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d404b5-1e51-4aba-2413-08d86fd4ce5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 00:05:05.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQDcWrr+a/nU3EXeyhm7+9oacunjdIlqROMXVMaldfFCs+uRT3zMhvtNmBwpRlqdl8fg54Q2fOLtfs1FWTfeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:44:46PM +0200, Oscar Salvador wrote:
> Currently, free hugetlb get dissolved, but we also need to make sure
> to take the poisoned subpage off the buddy frelists, so no one stumbles
> upon it (see previous patch for more information).
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
