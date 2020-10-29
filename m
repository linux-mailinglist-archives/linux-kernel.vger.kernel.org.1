Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2351C29EB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgJ2MKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgJ2MKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:10:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id za3so3480055ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e2sHDa2mhkWOuJmN+hoCmN8cTa4NFYGAA5wVstJq5b0=;
        b=Yi9jolG+XceXkGl0cgzCdhRKSlTOZa6v7rAygmCaNU9XA49oakKzQTEz+mfJIiSvYo
         zUcVZaUawLpxQNdZ3N9pyHNvBWGdficpE5A7NCxwiXAJy89CDX5UTnxcaCgIAyfgKGCi
         j4/7dvew9N3WdssfhM3HCBrCIblJhWtVeD8q67F4BT1bAK2Y7eUzWSGTP0mMG2OPRU6v
         wEGXz0EU76g+Se1NfeSvKL4Nz9dtChTG1G0ssxuB7cyBiKfTF2uLoF8jdrBpa//5tXGb
         F+5Vmb0DCeyaWLjpSBDKZOfcuFULC8Uf7ZTo3ZHtE9b9JOOuCfCxxQDWah1Libi2BGcC
         o6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2sHDa2mhkWOuJmN+hoCmN8cTa4NFYGAA5wVstJq5b0=;
        b=Lz7qNigA9wZ4fUjOrj5zeskVG04HC7lkalThiVUg8a5u0Pwt/dWN1/D2BT/zBMIWoa
         HVFkctEkQmi/19dk0AFRkcg9QUxAiLfDslR1mlMN8d6NpKtrlWpur1XZ843lQRJtRqE1
         l3LJB6BOm5EAthu+dF+cZUFI0wfo+syVKTyvDdamBbr4UroX5/4rTgdz06Of9VWxD0P8
         hrz9bwze4j8+sVYiot9ZgJSlYlg2X1TEOhO4xM3xe2fGQrLExpiEd6/pqOJPV/IZ9prR
         DOPxAPBd2/nTh8mMyFnlfrKa+0a6iJlO8ihVXIo65RrAhN72cvMJ63RF9xJVnmOsI+zr
         0Arg==
X-Gm-Message-State: AOAM531tGAloj39KAcu1JMJtg3k/NzccvoJkKrlAATa5hZSS7I1C14LL
        5Mw8g+a4qFIo5GWhUJ4Ge9BasJhnb6c=
X-Google-Smtp-Source: ABdhPJwXfAN8rSwplQlax4tHK+W917EmRaRt66BDSRu5rquoh+Xkh/5AVrDewNeiP1y1hsklOGTDgw==
X-Received: by 2002:a17:906:4351:: with SMTP id z17mr3703234ejm.110.1603973434287;
        Thu, 29 Oct 2020 05:10:34 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id m20sm1430146edq.16.2020.10.29.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:10:33 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:10:32 +0100
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v4 4/6] vt/vt: Add SRG mouse reporting protocol
Message-ID: <80a62b9ec357795b424148526f61f340b02e06a4.1603963593.git.tammo.block@gmail.com>
References: <cover.1603963593.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603963593.git.tammo.block@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRG protocol indicates a button release by appending a "m" to the
report. In this case the button number is not 3 (RELEASEEVENT) but
the number of the button that was released. As release events are only
reported for the first three buttons (LOWBUTTON_MASK), we need to store
the number on click events because it is not sent to us from userspace.

We also need to check for the case where no button state change occurred
at all (bit 6 set), in this case a value of 3 is OK even in SRG.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 02776d974fcb..c884539aee22 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1845,13 +1845,32 @@ static inline void respond_ID(struct tty_struct *tty)
 	respond_string(vt102_id, strlen(vt102_id), tty->port);
 }
 
+#define ANYBUTTON_MASK	0xc3
+#define LOWBUTTON_MASK	0x03
+#define RELEASEEVENT	0x03
+
 void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 {
-	char buf[8];
+	static char last_btn = RELEASEEVENT;
+	char buf[20];
+	bool rel;
 	int len;
 
-	len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
-			(char)('!' + mrx), (char)('!' + mry));
+	switch (vc_cons[fg_console].d->vc_protocol_mouse) {
+	case VC_PMOUSE_SRG:
+		rel = (butt & ANYBUTTON_MASK) == RELEASEEVENT;
+		if ((butt & ANYBUTTON_MASK) < RELEASEEVENT)
+			last_btn = butt & LOWBUTTON_MASK;
+		if ((butt & TIOCL_SELBUTTONMASK) == RELEASEEVENT)
+			butt = (butt & ~LOWBUTTON_MASK) | last_btn;
+		len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
+				mrx + 1, mry + 1, rel ? 'm' : 'M');
+		break;
+	default:
+		len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
+				(char)('!' + mrx), (char)('!' + mry));
+		break;
+	}
 	respond_string(buf, len, tty->port);
 }
 
-- 
2.28.0

