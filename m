Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1F2B6C15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgKQRoK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 12:44:10 -0500
Received: from mail-am6eur05olkn2034.outbound.protection.outlook.com ([40.92.91.34]:59310
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbgKQRoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:44:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8GS3LTitzQN1PHWgXW9LPGvX5TuMSAY3SitZNGD9GbjoE28jrlwrzX+67GjkNGkQkpobqAV7prJRdDGoNjOWbl8PqtwW/RYo/VIP/TqxNx7CMZMRq4iGIHYRzr41L17AXJAoZ3t3QVmVSwgZf4T8Avi2/rQBnH0UCAbJ6qBiyc2QWTUmv/6hW0JkzGZG+nOYz96ygoenTUNdCcVdHjXjJpuunmyd6B9/tmvipb2BlTwm13ObacSOd9HWuygTTtT/h+MLU//aOnt+tWonHgE7GDWfIWzm6WN4eQZbos0N78ftxOHEESLZNFBccblUMxcjtXtxtKq1M47n5dX5v6LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2McBTSLTXQwhye9zASywz7Q4F8i0UstVTPRZPgQx7Bc=;
 b=E0MaWTYiUL54jCynFF15jz+PTxg8Peuisvhtfv2PIx+Nj7+2plVM+P3XaCOW1Pb7ILkGs2jDwTrmlXO4NJirnSz26oZSa/dhKHDxnGXdFBtQ/n6259Mc6LgjtTmRrqnBzrm07sLgrUu+3ZBlmitCJQFXAOeqf5P9Upgrlswm/cIoGGscLDrqaiMKaaboqD8Ea2Ekqd4QirYYt+kJ9tLKEE7n1TAd34PJrU9l3yotShdLFi/llfy3yvAu0wcJb8Bem6F0F0qjYZ18PqEmsd93ILran9c2WFn3nZ6wzf3RAFIvoa7JkL2yk+JyXJ5HxGWfUwWFkDFwbfwfb4HEytRTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT011.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::41) by
 AM6EUR05HT047.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::178)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.22; Tue, 17 Nov
 2020 17:44:03 +0000
Received: from VI1PR04MB3216.eurprd04.prod.outlook.com
 (2a01:111:e400:fc11::46) by AM6EUR05FT011.mail.protection.outlook.com
 (2a01:111:e400:fc11::285) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.22 via Frontend
 Transport; Tue, 17 Nov 2020 17:44:03 +0000
Received: from VI1PR04MB3216.eurprd04.prod.outlook.com
 ([fe80::ed8b:4d28:ab1:b495]) by VI1PR04MB3216.eurprd04.prod.outlook.com
 ([fe80::ed8b:4d28:ab1:b495%5]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 17:44:03 +0000
From:   Mensah Attoh <euloge.blackwell2019@outlook.fr>
Subject: =?iso-8859-8-i?B?6+vsIPnm5CDw5eLyIOzpIC4uLg==?=
Thread-Topic: =?iso-8859-8-i?B?6+vsIPnm5CDw5eLyIOzpIC4uLg==?=
Thread-Index: AQHWvQk9uD32/+oNWkGza+8qng5lkA==
Date:   Tue, 17 Nov 2020 17:44:03 +0000
Message-ID: <VI1PR04MB3216BF268498CA3DA24B53E3E9E20@VI1PR04MB3216.eurprd04.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:F74D99B3AD2BAAE423DA2E76664B282FD28B1D54F07EECDF528FB92C235C0E9F;UpperCasedChecksum:9B00324B558D167CD9A9E8B754FA29665FE25DE533FC1E5D21650D0F05C0FD0A;SizeAsReceived:11575;Count:41
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [E3pe/lupJXkZAli89sL0iJn4U/bSuGbj]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: b5549798-311c-4ae5-9df9-08d88b205fd1
x-ms-exchange-slblob-mailprops: I5qrvvDeUuTJumcg58k08DItmFW7RApSnpYZQ5xKmbrYtQ6gR+qg47i/YSs3xObkMLujTe8uIDk8TMlA2fxf7BHSXwUZNVZP9YScCg95pm7gr8lAXfhkqjwxpgqpubyvj4GwAHBPi5i30T9RxOndnkJPyvfzbryh6eTY3wyh7HBtKCT/D4QEllhdYQymKWtEYnsP3+V1YdOHX6h2/gb/gFbb5y327YEvpp0bqhSptd5+B5ZHaw047HtALpCz2qIuN+DlQt9Q+EQFPburpVTicvLm3wgk0QhvhKxu7WhQmsPjqG7gCb61iNSCc/nRFsDUf78Q050h3JHap+aKX2ZGKQ3fOAmOF8GrX2Ft3nPnw4Q+zNiT1KAijHfzuLZUiWOpV8T+IODWwRnFKhwNhvUyqgyUSpHy9L4Jp3cvk9tQ8UZYy43WhtYvrBtqGZ+x2sh9DzVyDtxIEQayZB7esFDDzYhZQld5tFiqziMPL057MlU9mI3O+fr9S+Tp2XfqEUgZDdNg66DAam1U+AXUHiZeoiEykRArizj6FEFzEU2QLzm4J+MBXxJQGDjj3tOG3pR/7bvjVdBGQUTZdpXpI+yKQE44dWj4ac0Gd5v6Eh/FyD6AypZT2M7YwVa3DlRwrbb9nnA63niCm/mpEuZZxsliMXeI5brXmWfD+nYhjy7S80LDegR17tw8G4+N9FyXBOVFeTMeuc4uXaS+CEYNkZ0Jx3v0ztBqIgN9xah1/lomD9cmzIUVXt7YCKihMn5PPsO8gSYUO9x8bAxEO53Sjdc6qA==
x-ms-traffictypediagnostic: AM6EUR05HT047:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hlN5NhtWcgf8YW/vyGryWl+KETsC300E+tXUreVw8q44DwqCLR9zARWRb0ttlI4xPli0L+mcMkYxj8be11rsB1f+fYfuSJJTHyLBUwk22fTzbUxDqussTH0C5OPCbwSHAEgxc+zktWbT1+gqIFpeenuVni9pqQYXdiHiSCEmM0wthrvduxrA4p8xyKlDryZ651kyC7ZPidDgNEKs3Wjr2w==
x-ms-exchange-antispam-messagedata: WoMmzIShT+FhgGPhSxSHVzhBqLn+pyH3Nl/5b1QcPgaZqMobe0zWtBjbeRUw8UFr42ZdrqlXvr53hSp+W0GL77p14jrKfq/aAaiGgO2u24VhNPAckplw96J3EsxJ9BCdoc2PEcNz1c/mZ5wwOWn61A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-8-i"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT011.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b5549798-311c-4ae5-9df9-08d88b205fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 17:44:03.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT047
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

***

שלום,
כבר כתבתי לך בלי שום תגובה או חזרה ממך; אולי היית בלתי מושגת ולכן חזרתי על זה.

אני עורך דין במקצועי נציג משפטי של מר אמיל, לקוח במשרדי באותה משפחהכמוך. אני מגיש לך הצעה זו בנוגע לקרן העיזבון הבלתי תבועה שלו בסך 5.5מיליון דולר לאחר ניסיונות כושלים למצוא כאן קשר ישיר.

אנא תן לי את תגובתך המהירה עם איש הקשר שלך על מנת לשפר את התקשורת והמידע בנושא לצורך פורמליות תביעה (תנאי תשלום).

תודה,
מנשה

***





