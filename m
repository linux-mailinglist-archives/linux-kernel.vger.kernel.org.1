Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD802D4771
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbgLIRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:06:03 -0500
Received: from us-smtp-delivery-162.mimecast.com ([63.128.21.162]:60038 "EHLO
        us-smtp-delivery-162.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732200AbgLIRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1607533461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n0aVWuN2PbdFYQ7gJrwLBn6XKcfljJJEu1yETgERTOE=;
        b=hkZfahpIKRCydfqcKFDGnd16JeVfoBqUoadIBnTse0H9P7Gp6AmKi87UYf1E6z/xClDQHT
        6V1yy7mf6rVgQbAuURPECNEcjPlapzOc26ruNEM0CmMr5uG6sdqvWlk9sXFQLgI09GddUG
        Gj5H8DP5pFku2wEEui1kvlxGCy1Yf14=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-9vayQHv_NH-5-UVWwr9WyQ-1; Wed, 09 Dec 2020 12:04:20 -0500
X-MC-Unique: 9vayQHv_NH-5-UVWwr9WyQ-1
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::13) by TU4PR8401MB0432.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7713::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Wed, 9 Dec
 2020 17:04:18 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fd25:5d10:75b:4dc0]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fd25:5d10:75b:4dc0%11]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 17:04:17 +0000
From:   "Bhat, Jayalakshmi Manjunath" <jayalakshmi.bhat@hp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Capabilities required by NETLINK_AUDIT socket
Thread-Topic: Capabilities required by NETLINK_AUDIT socket
Thread-Index: AdbOTQm3MJ84FUuXQKKbJaCoyDLMMg==
Date:   Wed, 9 Dec 2020 17:04:17 +0000
Message-ID: <TU4PR8401MB121665B150716C56C4EF3DDBF6CC0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2401:4900:22e0:715d:5c33:1ade:2fbf:4ae5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac70b093-6871-4fae-a8a2-08d89c6476fa
x-ms-traffictypediagnostic: TU4PR8401MB0432:
x-microsoft-antispam-prvs: <TU4PR8401MB0432E38F9C7C5623FE806419F6CC0@TU4PR8401MB0432.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3173
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: hd5N1+AmuXzuIYqLx3jN8W7zXqBqCFOPfJSSZ9cL9tt9nVTWwa4n4PdvnskCHrqiNb2ARSPaOzVfiUQpSpva4RwZgrFsSTkyjDBUPSl93ZBsRiVl47iT4X1E4Ier+eMzaz9cAdTbiAiG1HHFr+yBAv+NZF/o/8fD+iCF4fpEmbSNgTRk++P8ReSGxvX+q9FD0c/p/ChuAL/XuSU+Yll+gw2Rf6No6kTFa5v2tLLqMsz7TtDWLTmPSR50/N2Og2iy8vSwaKzXo7sFJ8MhHRloDlouk/WxrnveyLoTqP+ucEyqN5KeykaBAMomIi/Z3gRXjlzYf+smwaXwPrR94s9GBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(66556008)(33656002)(64756008)(83380400001)(558084003)(66446008)(2906002)(71200400001)(450100002)(5660300002)(9686003)(52536014)(55016002)(7696005)(6506007)(8936002)(66946007)(110136005)(8676002)(66476007)(186003)(86362001)(76116006)(508600001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cbg4zcUsrEvqejh9PKg6bPv5nF56iK1AHOYVwCHRlemkvAhNvtTnggFYrGLp?=
 =?us-ascii?Q?Ubgm6nlH5mnqaKyIDx2ueV5ZUHO9nTCB07/eXOAQK0x4nES1DcDMQWkdxmNn?=
 =?us-ascii?Q?XzPusaY/cgfP7uTpdugOxrkrOAedsm5VBy42CMcgSepckI3zH4e1LsQ9i7IQ?=
 =?us-ascii?Q?AhRsBIP8VmNOvGREI/r9bO6RlEkBIm34G/vmdRsAmfteaUftv+1tLViub8vI?=
 =?us-ascii?Q?LwtNVDGokev9p/4CFqcylT1ahlSOyX1K3BpbqM945QdBuyytKVDtjSRQl9ZM?=
 =?us-ascii?Q?pkES4mxtA14gR5EM3HlUIrHaUwf/cTUG6gPgJar7er0qRacHbJPKc8b5ttCZ?=
 =?us-ascii?Q?fzwq/5B4C6u3TEUQXzeKiYa3EaakrzKRfF5YPIOZuMcydbqkE6pDNsKEPD07?=
 =?us-ascii?Q?30wfWP7rp3Osul2w7YFI1OZib+mnsOKfQmg7bY+U41LHwY5qQ5mg5MC2PJJB?=
 =?us-ascii?Q?V+D39C+VpIjNALslGxIierSXd2NUqd9g70ONlFlUNtEFt0HPhLbZoiTi1Ewh?=
 =?us-ascii?Q?m6Xucr/oLdo1B/t9szAV60lgV4wPSBIpZAcq7Qj5349ngvt2L6E3ENq8QiDR?=
 =?us-ascii?Q?Tn4q5p5hcbMQGrYI69jT+7FMUNBBAUhn9yTNTu3srb0h+DZnjJMGQrD2bgcS?=
 =?us-ascii?Q?IBEFtnDKl3cFz9gydLW9JrEiG4gZI3ERVDTycrx/rH4MMtmvYRVcvB74N5j1?=
 =?us-ascii?Q?bcq9uMjPvv0k3ox0Cdr4R+swbde3CdTPo+EQkpuzck1RtzWJZUcbVb6dtaxg?=
 =?us-ascii?Q?P8nHq55Ccs7VcEFovKDJBcmWacxMria3ZW3X0Ww3+kys1UDZmdTPoVsVB+iJ?=
 =?us-ascii?Q?niHtLk5ka5tZ1NCYmXnI5ZLtX/JAmwyiRs7ukmWDtY94V9r6PaPSToZNwH+T?=
 =?us-ascii?Q?KVBb4wViu5YkVCwTT5qBDVxbrn4ObkRZbLy/Mz0jmHhq5YCoAYwWKbIP0iXu?=
 =?us-ascii?Q?MjHUZrHTGyHhR3uNVWwMWawg8TRMaipHDI7hnyBEnhffVimgk4qniePyiFxh?=
 =?us-ascii?Q?nw54hS1wDLSx5zryyYcf3Lp3NJ0t6OjvtjT556nbFgaSHBQ=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ac70b093-6871-4fae-a8a2-08d89c6476fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 17:04:17.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2d1peUHsUXY1D6gpyXRkH3799Q0jv+eHXGFFF82psfvqJNR+maOZnmcOC7WnXIHFoHcTM6RkEUncG98E2SJyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0432
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=jayalakshmi.bhat@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am trying to create NETLINK socket for type NETLINK_AUDIT. Bind fails wit=
h error number 1. I have enabled capabilities CAP_NET_ADMIN, CAP_AUDIT_READ=
.
Can anyone please tell me what additional capabilities are needed?

Regards,
Jayalakshmi


