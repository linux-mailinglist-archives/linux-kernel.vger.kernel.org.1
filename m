Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF32FD7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404141AbhATSGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404227AbhATSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611165860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1GXrOUwM/xz1zXm3jo8tlIQfyarpq6lkJQ5j7tI259Q=;
        b=EZujm9M/aXA149l1OnH9Th8DYcfz+JvV+y7+A7nOcmPFePJHCC4et4CVYK3JP7LnyuMwTL
        U58QvAanclR7MBhkaRE89cADqHy3hvGLnFymMgWo8IO2iv1DTYtS6NQOhDBDiWKOigx3Hh
        eDlYzoPTQCx8f6266exBCqXEDAIKfHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-zFtO4mB7P7-x0G5JXOdyVg-1; Wed, 20 Jan 2021 13:04:16 -0500
X-MC-Unique: zFtO4mB7P7-x0G5JXOdyVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E0EF107ACF9;
        Wed, 20 Jan 2021 18:04:15 +0000 (UTC)
Received: from treble (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D829927C38;
        Wed, 20 Jan 2021 18:04:13 +0000 (UTC)
Date:   Wed, 20 Jan 2021 12:04:10 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Question about CONFIG_DEBUG_SECTION_MISMATCH
Message-ID: <20210120180410.taayippxf2wdrvpx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

I have a question about CONFIG_DEBUG_SECTION_MISMATCH's use of
-fno-inline-functions-called-once.

	  - Add the option -fno-inline-functions-called-once to gcc commands.
	    When inlining a function annotated with __init in a non-init
	    function, we would lose the section information and thus
	    the analysis would not catch the illegal reference.
	    This option tells gcc to inline less (but it does result in
	    a larger kernel).

Is -fno-inline-functions-called-once really needed?

From what I can tell, a .text function inlining an .init.text function
should be harmless unless the inlined function either referenced another
.init.text function, or referenced .init.data.  In either case, that
would be detected by modpost.

Or am I missing another scenario where this flag would be needed?

I verified this with the following patch, it detected a mismatch even
without CONFIG_DEBUG_SECTION_MISMATCH.

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6bd20c0de8bc..c3e41a3abc7e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -153,6 +153,18 @@ static inline void imcr_apic_to_pic(void)
  */
 static int force_enable_local_apic __initdata;
 
+static int __init foo(void)
+{
+	if (force_enable_local_apic)
+		return 1;
+	return 0;
+}
+
+int bar(void)
+{
+	return foo();
+}
+
 /*
  * APIC command line parameters
  */

-- 
Josh

