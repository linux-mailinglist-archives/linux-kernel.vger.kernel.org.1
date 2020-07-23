Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5422B95C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 00:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgGWW2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 18:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgGWW2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:28:40 -0400
Received: from embeddedor (unknown [201.162.245.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FD02068F;
        Thu, 23 Jul 2020 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543320;
        bh=vEQT3A/LyWK0mCM6I3RuObtccYEPnb7mjm5wXCVWyp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCpMfClVTRYfL4rYzlR7/UKOw5LPuNSG6D2ABHedyHp54ei5DwGHtS9gmNLYYxT39
         iLBFiufoZW9+Iq5AxowU7pNYr8EXAD/IpWZ/WJH/Fu0yJOReeptngQaPzgxosI2Lsb
         X73HP9g+erLqHgpsYtQi4g+hWCOfpQ7+LjidEkK8=
Date:   Thu, 23 Jul 2020 17:34:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/3] tty: Use the preferred form for passing the size of a
 structure type
Message-ID: <b04dd8cdd67bd6ffde3fd12940aeef35fdb824a6.1595543280.git.gustavoars@kernel.org>
References: <cover.1595543280.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595543280.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the preferred form for passing the size of a structure type. The
alternative form where the structure type is spelled out hurts
readability and introduces an opportunity for a bug when the object
type is changed but the corresponding object identifier to which the
sizeof operator is applied is not.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/tty/tty_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 629fbafc9b7e..ceed72c9a88f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1405,7 +1405,7 @@ void tty_save_termios(struct tty_struct *tty)
 	/* Stash the termios data */
 	tp = tty->driver->termios[idx];
 	if (tp == NULL) {
-		tp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
 		if (tp == NULL)
 			return;
 		tty->driver->termios[idx] = tp;
@@ -2489,7 +2489,7 @@ static int tty_tiocsserial(struct tty_struct *tty, struct serial_struct __user *
 	struct serial_struct v;
 	int flags;
 
-	if (copy_from_user(&v, ss, sizeof(struct serial_struct)))
+	if (copy_from_user(&v, ss, sizeof(*ss)))
 		return -EFAULT;
 
 	flags = v.flags & ASYNC_DEPRECATED;
@@ -2507,11 +2507,11 @@ static int tty_tiocgserial(struct tty_struct *tty, struct serial_struct __user *
 	struct serial_struct v;
 	int err;
 
-	memset(&v, 0, sizeof(struct serial_struct));
+	memset(&v, 0, sizeof(v));
 	if (!tty->ops->get_serial)
 		return -ENOTTY;
 	err = tty->ops->get_serial(tty, &v);
-	if (!err && copy_to_user(ss, &v, sizeof(struct serial_struct)))
+	if (!err && copy_to_user(ss, &v, sizeof(v)))
 		err = -EFAULT;
 	return err;
 }
@@ -2705,7 +2705,7 @@ static int compat_tty_tiocsserial(struct tty_struct *tty,
 	struct serial_struct v;
 	int flags;
 
-	if (copy_from_user(&v32, ss, sizeof(struct serial_struct32)))
+	if (copy_from_user(&v32, ss, sizeof(*ss)))
 		return -EFAULT;
 
 	memcpy(&v, &v32, offsetof(struct serial_struct32, iomem_base));
@@ -2743,7 +2743,7 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
 			0xfffffff : ptr_to_compat(v.iomem_base);
 		v32.iomem_reg_shift = v.iomem_reg_shift;
 		v32.port_high = v.port_high;
-		if (copy_to_user(ss, &v32, sizeof(struct serial_struct32)))
+		if (copy_to_user(ss, &v32, sizeof(v32)))
 			err = -EFAULT;
 	}
 	return err;
@@ -3215,7 +3215,7 @@ struct tty_driver *__tty_alloc_driver(unsigned int lines, struct module *owner,
 	if (!lines || (flags & TTY_DRIVER_UNNUMBERED_NODE && lines > 1))
 		return ERR_PTR(-EINVAL);
 
-	driver = kzalloc(sizeof(struct tty_driver), GFP_KERNEL);
+	driver = kzalloc(sizeof(*driver), GFP_KERNEL);
 	if (!driver)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.27.0

