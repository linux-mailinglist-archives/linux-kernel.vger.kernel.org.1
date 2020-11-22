Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3522BC763
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 18:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgKVRIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 12:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgKVRIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 12:08:38 -0500
Received: from localhost.localdomain (unknown [157.51.147.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330AD20760;
        Sun, 22 Nov 2020 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606064917;
        bh=6Kt7IBsktKXGsOCAQ+huvPZvZdPHOmlONpngR1NbzSk=;
        h=From:To:Cc:Subject:Date:From;
        b=YJm5CHvTrRn6sAjo2vtnZ87iCSK7f2XtgQkNC39z6EjC4HgOk1bZBkSIf4J9hGjS1
         3dhQ1DATDjXXAaVDlTLIoP+PYox/xTqESTyPCuRzY8CaV70rGfEXALmAO/4pHwZK1y
         7mgoJqbvIZxKvVIkrCJ1vXgdykSq+fyzfYQZ/two=
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, angelo.dureghello@timesys.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/3] Add support for MaxLinear/Exar USB to serial converters
Date:   Sun, 22 Nov 2020 22:38:19 +0530
Message-Id: <20201122170822.21715-1-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Hello,

This series adds support for MaxLinear/Exar USB to serial converters.
This driver only supports XR21V141X series but it can easily be extended
to other series in future.

This driver is inspired from the initial one submitted by Patong Yang:
https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop

While the initial driver was a custom tty USB driver exposing whole
new serial interface ttyXRUSBn, this version is completely based on USB
serial core thus exposing the interfaces as ttyUSBn. This will avoid
the overhead of exposing a new USB serial interface which the userspace
tools are unaware of.

This series has been tested with Hikey970 board hosting XR21V141X chip.

NOTE: I've removed all reviews and tested-by tags as the code has gone
through substantial rework. Greg, Linus, Mauro please consider reviewing
again.

Thanks,
Mani

Changes in v5:

* Incorporated review comments from Johan. Noticeable ones are:
  - Made serial and gpiolib support exclusive and used mutex to avoid
    race. The gpio requests from gpiolib will be rejected when serial
    port is in use.
  - The driver only binds to data interface but claims both control and
    data interface.
  - Handled B0 request
  - Removed all reviews as the code has gone through substantial rework.

Changes in v4:

* Multiple improvements based on Johan's review. Noticeable ones are:
  - Now the driver claims both control and data interfaces but only registers
    tty device for data interface.
  - GPIO pin status is now shared between the console and gpiolib
    implementations. This is done to avoid changing the lines spuriously.
  - A separate port_open flag is added to reject GPIO requests while the tty
    port is open.
  - Removed padding PID to gpio device.
* Added Greg and Mauro's review and tested tags.
* Included a patch from Mauro to avoid the CDC-ACM driver to claim this device
  when this driver is built.

Changes in v3:

* Dropped the check for PID and also the reg_width property.

Changes in v2:

* Dropped the code related to handling variable register size. It's all u8 now.
* Dropped the header file and moved the contents to driver itself.
* Added Linus's reviewed-by tag for gpiochip patch.
* Added PID to gpiochip label
* Dropped gpiochip for interface 0

Manivannan Sadhasivam (2):
  usb: serial: Add MaxLinear/Exar USB to Serial driver
  usb: serial: xr_serial: Add gpiochip support

Mauro Carvalho Chehab (1):
  usb: cdc-acm: Ignore Exar XR21V141X when serial driver is built

 drivers/usb/class/cdc-acm.c    |   6 +
 drivers/usb/serial/Kconfig     |   9 +
 drivers/usb/serial/Makefile    |   1 +
 drivers/usb/serial/xr_serial.c | 854 +++++++++++++++++++++++++++++++++
 4 files changed, 870 insertions(+)
 create mode 100644 drivers/usb/serial/xr_serial.c

-- 
2.25.1

