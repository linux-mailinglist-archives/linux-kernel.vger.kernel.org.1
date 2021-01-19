Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044462FB11C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 06:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404003AbhASFut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 00:50:49 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51933 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389808AbhASFOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:14:24 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 654B711E8;
        Tue, 19 Jan 2021 00:13:02 -0500 (EST)
Received: from imap5 ([10.202.2.55])
  by compute2.internal (MEProxy); Tue, 19 Jan 2021 00:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mxxn.io; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm1; bh=0spCGCoqY7KSGH8CarOZcNA+Cq
        9FEwb8V5as/niMdZs=; b=UFRKbJKYisucCyLX1gesl+FUldemdrorrD0TscO67A
        SxcAdG1vw9SdXswvyZCwE/EaHHFLonCXTv6chqe53uHfXsClmecN4XeNe/z0m5Xa
        xLsZn9vOjtaYZZA7318fdvkQyIruEsjahUfY3l806pTzDsv5Aeo7MEJYxEpEh6go
        S0sr2Ijoe+Ym1MrQNT7IoT/FW2v5qi2mCl5z2Lt0uns/mn9HT0t26NTJ8O4uNPLq
        D8cKMMpFm5sp8vhiOHHibwpPY63wx4b5GyME1IpNN1yU9fyNDa1MagNiYR+/xapb
        BsMAKcP2C0WGm6Pv4W9IRGZShyXVEpG07aXOtKf72HFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0spCGC
        oqY7KSGH8CarOZcNA+Cq9FEwb8V5as/niMdZs=; b=icJ7eWaGv656IdHEAV8AA/
        oyN7tUyJURpiCK3FjucdGEvjbPKrILvxo9fusRPSOaMwhlBKc4VuAbOZ575qKbbi
        udKRL8uVjedGruffUGwvMQHb6uM1PPoLCL0SoBR2q3EEtHMc0+NBPE+uOAhWkoM9
        Qcbr2mibvQRo+ewzNm8GUfgOFLu/T6QmpOKhz3JnUIq/DVXpOTWBuSa3p4ChUNbb
        qR6FeDB+zajIoA++P4D5Gtmf7bOm5yWFNMgdvLIf+yttPBxO2csZLMFSzLKjclNa
        J7NppR+6YyTYshTZEedib1g6GERbrOh3dS32OnQVH9ROTamZ5W3dHIxlH54dGe4w
        ==
X-ME-Sender: <xms:XWoGYIwK8c_g9sl9lJq1odeclKSPyDiZQ2GjyAyyiT7_qhMlxyMzYA>
    <xme:XWoGYMRhIYKjQDVqtB62-sC5As8zh5DDGL0RdcbKF0RFWx2OmK-SFIZ2_qJwYck_E
    1BZf_-F5yGi7aq7Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdelgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvufgtgfesthhqredtreerjeenucfhrhhomhepuehlrgkkpgfj
    rhgrshhtnhhikhcuoegslhgriiesmhiggihnrdhioheqnecuggftrfgrthhtvghrnhepvd
    etkeeludeiudduvdeijedvheevfffhveejveektdefieduudeffeevveelhfdvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghlrgiisehmgi
    ignhdrihho
X-ME-Proxy: <xmx:XWoGYKUQHXa0LOfEYSC5Uk3p1l8R-TWqYI6GIl5BtUt-LijmMnT-9g>
    <xmx:XWoGYGjAUxrQHTPuBtb5lMmncr46Sru0BuupPAPBlUslj6HUJ_ZWNQ>
    <xmx:XWoGYKAgqkDewB3hx41QZkHOAWu5XZwmquf1pHDGtjph8oEaXD95UA>
    <xmx:XmoGYFOCF0HrG7CQey2qedB3nVguKnJDKc8xQj-MW8Pvm2z2L6eNnQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 71F765C0099; Tue, 19 Jan 2021 00:13:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-45-g4839256-fm-20210104.001-g48392560
Mime-Version: 1.0
Message-Id: <b08d641c-3fb5-4845-85f7-e1753149cd7d@www.fastmail.com>
Date:   Tue, 19 Jan 2021 14:12:41 +0900
From:   =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>
To:     "Jean Delvare" <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: hwmon: (nct6683) Support ASRock boards.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with ASRock X570 Phantom Gaming-ITX/TB3. It also appears
on other ASRock boards.

Signed-off-by: Bla=C5=BE Hrastnik <blaz@mxxn.io>
---
 Documentation/hwmon/nct6683.rst | 1 +
 drivers/hwmon/nct6683.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/hwmon/nct6683.rst b/Documentation/hwmon/nct66=
83.rst
index 8646ad519..2e1408d17 100644
--- a/Documentation/hwmon/nct6683.rst
+++ b/Documentation/hwmon/nct6683.rst
@@ -61,5 +61,6 @@ Board		Firmware version
 Intel DH87RL	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DH87MC	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DB85FL	NCT6683D EC firmware version 1.0 build 04/03/13
+ASRock X570	NCT6683D EC firmware version 1.0 build 06/28/19
 MSI B550	NCT6687D EC firmware version 1.0 build 05/07/20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index 7f7e30f0d..a23047a3b 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -169,6 +169,7 @@ superio_exit(int ioreg)
 #define NCT6683_CUSTOMER_ID_INTEL	0x805
 #define NCT6683_CUSTOMER_ID_MITAC	0xa0e
 #define NCT6683_CUSTOMER_ID_MSI		0x201
+#define NCT6683_CUSTOMER_ID_ASROCK		0xe2c
=20
 #define NCT6683_REG_BUILD_YEAR		0x604
 #define NCT6683_REG_BUILD_MONTH		0x605
@@ -1225,6 +1226,8 @@ static int nct6683_probe(struct platform_device *p=
dev)
 		break;
 	case NCT6683_CUSTOMER_ID_MSI:
 		break;
+	case NCT6683_CUSTOMER_ID_ASROCK:
+		break;
 	default:
 		if (!force)
 			return -ENODEV;
--=20
2.29.2

