Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB382D4200
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgLIMSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731611AbgLIMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607516214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGNvVuHxlofEiNqFwm4S5XvgARTAcfm7dvdf/jd/fjk=;
        b=H4pc/ExOcw0h+p+FFgqgAilcnzYtx+9FB1ZWESHBx0vI3RTx0M6njErjzYyu37INE99kOq
        ruZKdBvO8VDao2dau9IZbVOeOKh09NPnfZiIBx6RMqcTEmnjQWDxzeGwkJZ96DS8IJ9rhG
        UQ3q/JS8yHPVXxhZs3gCj2f7zheMMFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-jxs4pzDNPgK02AI51EzWGA-1; Wed, 09 Dec 2020 07:16:51 -0500
X-MC-Unique: jxs4pzDNPgK02AI51EzWGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00AA6A0CDC;
        Wed,  9 Dec 2020 12:16:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBA2460BD8;
        Wed,  9 Dec 2020 12:16:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/18] certs: Replace K{U,G}IDT_INIT() with
 GLOBAL_ROOT_{U,G}ID
From:   David Howells <dhowells@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
        David Woodhouse <dwmw2@infradead.org>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Dec 2020 12:16:42 +0000
Message-ID: <160751620296.1238376.1118832878833351723.stgit@warthog.procyon.org.uk>
In-Reply-To: <160751606428.1238376.14935502103503420781.stgit@warthog.procyon.org.uk>
References: <160751606428.1238376.14935502103503420781.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Align with the new macros and add appropriate include files.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---

 certs/blacklist.c      |    4 ++--
 certs/system_keyring.c |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 029471947838..bffe4c6f4a9e 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -14,6 +14,7 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/seq_file.h>
+#include <linux/uidgid.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
 
@@ -156,8 +157,7 @@ static int __init blacklist_init(void)
 
 	blacklist_keyring =
 		keyring_alloc(".blacklist",
-			      KUIDT_INIT(0), KGIDT_INIT(0),
-			      current_cred(),
+			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
 			      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
 			      KEY_USR_VIEW | KEY_USR_READ |
 			      KEY_USR_SEARCH,
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 798291177186..4b693da488f1 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -11,6 +11,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/uidgid.h>
 #include <linux/verification.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
@@ -98,7 +99,7 @@ static __init int system_trusted_keyring_init(void)
 
 	builtin_trusted_keys =
 		keyring_alloc(".builtin_trusted_keys",
-			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
+			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
 			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
 			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
 			      KEY_ALLOC_NOT_IN_QUOTA,
@@ -109,7 +110,7 @@ static __init int system_trusted_keyring_init(void)
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 	secondary_trusted_keys =
 		keyring_alloc(".secondary_trusted_keys",
-			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
+			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
 			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
 			       KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
 			       KEY_USR_WRITE),


