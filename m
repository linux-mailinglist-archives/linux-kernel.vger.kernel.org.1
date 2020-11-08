Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0C2AACC4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgKHSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:18:29 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:39754 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKHSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:18:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 34D32C9D;
        Sun,  8 Nov 2020 19:18:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ccsJuX4cHE-j; Sun,  8 Nov 2020 19:18:25 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BF24E362;
        Sun,  8 Nov 2020 19:18:25 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kbpGi-00Cn8W-U0; Sun, 08 Nov 2020 19:18:24 +0100
Date:   Sun, 8 Nov 2020 19:18:24 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup: Document read_all_doc shortcut
Message-ID: <20201108181824.bso5exam72b4p4tk@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was implemented a long time ago, but never actually added to the
documentation.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 Documentation/admin-guide/spkguide.txt |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/admin-guide/spkguide.txt
+++ b/Documentation/admin-guide/spkguide.txt
@@ -344,6 +344,7 @@ spk key_slash = say_attributes
 spk key_8 = speakup_paste
 shift spk key_m = say_first_char
  ctrl spk key_semicolon = say_last_char
+spk key_r = read_all_doc
 
 5.  The Speakup Sys System
 
