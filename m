Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02C26D920
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgIQKcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgIQKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:32:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D688C06174A;
        Thu, 17 Sep 2020 03:32:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so1052600pjd.3;
        Thu, 17 Sep 2020 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54p7qoHzf7+ugk/+fGt4XtZ13EYtHqMRyG7/17c2q8Q=;
        b=k5EHHddjSUw+zfRBSeYI+gdy9nTgri2kD2ZKlXVYmVOIxRYYyPdiIexnhlBjOvnZnF
         A57KFb7oodOidv95tec2+ySSJ3w1GEdxQgWRBro4rEl3i8vNc6scx1ksOHx6Eq+AhzGv
         BPKBT6KSBSIF7G2Pwit6eX1C1SwUZFnfKjJKdV11Km+QJBc3hyVpWC7pPTmnzy4M+YO4
         jlZXDNFu19wcqYf46rZZ7fyhwvdayUHMiT99AP5TsRd+Lu5ymf5A4ZtF1BKye79moODE
         d0Dh4EvOyRCrCbhzkbxRvL+vc8I8mYVE1tCL448OlS7oyYleyOdyaxZVxpmrzII6vT0J
         KfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54p7qoHzf7+ugk/+fGt4XtZ13EYtHqMRyG7/17c2q8Q=;
        b=q7wBZRNGXnJSoDkId4yyG+DFLOIzTjuxk/T3bNKWt2BqTBUfT1ryK7CLF19Q0rYktG
         RW92TLhHO6QvscgQJ0RCeSTMwGVg01g2W92okubMEDNxIeDzFy/bekfOecnC6L1xn8RP
         6Sg36qaanqqI+ppLMZ2psCxvrHpWmqb85Qku0ZS/xuXHJdjLRcLBAxQrBbp+W3TXUoa/
         yIDrUhaEGAfT9E3Za7aNFrvUax5rg/my/fmcdqOoCZwDx/u+eR3ebNk0tiyb/7Oh2lrV
         oKwuO5t7QZ5WH64cibnzmQm2eoAUt86Xd4TfBaxtgvYPNq94M2KL6CNm4UTG0sZYMvP+
         RrZQ==
X-Gm-Message-State: AOAM531qc1eFLblFQh2pOkDCwg6SsSL/R9IqEvxMbc9s7AhkYCiqRNyO
        gWXwtzcCiAmY78VQEYC1cig=
X-Google-Smtp-Source: ABdhPJxf1IPlHpZWbPGZkh8IgsqbIzWiJpHfAoaSybS31HlR6xoit1TTgna24ML3R54scVbQGkdvJg==
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id b8-20020a170902d888b02900d0cb2df274mr27934127plz.13.1600338753820;
        Thu, 17 Sep 2020 03:32:33 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id e207sm21781927pfh.171.2020.09.17.03.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 03:32:33 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 4/4] docs: fb: Remove vesafb scrollback boot option
Date:   Thu, 17 Sep 2020 15:56:15 +0530
Message-Id: <799e4d6ecca9aab53e823fc0001887d728be0aa5.1600333774.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
framebuffer scrollback mode was removed, but the documentation was not
updated.  Properly update the documentation by removing the option that
is no longer present,remove the scrollback option.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changes since V3:
Following Willy's and Greg's suggestion,get rid of not relevant commit 
hash and message from changelog and put a correct one.
 Documentation/fb/vesafb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
index 6821c87b7893..f890a4f5623b 100644
--- a/Documentation/fb/vesafb.rst
+++ b/Documentation/fb/vesafb.rst
@@ -135,8 +135,6 @@ ypan	  enable display panning using the VESA protected mode
 
                 * scrolling (fullscreen) is fast, because there is
 		  no need to copy around data.
-		* You'll get scrollback (the Shift-PgUp thing),
-		  the video memory can be used as scrollback buffer
 
           kontra:
 
-- 
2.28.0

