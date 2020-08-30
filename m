Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D00256AED
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 02:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgH3AcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 20:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgH3AcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 20:32:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7161C061573;
        Sat, 29 Aug 2020 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Wn0QekRidMhm9stuLLcOQt4vL8D9U9wBUq8kPt8hqzM=; b=QKwUQQhHAMcKgV+zUpNBAYCZRl
        gXFJGx+AHMR7WsgwT9GW3w9TqzUdHit5CgkWOZn3NdafO6r80IJ1c6irf06CS7iQvNbpgqK0pBoaN
        qRQq5Q/3deVB51ZfnIQpCLMMX6sXAG0oSZjTKYAKGHVqTNSZPc8fhteEwxHwKzQb9PYA9jY66fsDI
        8Yp70dm5MNZNO+9HWauVUX3PmMBmBFtsLit2lebbv6wKCatT4SJ36ImZ3u4zjZpFRKkYBCRTmsF09
        /6zNcKXCq9pPOIObaT5Kkl2nraebz/kOlkewcgD91zaYVUIUbuIO205lPQCxZ2sZu1gVxugzvM57J
        kjHQDrxQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCBGM-0002eN-To; Sun, 30 Aug 2020 00:32:03 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] MAINTAINERS: IA64: mark Status as Odd Fixes only
Message-ID: <7e719139-450f-52c2-59a2-7964a34eda1f@infradead.org>
Date:   Sat, 29 Aug 2020 17:31:59 -0700
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

IA64 isn't really being maintained, so mark it as
Odd Fixes only.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200828.orig/MAINTAINERS
+++ linux-next-20200828/MAINTAINERS
@@ -8316,7 +8316,7 @@ IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
 L:	linux-ia64@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
 F:	Documentation/ia64/
 F:	arch/ia64/

