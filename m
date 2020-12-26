Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9577A2E2EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 18:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgLZRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 12:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgLZRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 12:45:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06763C061757;
        Sat, 26 Dec 2020 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oUVxQrt/hbpLn9cx4/4aB2X7esBxzlJWZp8c968lah0=; b=L22EyjwWmD9sAeo8/SM4GkqqWc
        weFIvW3AYPuGx9AQahHvdkAB8gqn1MCLa4KrJi7DEVuKu5YA3LOHQV4eLT7r1ap/IO9n9cBF3l5aH
        6FzUwhgQzItMVWnXXOcJUKNjjlA1rNAQKu6l6UcO2t96PGjrV/fwp9yLM7sX1hJPziSlprCziMuEM
        d7AeajuxSdFMxW/9UPKBiFezvjecZ0iC/DKWghFhwGpjDfBvpsg+JvYGJ3y8J7lfiib0AbC08nR4V
        P5u/4s5D4jxZ3GshyOC4xXkJilkc/M2/RPuN1v50RkDuszKoEYZjlOsDBszyCE9Y8X1oCU9Ma1A/F
        nbztD9Bw==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktDcM-0008TY-Qg; Sat, 26 Dec 2020 17:44:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: admin: early_param()s are also listed in kernel-parameters
Date:   Sat, 26 Dec 2020 09:44:33 -0800
Message-Id: <20201226174433.7885-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add info that "early_param()" kernel boot parameters are also listed
in kernel-parameters.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20201223.orig/Documentation/admin-guide/kernel-parameters.rst
+++ linux-next-20201223/Documentation/admin-guide/kernel-parameters.rst
@@ -3,8 +3,8 @@
 The kernel's command-line parameters
 ====================================
 
-The following is a consolidated list of the kernel parameters as
-implemented by the __setup(), core_param() and module_param() macros
+The following is a consolidated list of the kernel parameters as implemented
+by the __setup(), early_param(), core_param() and module_param() macros
 and sorted into English Dictionary order (defined as ignoring all
 punctuation and sorting digits before letters in a case insensitive
 manner), and with descriptions where known.
