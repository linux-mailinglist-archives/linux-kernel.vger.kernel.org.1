Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27982B9FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgKTBdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:33:38 -0500
Received: from mail-eopbgr1400051.outbound.protection.outlook.com ([40.107.140.51]:11200
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgKTBdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:33:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eimuKxEwEE8Oj8kzWyLXTgoRsyNfN9DC567XHVLnhmYwQ4Iml4ixxa8FoKVZDVUeDHIn0k2VLv3F9owp3lS+rD2OMPzjWnMZvxv/jSUT4JhaWBEJedHAu0Z7MbpxDcZdX9nTCxaj/eKiCFsJR00ScZJqzktK7Yh7m6kleu0wJaSRr5g2186o8PK8hFC9mY4EVkQUoXJpEk2il/QUdSPRQJtARSBOKbngr88XMgHz7HYk3GZ0C5toDvMVwsrFzbCPdggbPA6JsupNc0Hr33LN73rGVKmAAfYa3rg3qGQCkBE4UcccXVv79BP/Yqhu+Lf7+Go7358AxgT1oUwDW8MBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNPVkm6TbOH7iQBu3e7RLhxzcX83kOEhalMb3Kb/D7I=;
 b=inqeUGx4CpGrF2fbCd/b7h4t2Ktmdcapmsr8epOB/MfVsRC/QISKnZsM0XVVZ4l7ujOX2Uh86n507+eqJz2s7OSrhyLuZY1w3IqWyuef9NIbCb1Zb2NmRiA/A6VmaSq/BVVMToIUuy6xbLCCtTyTZxL7pNpUimaM9NyZz/VbG8WbiqO8hsPrJoB5weOKUkG7UTPUJYokLIobMvvZSdFOt0+MpI/q+6GMsaSwykYu20AZMI7qftc8GODQ762G0k+NV8DAql30kkTfJR6j4YMOs+Wv73yDYiIoE+v8DjPVByQ9kMur/2+LUZUOM0h6KbMIZKLSfosbO4mRyQfVMLyq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNPVkm6TbOH7iQBu3e7RLhxzcX83kOEhalMb3Kb/D7I=;
 b=aimr4/szXAf544ZN9w3xhMUUTkA2f7g0acoQwRIEUoOCEZeKA3UEQONH3e1B9qD4fyloWYJWy9FSDsQ57qRjIfDRVEaMskLmIlZ8ECyWwRUA3qC9jFK9pXjgAgXmiRAhrfs43NDCJp3ibqkyni8XuwEQZZPeggPdfx7CVguf1Cs=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 01:33:34 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 01:33:34 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] mm,hwpoison: Disable pcplists before grabbing a
 refcount
Thread-Topic: [PATCH 6/7] mm,hwpoison: Disable pcplists before grabbing a
 refcount
Thread-Index: AQHWvmLLXmur5N20F0OaflxcOyKm86nQPYuA
Date:   Fri, 20 Nov 2020 01:33:33 +0000
Message-ID: <20201120013333.GC26144@hori.linux.bs1.fc.nec.co.jp>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-7-osalvador@suse.de>
In-Reply-To: <20201119105716.5962-7-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61478f93-c473-452c-3d7a-08d88cf44b88
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB59363E2A15A004A5833AF025E7FF0@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSypqSJA2FRb8cQEj5d786467fWju/gZAhdxP87KnI5Jn9n6LLvJBBgctQW1Qzrg356qx/EOAzPXZ/79ubtPU9HHu1sQjC3sR6KQXLIL3dHhMZg6EaM+P2Bs7aug/GmbJxW85YjCaEreT+MhvM4QmvYRROg9XfVeVEeoe2L45dZ2amHotZ00S0HZGu8h8nlhFmUx69mVeX0pb40fybLNaTxQJia5LOwrTrmJ107bMCeR2sP3uCbYejwmxAVKW49E0FkRwqe1YRpKidVCc3Vta2mcHhQpfYp79zof/UaweZSyRWWCUixe3p5LVkFuAfWtB6OEGPpxI+ybHQylCbL4iX7iPE5QHdGCbQoiEtUqFJN5ZJqguogeFate7uenoF/Alw2k6F+RfBMOaEkCwqpLrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(4326008)(4744005)(86362001)(85182001)(8936002)(2906002)(33656002)(9686003)(71200400001)(54906003)(316002)(83380400001)(8676002)(66476007)(5660300002)(6512007)(6486002)(76116006)(26005)(55236004)(6506007)(186003)(966005)(66556008)(66946007)(66446008)(6916009)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: X4+8RzMgJfx+pXnGdc+a2mfwbZfEa9e1nTMP6Xt7++ueOZHbcBkk2emLNU7s6V1KS7P5HfnDX6bbllHQ9E+gTq7GtXhxbh68flmb12GvODXo2URtYrIubRBgLIXy5eX/esUa+xMsw3lheBM7b8cGvTTasezLSUBDy/+zzFN4ITjqsTPbF3sJOhjHY7GjUlImpdJPWS6J0jfP5kIjVnRfpFh5c/Tk71utL+QY/g4/mNiuvQjmG5g+JyjgXpmcUhKL8TDM6alGrU5VLQg1MQUb8VVLjSnqF1YnQsCdKWvp5imYz4bG3jydLjepZ/gTr74tKgC2qU8cw88tfggZqwOa9lOWUjA9WuQWIi9QNUlTiOsct/Y9xYm2irgVLXq1LKdoD5N5x8ZutGMI2uQ2raOuSTBuTp627Cfjg+DIRT/tcge/V1rAySvpegXvcgAC3iFbMPeJwJqti3bBkUmpcIOJ8P89SvQFFJryybcc1H5mJh2756KtBN7BgKmsv4G1dbrDUtrOJLRxIb4hVPLh2zSIalw3egFcx6SHkTuoMcAx/kT7nsHYucntrZBrKhjiKC5Twj9zhG5x9P0hTxq3s8NLxNDVMFxEG0EbKNsFmz9sxubwIVNPcV101V/sSj5OEvKEhhJP46ockmcZGzb5Ep1lhw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E2B7B2E115928C448DE36442917D0EEB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61478f93-c473-452c-3d7a-08d88cf44b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 01:33:33.8904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYyRtf8BhJMXbjRTEI2bjUaCR5Oe+OXoYSMd1xOC/L9I5jj3UIbm0XYIWUAG7oTySO1+2FYsmL1mP3c9C8djgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:57:15AM +0100, Oscar Salvador wrote:
> Currently, we have a sort of retry mechanism to make sure pages in
> pcp-lists are spilled to the buddy system, so we can handle those.
>=20
> We can save us this extra checks with the new disable-pcplist mechanism
> that is available with [1].
>=20
> zone_pcplist_disable makes sure to 1) disable pcplists, so any page
> that is freed up from that point onwards will end up in the buddy
> system and 2) drain pcplists, so those pages that already in pcplists
> are spilled to buddy.
>=20
> With that, we can make a common entry point for grabbing a refcount
> from both soft_offline and memory_failure paths that is guarded by
> zone_pcplist_disable/zone_pcplist_enable.

This new mechanism provides a better solution to us.

>=20
> [1] https://patchwork.kernel.org/project/linux-mm/cover/20201111092812.11=
329-1-vbabka@suse.cz/
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Thank you very much.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
