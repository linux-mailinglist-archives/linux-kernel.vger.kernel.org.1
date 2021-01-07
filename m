Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25ED2ECE09
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhAGKkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:40:36 -0500
Received: from carinthia.it.liu.se ([130.236.56.10]:43122 "EHLO
        carinthia.it.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAGKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:40:35 -0500
X-Greylist: delayed 635 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2021 05:40:30 EST
Received: from e-mailfilter01.sunet.se (e-mailfilter01.sunet.se [IPv6:2001:6b0:8:2::201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by carinthia.it.liu.se (Postfix) with ESMTPS id CF38280F7A;
        Thu,  7 Jan 2021 11:29:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 carinthia.it.liu.se CF38280F7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=liu.se; s=liu.liu;
        t=1610015352; bh=10n1WDITvywFHZSzdbV9/3ZgA7dRXjLw0RDtZXgmHuc=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=Iv80OBkFxsJC7YSqZPy7WzPbEiKdbnWL/pHWnr3qd3WMZMvbgVcATv1Jr5tdcdCiY
         cvrcmHT4CVrnCc66q1RG0mkYMTjUzORDYJymkqz7EfENj/PAgnAd+/FOULhV/KBT/b
         AkVPU/RFQ1xbzX04slqabeQGc+PNUMPNOD4bb1YI5fSf5NfzkGsUtexQRH1RBfFRT2
         3gFlfQ/8RaRmJRoEbPtuxiCCd+m5HC4KOsYLGHInQgekRXHJoC3ek1KyxiNvA1CJUO
         1jLeUwdX9VKtfZUdLpueSHHxTGr3jQfOUg//8ZW8Y+p29CqBRe1kJldnjELvDzoFrI
         EuLq9bvAiDgmg==
Received: from andania.it.liu.se (andania.it.liu.se [IPv6:2001:6b0:17:2004::56:15])
        by e-mailfilter01.sunet.se (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id 107ATBWG193920
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jan 2021 11:29:12 +0100
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by andania.it.liu.se (Postfix) with ESMTPS id 8C14DA015D;
        Thu,  7 Jan 2021 11:29:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv5YcJrBifOEIgFBM6kdQsJAYIhhNYa47gw4yyOHIlfeLC52jm+UIZ3eUK1up+DDCajCRb4+LkfKIUOo95QlQaDzCV3RehJmlOUifC4NH6ZdJw8lNGUYGXUVrJCzUK6tbfaZijZwTzeXJOjgR5vGn1OqsuvczWNYWO6mN+baoTirSHts8R5+kzDCBwEo7atmV506M7Z+zEHGv7gDJEf6h6Sb1PvP69/bynVT4OePDu2G8dwoNmCyf2UftbhRP7Bgijd0SihnUyf2hM4C6cjX+HtW9jVqXQWAfIca0klyo0+e2e4yb8hO3mvRqdpsUoc4q88OJ5yXTeh3IN/574dRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10n1WDITvywFHZSzdbV9/3ZgA7dRXjLw0RDtZXgmHuc=;
 b=IuuKbmyLelWzEh804uIu2kDJSIHR1gzz19pejBC9CMi49mTV7457v3ELrxHJpJ1pSdzQUg9WkGkfGh87ifN9mipTimBP8vellZ8MBbIkThVICKMXDPiQeJCv8UQpZPD1RMFShN7LSYiVIAteRbAs44Fn/4GLOMFsdJBrqE6C99g+3b41u7XuPUVTCDy2O4A4ECIAEged9vzAGP4urUktYMrE2fVm9srj/0EjnZ3WBaKfPqbNT42n/RPlLHSF9kkaR+7N2skmjNs/c2qxubeTaQuwuy3RY/GM0OTu+k+oltDzGuK3PVi14u1JoF52Pu3f8IIHZ2H2RYd+viDaFCLAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.liu.se; dmarc=pass action=none
 header.from=student.liu.se; dkim=pass header.d=student.liu.se; arc=none
Received: from HE1P191MB0219.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:c9::7) by
 HE1P191MB0187.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Thu, 7 Jan 2021 10:29:08 +0000
Received: from HE1P191MB0219.EURP191.PROD.OUTLOOK.COM
 ([fe80::15ad:9a62:f2a5:2d75]) by HE1P191MB0219.EURP191.PROD.OUTLOOK.COM
 ([fe80::15ad:9a62:f2a5:2d75%7]) with mapi id 15.20.3742.007; Thu, 7 Jan 2021
 10:29:08 +0000
From:   Mikael Szreder <miksz574@student.liu.se>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/squashfs: Remove caching of errors in squashfs.
Thread-Topic: [PATCH] fs/squashfs: Remove caching of errors in squashfs.
Thread-Index: AQHWphvpBQUJqJO400Ollg7lzXQXoqocctKI
Date:   Thu, 7 Jan 2021 10:29:08 +0000
Message-ID: <HE1P191MB021916F9655748D8322308B2A5AF0@HE1P191MB0219.EURP191.PROD.OUTLOOK.COM>
References: <HE1P191MB0219DFBDF498117B6CAFE34EA51E0@HE1P191MB0219.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <HE1P191MB0219DFBDF498117B6CAFE34EA51E0@HE1P191MB0219.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: squashfs.org.uk; dkim=none (message not signed)
 header.d=none;squashfs.org.uk; dmarc=none action=none
 header.from=student.liu.se;
x-originating-ip: [92.35.24.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 037141f5-068b-4770-d1a9-08d8b2f71140
x-ms-traffictypediagnostic: HE1P191MB0187:
x-microsoft-antispam-prvs: <HE1P191MB0187869060548C15E26003EDA5AF0@HE1P191MB0187.EURP191.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /N+kdZsadSsN7Y7ycW/40h411sxQS5zdLOPVcHnvgwXFse6wbtLiPpAx+QKTq7Nbw5oG+Sp1EyR6/zTNpJtHNsrFetDDjqklJsqFjy1oNWVQYBHNrYO+xqE+ndmI70Wv0nj5W1eDEkrC8poJO4wCNr5WqSDxoZpc4NovEKrVjGlZb/wEqQsU8O+kxWwnUHW4umvbZ/1NGbGrAoE5lO8H7R3Xp3wZ3EFN1kZMxOgt4vVe5rBAC/ERDqhrXM8qdVNhXOhw5ANUbegV9qThCIMba6uoN4JcpSvJK4Pg3WX2neiSuA8Ga8MoMOWAdoiG35msmNetBcqNK6KT/s7wVWjbvWum4unBm1xw+sV4RGoq6wDBIVevQj74EvwmhjetLFY8Qf+XgmZTWJiTYC7FYd5BKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P191MB0219.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(55016002)(8936002)(33656002)(9686003)(478600001)(83380400001)(186003)(26005)(7696005)(52536014)(8676002)(6506007)(76116006)(786003)(86362001)(66476007)(71200400001)(66556008)(110136005)(66946007)(5660300002)(66446008)(64756008)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5NJZTagaSi0yAg/1t1lAnGHMGedxuLHhOBdtKQfk8NlEC1o/StdEmRKQl0?=
 =?iso-8859-1?Q?vup9tMtgAjL/vcWfoV/NwFP+ULw7o9oUoP5Mo+aZvYeRrntWnEJUGYswsE?=
 =?iso-8859-1?Q?8cnNFb7T6i99d207gTiPLT3XWyBztQSUlOAVVpDJSUF5fTPp3/Iae12O6w?=
 =?iso-8859-1?Q?wIi6PGqkHyJ7CDYlQ3S89+wNWaffNZFeRdiGbFuUIBOyE9EnmBqj/oxu2G?=
 =?iso-8859-1?Q?vqYpiCzaruQppWAdKCmyDz+kGhp+EZhXQLYl6B+DXcVEO0CUioXsDEIP8v?=
 =?iso-8859-1?Q?pQbMU0izqjn4cQRyUFRh7ox4uQmZp2nwXUvX7GI5ZqSppOjMbvf0ZoSpMC?=
 =?iso-8859-1?Q?qTXD5yR8k/znKPaLX9Vhkq152W6rIQX1luMvoc+qfyBlwvpd5Pi7kzbrqZ?=
 =?iso-8859-1?Q?azqQsGAQgrhclQ6Hu/A28FDej0ruYO22PCbGZms64Nnu0hZs0H8N7WCjw9?=
 =?iso-8859-1?Q?lm4GFPeji3jr/T6Qmj1wIeQmJd8yOXptIW65P4h5I0Ofhj24uCyD4cgHzF?=
 =?iso-8859-1?Q?WvQVwTgv86qbepTDr4wPqOUGubH5Z4kfwMa6+pNDoDSmtGTe5N0D3i12Jd?=
 =?iso-8859-1?Q?DWIhaRjlQ/odzm718VPnc2c5pJnwK6obpmPpGuxjqKkZ7y2p2jD3V4H3ey?=
 =?iso-8859-1?Q?4HB7sMVl+7sVUnEYeBN/I9lnJ1JN4nbur0eJaTRx9lroIbxzFCLZewO3/0?=
 =?iso-8859-1?Q?AoGNXzMWASgdG/nwrGeoOp2a89DlvFfXhqFYsTn+aVwioMAL1Hhydy+8ov?=
 =?iso-8859-1?Q?EZIS0RrcBrRAqmb4snoPzVQoUOk+EBqLEyiSAqy/l9ZQ+ptWSWz1aoey1U?=
 =?iso-8859-1?Q?el72BRUDhAVVHTBQa/nzmDwPQ5elGILzM4ptb8g650gHWSQkMrglCZnzZA?=
 =?iso-8859-1?Q?JFVHdu/S/YfqDkDDCw2wn/W9TTmKmjj50kRI3nHmcyFYCAhyywp1G2/UWA?=
 =?iso-8859-1?Q?rViJSkaWAJGXIGWjzMFvzwc5diDeufQNoj7ASnJkD/0HNFoGYb+WIA=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.liu.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1P191MB0219.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 037141f5-068b-4770-d1a9-08d8b2f71140
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 10:29:08.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 913f18ec-7f26-4c5f-a816-784fe9a58edd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIcQtX21C9AOsS4YKIaWFy2VF1R1EVaNlP1UuoHoHnyjxDN4zCVf6qFFbcrNJamCsvvjMzYD+U4FaHr8QpAEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P191MB0187
X-Bayes-Prob: 0.0001 (Score 0, tokens from: outbound, outbound-liu-se:default, base:default, @@RPTN)
X-Spam-Score: 0.00 () [Tag at 10.00] 
X-p0f-Info: os=Linux 3.11 and newer, link=Ethernet or modem
X-CanIt-Geo: ip=104.47.1.58; country=AT; region=Vienna; city=Vienna; latitude=48.1933; longitude=16.3727; http://maps.google.com/maps?q=48.1933,16.3727&z=6
X-CanItPRO-Stream: outbound-liu-se:outbound (inherits from outbound-liu-se:default,base:default)
X-Canit-Stats-ID: 094dKtcln - b948db63608c - 20210107
X-CanIt-Archive-Cluster: PfMRe/vJWMiXwM2YIH5BVExnUnw
X-Scanned-By: CanIt (www . roaringpenguin . com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resubmit of this patch, originally sent on the 19 Oct 2020.=0A=
=0A=
If squashfs encounters a read error when reading a block this error will=0A=
be cached. When the underlying problem that caused this error is fixed,=0A=
squashfs will still report the previous error, even though, a re-read=0A=
would now be successful.=0A=
=0A=
This patch fixes this by setting the block field of the cache entry to=0A=
SQUASHFS_INVALID_BLK if an error was encountered. This prevents the cache=
=0A=
entry lookup from simply returning the cache entry with the previous error.=
=0A=
=0A=
With this patch a mounted squashfs file system can recover from read=0A=
errors. Whereas previously this would have required a full remount.=0A=
=0A=
Signed-off-by: Mikael Szreder <miksz574@student.liu.se>=0A=
---=0A=
=A0fs/squashfs/cache.c | 4 +++-=0A=
=A01 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c=0A=
index 5062326d0efb..020fded42a6b 100644=0A=
--- a/fs/squashfs/cache.c=0A=
+++ b/fs/squashfs/cache.c=0A=
@@ -112,8 +112,10 @@ struct squashfs_cache_entry *squashfs_cache_get(struct=
 super_block *sb,=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sp=
in_lock(&cache->lock);=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ent=
ry->length < 0)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ent=
ry->length < 0) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 entry->block =3D SQUASHFS_INVALID_BLK;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 entry->error =3D entry->length;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 en=
try->pending =3D 0;=0A=
=A0=0A=
-- =0A=
2.28.0=0A=
