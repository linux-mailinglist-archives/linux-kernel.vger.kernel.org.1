Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78442140CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgGCVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgGCVZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:25:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA9C061794;
        Fri,  3 Jul 2020 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LKcWECJWQ/lzdFrL9B//11HmmkFyUCF2eCznKQtoNWw=; b=t1s/00nQHDTzhA+38R0c64w4b6
        B14AjmJMtAcgxzOtPWhovmksGdfYdjcJ91ui0PsbnOI6kjlTWkJjlyKuJfi2HadHS7br+cTaRp4jx
        ExazdFTlBZrMJuWO9LTQEpnH0zDkf2CG2fIGJMx9+REzktNXGy+9NGg9J8tkaxIOP61YEIYU7+atR
        794M51g4TeTdMj2msY7f8K706gB++CxPSn+EZ11ZsdUxekBUBaL76iBmsz3bqqGN5OF/oBQazcePB
        CpSngt1fhU6u08v6PGIS5amFM4AMGLVd2LpvBX/6V7gOORCaC0B5wXyB6pV1zVlQnrDt/5Q+PBQxu
        EDN7he9w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTBC-0006Bh-4G; Fri, 03 Jul 2020 21:25:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 3/3] Documentation: trace/stm: drop doubled words
Date:   Fri,  3 Jul 2020 14:24:53 -0700
Message-Id: <20200703212453.30553-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703212453.30553-1-rdunlap@infradead.org>
References: <20200703212453.30553-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "and and" to "and an".
Fix spello of "example".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 Documentation/trace/stm.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/trace/stm.rst
+++ linux-next-20200701/Documentation/trace/stm.rst
@@ -33,8 +33,8 @@ This policy is a tree structure containi
 have a name (string identifier) and a range of masters and channels
 associated with it, located in "stp-policy" subsystem directory in
 configfs. The topmost directory's name (the policy) is formatted as
-the STM device name to which this policy applies and and arbitrary
-string identifier separated by a stop. From the examle above, a rule
+the STM device name to which this policy applies and an arbitrary
+string identifier separated by a stop. From the example above, a rule
 may look like this::
 
 	$ ls /config/stp-policy/dummy_stm.my-policy/user
