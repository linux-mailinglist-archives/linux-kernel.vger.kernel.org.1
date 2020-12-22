Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE62E040B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 02:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgLVBsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 20:48:41 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44756 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgLVBsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:48:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id A6176FD5;
        Tue, 22 Dec 2020 02:47:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zaj3haHk2R_5; Tue, 22 Dec 2020 02:47:57 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id DCFEEF06;
        Tue, 22 Dec 2020 02:47:57 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1krWmK-0015DC-Sa; Tue, 22 Dec 2020 02:47:56 +0100
Date:   Tue, 22 Dec 2020 02:47:56 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup: Add github repository URL and bug tracker
Message-ID: <20201222014756.ov5vi6fywylbp5n6@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have set up a repository for users to try newer releases more easily, and
keep records of known bugs.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-5.10/MAINTAINERS
===================================================================
--- linux-5.10.orig/MAINTAINERS
+++ linux-5.10/MAINTAINERS
@@ -16325,6 +16325,8 @@ M:	Samuel Thibault <samuel.thibault@ens-
 L:	speakup@linux-speakup.org
 S:	Odd Fixes
 W:	http://www.linux-speakup.org/
+W:	https://github.com/linux-speakup/speakup
+B:	https://github.com/linux-speakup/speakup/issues
 F:	drivers/accessibility/speakup/
 
 SPEAR CLOCK FRAMEWORK SUPPORT
