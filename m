Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE424F08C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 01:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHWXvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 19:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHWXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:51:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01DC061573;
        Sun, 23 Aug 2020 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x68+/9gZRBueaUiRyC3EaV8OJhDP5e+ZIa6O6Q/qQ50=; b=H8tFAEk01HyNU4/Lqsvj1LIQpM
        7GAXqp+bS1X1wa5tISl/EG4is+BMD3gCZVicCSy+pEVehEwuEbdIabvpNZROISPAZ/lHlHXlB9YCk
        3H63/8EN8mdnc3uQHnbghVbEdW8ryhWECuUQWP80XWFTPLxcB4laiWq5BnTJDAldu4GpCokx9bKsv
        Z2ePQohE87n8Igd4t2zI2dQ8urftmLW+KjcZLeIkQef9VGsePqESbZ6Gy5wjZPberWu9Xan+Injpo
        /xQoq5xOMOOzY9u2uKROTRrwlMav1hwiIEVO7qGU/djyoqFJG/irUX/bxQktjiBcAORjKvwN7Amam
        1j9+8zQQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9zlm-00026T-Ou; Sun, 23 Aug 2020 23:51:28 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Thomas Cedeno <thomascedeno@google.com>,
        Micah Morton <mortonm@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATGCH -next] LSM: SafeSetID: fix underline length warning
Message-ID: <ac079c4a-a9ec-1a46-455a-035b8cf44d6f@infradead.org>
Date:   Sun, 23 Aug 2020 16:51:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix documentation build warning:

Documentation/admin-guide/LSM/SafeSetID.rst:110: WARNING: Title underline too short.
Note on GID policies and setgroups()
==================

Fixes: 02e316b088df ("LSM: SafeSetID: Add GID security policy handling")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Cedeno <thomascedeno@google.com>
Cc: Micah Morton <mortonm@chromium.org>
---
 Documentation/admin-guide/LSM/SafeSetID.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200821.orig/Documentation/admin-guide/LSM/SafeSetID.rst
+++ linux-next-20200821/Documentation/admin-guide/LSM/SafeSetID.rst
@@ -107,7 +107,7 @@ for a UID/GID will prevent that UID/GID
 privileges, such as allowing a user to set up user namespace UID/GID mappings.
 
 Note on GID policies and setgroups()
-==================
+====================================
 In v5.9 we are adding support for limiting CAP_SETGID privileges as was done
 previously for CAP_SETUID. However, for compatibility with common sandboxing
 related code conventions in userspace, we currently allow arbitrary


