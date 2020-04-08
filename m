Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371551A27F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgDHR3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 13:29:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgDHR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AIkLRB9tu9cJ1QlOgikaPxAEDOuOfsDdcUkPvhqx0SM=; b=hyeDAxIEzdJhFkIc48CSeTBtMl
        M3LpwqPXHD096Ch/f7BZnLN3lXAIJ2c0ZAySyCKjMt7HIrSfQhJSiz7ud8lcnouY+Dj5YfyY6Fzu0
        sk8mOdiHPwtLJ2i9fXz8kFAZQ55elCJbCgZu4/zIspouXkOyz82SKPcLDQyYuIOIhBudIFhrAI0KF
        gT4BKnwMH2tx1UZSeVDrcRzXLalzLuxh/chK9zyWfaFMR7Wm2UfSbyjD+Ebdh4bAegWvHefspg2tE
        at3mBAUBlZhh//ikFp7Z1ROs18fSOyfZiecGBTjbIGzVbEr4MLvAMLm8wKwkofg9tupC1TXSwQsj2
        DTSffYeA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMEWQ-0006om-Hi; Wed, 08 Apr 2020 17:29:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: android: binderfs: add 'stats' mount option
Message-ID: <baa0aa81-007d-af46-16a5-91fead0bd1b9@infradead.org>
Date:   Wed, 8 Apr 2020 10:29:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add documentation of the binderfs 'stats' mount option.

Description taken from the commit message.

Fixes: f00834518ed3 ("binder: add a mount option to show global stats")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org
---
 Documentation/admin-guide/binderfs.rst |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20200408.orig/Documentation/admin-guide/binderfs.rst
+++ linux-next-20200408/Documentation/admin-guide/binderfs.rst
@@ -33,6 +33,12 @@ max
   a per-instance limit. If ``max=<count>`` is set then only ``<count>`` number
   of binder devices can be allocated in this binderfs instance.
 
+stats
+  Using ``stats=global`` enables global binder statistics.
+  ``stats=global`` is only available for a binderfs instance mounted in the
+  initial user namespace. An attempt to use the option to mount a binderfs
+  instance in another user namespace will return a permission error.
+
 Allocating binder Devices
 -------------------------
 

