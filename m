Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF81DFD9F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgEXIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 04:10:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:55429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgEXIKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 04:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590307797;
        bh=Yh4A99YJCgkA9UbuO3RfCVtF8HiYdKwmMW3V19IImEM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UkZ5fwVEuQEPo519I9Bim3bwomLEMCwU16ReQvnBT1hYayPucK9Kd/yr2CyAsCfsP
         cttCbWQFQ+AwXocbrl/2yj2bOPxeQILT1EJ4VN6HvtCFnMNjIHAmeqNFd5LCOMtyGP
         ty0Qy/7xjEr6EN2mDa78Ajhq/ex8OuT/Dtbn6Sgc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MbAcs-1j1V0v2EQK-00bXzT; Sun, 24 May 2020 10:09:57 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH] drivers/irqchip: Remove function callback casts
Date:   Sun, 24 May 2020 10:09:10 +0200
Message-Id: <20200524080910.13087-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DPSzdRpyRux4A5kUtqLHMEMr9pHGkwQE+bKYyADNmfAZpC447sS
 BVR1oCo6gXQUg+ZC3B0H4u04qrR/36ilTAe4FoXmoduPjLqwXF8dgtNgUX7zQfXCaDLMl9U
 oz9L2o6IP2ZpdOHJ79dk10pmPl8bLERfuJOzdfmR/oZMiqlr7HgSMGiXXXPiKGSEveS1lFn
 hljV+i1ABOCLBauvj1Kcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2CgksPlfxEg=:lbVsvV8SCTgDDaPaOCYklz
 OyoJ6CqTZX6vsMElVRTIXKQwIb3GZdtmDPZDs9f/O/96geY1kGCEiqcYmC7CedcxyBpwFr2aX
 RCuQT4JR2Wyj0Wy70477E/I4TmTwLiu8gvL13Ep9+LjfMj+EWq8wyBXCQKGh0NAdT7ZM1trs1
 2H4f7T5JO1YBNnSJ4OazykSas5qGy1P/0F9GHi46HbHW0vHQ0QjfTmsXIfZzMNQIMh0CsXfI2
 na6JQTMFrQfAfwtR2To6AHhqdiPNGeVTnEWtd4FA3XPvr7S+1ryLSideOgaFmrnDGRhuxmNAI
 wdk73/mK63o/ucMKYgVTwcZO2rnsq7G9j9Fcb5vfPXtArZpdm5iUYYr9Qka6giv2Pokl8slQ/
 gXZWJBpcggcBpPJIEeKdXfryDuOiAgxWhRH7wzR3458FMyxgD/fZM27BqRLAGLd7ieLU/nmHo
 6JcfeCYyKqxoegB3iqbdPB8xjkPjxeMQ79nMf4/u2Fs4WQqe4/PcFZ3LqNf+vG3t24Mlxf+d2
 U6HoYDNSU7RRG7Gac9ZEFwc+jK6cKdHzhnXShBr5L57xBhQ83uLHjkH0oLuEbsONdVZeElBJh
 2ZsqJmwCJPcQn/t7v/EGCnMM659/FCkxRqTSuVNj+OVvQbrJqSxIkJo4/38eg6d656wTrUkn+
 PChQmeMS7PBLoIiuUPhqMPCEas/xFGR/sZ2dk0i8tMXurbIWxzHBthGtLghuJ3SuJFkuBawie
 yeIs2j2KjFvs4jZy/BmfJMg8BNWCx1UJXD9QS/sPF0b89IY0LSa6N2Fv2URQwOIvYCbz9Co5D
 yP75P5QmwF6bTFNune7Z37zG82/UhUwDxqrOmqwGbLmwMFZ8YXDtSg9b7sXzfRyGs1K8ihISy
 WB5h/sPxKrWwUleT+Vdn4YUFlXs29iwc7yFsvWUJzpAZDhPXpum+2IZOw8cSt+7xf/1O+RlHG
 RuhDlB7F8ERpxPd80LqKSuv99HmhUSkvHNiFv/q2WjvTrhnmES2Uy7T7aEsxaL5P4N/PmyRxm
 cWAMc5ng/qSMQ26ItQkTq+SfTLw9aWwqZSjxeftA0KqnxpZ0NRs7kHqq/GKDe4cy9i430bJbP
 qwkM8mxZpOcwCGgWbqA9xPu/LyYn6HZoUvdc+Iz/mm0eabzMqmXGQLiSsXrY6CW51kLz9eQ32
 MlsBGLENs4MZcXsYLBrpSsb7ilQnPGG160geMK6xFdZbEgCAaK7gv2CearH0mPtDkhCopX63C
 +sfOsXti/aMf+X76y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, remove all the function callback
casts.

To do this, modify the IRQCHIP_ACPI_DECLARE macro initializing the
acpi_probe_entry struct directly instead of use the existent macro
ACPI_DECLARE_PROBE_ENTRY.

In this new initialization use the probe_subtbl field instead of the
probe_table field use in the ACPI_DECLARE_PROBE_ENTRY macro.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 include/linux/irqchip.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 950e4b2458f0..1f464fd10df0 100644
=2D-- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -39,8 +39,14 @@
  * @fn: initialization function
  */
 #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
-	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
-				 subtable, validate, data, fn)
+	static const struct acpi_probe_entry __acpi_probe_##name	\
+		__used __section(__irqchip_acpi_probe_table) =3D {	\
+			.id =3D ACPI_SIG_MADT,				\
+			.type =3D subtable,				\
+			.subtable_valid =3D validate,			\
+			.probe_subtbl =3D (acpi_tbl_entry_handler)fn,	\
+			.driver_data =3D data,				\
+		}

 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
=2D-
2.20.1

