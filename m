Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3147A263B72
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgIJD1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 23:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIJD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F87C0613ED;
        Wed,  9 Sep 2020 20:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PO7aEW0T3IkS0F8WxlPuWO3uzY5WLy4/PEV7R6Fm92Y=; b=YBzOWM+473iDNGf0tqrCsfnVVg
        6EICnUdAiPaGy31jDdtvyC+TL3FbzGxCBWZk0qWQYWqJZsopT//UK/PVydlfeUaJX0cxTtPcEeJTV
        /Gbzk1GaavQ9NcH6lu3C3cHNnFa3fAlbv2yGZiRtYKV9jdCoTV6yBXh/kxbLoU4HPqmwGHMC5d4kv
        1VgVfS4150lf5cF93/cCK9/CwUa/ptPhvQ/RQbNttsRR4amBp50VBMBxGTH8tKfYbG97USo4lR1gq
        xV9H7XbW+bN5JUw1w07BDl5vlqYRP+pp3PosEmMKb3Zv1GR8PP84aLhU12bo8yp4jPVgCydED9bHo
        Zazn+ZNA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGDE0-000659-TW; Thu, 10 Sep 2020 03:26:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/3] Documentation/admin-guide: kernel-parameters: add early_param() to list of types of boot parameters
Date:   Wed,  9 Sep 2020 20:26:06 -0700
Message-Id: <20200910032606.7355-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910032606.7355-1-rdunlap@infradead.org>
References: <20200910032606.7355-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_param() is missing from the list of types of kernel command line
parameters that are listed in kernel-parameters.txt, so add it
(so that I can find parameters more easily).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200909.orig/Documentation/admin-guide/kernel-parameters.rst
+++ linux-next-20200909/Documentation/admin-guide/kernel-parameters.rst
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
