Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9967728C776
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgJMDEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:04:25 -0400
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242]:50062 "EHLO
        mx0b-0039f301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727831AbgJMDEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:04:25 -0400
X-Greylist: delayed 52788 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 23:04:24 EDT
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CCEe05007206;
        Mon, 12 Oct 2020 12:24:35 GMT
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53])
        by mx0b-0039f301.pphosted.com with ESMTP id 343508m453-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 12:24:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep0dkEpcFfaFZvjMnVNhYJ8KIBm4r1z3bYTD/kSx5EC9Nt1Ts/j0bZvnc/hlH5Nr1QD0iHTcTgPVQfdKAAL7lEUAZHGN0yyD7HlK9iyL+nwOveZvUxWjkTbngRzdIeijt0/tnEmz+PHkL5Ryu0XcS+N8DxKzK9XiACJavE8yRd0gezG1n+uxwm8/v9cvhI6BlR7TgrOcQI/Hw7WtmsqanGb3VcchdrYtxNWfJM6sfhYIAwWvx9D0Aom1IGFZfEKLor9nhciJMcF4OQKCtcI7E6NRzoyi/UGOoJM8myrWFdAopj7SwDjT6Fcu9geqGupObK+kbvaZ+uNKoWTUT3Ulqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfGEOiKENCd3V8feRw9i26r8/iuyK5VhldZ+XKhueGM=;
 b=cPwOYQdULYTVwTDRpfm6uDdYggmgGTLC52syEyHyhuxdigpoZIYIQZ9Y1rEIkRDLf5fjAIKC79YTlKK1POuTq5fFNRw2sSKFK8E+j+p1Z+7lJMcFUaoMQxH05zUhRqMtuwC7yuVZcc4qXOGMV5bmMMwF1ZpAPE6gqWBJ5abIFwLgrCFPSEQ5iNhlMjUOhPL3v5r0+iD/wslf+PBDnte28KOFsjLzm+7F5qRkisRaGTbgB4bI6U9Cwkuldi1UFn6HivsXGs7Z50ZblreibV/urT2OsXal6lqOQxzpmqOymWQSt5ONwxSuv+jaFBF0FixFFhTpG+DSOfHt8rldEYDBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfGEOiKENCd3V8feRw9i26r8/iuyK5VhldZ+XKhueGM=;
 b=JHGzHxdUQ2TPvUI+wLw0/zrVC8vPFaYVmxicGN1RkNIm1rtJ9v555kKe1JqFMHCOdUs/hFF4xOT+HLCFLlS/zNYtZmKIEXpdscWfTvjmUsKeotUFNZGD3rg/kJNweD7ddiiT0wXgw2+CBKBRrSUU9K8/A+Rf7pCzPQIxyoE2uGrHs+hbS+oJbvAZrCFTphy3xX9G6O7dOofU7tKslbtKYM3l3cNb8OBZO5062mpcy+8m/0nS0YOWYuCbd50Sr1kUWq4AUeI/I9iHkwohGiDnBa/OsRWHOWuBtyYfe9DodP9GCFqUf27wSUQcDwxCEUi/6OIqW7Y7yYMy7sieCdp8Tg==
Received: from VI1PR03MB6400.eurprd03.prod.outlook.com (2603:10a6:800:17e::20)
 by VI1PR03MB4125.eurprd03.prod.outlook.com (2603:10a6:803:73::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Mon, 12 Oct
 2020 12:24:33 +0000
Received: from VI1PR03MB6400.eurprd03.prod.outlook.com
 ([fe80::71d4:858b:cc47:7da0]) by VI1PR03MB6400.eurprd03.prod.outlook.com
 ([fe80::71d4:858b:cc47:7da0%4]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 12:24:33 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optee: remove address tag in check_mem_type()
Thread-Topic: [PATCH] optee: remove address tag in check_mem_type()
Thread-Index: AQHWoHnLmMBjWnaqfkeJ/6WMB4Ss4KmT1oMAgAANzoA=
Date:   Mon, 12 Oct 2020 12:24:32 +0000
Message-ID: <87wnzv639c.fsf@epam.com>
References: <20201012092603.630703-1-volodymyr_babchuk@epam.com>
 <CAHUa44EAR=5Syz9vz4pCNm8ytqd3rhj=PDE8trAvOiAdhs_T8A@mail.gmail.com>
In-Reply-To: <CAHUa44EAR=5Syz9vz4pCNm8ytqd3rhj=PDE8trAvOiAdhs_T8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.4.10; emacs 27.1
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=epam.com;
x-originating-ip: [85.223.209.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 401537d4-877f-43a0-2a91-08d86ea9c682
x-ms-traffictypediagnostic: VI1PR03MB4125:
x-microsoft-antispam-prvs: <VI1PR03MB4125D48DD93F7A4B3DD2B437E6070@VI1PR03MB4125.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gc9O0lzLX2g3VaQe2+3RmKyrUqnYiBikCTXkmR91cpLAY7aPjchdTszuA/hOcd1NNsJ1qnhb/aV67Aj51U253LiKuTj580Pr+Z08tsfSkXbfBZmQXdYN2Yp3tF0ytNUXnaX2bPzAH1q2lwv3bEik0ibDM8Fx3MtoBWqNeLktToPg55nf85LVeQMwVcJwxOZTScWLFqdRvT4L+qNUl5SfQnmpJlINryiSy7YMFB0gwgYiS9ecNAkEaDapco2vmGN5LkpJEZHSX/RHZXQYjUKQvgA85fM6AXefpmQL5oA151xX2UGK3AaXzPfbVprdMVhsTeZD432XTQPfxcG0yVZiYCFz/u7b3GeRotOeZmYm7MNZRyLymjzx/cEehuW9P/wOpZlwtQeacd9/mYHS17bkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB6400.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(71200400001)(36756003)(66476007)(66946007)(66446008)(66556008)(316002)(2616005)(64756008)(54906003)(478600001)(6512007)(6486002)(6916009)(86362001)(966005)(5660300002)(26005)(2906002)(76116006)(83080400001)(91956017)(186003)(4326008)(6506007)(8676002)(55236004)(53546011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 67ia4NQLbCWGl3MYvMvPcK3SxLcYCA+TV86fGsd9fl4KtVESJx+138lqIJtrF3jcrFt/nv/9CzpRWaUL/bjZXO5O6mWU/k/hTxy7jBPsHklHn+2OvFe6zE5S3ivoB3SmDFXnNvi8MY5B5fH/+f73/RGne4B6ovTjA8UIogFImVY3WMko0mbr3BC+7x1Udp4PuRxGQ+fHoZg6QZvk9/xxekRPKVs6algdJZ3ykHjJQcUjwGlzoojdbLuFvS+L6vS89z1R+qAwPnB/9pFfusJXtczlLGefEVPE9BnZk/zxhgXodnK85SFPFSLa7HmQyTmGxQIAKZp9+2zmmLek5Sp7WPKZwaHcxPUVajXEOIW1WKRcV3uzhabt+/dXgT7bzmP+vHrOeJFsYyZFMSe9mEQV3P2acyGeRkY2/tSwjNUnxJQ0QFyc7JchoDR0MdbnjMRugTXs3ufYqNr9UJ83xJI/IUScrXLdsLVA2spuHa9M168pkz3iwYexMtdh6eP3RjIQnHHAiO0AH+w1VpbxHBu2s5VTzuHO0H5giRs6d0MDq+kxGB8d4g5414AObvhb2bHTf8+hZI33TFfV3T//82RUNpyWWcEZbgxA4ClbAyPOZi/qDMAHXjbOZeZuwt/I0BIZYzDOkT5nLYIiSSomjQDRXg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB6400.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401537d4-877f-43a0-2a91-08d86ea9c682
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 12:24:33.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g02uQgAYB/s0PfcChnZ48CGCa+WRMOaJjo+5Wq5Ow299M+y5ZkxJuHNn1wGTkMxKhc84UroxcTJRqphWg36NQrBqjg4iHLdPE4CRuDyYj1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4125
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_09:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Jens,

Jens Wiklander writes:

> On Mon, Oct 12, 2020 at 11:26 AM Volodymyr Babchuk
> <Volodymyr_Babchuk@epam.com> wrote:
>>
>> Before passing 'start' to find_vma() we need to remove
>> tags from it to get sane results.
>>
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> ---
>>  drivers/tee/optee/call.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Would you mind giving a bit more background to this? For example in
> which contexts this function does or doesn't work as expected? Do you
> have any special use cases that don't work, etc? This is not a new
> regression, it's rather a problem we've always had, right?

Yes, sorry. I had to clarify in the commit description. Issue was found
on Android. Android uses pointer tagging [1], so MSB of user pointers
contain tags. As a result, passing raw user address to find_vma() leads
to NULL result, as it only traverses RB tree and does not alter passed
address in any way.

Code in mm/gup.c already strips tags and maybe, it is better to call
untagged_addr() inside of find_vma(). I'm not sure. Probably, we need
some help from MM maintainers.

Anyways, this patched fixed issue with register_shm failing in our use
case.

[1] https://source.android.com/devices/tech/debug/tagged-pointers


--=20
Volodymyr Babchuk at EPAM=
