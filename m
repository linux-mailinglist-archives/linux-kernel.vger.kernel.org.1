Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3B2FD289
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbhATOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:21:34 -0500
Received: from thsbbfxrt02p.thalesgroup.com ([192.93.158.29]:52164 "EHLO
        thsbbfxrt02p.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732961AbhATNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:00:56 -0500
X-Greylist: delayed 658 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2021 08:00:54 EST
Received: from thsbbfxrt02p.thalesgroup.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 4DLQM46jPHzJpW1;
        Wed, 20 Jan 2021 13:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
        s=xrt20181201; t=1611146944;
        bh=mYgwiqx2vpikRS4hPuojXriHJZh9TkQLeiD6+yTQyeY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:From;
        b=clziWE5brbNN8b6aCWpFC26jwUKL1KtQ6JoFvIBZNiz0IvKoqQS617IIVOy3v7qeF
         09/owP1bV5tPeAhHrj0MCT1GRcE1NmRfMO33h57ojiCQMxMN+DK8UXI2Rjr3xfchvr
         HRysD8xp+qyh5ReJm35QI4WS1Z1s0KdzTia+CrjmmBVfTDmiUTlaNXSmd7L0QrJnHR
         FCB0JbWoxgauQFIfuU5NDMciVFnfChXgFJ7z5lS/lucX/VvYs7eyobue3pB6JWVsBe
         kK5aSH+FWkZuswoMPPxTp8JJIHP3FOB8cIoPFWnzO7i0c7QMbZiUzRWOo9SPftX+8S
         Do7/WK+4VMJhg==
X-MTA-CheckPoint: {600826C0-0-C52F090A-C0A}
Authentication-Results: thsbbfxss01p.thalesgroup.com;
        dkim=pass (1024-bit key; unprotected) header.d=thalesgroup.onmicrosoft.com header.i=@thalesgroup.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-thalesgroup-onmicrosoft-com header.b=6c50wiBV;
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNnfBt6Xfc+WLRioleFkRZwL395zxIl6aRVWaOstMOzxD6K28XaEgTXVgoT2q2JMhKYT56fOt5nr4v3D0Ubge348VVn8TOSA2FRihZXiIg/FsKb+pnhE8fSIznLR2DW+NVVFSWAT/BoDuyOL3CGv3F51jMxhwvbPqwHpfKDIQrkd/pcHNrmf2vLLKBZONXNAfheCDo2FRwf3NkOI4/VgXlR152j43bCwC99sZSrQTUzjBy4i/r48K9gqL03g+4SIEU6saFOO+xRbwRiB09B5+No1xHoYXpKzVPUkbghVy5wi6J2n6DrDflxGLXN7RZpdLtzAJH6VsyXRMGBN1c3rbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYgwiqx2vpikRS4hPuojXriHJZh9TkQLeiD6+yTQyeY=;
 b=UC6M/2S+A1ZMiZL2CCYOnIR7DKMO4HlbsHOSxuus7rsbqoXgNPQn8koPtKsN+T3pk5iIBCFDDGGy/deotb/JahrRY8CK69XtZirkZCqfKZNl+OtPpA4fz02OoQauFC51z4b/6PSTQRHlBO++RVcikqFXFiqh5UsuRHZbSXxnO1xbKxmzdxKcVhlOlCAtB2fnWnMV0I/4NkFvPnYe49rSl8tghT6dtZvdP3ee636Ko/TZrszWfZtGnjRd2yMgW1W+1ky84ciynoPu4zhSyeJuo7k7tOjQnpLKy2KxiH3YXAkPE4g8wOFlQFVm5t0rSupSMr2eFH1W3k+1cYLEi8v+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thalesgroup.com; dmarc=pass action=none
 header.from=thalesgroup.com; dkim=pass header.d=thalesgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thalesgroup.onmicrosoft.com; s=selector2-thalesgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYgwiqx2vpikRS4hPuojXriHJZh9TkQLeiD6+yTQyeY=;
 b=6c50wiBV7neHBIeaQXIlfchleDfRs6T0N/vanGllqNjaqzln+Hb9H4zNb86aGSVsHI6xU8NAor0ODSLl4dIvTpO91F9iR6zgWnojhWplGz9XjjJ07gzosXh+LBhibfcCIYZB4110BDFqU4W3h62WLtjZQZ1sjajtap6U2EPZt/w=
From:   SCHEMMEL Hans-Christoph <hans-christoph.schemmel@thalesgroup.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: serial: option: Adding support for Cinterion MV31
Thread-Topic: [PATCH] USB: serial: option: Adding support for Cinterion MV31
Thread-Index: AdbvKnwKUWr6nTzLRJ+5Hmbj8D916A==
Date:   Wed, 20 Jan 2021 12:49:02 +0000
Message-ID: <PAYP264MB10254F44F1B0DA6A7797E78BAEA20@PAYP264MB1025.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=thalesgroup.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36fa7f9e-32f7-4ffc-07a8-08d8bd41c39d
x-ms-traffictypediagnostic: PAYP264MB1044:
x-microsoft-antispam-prvs: <PAYP264MB104427535B04E71DD874129BAEA20@PAYP264MB1044.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9yC5R+ifWNDD+kfiwJDYlV5Vs3umE+E3cBQcgqQWsSHnGk23OTgxtGJ5i8EgZ5sPXHGFKijLssABlUmw8sMu/2IJP7eEtGsGnhv4qbDTUVTj9l6I9QdS5qJ4jujWBlTDezJ/HD4+Dv7/CTWJ903tL1uMnD3vKyYT/uA8YlhJMDwpjDDCw/ot9F9P0MHbNQACAw7TiL7rIXvDolM46wzZ0QXcNrq56qRoIbHt+toASUhhXWGij9SuddFhZ9hxfHuIHA8TzadtQN9mjN1HdHYowvpqKK1GZ7EgTYsSkVLCKmONRpCJDaLWc5avf8Ad5nguKrCgnWVTBWhGto98IB+/qGqScAwZ6XFoOrbOHX7AdmN3f2XhQGJgXlTcYwPpqQBQogStWOumAgYm+hxxda+QhsfK5Sbonin6i6ZcHRAjdQGQq675g4mVDa0Je4s5ywg2Wv8HuDIWumYpAyEa3v4grf4WJlCLvMTqBPIZqEXFEaKQ2dmCvMMtaktJGPYkpOST+g4BmJ5v0D1HKo70mpUog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB1025.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(66616009)(71200400001)(64756008)(66476007)(66556008)(33656002)(52536014)(99936003)(66446008)(86362001)(5660300002)(316002)(4326008)(7696005)(76116006)(55016002)(6916009)(478600001)(186003)(8936002)(26005)(8676002)(6506007)(9686003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?18NkZTRQBVBYESH0qMmOGoaThPXjKoscN4c2EMHFVYuw6N6iJrdI8KbWwC5b?=
 =?us-ascii?Q?pSaV9xwCqSrhSDB3bECYyiADzXZK1B0mQfYrnI+3ZpDWbUu62P8q7H3uS809?=
 =?us-ascii?Q?i6YzkPx/i5PRxSO05TeODNsCon4wxsVg1lvUTBWAZIxwRjyld0ldSQFzzb9k?=
 =?us-ascii?Q?N1qCWI8SXLX+Nx8OL9as797NE+P0VI7oCLweQtcjH8PMTBe7eUKTKatJr4G5?=
 =?us-ascii?Q?w0VZXOz7uPP5jouHb9qtw++1p+HUqzhxN8VKZjOUxaZOGAaamO1heeCuM2mg?=
 =?us-ascii?Q?tphYsQ8iUXimdxIIsWppJ5EjSZD4zRO9wNPv70aXapGsUA1mX6HaR9TA5SqE?=
 =?us-ascii?Q?DKnKOXIjoA6osEcZbiXooXiLo9qzRae2JKU1wjptbBNyR4UecunuB3/v+S+V?=
 =?us-ascii?Q?whIX0vszNrjwixQ72qrawuiJS7kvQ1e1jgkmdmrEw8p3oxd7rS5DJKItW6FR?=
 =?us-ascii?Q?seW5G5gy7FHpFcaKvSDEKnf4Sk4unSM9rgTEhHnJA+Cy2tm20SVf7qC3F+22?=
 =?us-ascii?Q?WLMOuPvdzr/679Tqa7IJW5ZEjkchvbvUwj7eXudXwPs12YWT4J+b2dfk/333?=
 =?us-ascii?Q?gDfYOdlbNYSqKzKTTU0b0G2ZfnuaWq2mckiTQ178Nc4ewFZkZB/oszRlvSXy?=
 =?us-ascii?Q?heGQtTg0lSGGL3CsIZPGLwZheYrjFIVUnNHWs2L/YRQyAFPocAPC2qHDtc5S?=
 =?us-ascii?Q?9XEFQVdR9p1oz7q2o6n1cBWwltRfmwiiM8uGg3TKlE8jLaSHCmFpxiOOIh2V?=
 =?us-ascii?Q?DqzYCO92ibn7IfPdaAZyycbKqsccKeFdH6jruHRBaYluErpTYtXJOXY3gZYU?=
 =?us-ascii?Q?OOKEmiwR11sES8CVCWZYiz27Eh0BApCJSsh2tGAoVtfcab+4Y1WnsULlI/Bs?=
 =?us-ascii?Q?y+/xZ0XhchVSe7lCKsFRNCKFMvQN3VoZYubAmxvcpQhuwMGrxaMZsJFr25zo?=
 =?us-ascii?Q?a05zJcLznN5XAIdq2gXdWz8ek8pcY4VlW+Q7ZWK9xWU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_000A_01D6EF33.016D9E20"
MIME-Version: 1.0
X-OriginatorOrg: Thalesgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB1025.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fa7f9e-32f7-4ffc-07a8-08d8bd41c39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 12:49:02.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e603289-5e46-4e26-ac7c-03a85420a9a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCPCz/N3Zgq3KtyF6AitlM5+nxCuc0S54X4a6ee8XJl0Gm66byk1P9Bl2sSr1uiv+JiuexwVeraVqqhjGWL2XWfy7xVHqHlFn+bwYs9hZFCqv51xDwW5N2xEj6ga7/QD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB1044
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2021.1.20.123919, AntiVirus-Engine: 5.79.0, AntiVirus-Data: 2021.1.20.5790001
X-Sophos-SenderHistory: ip=104.47.24.101,fs=42514,da=59861474,mc=927,sc=0,hc=927,sp=0,fso=59729860,re=72,sd=0,hd=30
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_10000_PLUS 0, DKIM_SIGNATURE 0, DQ_S_H 0, KNOWN_MTA_TFX 0, NO_CTA_URI_FOUND 0, NO_URI_HTTPS 0, SPF_SOFTFAIL 0, SXL_IP_TFX_WM 0, WEBMAIL_SOURCE 0, WEBMAIL_XOIP 0, WEBMAIL_X_IP_HDR 0, __ANY_URI 0, __ARCAUTH_DKIM_PASSED 0, __ARCAUTH_DMARC_PASSED 0, __ARCAUTH_PASSED 0, __ARC_SEAL_MICROSOFT 0, __ARC_SIGNATURE_MICROSOFT 0, __ATTACHMENT_SIZE_10_25K 0, __AUTH_RES_DKIM_PASS 0, __BODY_NO_MAILTO 0, __CC_NAME 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __DQ_IP_FSO_LARGE 0, __DQ_NEG_HEUR 0, __DQ_NEG_IP 0, __DQ_S_HIST_1 0, __DQ_S_HIST_2 0, __DQ_S_IP_100K 0, __DQ_S_IP_1MO 0, __DQ_S_IP_2D 0, __DQ_S_IP_MC_100_P 0, __DQ_S_IP_MC_10_P 0, __DQ_S_IP_MC_1_P 0, __DQ_S_IP_MC_5_P 0, __DQ_S_IP_RE_99_L 0, __DQ_S_IP_SP_0_P 0, __FROM_NAME_NOT_IN_BODY 0, __FUR_RDNS_OUTLOOK 0, __HAS_ATTACHMENT 0,
 __HAS_ATTACHMENT1 0, __HAS_ATTACHMENT2 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_XOIP 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_TEXT_P2 0, __MIME_VERSION 0, __MULTIPLE_RCPTS_CC_X2 0, __NO_HTML_TAG_RAW 0, __PHISH_SPEAR_SUBJ_TEAM 0, __RDNS_WEBMAIL 0, __SANE_MSGID 0, __SEXTORTION_PORN 0, __SUBJ_ALPHA_END 0, __SUBJ_STARTS_S_BRACKETS 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC 0, __TO_REAL_NAMES 0, __URI_MAILTO 0, __URI_NO_WWW 0, __URI_NS '
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_000A_01D6EF33.016D9E20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adding support for Cinterion device MV31 for enumeration with PID 0x00B3 and
0x00B7.

usb-devices output for 0x00B3
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=1e2d ProdID=00b3 Rev=04.14
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00B3 USB Mobile Broadband
S:  SerialNumber=b3246eed
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=cdc_wdm
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option



usb-devices output for 0x00B7
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=1e2d ProdID=00b7 Rev=04.14
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00B3 USB Mobile Broadband
S:  SerialNumber=b3246eed
C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option


Signed-off-by: Hans-Christoph Schemmel
<hans-christoph.schemmel@thalesgroup.com>

--- drivers/usb/serial/option.c.orig
+++ drivers/usb/serial/option.c
@@ -425,6 +425,8 @@ static void option_instat_callback(struc
 #define CINTERION_PRODUCT_AHXX_2RMNET		0x0084
 #define CINTERION_PRODUCT_AHXX_AUDIO		0x0085
 #define CINTERION_PRODUCT_CLS8			0x00b0
+#define CINTERION_PRODUCT_MV31_MBIM             0x00b3
+#define CINTERION_PRODUCT_MV31_RMNET            0x00b7
 
 /* Olivetti products */
 #define OLIVETTI_VENDOR_ID			0x0b3c
@@ -1914,6 +1916,10 @@ static const struct usb_device_id option
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC25_MDMNET) },
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC28_MDM) }, /*
HC28 enumerates with Siemens or Cinterion VID depending on FW revision */
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC28_MDMNET) },
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID,
CINTERION_PRODUCT_MV31_MBIM, 0xff),
+	  .driver_info = RSVD(3)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID,
CINTERION_PRODUCT_MV31_RMNET, 0xff),
+	  .driver_info = RSVD(0)},
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD100),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD120),

------=_NextPart_000_000A_01D6EF33.016D9E20
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
c2dyb3VwLmNvbTEYMBYGCgmSJomT8ixkAQEMCFQwMjE1MjIwMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEArDrHfip5J4G25AWZAasmGKINnXKG4XEiNzMeckU4mweDhgsrLF+XrffjxFq6
B21mtdCdhlgDbUZ8u++CwQJLn+Y4k4+OQ6nb/ljQxi8uuo1DYRQ+K+y9cYrAN9DfJ+p2AocjtTJA
O3CXV6rThX3TlfCRU9QjAw3WDzOw5zV1ROPkFYGz5CRp4Kk1Uqtgr+OoM74uWvtsz+RXQfZHBbEJ
XUA58HqfZjKLz5gEtMmpVzn9leY92CX88bMZjXqbO8iaHkAAJEZ6MTwTxTiJmD6RNbNEM2fGL6r0
bZayVMHu5PmRXqSzvLNoFc9aeaOqgdxUOJTgYlrRPX1CXOwVUFRu1QIDAQABo4ICGTCCAhUwHQYD
VR0OBBYEFLjOPumMUjJUJVxkG3TXXJ6ECKtJMB8GA1UdIwQYMBaAFEWQlf+ZXdIHjbMS9u3yKDSS
W9uBMIHaBgNVHSAEgdIwgc8wgcwGByqBegFsAQMwgcAwOwYIKwYBBQUHAgEWL2h0dHA6Ly93d3cu
dGhhbGVzZ3JvdXAuY29tL2NlcnRpZmljYXRpb25fcG9saWN5MIGABggrBgEFBQcCAjB0GnJNb3Jl
IGluZm9ybWF0aW9uIG9uIHRoZSBUaGFsZXMgQ2VydGlmaWNhdGUgUG9saWN5IGNhbiBiZSBmb3Vu
ZCBhdCBodHRwOi8vd3d3LnRoYWxlc2dyb3VwLmNvbS9jZXJ0aWZpY2F0aW9uX3BvbGljeSAwHwYD
VR0lBBgwFgYIKwYBBQUHAwQGCisGAQQBgjcKAwEwDgYDVR0PAQH/BAQDAgbAMDIGA1UdEQQrMCmB
J2hhbnMtY2hyaXN0b3BoLnNjaGVtbWVsQHRoYWxlc2dyb3VwLmNvbTBCBgNVHR8EOzA5MDegNaAz
hjFodHRwOi8vY3JsLnRoYWxlc2dyb3VwLmNvbS9UaGFsZXNJbnRlcm5hbENBVjMuY3JsME0GCCsG
AQUFBwEBBEEwPzA9BggrBgEFBQcwAoYxaHR0cDovL2NybC50aGFsZXNncm91cC5jb20vVGhhbGVz
SW50ZXJuYWxDQVYzLnA3YzANBgkqhkiG9w0BAQsFAAOCAgEAHCsVI6198E+o0RTRIsKVdfSTDwz9
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
AAGjggJDMIICPzAdBgNVHQ4EFgQUk1k1pvXJifLzRA6r0HW2vXhWBfowHwYDVR0jBBgwFoAURZCV
/5ld0geNsxL27fIoNJJb24EwgdoGA1UdIASB0jCBzzCBzAYHKoF6AWwBAzCBwDA7BggrBgEFBQcC
ARYvaHR0cDovL3d3dy50aGFsZXNncm91cC5jb20vY2VydGlmaWNhdGlvbl9wb2xpY3kwgYAGCCsG
AQUFBwICMHQack1vcmUgaW5mb3JtYXRpb24gb24gdGhlIFRoYWxlcyBDZXJ0aWZpY2F0ZSBQb2xp
Y3kgY2FuIGJlIGZvdW5kIGF0IGh0dHA6Ly93d3cudGhhbGVzZ3JvdXAuY29tL2NlcnRpZmljYXRp
b25fcG9saWN5IDBJBgNVHSUEQjBABggrBgEFBQcDBAYKKwYBBAGCNwoDAQYKKwYBBAGCNwoDBAYI
KwYBBQUHAwUGCCsGAQUFBwMGBggrBgEFBQcDBzAOBgNVHQ8BAf8EBAMCBDAwMgYDVR0RBCswKYEn
aGFucy1jaHJpc3RvcGguc2NoZW1tZWxAdGhhbGVzZ3JvdXAuY29tMEIGA1UdHwQ7MDkwN6A1oDOG
MWh0dHA6Ly9jcmwudGhhbGVzZ3JvdXAuY29tL1RoYWxlc0ludGVybmFsQ0FWMy5jcmwwTQYIKwYB
BQUHAQEEQTA/MD0GCCsGAQUFBzAChjFodHRwOi8vY3JsLnRoYWxlc2dyb3VwLmNvbS9UaGFsZXNJ
bnRlcm5hbENBVjMucDdjMA0GCSqGSIb3DQEBCwUAA4ICAQBJscb4e8apsuChI1JT0qhnUzkkizpo
iGPONutwq5XS47uZNmGVyOWBM/RBW8QGQF20OMCm2J0xXDnHMqaLzUexvenQMFFnZ/vqaTJ0TA0v
KGLso2hrYxtrOgj4xtv4qqQgRojS43B0Us0tdW9naILplXT+XqdNYoO9b/3D0If4QP691o9OKnNq
lCvIFjCDOUNl8XMHwapEkGRwCnPzBTnmYGCJHh/NqMdtQqT62gxmRXQbqbXCAH3d02Idywz281sL
htOAP8PbDKVMbn613MF78k9Z+Px0ni7VtsVJrMdgHjcS2gpEw0V7Jhsp36pinLymuwbp+u2IZAqI
uJFkSceKHp0WGDLteN6pU81V7udyrrXh1FoGMEowOVNrlJrUSvJNg4VLI+SwQbNmAKO7t1+KPjbs
MmvyP11S3XUmlwX2FmzCO/OV1PQQJRQhb/DeJQRkM4U98UscisaBvH3A6KFQPcuq4fc2CowK0TPL
krkWAgwQclA8thJJybUnMDR4ST8Ptez0cuIK9zpLDoxdfJiT9Gp4zYopCvV4nTG+tfiIhxNNPqaZ
2qGnENPwN5oi1qTY1stsPnYpvON2WFUey8i5DdcQNicZRhnwDErYn3v9fMH0NFcDfj3SwiBiIPXK
MpM0yiCGYcgZteINbve8LiyPHIE0/6kYNqwKlcMz/dDBjzGCA1wwggNYAgEBMF4wVzELMAkGA1UE
BhMCRlIxDzANBgNVBAoMBlRoYWxlczEXMBUGA1UECwwOMDAwMiA1NTIwNTkwMjQxHjAcBgNVBAMM
FVRoYWxlcyBJbnRlcm5hbCBDQSBWMwIDBwAbMAkGBSsOAwIaBQCgggHTMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDEyMDEyNDkwMFowIwYJKoZIhvcNAQkEMRYE
FCA+1fqVQUxEPqxF5Yez5UxR64oOMG0GCSsGAQQBgjcQBDFgMF4wVzELMAkGA1UEBhMCRlIxDzAN
BgNVBAoMBlRoYWxlczEXMBUGA1UECwwOMDAwMiA1NTIwNTkwMjQxHjAcBgNVBAMMFVRoYWxlcyBJ
bnRlcm5hbCBDQSBWMwIDBwAXMG8GCyqGSIb3DQEJEAILMWCgXjBXMQswCQYDVQQGEwJGUjEPMA0G
A1UECgwGVGhhbGVzMRcwFQYDVQQLDA4wMDAyIDU1MjA1OTAyNDEeMBwGA1UEAwwVVGhhbGVzIElu
dGVybmFsIENBIFYzAgMHABcwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJ
KoZIhvcNAQEBBQAEggEAnzcsRWBcV26wq+bogSNyfA8vgFgCH0w0FDotSQG4FZNQ3wQfPlm4bmAY
Is3NR/Z5xLrla9UtDuZF+szDYMbnZopCJb0a7sc6JuJbLuoSIaqXa32HUSDQLYpme6EGnxvguPas
3STIgOYH1qhdpzCH6i7KlIdGJJk/DMi9k6e+117/sA2RhgP/H5u/gYazXlaiMsAsYB95lxGCCQsM
uAbwlB22jU7Lx4iPINt+qRzJuz9oGibmXjRdFftPUoqan4isDj7fcenbJJpJvH8nbRvEi+m/hFLq
yhu/51aMnbq1FYtqrFc6qJyBo/QdWr+hr7IBb0Gs3Vijq8iucMkxeZcnbQAAAAAAAA==

------=_NextPart_000_000A_01D6EF33.016D9E20--
