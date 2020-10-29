Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B517D29EB54
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgJ2MJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ2MJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:09:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ABEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:09:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j24so3433027ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9zieL4fgla3Rvmx+X+1xyRvc7BAN1mtKcaHPIf4/Ch8=;
        b=TXKPblqmbec4xq4yVbtpInnc04kAwb8+yeV2ZSksSWt0i7rXyG59mChCIfYPiBBiKy
         9mbZEnQ4hfavWr9R2dPhipfwQPqN5DHth+kWhoMgGbrEsrpz5AQ4iLaWgcXU6/8ODufV
         vnSRBDEssw5RzhyZygZvGpxt94Wrrnn654YhKf31zluCq3aFvp5GUx+rlNmLyqM6a7lY
         /vf6qZNiGwDZGWWXORK2DcVrPp3iBAqMOkXJWbTeSM/ygcOtblmqL6Bl54iU04bMuoPA
         aG6KRpzJb6nfYnlJiwOyof1fjK+k1Rt2RQK7LF0qlPkP1f8JV2icJgyj6UnaVQVtEVoD
         XNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9zieL4fgla3Rvmx+X+1xyRvc7BAN1mtKcaHPIf4/Ch8=;
        b=lecX90Dn/1GuX8wojFjXODuVyY/BRC/sCWs5zlqNZ54TLzbtyQ0z8f4bN/iKB2OauL
         v6WSrFJfDlzPw7LMdX4QrrwRl5NsWS4q6aXbeO0bKM4+ovEBa6+gOD54IqOelTIIYdoz
         JMI/lFNvIlZNkuyUKk3RRC64m/JxGb9pSlFgIacaDECYpO/JRdYVTAYJUjdPEp1ctntH
         leA2yYL2j7ZKlUgYfcxHviYw3Bn1ctjaMZHnyZPHOVg75fuPDjPCAOEfsK6BTok+rS/G
         cFU24KFF8+mMwsiZNWFfM+dtNJAXYdQ5TO+Nst3zBEt8VX2eYQckUjVAO/pZtHvC9Q7k
         eLHQ==
X-Gm-Message-State: AOAM533GDQ8kPzFG01n2lcYcYW8/4vpJ+x23YvGvTS65WS+agYJL/jym
        b7MjdJG75Sdgmo6kTSkpCgGM+O9AinE=
X-Google-Smtp-Source: ABdhPJy6Ytg+IxllvIM9xL9uBcnYfAatfLN5roqaryP4gT/+iCO0hhsaW4wZqThgpyQGXzYWb2VVzw==
X-Received: by 2002:a17:906:1a0e:: with SMTP id i14mr3762427ejf.7.1603973386299;
        Thu, 29 Oct 2020 05:09:46 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id o1sm1401250ejc.81.2020.10.29.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:09:45 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:09:44 +0100
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v4 1/6] tiocl.h: Change/Add defines for mouse report
Message-ID: <d9732edc6cfd2359ce27a68fbeb60e0648037f1f.1603963593.git.tammo.block@gmail.com>
References: <cover.1603963593.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603963593.git.tammo.block@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional defines for mouse event types. The change of the value
of TIOCL_SELBUTTONMASK deserves a bit more explanation :

The old value of 15 uses the first 4 bits and sends them unchanged back
to userspace if requested by an application. But in fact only the first
two bits have ever been used by any daemon or useful at all, as the
kernel already knows the status of the shift and alt keys encoded in
bits 3 and 4. On the other hand we *do* want to know the status of bits
6-8, encoding button values >3 and mouse move and drag operations.

This change is up- and downwards compatible by masking all spourious
bits and leaving only the undisputed parts (bits 1 and 2) untouched.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 include/uapi/linux/tiocl.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
index b32acc229024..3717e865571d 100644
--- a/include/uapi/linux/tiocl.h
+++ b/include/uapi/linux/tiocl.h
@@ -9,7 +9,7 @@
 #define 	TIOCL_SELPOINTER	3	/* show the pointer */
 #define 	TIOCL_SELCLEAR	4	/* clear visibility of selection */
 #define 	TIOCL_SELMOUSEREPORT	16	/* report beginning of selection */
-#define 	TIOCL_SELBUTTONMASK	15	/* button mask for report */
+#define 	TIOCL_SELBUTTONMASK	0xe3	/* button mask for report */
 /* selection extent */
 struct tiocl_selection {
 	unsigned short xs;	/* X start */
@@ -28,7 +28,11 @@ struct tiocl_selection {
 
 /* these two don't return a value: they write it back in the type */
 #define TIOCL_GETSHIFTSTATE	6	/* write shift state */
-#define TIOCL_GETMOUSEREPORTING	7	/* write whether mouse event are reported */
+#define TIOCL_GETMOUSEREPORTING	7	/* write which mouse events are reported */
+#define		TIOCL_REPORTBTNPRESS	1	/* report button press only    "9" */
+#define		TIOCL_REPORTRELEASE	2	/* report press and release "1000" */
+#define		TIOCL_REPORTDRAG	3	/* report drag events       "1002" */
+#define		TIOCL_REPORTANYMOVE	4	/* report any movement      "1003" */
 #define TIOCL_SETVESABLANK	10	/* set vesa blanking mode */
 #define TIOCL_SETKMSGREDIRECT	11	/* restrict kernel messages to a vt */
 #define TIOCL_GETFGCONSOLE	12	/* get foreground vt */
-- 
2.28.0

