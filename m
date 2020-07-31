Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76E4234925
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgGaQYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgGaQYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:24:12 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF32D2177B;
        Fri, 31 Jul 2020 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596212652;
        bh=He4lRX7qUXd0rGaWvtl8uJvJvotCXPBWhv6zQbIkFB0=;
        h=Date:From:To:Cc:Subject:From;
        b=YKFJ07NPiUmy4q4bbxyUhCFTy+UWzeRu3MDxCdhvvC7MKJuMrzh42CYPwjcJVQukG
         TaIS07ODq3b67Vv3FphWsEZJGGPWGBYYp4z50zGm1vlMTWpeVVTaxF7aqtUkA6Y0S7
         i1837uj8TrgvKv1K/S467IAUcCXOpF4SlMxj4WFA=
Date:   Fri, 31 Jul 2020 11:30:15 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] vim: linux-kernel: Increase columns highlighting to 100+
Message-ID: <20200731163015.GA7922@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase columns highlighting to 100+ once the 80-column warning has
been deprecated in the Linux kernel[1].

[1] commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 plugin/linuxsty.vim | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
index 6f7e331..c42ce72 100644
--- a/plugin/linuxsty.vim
+++ b/plugin/linuxsty.vim
@@ -62,7 +62,7 @@ function s:LinuxFormatting()
     setlocal tabstop=8
     setlocal shiftwidth=8
     setlocal softtabstop=8
-    setlocal textwidth=80
+    setlocal textwidth=100
     setlocal noexpandtab
 
     setlocal cindent
@@ -80,7 +80,7 @@ function s:LinuxHighlighting()
     highlight default link LinuxError ErrorMsg
 
     syn match LinuxError / \+\ze\t/     " spaces before tab
-    syn match LinuxError /\%>80v[^()\{\}\[\]<>]\+/ " virtual column 81 and more
+    syn match LinuxError /\%>100v[^()\{\}\[\]<>]\+/ " virtual column 101 and more
 
     " Highlight trailing whitespace, unless we're in insert mode and the
     " cursor's placed right after the whitespace. This prevents us from having
-- 
2.27.0

