Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC66222A94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgGPSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 14:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgGPSDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:03:34 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F8420578;
        Thu, 16 Jul 2020 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594922613;
        bh=5KwcsaBu7BUQxh20BOcLc3hsF8YKVmjgY6g59//hEzI=;
        h=Date:From:To:Cc:Subject:From;
        b=SxptUY5oeRchbMENgLCF+DFzAIl11WhRny/okAoL8iAphdsnJTNiVyvFby67Mj6SO
         2B2mem2bKBrHs+MYuuXTuZu2LhRrhAs8+Eae6agJ9lSTiJB7zzHjDa6k/5OsDuG18D
         Vhtm8A6y3TNGzAVcXfQbVGu4NxU72fAW7fvQWW9s=
Date:   Thu, 16 Jul 2020 13:08:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] tty: Avoid the use of one-element arrays
Message-ID: <20200716180858.GA30115@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element arrays
with simple value types 'char reserved_char' and 'compat_int_t reserved'[2],
once it seems these are just placeholders for alignment.

Also, while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the variable type is changed
but the corresponding sizeof that is passed as argument is not.

Lastly, fix the checkpatch.pl warnings below:

ERROR: code indent should use tabs where possible
+        char    reserved_char;$

WARNING: please, no spaces at the start of a line
+        char    reserved_char;$

ERROR: code indent should use tabs where possible
+        compat_int_t    reserved;$

WARNING: please, no spaces at the start of a line
+        compat_int_t    reserved;$

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/tty-20200716.md
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/tty/tty_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5a6f36b391d9..505bcba5ee02 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2683,7 +2683,7 @@ struct serial_struct32 {
         compat_int_t    baud_base;
         unsigned short  close_delay;
         char    io_type;
-        char    reserved_char[1];
+	char    reserved_char;
         compat_int_t    hub6;
         unsigned short  closing_wait; /* time to wait before closing */
         unsigned short  closing_wait2; /* no longer used... */
@@ -2691,7 +2691,7 @@ struct serial_struct32 {
         unsigned short  iomem_reg_shift;
         unsigned int    port_high;
      /* compat_ulong_t  iomap_base FIXME */
-        compat_int_t    reserved[1];
+	compat_int_t    reserved;
 };
 
 static int compat_tty_tiocsserial(struct tty_struct *tty,
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
-- 
2.27.0

