Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC4301DD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 18:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbhAXRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 12:06:43 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:18734 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbhAXRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 12:06:38 -0500
Date:   Sun, 24 Jan 2021 17:05:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611507955;
        bh=hjSZRwhUTaBCIu8THUWGJXntz0w+/mbDwBQlNpsJTYw=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=XClmiAgksbhZw+/K68YnBV2mV20s6IOr1JWywswHQd5DGPnLUj7wfKdsJRXzpxnD4
         AvbDctikA7UPYnhrjcGFcEk0L6/zOOOLt+LR5Yqv16tVEvt+DrB5Ibd6rdAgmCuS4V
         5Brxw96Q4XUwNcm5zbXswYyccW/h3TuI89lOb+3o=
To:     Lee Jones <lee.jones@linaro.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH] mfd: max8997: Replace 8998 with 8997
Message-ID: <20210124170528.1230932-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace occurrences of 8998 with 8997.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 include/linux/mfd/max8997.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/max8997.h b/include/linux/mfd/max8997.h
index e955e2f0a2cc..6c98edcf4b0b 100644
--- a/include/linux/mfd/max8997.h
+++ b/include/linux/mfd/max8997.h
@@ -14,13 +14,13 @@
  * others and b) it can be enabled simply by using MAX17042 driver.
  */
=20
-#ifndef __LINUX_MFD_MAX8998_H
-#define __LINUX_MFD_MAX8998_H
+#ifndef __LINUX_MFD_MAX8997_H
+#define __LINUX_MFD_MAX8997_H
=20
 #include <linux/regulator/consumer.h>
=20
 /* MAX8997/8966 regulator IDs */
-enum max8998_regulators {
+enum max8997_regulators {
 =09MAX8997_LDO1 =3D 0,
 =09MAX8997_LDO2,
 =09MAX8997_LDO3,
@@ -207,4 +207,4 @@ struct max8997_platform_data {
 =09struct max8997_led_platform_data *led_pdata;
 };
=20
-#endif /* __LINUX_MFD_MAX8998_H */
+#endif /* __LINUX_MFD_MAX8997_H */
--=20
2.25.1


