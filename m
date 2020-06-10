Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA91F5C97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgFJUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:52 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17546 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbgFJUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:14:43 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2020 16:14:43 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1591819175; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CCM/uK+8z2LgiHjGSaoaqB2YZaB5cL+q75We67/D58WGMSwx7FYzXqiR+4/Vp6F07ZUFnzFj6OxEYE2j5Ls0P6XniBnCPbDqbllCwuISzNkQZBfyrc+QtX4ZSAxz1yPCS0ilAASGOL/KCqMrJ7oyjRFMaHRuSd6mvi0CYjTtK4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591819175; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=w0o4OowJsl4iAr761FXtE6DpOWppvwGF0W6F8ylVrDE=; 
        b=eUo1EnNSUZ2kp67gQ/lzbN3m3rne23/SmR3etvpWrXTmXP15ToY+jnQqpiOMPw3PuZ2TDhvCxLZnFW0oUxdJBPICcYT5Pibg7LfxyM2wz1a1SYiSYSrK6eH4w/wonHPXA6/Xner3a6b2OnTfmgBJV1LYs8KKJDahGmHicwTy5Zo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=tyler@shetrompf.com;
        dmarc=pass header.from=<tyler@shetrompf.com> header.from=<tyler@shetrompf.com>
Received: from archlinux.localdomain (50-232-53-226-static.hfc.comcastbusiness.net [50.232.53.226]) by mx.zohomail.com
        with SMTPS id 1591819172538462.68323652810307; Wed, 10 Jun 2020 12:59:32 -0700 (PDT)
Date:   Wed, 10 Jun 2020 19:59:23 +0000
From:   Tyler Shetrompf <tyler@shetrompf.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: comedi: comedi_fops: fixed a blank line coding
 style issue
Message-ID: <20200610195923.GA12602@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Tyler Shetrompf <tyler@shetrompf.com>
---
 drivers/staging/comedi/comedi_fops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index e85a99b68f31..3f70e5dfac39 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2169,6 +2169,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case COMEDI_CHANINFO: {
 		struct comedi_chaninfo it;
+
 		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
 			rc = -EFAULT;
 		else
@@ -2177,6 +2178,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	}
 	case COMEDI_RANGEINFO: {
 		struct comedi_rangeinfo it;
+
 		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
 			rc = -EFAULT;
 		else
@@ -2249,6 +2251,7 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	}
 	case COMEDI_INSN: {
 		struct comedi_insn insn;
+
 		if (copy_from_user(&insn, (void __user *)arg, sizeof(insn)))
 			rc = -EFAULT;
 		else
-- 
2.27.0

