Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA78529EB59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJ2MKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2MKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:10:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id 7so3532583ejm.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vqdd5oC4UyVoBAfI4M4NvTbDRg/jWvqaVTqesPTF9F4=;
        b=XGB0+EYcD313LlrHMc24woOMvBc7El15Pag3Hiurpf3hMGlTxt+YQPQdIL0H70OeOY
         J7iphDu7L8597XcCehsfW27Q80T+W/euyPwwIAaTwNG+ImFfxPnCtb7nLIEveCPaeeTU
         SfC8QcwQFj6sweEw2LDhSHE2Jgw/7y8f4uJdlX1l9pabQh0Bx3jPtUhsvqF10tPK250q
         QeZRfX2UUi/jIjo9q2/D7rgUIJHegNGaSdZh2zyO4paPU/B6zUbQXQBDStsB52JY3/me
         fBArOTfGeBTeCdVPyVqfKgMA9ggiXoF7fPt+TRLGJxERHvTrCVW9jdt2eckZ4NQXiwFN
         euHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vqdd5oC4UyVoBAfI4M4NvTbDRg/jWvqaVTqesPTF9F4=;
        b=cWrt0ItbmYeYJLk/wLqSHnAnppkYR7RhEYpyERjkwEoaNbY6g35ktU1SqNqP05nvjd
         VgOYEApaoCqcImx6NZjzL1j/uoC1Z07UHRuKYvaaOOD2eXxZPslZs49SK7S7f6xgaSWr
         +YSDAKN9O+F6AvX70GunUkjDSkfitI+OTkWg/Rhr3yMMWyTp0MWKba3SEgcGFI0BYnGs
         Di3j/5FqbcX67OHvC7Jj3ARzj1qzUhHMRdQzIrwjc4OTcYKcR+lZOX89oi+5gPzagYYV
         u7wi+jwoFB+eCChVgJMp75aHQlR67AqDT5h6sz3Qcga8Uf6z+LqbuydyO5k4TTykixXA
         MPew==
X-Gm-Message-State: AOAM532VSjUFxYf7FT5SsEm1OCwgC6abHx0DfE/gCnjeW9IbGDTU/hzs
        Qhx0ee85GLy0zQEJHZqJZdEbVvdPeHs=
X-Google-Smtp-Source: ABdhPJw8OGc7lO1JNWGbaFtYjghS9bKW1EWloDxUvHYMMBcEMSWPFZdfF1Ig4VxdjeaosPnybNewpA==
X-Received: by 2002:a17:906:51dd:: with SMTP id v29mr3797506ejk.69.1603973417585;
        Thu, 29 Oct 2020 05:10:17 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id o13sm1365887ejr.120.2020.10.29.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:10:17 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:10:15 +0100
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v4 3/6] vt/vt: Enable mode change via escape sequence
Message-ID: <bc3f406ceee517cca2e5ba06ad3935e440a57d1b.1603963593.git.tammo.block@gmail.com>
References: <cover.1603963593.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603963593.git.tammo.block@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables userspace to enable one of the mouse protocols and choose
one of the new event types by escape sequences.

And don't forget to reset protocol value also if resetting vc.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9506a76f3ab6..02776d974fcb 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1905,13 +1905,25 @@ static void set_mode(struct vc_data *vc, int on_off)
 					clr_kbd(vc, decarm);
 				break;
 			case 9:
-				vc->vc_report_mouse = on_off ? 1 : 0;
+				vc->vc_report_mouse = on_off * TIOCL_REPORTBTNPRESS;
 				break;
 			case 25:		/* Cursor on/off */
 				vc->vc_deccm = on_off;
 				break;
 			case 1000:
-				vc->vc_report_mouse = on_off ? 2 : 0;
+				vc->vc_report_mouse = on_off * TIOCL_REPORTRELEASE;
+				break;
+			case 1002:
+				vc->vc_report_mouse = on_off * TIOCL_REPORTDRAG;
+				break;
+			case 1003:
+				vc->vc_report_mouse = on_off * TIOCL_REPORTANYMOVE;
+				break;
+			case 1006:
+				vc->vc_protocol_mouse = on_off * VC_PMOUSE_SRG;
+				break;
+			case 1015:
+				vc->vc_protocol_mouse = on_off * VC_PMOUSE_URXVT;
 				break;
 			}
 		} else {
@@ -2076,6 +2088,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->state.charset	= 0;
 	vc->vc_need_wrap	= 0;
 	vc->vc_report_mouse	= 0;
+	vc->vc_protocol_mouse	= VC_PMOUSE_X10;
 	vc->vc_utf              = default_utf8;
 	vc->vc_utf_count	= 0;
 
-- 
2.28.0

