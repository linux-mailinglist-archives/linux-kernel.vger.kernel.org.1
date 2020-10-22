Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E229597C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508804AbgJVHme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:42:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508780AbgJVHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:42:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603352546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHAk3DX3D0x2mTNVKivpF51Q9ju8eawUFMYlwMlLqII=;
        b=vFm0SaytDZT7HUOYCTHQFDI2uCpz4rcWn77wHy8dww39cSM0pDpTkPn9YL7t2Ax4aJ+HEd
        CKnHFM48SdWPOubGznfdTt+CRYTHR3c+F8RNasbOnBpcyAA1OELv3r1MrFsuGFUS0dqV6z
        1EeT51axrFMSZOTmfRvoS8dRL0W18j8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60548B1A6;
        Thu, 22 Oct 2020 07:42:26 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/5] Documentation: add xen.fifo_events kernel parameter description
Date:   Thu, 22 Oct 2020 09:42:14 +0200
Message-Id: <20201022074214.21693-6-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022074214.21693-1-jgross@suse.com>
References: <20201022074214.21693-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel boot parameter xen.fifo_events isn't listed in
Documentation/admin-guide/kernel-parameters.txt. Add it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 02d4adbf98d2..526d65d8573a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5978,6 +5978,13 @@
 			After which time (jiffies) the event handling loop
 			should start to delay EOI handling. Default is 2.
 
+	xen.fifo_events=	[XEN]
+			Boolean parameter to disable using fifo event handling
+			even if available. Normally fifo event handling is
+			preferred over the 2-level event handling, as it is
+			fairer and the number of possible event channels is
+			much higher. Default is on (use fifo events).
+
 	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
 			Disables the PV optimizations forcing the guest to run
 			as generic guest with no PV drivers. Currently support
-- 
2.26.2

