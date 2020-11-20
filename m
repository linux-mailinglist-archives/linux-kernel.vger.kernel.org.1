Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C102B9FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgKTBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:33:47 -0500
Received: from mail-eopbgr1410044.outbound.protection.outlook.com ([40.107.141.44]:2007
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727087AbgKTBdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:33:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTqMfkjz4OYdsSmtQia8XPkFOmgVKZ9tjZIFDk7OZBcyWMhlIzknPnvsPzgenDGqx6qfHYbMr//kyZ6oNUNZGRc4P6skg+ah6yxwxxxODPnFxzyAPyD7j14quylhzYK9uF1KAc5PSLl+5BRQF/+TqoZEtv0z8DCknuB0zhprYB1w7kIBJJfM6PwPG5w0WbdY2zQj2/Uxgoamvm/DiQFCfxdv8RKUShOW3iw2vNMJhyIspvxPEk9oRfqE/I1+Wa7MyWZoCJJt0deb6wwOWuQdBQLNHya51iORWN4zeSbi2vUPPkYHPs99Nq6h81cVzaL+0wZ1bypKGxd8OfkSR+S7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Craj+V3E4cjJ++YEE7z7FX4t4rmxXtDyxd68dK1HJQM=;
 b=iWlnYnAYtdQGjVe+hR3diMjqz8NPMXj5bFUdcS0/PfIJCVIoYvuw1+IRg/SMnA0wIZe6R4RWgdD4eY9joOpTf73hd3Jjob8m3dtYNysGoC3IMa6tizs48AlCKG6nZyFuDAx6N+ZOm3l/Tq+e0VUgNBOEK0be2UTLehbqAE+LWoBAaoMokGS2eJHMbYxco98jfg48gjT/ePnjSTPICL6WO7CcdxMBiTUYlZL8zXgCldlOQX5CEX1JgkLx1eECsoBxb2yXUITfJKi7MhUNm0ZoAI5+Egnm4nKJyN6OxnS5/5gXF23EHpHj+iOCW+KAzSJT04+yNIoc874m6EbBC3IaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Craj+V3E4cjJ++YEE7z7FX4t4rmxXtDyxd68dK1HJQM=;
 b=r8KG9kPIu63ms2BouOmOLAF/C119+nnRNXCtGHtOP8xZJAeB/YvlbZif4+Ti4oXMXfWQLigCWiBTfBtQDPNNtV5V7Q8jJAE5sLbFdAqU6WH1AIL+DwIyRp0pGV5wFOhc4xFrDUAPu1TB0cVi5yOkkbDlHpjczG0hIrgiscsLhGg=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 01:33:43 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 01:33:43 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] mm,hwpoison: Remove drain_all_pages from shake_page
Thread-Topic: [PATCH 7/7] mm,hwpoison: Remove drain_all_pages from shake_page
Thread-Index: AQHWvmLKDnQ5kbHS+Uyk0zuItW6jOKnQPZeA
Date:   Fri, 20 Nov 2020 01:33:43 +0000
Message-ID: <20201120013343.GD26144@hori.linux.bs1.fc.nec.co.jp>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-8-osalvador@suse.de>
In-Reply-To: <20201119105716.5962-8-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 259c36f4-656b-4502-c672-08d88cf45141
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB59366E720DC7894C5C0932CEE7FF0@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gb2cLGXQE4ClWO/2yBOiwgs1/9meBridsV0jiz4fFQGfsuf+sWkOy/o7plkZLUPo2JQnqscRii6pNxr5esRno2b9kLk52IEq2ezfi7jEeTmHAt2KsUsb4sBLWPkuKtJ2eujEsznGTztLvmOkQfHgUyBujY7uRuMp4a1omfPXYoBWQG3DcqYJvCYlbGiqcLLXv7UNKM6IQq6VBbpodmkNQ01frYgfe6UWZcYsaZMo9eiovdnGr8LimRmOVFvvRQAxTFVgRlm0eNYgFFxV2CpZyWfQkEFS6t21oRMOWqqAdYodW5eCpI4+OfSzMnnNuoBfzSd5Xds0qWrsgb4cPBsWiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(4326008)(86362001)(85182001)(8936002)(2906002)(33656002)(558084003)(9686003)(71200400001)(54906003)(316002)(8676002)(66476007)(5660300002)(6512007)(6486002)(76116006)(26005)(55236004)(6506007)(186003)(66556008)(66946007)(66446008)(6916009)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TkfZZ/SCEQEnIQUW/HC7LKjI2hIEwEqxWwqC9vkIzGwm5xWJQch77G3E5CHIzZ66L4I9WKZtgBUckcBtqnk10ac/RWNsR6Tk22bC0A4a/VzYdaaGtBdlAioz1ncpmgfZp4gqLIi1hSsp0Dr7sxJuUUaHhSPnAuVpmNh0Pt19nsAlMSCuLqPu/qif9sxAMQqBo3DjHqgT2ghVtzHBTspbvDwVspdPgEiHhiLUfoH+4/hbKI7GbXOxOaC8j2HI9w1qF+KeGEJ2p0reype10m/h9mYNL+F88ayJxF7et1v8PbmBrZeamMBdN8Bgj1L9T57600ATfNoxBB1yDMPPRqFN+cjGdxmmtgWdUpSLhSIYy++gaoFbyCTtJXhDXYyyei+xwsWraaUq4avdMn81g+3RyhbW1duJBwpzjJ1p+h+L7gapwklgRsQazgTCINdKU85sfU4ED6amkMi45grQJ328HojoC9C3v8FOxbSfJjxMszTrITMafs9l3YmRyhyYuVzjbOeyHEabckq10/0N2vsy4rertgER5Hzbr3bdwfBlz8d4ay3wN9xtcjZwJAOLRxH7RiMpoQdBuckG1hXdC1InxgxIWEJeR/gEvWIhQQsY52Y+/XGoi/Xqd9SMtWTRToLbyZymek428ex/ZQgbMX71qA==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6B8E2FD0ABED6A42B7708138F7F64B61@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259c36f4-656b-4502-c672-08d88cf45141
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 01:33:43.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C09hYAfncIv0FgN/8OspypAl8Sy5IRufeXu2lZO8n9iME5dvjdpGxmuuAK2ah5CM2J1O/EsmS1JBE0H6ARkFfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:57:16AM +0100, Oscar Salvador wrote:
> get_hwpoison_page already drains pcplists, previously disabling
> them when trying to grab a refcount.
> We do not need shake_page to take care of it anymore.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
