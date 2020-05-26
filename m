Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC571E0087
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgEXQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 12:23:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:41243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgEXQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590337362;
        bh=GhbaLbz6BoWoySPE2WrVRqo1Hs0zEpUCTqPaWcI0xwE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BmN0JpbSnv0GLBU/g6FHt+QEkAdwjigWwKVDOdNkMZUOghd6EoOoQyt09XDSCfLWo
         ffB2CcAfywPb/5UPM8H2Ij9CsdA6M4x1yhczmNYeFtfdYADQ++CRRbPF8tTqDa5Kyr
         5ea8MsSvdUtOePfvdOJ9IlWH4QEJxTTFEO1N84sE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MbAh0-1j1Lis1ZbE-00beoV; Sun, 24 May 2020 18:22:42 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH v2] drivers/irqchip: Remove function callback casts
Date:   Sun, 24 May 2020 18:22:20 +0200
Message-Id: <20200524162220.10186-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:et4o8Q6v0HWJb9s6cbtqw5ilkVjTdMIhGXcGmpZesYL/diDIHAw
 5twt75zNlwyDUAocjXlC3OTsqL+VakCZu09fks2op1KXjc+BVaq2N/zH97oebbgkCxc9bzc
 rTtFk1In3pZAxtcFyjZeIOowUyc7UdNSCf959pwJiF3obh4gZ7zXitIy7EfORKkzAcmU5B6
 qYlLxnH6IgEUgwMcVL6sA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u4eOC1hoWnQ=:J1YITlvQlifiCqL8IYQxo1
 EdKpfoFKSD4kAZEXm8BNjY0xaBaTGlpL1JJcuZgoZ6JNT2oyBcoUfdQE3iLny2aiaOlFzeMlx
 t1JG2GYbLIo9vodQJ13eygHsOMpu3WdO1PTIomvF8zGoyK+9XqrqY7Bin0VFIH3So9K+JJ84O
 G7f8BycFp9Bt0DPaOSRR7gG13OQ+tMp3isHjbLXAX6z/vsdr78zurvgaDIQHBsMRe4QzxsNkE
 ntyFtwuZpiHIKHcJNfblJ57h5333YUMpfU6c/Pq0M/1tYWLG+n6EWOHAmKYlEVM1+ezxYfEQd
 o7dxrUhIv6rEwIAOQr0XInxt2jVWyTBKjMCRCgwdgTUvF/Hds7VxfTFzzwTzAtubmzf+MRkXO
 CVX54z+FQpt1dKjU9d0RE/iHhnFzuStIEFy8CLmERKOX1sp/GFoSr8MLkM1bgWN/4teiwjxqZ
 SXDQJ/Lh0SWjKRCQDUaLkoKeeKKvI0DSpObkSWgvME7fsyy8iHrVJIRQoAmVvT2eobMA9MZrP
 jtSCLUe4nBHgXLwSdRXXm8uMKlkbaCigeiji7n7fVqGOvri4MLXAT6DaE82BR85F4wnxSnuuO
 gcEcSKZ4SnM5ECWc70J//QwfayLyUcE3scUQw8EXnHwJoeL/VEPHDDwbchHlPQB8LQB2ZVZTz
 egDLdS9p6UUGGPDjHXkGPSux+LnRijVyhInZ+4A1Ke0iZB7OtroG8MOpYfzgvl+sQIjJGe+WT
 No7mpJ9aSYiuytaWo1oAUuMy1mspigHVX+Oq8h5BVk37tPdXVE7EiGcGrPcra5eas93uOxNFU
 eMWyA3hO7UNyZX0GX9w4KFGbTW/joUesfN4b++bxDTgNMQ30cWcfYj4xo5lPHCjyphMEGJvHs
 6qM9Bia/ETOUdvIXFZw2vNpgaL3LWFQ61y7xYBY8Vv7uvoAzNYAkGDR0IsqSfEUJ3eCdfAK+b
 2ZxAsRmRq3P9uPXmaWCqwenfk94945zNTVo/IzH2umFuS1CmKj67CBoG5SzCspY5T2ck+g7vM
 ITg4jU93Ue8jXxQOW2vl9Rc4kJycwRcm63vHWc07V4ipHhqbPSxywWQCdnIidkDFyAmCmwYzR
 Bjs/XC5iq4VWyT2FWZo8SUDw9VzQRmDR84x1Dxq9HPdC/C5tJVObE2qmMu90q9K1PvILLHKSu
 XULrGJ3OI0NTprbzvYbh/5PpkM7JcCxhb+Z49hzWlsN9trwZ8DAdbfRqoP18L/5UsSO3g87R6
 8XqEHL1LSoorbWfHn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, remove all the function callback
casts.

To do this, create a new macro called ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
to initialize the acpi_probe_entry struct using the probe_subtbl field
instead of the probe_table field. Then, modify the IRQCHIP_ACPI_DECLARE
macro to use this new defined macro.

Even though these two commented fields are part of a union, this is
necessary to avoid function cast mismatches. That is, due to the
IRQCHIP_ACPI_DECLARE invocations use as last parameter a function with
the protoype "int (*func)(struct acpi_subtable_header *, const unsigned
long)" it's necessary that this macro initialize the probe_subtbl field
of the acpi_probe_entry struct and not the probe_table field.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Changelog v1->v2
- Add more details in the commit changelog to clarify the changes (Marc
  Zyngier)
- Declare a new macro called ACPI_DECLARE_SUBTABLE_PROBE_ENTRY (Marc
  Zyngier)
- In the IRQCHIP_ACPI_DECLARE use the new defined macro (Marc Zyngier)

 include/linux/acpi.h    | 11 +++++++++++
 include/linux/irqchip.h |  5 +++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d661cd0ee64d..fed49b276a90 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1154,6 +1154,17 @@ struct acpi_probe_entry {
 			.driver_data =3D data, 				\
 		   }

+#define ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(table, name, table_id,	\
+					  subtable, valid, data, fn)	\
+	static const struct acpi_probe_entry __acpi_probe_##name	\
+		__used __section(__##table##_acpi_probe_table) =3D {	\
+			.id =3D table_id,					\
+			.type =3D subtable,				\
+			.subtable_valid =3D valid,			\
+			.probe_subtbl =3D (acpi_tbl_entry_handler)fn,	\
+			.driver_data =3D data,				\
+		}
+
 #define ACPI_PROBE_TABLE(name)		__##name##_acpi_probe_table
 #define ACPI_PROBE_TABLE_END(name)	__##name##_acpi_probe_table_end

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 950e4b2458f0..447f22880a69 100644
=2D-- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -39,8 +39,9 @@
  * @fn: initialization function
  */
 #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
-	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
-				 subtable, validate, data, fn)
+	ACPI_DECLARE_SUBTABLE_PROBE_ENTRY(irqchip, name,		\
+					  ACPI_SIG_MADT, subtable,	\
+					  validate, data, fn)

 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
=2D-
2.20.1

