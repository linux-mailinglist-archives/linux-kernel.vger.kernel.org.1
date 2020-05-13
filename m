Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD631D13F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgEMNFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:05:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725967AbgEMNFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589375152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TJdFyMgfGZgfld7LMBLUHKi9LQK5NbAS1ZzjvMWCw+8=;
        b=FlzewjQK3MEiJCrPb+s7ESxbISxYG6up0AaWgrm5blricfsoHpe+v8rG7yxGTdSAN9unw1
        D0L40VjyngTFWDkTiRJY7BVSXJ4yP5JZffqaT0ioh4D1DdmALDL6hB9itXwTsvkzDw3lAl
        BOV0wKOnFpscQ6S/HyGdeNH7Lm4anik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-gplqFkXGN0KWL4DLM3W7SQ-1; Wed, 13 May 2020 09:05:49 -0400
X-MC-Unique: gplqFkXGN0KWL4DLM3W7SQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C22938015CE;
        Wed, 13 May 2020 13:05:47 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-110.ams2.redhat.com [10.36.115.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 230156E705;
        Wed, 13 May 2020 13:05:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-wmi: Ignore keyboard attached / detached events
Date:   Wed, 13 May 2020 15:05:44 +0200
Message-Id: <20200513130544.90243-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore events with a type of 0x0011 and a code of 0xfff2 / 0xfff3,
this silences the following messages being logged when the keyboard is
detached / attached on a Dell Venue 11 Pro 7130:

[   63.621953] dell_wmi: Unknown key with type 0x0011 and code 0xfff2 pressed
[   70.240558] dell_wmi: Unknown key with type 0x0011 and code 0xfff3 pressed

Note SW_TABLET_MODE is already reported through the intel_vbtn driver on
this and other Dell devices, so dell_wmi should not report this too,
to avoid duplicate events.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/dell-wmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 86e8dd6a8b33..c25a4286d766 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -310,6 +310,16 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
 	/* Battery inserted */
 	{ KE_IGNORE, 0xfff1, { KEY_RESERVED } },
 
+	/*
+	 * Detachable keyboard detached / undocked
+	 * Note SW_TABLET_MODE is already reported through the intel_vbtn
+	 * driver for this, so we ignore it.
+	 */
+	{ KE_IGNORE, 0xfff2, { KEY_RESERVED } },
+
+	/* Detachable keyboard attached / docked */
+	{ KE_IGNORE, 0xfff3, { KEY_RESERVED } },
+
 	/* Keyboard backlight level changed */
 	{ KE_IGNORE, KBD_LED_OFF_TOKEN,      { KEY_RESERVED } },
 	{ KE_IGNORE, KBD_LED_ON_TOKEN,       { KEY_RESERVED } },
-- 
2.26.0

