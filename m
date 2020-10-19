Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547AC292E89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbgJSTfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbgJSTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=C9AZJInHSA4bqiVYuqisAmQR3f3OqCj1KITHHKH76j8=;
        b=AA/5OToyYjNvmTcX1fmYwyuPYDWQ96yJchYMvi+SCsLkbRWPe3KbY3U0kOELl5taL3AHo/
        TPZvt2Nq4UQ+iH+Ea/oKzNSt4c8JOC9wn71hpm0KZ+mbdO5KISHojuDAZMvGEN7ZxfNIDl
        a3Eh/hP0IT9BH5qJzMVqxTC5DUEMJOs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-pUK-fHR7N1ioyVxJ33PJQA-1; Mon, 19 Oct 2020 15:35:30 -0400
X-MC-Unique: pUK-fHR7N1ioyVxJ33PJQA-1
Received: by mail-qk1-f199.google.com with SMTP id u16so463437qkm.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C9AZJInHSA4bqiVYuqisAmQR3f3OqCj1KITHHKH76j8=;
        b=pG3WYQrGHSjHh+z80mGqK8bN95yNpfw84Ebppz/gTDOW3y3qtqqb3KXSysFS2ovF+9
         3sj2phQiEXOoh3mr5bH0ZOua4wjDbN0U+ksQVTtyq86/xrX1X60rJGBH8A+NfLCNdo+J
         6HmJFduT/W4CF4of+0fc5KSDnfXIkpJDAmvcw97A1JKPpAJnCBN9P/ObXhrHnRa4zFgF
         tw6I7AvduJ3jFxepXLxhjqA8SWZzCK4F/kuorKJ1pw4mKAwXtiA1hFYSRj86VJ6F2ho6
         CnVfHd46QA/CWlPohuIqq8bg9walgrMFGIsrVFE4krEHmNLSZx1qnscCbD6JySLe82io
         DjDA==
X-Gm-Message-State: AOAM530KsPUsf5R3b3/tG9WNyRXTXkn7BlE681cnd0GuYUaXxVmBIP7s
        pRYnnmn6+Cx5N5onIWsoyAq7IfAtyRcw7Z1MJBD3IkjKM5l3SzjmxK/FMtdapyKFWzJ/qYONoKX
        2afNR0JfaYtHbCaLqgHBK/U9c
X-Received: by 2002:ac8:59d4:: with SMTP id f20mr978040qtf.327.1603136129775;
        Mon, 19 Oct 2020 12:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNn25tOM18TKKphRcF7Bg5son2KFp4L4PtW6Ts6kD/aZlr1L+H762Br156VUgjamQ6Rc0lEA==
X-Received: by 2002:ac8:59d4:: with SMTP id f20mr978021qtf.327.1603136129574;
        Mon, 19 Oct 2020 12:35:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p5sm363005qtu.13.2020.10.19.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:35:29 -0700 (PDT)
From:   trix@redhat.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] edac: amd64_edac: remove unneeded break
Date:   Mon, 19 Oct 2020 12:35:24 -0700
Message-Id: <20201019193524.13391-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/amd64_edac.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fcc08bbf6945..386a3a4cf279 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2461,14 +2461,11 @@ static int map_err_sym_to_channel(int err_sym, int sym_size)
 		case 0x20:
 		case 0x21:
 			return 0;
-			break;
 		case 0x22:
 		case 0x23:
 			return 1;
-			break;
 		default:
 			return err_sym >> 4;
-			break;
 		}
 	/* x8 symbols */
 	else
@@ -2478,17 +2475,12 @@ static int map_err_sym_to_channel(int err_sym, int sym_size)
 			WARN(1, KERN_ERR "Invalid error symbol: 0x%x\n",
 					  err_sym);
 			return -1;
-			break;
-
 		case 0x11:
 			return 0;
-			break;
 		case 0x12:
 			return 1;
-			break;
 		default:
 			return err_sym >> 3;
-			break;
 		}
 	return -1;
 }
-- 
2.18.1

