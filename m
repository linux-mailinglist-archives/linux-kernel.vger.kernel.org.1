Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734BD1AB230
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437231AbgDOT6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:58:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:61251 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406322AbgDOT63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:58:29 -0400
IronPort-SDR: p8a6T785DvUd9plRKDfqX0yT8DCABhbt8yTwQXme4lbTmJpt6t9QRsF7Agq3fbSxklU8ul7Ae7
 lJyKNyg+B6pw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:58:27 -0700
IronPort-SDR: yg9WPGwZLVgnXTFOAcwWaX/efMtQ+0NL7uYyxiBr7rGkAcc1kbJTFi3jlVOd5P91xhD/fdU1ZB
 HAe9W15L2M5g==
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="332601244"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:58:27 -0700
Date:   Wed, 15 Apr 2020 12:58:26 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     x86 <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce: Drop bogus comment about mce.kflags
Message-ID: <20200415195826.GA13681@agluck-desk2.amr.corp.intel.com>
References: <20200214222720.13168-4-tony.luck@intel.com>
 <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
 <3908561D78D1C84285E8C5FCA982C28F7F5E6485@ORSMSX115.amr.corp.intel.com>
 <20200415183620.GJ31362@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415183620.GJ31362@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit definitions for kflags are for internal use only. A
late edit moved them from uapi/asm/mce.h to the internal
x86 <asm/mce.h>, but the comment saying "See below" was
accidentally left here.

Delete "See below". Just labelling this field as internal
kernel use is sufficient.

Fixes: 1de08dccd383 ("x86/mce: Add a struct mce.kflags field")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/uapi/asm/mce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 5b59d80f1d4e..db9adc081c5a 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -35,7 +35,7 @@ struct mce {
 	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
-	__u64 kflags;		/* Internal kernel use. See below */
+	__u64 kflags;		/* Internal kernel use */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
-- 
2.21.1

