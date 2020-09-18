Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ACE26F4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIRDZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:25:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40595 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgIRDZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600399557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=c4VwO85A9+mp2WVd9k1jCoZ5nINLwE7TYvBJh3ITwsc=;
        b=Mj5qhOHsdC7TlnuAKUfy3jcDwziSw2zexpI747L4HsPOefBIYYlX7pws4DqOZR9V4LYt1D
        y43BPPyJjleBCDq+gYbr/M5GC0abCb69cEHBPamliDb70Q7vRutUDyRgJG6Xbm+AJLGdqv
        0rXXXmmq/1ePN8go9Ju1Tf1O9yI6Yhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-amqInmCUM3OsoF9jT9LLFg-1; Thu, 17 Sep 2020 23:25:53 -0400
X-MC-Unique: amqInmCUM3OsoF9jT9LLFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01900188C12D;
        Fri, 18 Sep 2020 03:25:52 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-81.pek2.redhat.com [10.72.13.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 970EF78806;
        Fri, 18 Sep 2020 03:25:49 +0000 (UTC)
Date:   Fri, 18 Sep 2020 11:25:46 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crash_kexec_post_notifiers enables running various panic notifier
before kdump kernel booting. This increases risks of kdump failure.
It is well documented in kernel-parameters.txt. We do not suggest
people to enable it together with kdump unless he/she is really sure.
This is also not suggested to be enabled by default when users are
not aware in distributions.

But unfortunately it is enabled by default in systemd, see below
discussions in a systemd report, we can not convince systemd to change
it:
https://github.com/systemd/systemd/issues/16661

Actually we have got reports about kdump kernel hangs in both s390x
and powerpcle cases caused by the systemd change,  also some x86 cases
could also be caused by the same (although that is in Hyper-V code
instead of systemd, that need to be addressed separately).

Thus to avoid the auto enablement here just disable the param writable
permission in sysfs.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index aef8872ba843..bea44fc4eb3b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -695,7 +695,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
-core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
+core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0444);
 
 static int __init oops_setup(char *s)
 {
-- 
2.26.2

