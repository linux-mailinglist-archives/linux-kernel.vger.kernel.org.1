Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77152EA5A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhAEG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:59:24 -0500
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:35906
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbhAEG7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:59:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbDiJAk4DDLy59CGSVPBIoUXlJs91lgcAMGvwUegjm2PrIFaOSo12IC+pl7nUntSUypX2pNJKpvob6xxnRkodj86S1i/1Bai+XfBLYXIh4KOZFnwLF3J7XK0+nQJejSJoCKKOOnoxCwcQtWXZUYj7PXgTFoXMMMLLcQZuSKA7cZKf4lc5SglTt986TP8eeZMp7ZD6uA2RSa609hf+i0HoGc4IcWtKwLHsIYnLyqkjvEZrZCU30KfLmuQt4YuH9/uwT7bg6Xy8+InDpcksCOB0MNoghmWX0XB+6ihbdMT6WrTnMsNMUgFTo/I8t9FiqK0iVRboIGPZlL8gZHl0Dr1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2TJI7OSgImih2sVHh14PbJDdXLJ2yICpg/pwCSyho8=;
 b=mY3nJ9TxY53XfV9DE4Fj+9cwP6mkATQPG+Z+WQRqgplXp+YwoPemggbFRUbHENUjbNLd0se/S8GrHl9kWMTB4//6DA/i/oaSExcZ0xOUozw0h4AS0cDfzzxQ6vGaCzE2fM7d8TQ3IfPaD+eMUvUtuFEWB65ksUn4PzHE8QukdLmWvalCuYteyTH5i3HGaWECuwRHSjbhVNm3yh01We1aNxUn1VymQyy6rBJiDtRz5gQIvFLVYNQHU6vp2xqAhlKZk18RrJhTrsq6Q9wfvIFkKVropTitA5kyHOy3UNrqGxPBqfDOtLBAhYBQOQfDPl8y9yBWR3VZcq8RDlt+mklsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2TJI7OSgImih2sVHh14PbJDdXLJ2yICpg/pwCSyho8=;
 b=R/lbuOIzUuynQcwisCDPwC8kzJ8pSllyGVQ9jaNHQOWQPXfnmIpaTU4qp7y4pDFsEbTDJrNRIAYTtGkvSrQpexi1IBAtdg/eu0/lziv0dgh5y27rsrYz//tXNZpaNUnSBJKAfuK9pXbYH0GdSXXExCdkmu1RL5a1JCgZCyamkSQ=
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by BY5PR11MB4085.namprd11.prod.outlook.com (2603:10b6:a03:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 06:58:40 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 06:58:40 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: RE: [PATCH v2] drivers core: Free dma_range_map when driver probe
 failed
Thread-Topic: [PATCH v2] drivers core: Free dma_range_map when driver probe
 failed
Thread-Index: AQHW4yWKa6kEFv0rP0eEpZ2IZR1rOaoYifKAgAAQB7A=
Date:   Tue, 5 Jan 2021 06:58:40 +0000
Message-ID: <SJ0PR11MB5072A5F0781FD932A1B3C4BBF1D10@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20210105054148.13625-1-Meng.Li@windriver.com>
 <X/QAk+bJoCc7lf05@kroah.com>
In-Reply-To: <X/QAk+bJoCc7lf05@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e6d45d4-2f43-4940-45eb-08d8b1475585
x-ms-traffictypediagnostic: BY5PR11MB4085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4085DADBCC0EFC5A38CDB64CF1D10@BY5PR11MB4085.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q6Raee/SU4vOliQ2b3h+Ngmv3Oe+PP50iFyvmrbpPamVfDAD3801BOf483CjRsQWbPtdpdQ03nYkutZr3ysety+8ytFw7qt+SKTpIF2vw9hFRcQGeA4sifCb0PpJ1eqsDa/i+LVqkY78Ly6kjA+UB/8Zfw7F5WwQ7oz+o033I9ZZMyluVPVst3GYsQtVKeqpYEp2e/3Je9sXHtlqAtRk6UpYnSBpbOFGx60n2VG7pSrzhiO2BRgBwVD3Ml/mDnh4fhsv3w681KKuO0edCgjeyKvTF9mV/SKq3QKnrgHk8b3L/SFNGQ41QNGpuQEKyN9R427FfO6crXHfFTt5OeBtvi2u4k1Z6ya0C2hDVfKECDzfFpLnsRxro1c4avBZu5IqEYdM1ppb6+FCRS/3RNq3NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(4326008)(54906003)(478600001)(8936002)(66946007)(66476007)(66446008)(66556008)(64756008)(52536014)(55016002)(9686003)(76116006)(86362001)(107886003)(71200400001)(6506007)(2906002)(8676002)(53546011)(26005)(316002)(6916009)(4744005)(83380400001)(7696005)(186003)(33656002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4zihVh6k6fQyeXIHlr0hKEaSpiervNFVAf3Xi2Zdd1IjhvHzwl9qLBV3dJzo?=
 =?us-ascii?Q?jp/ZEaHkgMAVN9M/OFvEKUhkCKAn93A+hJFsdQ38do/2vuF0UF4Ezj/k51LP?=
 =?us-ascii?Q?idbUkukaSLXSnVSVGuf5WacLIkjmzTwSrhk9fdXNfY9lYA7AmzTB+hdQt4ie?=
 =?us-ascii?Q?qEyTaXj4uTK/CgiwuhIcsKbYOg4WdGCplY/zvA3O4Mzar/8X2ZeCVQlHo0Hx?=
 =?us-ascii?Q?sY1Wnf4PpPs94MJCAbUjSFo3B/accRtsu3oYA9MM5AuakXREm7IYTi9jA5J1?=
 =?us-ascii?Q?+AhOKF3eMvgXUoMffM8Z0OTajy6xYtsEFpMglb2KsigJcBMKump05NjPblOc?=
 =?us-ascii?Q?Ag+LsUMLgZnwISF1tRmk+kw6Ae3AjzQG7WsXRxeq4rj2r2gvqZTeVa9hqTXQ?=
 =?us-ascii?Q?Ejj8LaTVIPESFMKxtQ/OQle85+G+X48gFRicRsUNNC4fBeJ7c+9TQBQPdv/h?=
 =?us-ascii?Q?zHVwiX8LNjm0ZCXU//Jruq+0P2nWulwAdotx4bxfZGrFo9tKZfTEoSG4tNfB?=
 =?us-ascii?Q?OsSWjM6ufQ0+c6+p2ofulZqCShujTQKcM7ciiv6uH/mko+tRnRz/Bruly6cx?=
 =?us-ascii?Q?KgRcBDR2qYntHRjesVkDE7lm6znVrK4JRDSLGqc/tHOT8YvWNL8+Aojt+eoJ?=
 =?us-ascii?Q?n77N8JD91L7pcSq2Lv9m35WJDKwNtlmJhDpPvHV7t8c+TQntSzk+zuG8JYhv?=
 =?us-ascii?Q?D9mKDTLYIsryqJigqTzFvM4sXm7OfXnfy1KFfTuOhtktO8EEySiexMgVcep5?=
 =?us-ascii?Q?uPKKBvsG5Fv5fso4XICK2oNHPZjit4nSwMVcrCKMKtvr64Ozc83n379UKRfw?=
 =?us-ascii?Q?EpiEosBNhqo+uJXsewMdnJqRNa5kZh1so2F1Hw8QdsRKf0nZ8jF3jDFRYJNn?=
 =?us-ascii?Q?/3DR1nDjxQIesVZsNpqOyvt69hiPJ2W0YleA2z2Y/d0+ncJLKY8209W45hSB?=
 =?us-ascii?Q?pU29kGPeUUj7WgqegcPryDOFdxOokklrDZ/TZA+D+nI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d45d4-2f43-4940-45eb-08d8b1475585
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 06:58:40.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VnrpK4DPhJosEcwk9aLD7I0XYLioCDy6GZzd2Q1O7de1VTC8Rp8bs9hWFzaJrGF8mEplaX2WM9L0V1TDafucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 5, 2021 2:01 PM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: linux-kernel@vger.kernel.org; rafael@kernel.org;
> james.quinlan@broadcom.com; Hao, Kexin <Kexin.Hao@windriver.com>
> Subject: Re: [PATCH v2] drivers core: Free dma_range_map when driver
> probe failed
>=20
> On Tue, Jan 05, 2021 at 01:41:48PM +0800, Meng.Li@windriver.com wrote:
> > From: Limeng <Meng.Li@windriver.com>
>=20
> This does not match your signed-off-by line :(

I will fix it.

Thanks,
Limeng

