Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6027D6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgI2Tdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:33:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:52827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgI2Tde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601408009;
        bh=LACz1Prky4MmONxmw10GDUp4kVaA/QaOWNNS0asK8z4=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=EaHAqZoZ9vgWBfn3Z3HtL8dRd1bUG92qdszQNAV0O33/+mrNK6zhqSkVecQCP8q5c
         8QYQisFyeiO3zywOPI/p1dZNpzFfX8SZ4k5dleRkqZHx+dnvkMLWZFJjVHRwTqwD7N
         XkuCxDE0ScdY5K02swjn+Tif/4QnE1QJr01dxBBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.149.158]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1kgnAW18Rd-00tSqi; Tue, 29
 Sep 2020 21:33:29 +0200
Date:   Tue, 29 Sep 2020 21:33:27 +0200
From:   Helge Deller <deller@gmx.de>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: ftdi_sio: Fix serial port stall after resume
Message-ID: <20200929193327.GA13987@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:WwCbttWo164ecU2xU07tVn0sMXp75TV8SmfImIYaQlYRDq6Lxiu
 LD//FzIEzJDbOc1owFQFaWeguLBqGyE9JhUZAGv+0ruH46ZUarnXVtzWcAY38+nGEaKTjMZ
 a2TJbeS2FaApMqR+MfcWruCe3kt2QauqwVS/iCjo/woEaDBwBZ3yDJWIzcwbRnqFwUO5W4w
 Dxuwp5olNqdQZ0qZaxEvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6j723MT5f50=:iPtfXI3n5XaCmP4yxANpY9
 dfwu4eS7NolJya1/1BKKDdZae5EZRozoLBfbJ3RZ6+2vydrimlmvp7FFmahCzImAEvwxxlpyK
 tZtemXgz5CIBYSD9mjhdyiKJ9Q+vKjOnWHMZmNhgY+Srxoce6e9VKZUWXzZ0TjD7ypcusnIK7
 rzpm/Bl7cD+GphcyQejmCdRZzlW/yTayRzo+ecCn6a8Glb2MR800S013UZttYNDCzpNnHe3WK
 l0+k8+imrB0DbvAQ5jMtC1bwhMT+f9kYEF+RiCwSsbCQ4IbHClRqn3ImjPISQCVMSzBsYveT9
 Xb303R0m5tNTPNvEP8NmJtTOP1g41/O97CgIVhGcoXQW4LkgTW+sGjmAjQV3AMwRUbmcgecpP
 9/x4VfJgjMUUp/WnmujPRBB1ETD3v4vGerOic9Iw+U8V3tdBYI8MMKiXiXqGlbJzvWotyvXLA
 zzxQAyogAx2+w+hhAzt5ZA7alaW7wrv9VwwoYY5FgSmWsGSTK25tkFjKP3IEASnhYsxxTqYMr
 MaODNnbKwVxCHG0qyCelbFf7/f5TryLSJvsfuR4lkRSStc9YUwPU2kZMwfK6011ceocLVGL0I
 oVVeD/VY8Nw/iUnd0XlYw8zvjZH6MF5sAoeL5yTDJbpY+qpZZkLe65LryYCRC/RgJ3Sqm9j4h
 NVHMhD28yMUSwdMX73yj/p4/byk1wjQrT0at9NQQReU4JliQ7dB3kBoJtZ9jbpwyQM1Dquu4a
 zwzlJUqOcHOiLHtGjgukvOE/WnlPrL7XRBIWYxDlYSy4IPkNM0J+mrwWxanP0C0wgUoAt7Jkn
 igE3Wb/u0iac9369V4IIZNYo7McddUf5fFy9pRSHdnGFKNAOUXkjpRf2pPSRm87K0Op6U8DmV
 5i+X+ewFGvlqfJuFrSVY2D3JqYsX+Z+qVrx55wCrmgMTHWXBeILE2pB3BBRUeLN/ftP6Y4r5R
 vevpcxu1cw/mAhxfUjHR++UEdiT3nYcS18IByxgg9jkxTx7fGdfKhQjZucTNkT5sx6+3XrueW
 GQhxjOSBQglvdFYFxpJ+4iCMyT9bzsShkdgeZfcqaOktPnWkjnpMHA7pAWA63hrtGPGWpjgQD
 JDMZkUDzSp3X2neir+Dq74Hzac5Qil7OnSvGnyMDakrY/FxcP84zfzzd12falz+8d61qDlIlc
 DsxAjgJD5SVC3V2BdtMI6tIxyUSvOxyZmD7buJmzvo74rkqM1edtvk5l0Bt/9Up4jSZ9l6R5m
 1UtuUCm8eb5EbPHrJ
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a 4-port serial USB HUB with FT232BM chips the serial ports stop
working after a software suspend/resume cycle.
Rewriting the latency timer during the resume phase fixes it.

Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 9823bb424abd..8ee6cf6215c1 100644
=2D-- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1092,6 +1092,7 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud,=
 int base);
 static u32 ftdi_232bm_baud_to_divisor(int baud);
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
 static u32 ftdi_2232h_baud_to_divisor(int baud);
+static int ftdi_reset_resume(struct usb_serial *serial);

 static struct usb_serial_driver ftdi_sio_device =3D {
 	.driver =3D {
@@ -1122,6 +1123,7 @@ static struct usb_serial_driver ftdi_sio_device =3D =
{
 	.set_termios =3D		ftdi_set_termios,
 	.break_ctl =3D		ftdi_break_ctl,
 	.tx_empty =3D		ftdi_tx_empty,
+	.reset_resume =3D		ftdi_reset_resume,
 };

 static struct usb_serial_driver * const serial_drivers[] =3D {
@@ -2379,6 +2381,16 @@ static int ftdi_stmclite_probe(struct usb_serial *s=
erial)
 	return 0;
 }

+static int ftdi_reset_resume(struct usb_serial *serial)
+{
+	struct usb_serial_port *port =3D serial->port[0];
+
+	if (tty_port_initialized(&port->port))
+		write_latency_timer(port);
+
+	return usb_serial_generic_resume(serial);
+}
+
 static int ftdi_sio_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv =3D usb_get_serial_port_data(port);
