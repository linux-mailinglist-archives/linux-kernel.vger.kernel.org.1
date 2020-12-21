Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D542DFED9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgLURPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:15:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbgLURPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608570814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=7pqn2JGHK+dc23AjkYsCglPOVdkvRbSf1p9vS6vCeVw=;
        b=Stp+gioDtW1Kf9Jo9DLcI/phGOZtRjuVLQkQjvxa79w4Sj6BDeLljuh9gAfCN/ysonuxDk
        luKPMSz2p0Ub5Xf5br77iyDo+5dZAmY7or844kPIPN5eIA93LLmxzuWJDCqaxlZvjPWhAX
        HVtebiyp/z/GQK0nJJhO615IZ6qIxbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-vZvWK-78OFyNa94IgtnLVg-1; Mon, 21 Dec 2020 12:13:32 -0500
X-MC-Unique: vZvWK-78OFyNa94IgtnLVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 460CF192CC44;
        Mon, 21 Dec 2020 17:13:31 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29EF5D9CA;
        Mon, 21 Dec 2020 17:13:29 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux Containers List <containers@lists.linux-foundation.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Eric Paris <eparis@parisplace.org>, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v10 02/11] AUDIT_CONTAINER_ID message type basic support
Date:   Mon, 21 Dec 2020 12:12:42 -0500
Message-Id: <20201221171251.2610890-3-rgb@redhat.com>
In-Reply-To: <20201221171251.2610890-1-rgb@redhat.com>
References: <20201221171251.2610890-1-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines the message number for the audit container identifier
information record should the kernel headers not be up to date and gives
the record number a name for printing.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 lib/libaudit.h    | 4 ++++
 lib/msg_typetab.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/lib/libaudit.h b/lib/libaudit.h
index 7fe56f4c8b22..3b0b1e8d0d22 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -303,6 +303,10 @@ extern "C" {
 #define AUDIT_EVENT_LISTENER		1335 /* audit mcast sock join/part */
 #endif
 
+#ifndef AUDIT_CONTAINER_ID
+#define AUDIT_CONTAINER_ID	1336 /* Container ID */
+#endif
+
 #ifndef AUDIT_MAC_CALIPSO_ADD
 #define AUDIT_MAC_CALIPSO_ADD	1418 /* NetLabel: add CALIPSO DOI entry */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 376e121e1278..9484bdce6776 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -128,6 +128,7 @@ _S(AUDIT_TIME_INJOFFSET,             "TIME_INJOFFSET"                )
 _S(AUDIT_TIME_ADJNTPVAL,             "TIME_ADJNTPVAL"                )
 _S(AUDIT_BPF,                        "BPF"                           )
 _S(AUDIT_EVENT_LISTENER,             "EVENT_LISTENER"                )
+_S(AUDIT_CONTAINER_ID,               "CONTAINER_ID"                  )
 _S(AUDIT_AVC,                        "AVC"                           )
 _S(AUDIT_SELINUX_ERR,                "SELINUX_ERR"                   )
 _S(AUDIT_AVC_PATH,                   "AVC_PATH"                      )
-- 
2.18.4

