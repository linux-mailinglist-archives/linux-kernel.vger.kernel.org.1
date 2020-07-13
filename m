Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006F2219FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGIMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 08:09:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbgGIMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594296561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ex8pOiGF4BfjdTyVdbbdnbvgebKWwF1cB3L99MgdkaI=;
        b=TZl2ny0XqyqZddaDABMqaUXLKTnWgU+5Y7FGFYZQm60TIBPV36/Cd+q7/3EAvZi/3hWyXw
        5/fr4od4iYQVfldhEXXInx0EVxjAPYL8fCCnyQn2TtcgzLhKnme0xkzRYbHsckKnThma9A
        vvuUg2yiqu4J4HhKZFN/bFjLymTrw44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-Bg48lVlnNq-uzxt_YZe60Q-1; Thu, 09 Jul 2020 08:09:19 -0400
X-MC-Unique: Bg48lVlnNq-uzxt_YZe60Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DA5419057A6;
        Thu,  9 Jul 2020 12:09:18 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-29.ams2.redhat.com [10.36.115.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52FB21002382;
        Thu,  9 Jul 2020 12:09:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH resend v2 6/8] virt: vbox: Add a few new vmmdev request types to the userspace whitelist
Date:   Thu,  9 Jul 2020 14:08:56 +0200
Message-Id: <20200709120858.63928-7-hdegoede@redhat.com>
In-Reply-To: <20200709120858.63928-1-hdegoede@redhat.com>
References: <20200709120858.63928-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream VirtualBox has defined and is using a few new request types for
vmmdev requests passed through /dev/vboxguest to the hypervisor.

Add the defines for these to vbox_vmmdev_types.h and add add them to the
whitelists of vmmdev requests which userspace is allowed to make.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1789545
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 2 ++
 include/uapi/linux/vbox_vmmdev_types.h  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 4f1addaa3f6f..ffd76b949276 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1299,7 +1299,9 @@ static int vbg_req_allowed(struct vbg_dev *gdev, struct vbg_session *session,
 	case VMMDEVREQ_VIDEO_ACCEL_ENABLE:
 	case VMMDEVREQ_VIDEO_ACCEL_FLUSH:
 	case VMMDEVREQ_VIDEO_SET_VISIBLE_REGION:
+	case VMMDEVREQ_VIDEO_UPDATE_MONITOR_POSITIONS:
 	case VMMDEVREQ_GET_DISPLAY_CHANGE_REQEX:
+	case VMMDEVREQ_GET_DISPLAY_CHANGE_REQ_MULTI:
 	case VMMDEVREQ_GET_SEAMLESS_CHANGE_REQ:
 	case VMMDEVREQ_GET_VRDPCHANGE_REQ:
 	case VMMDEVREQ_LOG_STRING:
diff --git a/include/uapi/linux/vbox_vmmdev_types.h b/include/uapi/linux/vbox_vmmdev_types.h
index c27289fd619a..f8a8d6b3c521 100644
--- a/include/uapi/linux/vbox_vmmdev_types.h
+++ b/include/uapi/linux/vbox_vmmdev_types.h
@@ -63,6 +63,7 @@ enum vmmdev_request_type {
 	VMMDEVREQ_SET_GUEST_CAPABILITIES       = 56,
 	VMMDEVREQ_VIDEMODE_SUPPORTED2          = 57, /* since version 3.2.0 */
 	VMMDEVREQ_GET_DISPLAY_CHANGE_REQEX     = 80, /* since version 4.2.4 */
+	VMMDEVREQ_GET_DISPLAY_CHANGE_REQ_MULTI = 81,
 	VMMDEVREQ_HGCM_CONNECT                 = 60,
 	VMMDEVREQ_HGCM_DISCONNECT              = 61,
 	VMMDEVREQ_HGCM_CALL32                  = 62,
@@ -92,6 +93,8 @@ enum vmmdev_request_type {
 	VMMDEVREQ_WRITE_COREDUMP               = 218,
 	VMMDEVREQ_GUEST_HEARTBEAT              = 219,
 	VMMDEVREQ_HEARTBEAT_CONFIGURE          = 220,
+	VMMDEVREQ_NT_BUG_CHECK                 = 221,
+	VMMDEVREQ_VIDEO_UPDATE_MONITOR_POSITIONS = 222,
 	/* Ensure the enum is a 32 bit data-type */
 	VMMDEVREQ_SIZEHACK                     = 0x7fffffff
 };
-- 
2.26.2

