Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B069B292878
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgJSNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:44:53 -0400
Received: from carinthia.it.liu.se ([130.236.3.99]:34848 "EHLO
        carinthia.it.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgJSNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:44:52 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 09:44:48 EDT
Received: from e-mailfilter01.sunet.se (e-mailfilter01.sunet.se [IPv6:2001:6b0:8:2::201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by carinthia.it.liu.se (Postfix) with ESMTPS id 49A5C80206;
        Mon, 19 Oct 2020 15:37:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 carinthia.it.liu.se 49A5C80206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=liu.se; s=liu.liu;
        t=1603114639; bh=0JQD0GtboB34dgpP69XRmRNfNnzkZNSnDdBDrRr7vlQ=;
        h=From:To:Subject:Date:From;
        b=G8jVT8nU4BgmGiv1b3X0K/wsnG3zb42bUbfT3se4r6bRz7ptjRjaBiaxPkzMwCryY
         7Au8hAasooipqnBzYoFw6nzwXNwOOC1NyjMadwPfZM5MFZTrpKGEs7nD2+PXjwU8Ds
         /2Gb5A7wh9MjM7x9b0C/0HC+gRLBfLGo7qzKDr2YLM05F1D+KZB45y5a31+ZTrOKcG
         vreC2X8GOopzsHx+2IyfEREt5YMUNvSw7GwzvRy3hmTCpp0eRaYhuyUII5vDTHT9Ia
         x8KHfO79Po4ErHWZwTAv6LXqCM98tLDx7iRIZd6JpSXgsfCbkwZ2fQ+LikQGZt6e5F
         8ye8TTxjr3+5w==
Received: from andania.it.liu.se (andania.it.liu.se [130.236.8.136])
        by e-mailfilter01.sunet.se (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id 09JDbIUn020906
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Oct 2020 15:37:18 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by andania.it.liu.se (Postfix) with ESMTPS id 52AD6A015C;
        Mon, 19 Oct 2020 15:37:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL0oX9txUIpoif2mirqvXYzVbIJNxXg02i5cLlsoSgvtR6jpcU2ZshmfUzhD5RHndN22cnBAtqudn3DC9rHwBHe8j/JyKXsFyIZ4oT6KDtBAdeox0wo6btGv4lDytsOsOnZdLn2YqFQyke0VttcRUnGZ5UqJubCnqBBfI75i9UJ7TXNByTNksV22Fs/eAlv8G3Q78uZDU7+cuvBHMHVWoiGcIkr4Eh9YxEqnRsdNjO6KqryST2RRuLIKfj0TbZ7p1SAiXf3g4/eDcuRz0Wnyr+iubiFBOpeHtg7kkc50y9hkr7FQ5mGIZy2BGw8l4ILAV4HDGkM2MGEC3M4nWzbZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CCtfIEjMO3ekEHFyXGviymelYSxEMNHCHFMSFSWazQ=;
 b=ihFJFDvB7OD3eGYZ8Po8Vs1ls4BD6T6SxNK3fmD15r6PiXzPqKmKbOb9hni6Rg6y2Kq0ugGRcbawzFXXwFMFvo9TvS1IQBJndAHBDB7wuuDPdWA5AQALnJef/h6TU6LM/5uuwgz7eYGXy4NAMDzzkSvqDyuuo2tw28sxTtoKUhXiyq7+RvPEz0F5Grrw1vrvOO9eepW2r07lC49pTvcxz1CwL/Ka0chifSQIH9uKtByq+zW7+Ie0M4gMODbQqTE7oaB5tsH/ItArCwxY8Hhx7l3kGJAaKxIieLkWKu9NlZbWV0S2FZ1uiRkuirVrUBgbItUUbMQjMIFEJ7C9TwYrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.liu.se; dmarc=pass action=none
 header.from=student.liu.se; dkim=pass header.d=student.liu.se; arc=none
Received: from HE1P191MB0219.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:c9::7) by
 HE1P191MB0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:ce::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Mon, 19 Oct 2020 13:37:17 +0000
Received: from HE1P191MB0219.EURP191.PROD.OUTLOOK.COM
 ([fe80::1e8:a012:e93b:680c]) by HE1P191MB0219.EURP191.PROD.OUTLOOK.COM
 ([fe80::1e8:a012:e93b:680c%5]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 13:37:17 +0000
From:   Mikael Szreder <miksz574@student.liu.se>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/squashfs: Remove caching of errors in squashfs.
Thread-Topic: [PATCH] fs/squashfs: Remove caching of errors in squashfs.
Thread-Index: AQHWphvpBQUJqJO400Ollg7lzXQXog==
Date:   Mon, 19 Oct 2020 13:37:17 +0000
Message-ID: <HE1P191MB0219DFBDF498117B6CAFE34EA51E0@HE1P191MB0219.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: squashfs.org.uk; dkim=none (message not signed)
 header.d=none;squashfs.org.uk; dmarc=none action=none
 header.from=student.liu.se;
x-originating-ip: [81.236.103.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c719abf-91e0-4a4f-a626-08d8743418a7
x-ms-traffictypediagnostic: HE1P191MB0028:
x-microsoft-antispam-prvs: <HE1P191MB0028881930E30793FD3A0F07A51E0@HE1P191MB0028.EURP191.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMD2LxNn6qhzoSxTEOzOWdFDm0+Z4dT1vjeyDJlj3E/RICRIXC4nE+YRQtbjhrx+7w2NCddb7wyEHNN9EjlKFXyjoE16cJGUttEOJY9Vjz5wyXsTvDbGr0abKZgCpEqOuiAvpNSjqoUmq4lHe9shyzpII/XhUsMFFMULErafQMlKzarURn9nef2HlyyLdHskE4ZSDEDw9XP2cRkB4QUQRnCqizl/ZnMnEZgemPrSc+EUigl+asnkjsldM5bOVfUgbQEdC++yKx3FjRiBfvO+jjSQa7EHi6+iavUfwM7Zzx5clmYs12g+S4WVcohukChtwEJAyV7FOiA3EAAfUzgSAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P191MB0219.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(186003)(55016002)(83380400001)(478600001)(2906002)(26005)(86362001)(6506007)(7696005)(33656002)(8936002)(66556008)(786003)(316002)(9686003)(110136005)(64756008)(5660300002)(71200400001)(8676002)(66476007)(66946007)(76116006)(52536014)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gLDw08V8mrbspSI+c79c91Dp6u8pSt5J4LC0NcnsxfXOnJGN2dO0/eEmithTF3C+mQ0SobsO5b5Y6vztNOMsPJ0k0frXx3J/dV+IsKU1DgWrqnwP7HWclRrKOTjo10m1BjKSjBx/y0z4a8e+q360nBOq74M+P0Idcm9MWIoL5cUlRmDxUHX12ay6uzbPb+bkEg1Xr1MHSIgbWNWo+Gz+ek5he7WQ7bGLxwz0daL1jFDzVvjtnDZAQpiI/3Vv+nfIQZ0BF0R7SwOSX234y46PGbg/Zu4pxdY6uySBqJ6kyDMNqe+a5gvyUaLMlJrbM22nCiuuLdegTI5izQf37A2g85GNhEVkRuoGnhJGQnGQhChb4BB1KZkaRt+MH36dcILmy2tz63pU6xjwG9B8ipMEA8WmuypJ/fmEzRDSdtZSqxq5hQWgauQRufgkmxiH/6HG86XpJNR82lwxu1HDoXxQMiWHInQRe7Tw/FsVtNFofFl//gOASm6JLlcEvXVIkdeZMPcfxJUYz8kxKZdw4C8Nx7vbReTTvh2D2uozS19tbQMGr2OsCTszN4eVzHSjw05YWt/biIhlhsBE7bVaXz3FoSAD0y2GG/6O3eGCFeZ+/ha3/TK4CLje0aqcsDgWiItaVD+H8PHdDS5vmEgTEE1lDg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.liu.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1P191MB0219.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c719abf-91e0-4a4f-a626-08d8743418a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 13:37:17.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 913f18ec-7f26-4c5f-a816-784fe9a58edd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTr/IeSNDFqGk+MVb+ex+exJYD7Vz/X96Dh82j0FdMUWO29SMPMT0m/LsrQkVNk9ifwNBYWUnijh8Euugnuv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P191MB0028
X-Bayes-Prob: 0.0001 (Score 0, tokens from: outbound, outbound-liu-se:default, base:default, @@RPTN)
X-Spam-Score: 0.00 () [Tag at 10.00] 
X-p0f-Info: os=Linux 3.11 and newer, link=Ethernet or modem
X-CanIt-Geo: ip=104.47.18.112; country=NL; region=North Holland; city=Amsterdam; latitude=52.3534; longitude=4.9087; http://maps.google.com/maps?q=52.3534,4.9087&z=6
X-CanItPRO-Stream: outbound-liu-se:outbound (inherits from outbound-liu-se:default,base:default)
X-Canit-Stats-ID: 093FNBisb - 9285fe60ed87 - 20201019
X-CanIt-Archive-Cluster: PfMRe/vJWMiXwM2YIH5BVExnUnw
X-Scanned-By: CanIt (www . roaringpenguin . com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 fs/squashfs/cache.c | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c=0A=
index 5062326d0efb..020fded42a6b 100644=0A=
--- a/fs/squashfs/cache.c=0A=
+++ b/fs/squashfs/cache.c=0A=
@@ -112,8 +112,10 @@ struct squashfs_cache_entry *squashfs_cache_get(struct=
 super_block *sb,=0A=
 =0A=
 			spin_lock(&cache->lock);=0A=
 =0A=
-			if (entry->length < 0)=0A=
+			if (entry->length < 0) {=0A=
+				entry->block =3D SQUASHFS_INVALID_BLK;=0A=
 				entry->error =3D entry->length;=0A=
+			}=0A=
 =0A=
 			entry->pending =3D 0;=0A=
 =0A=
-- =0A=
2.28.0=0A=
=0A=
