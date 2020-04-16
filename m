Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3121AD19F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 22:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgDPU54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 16:57:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:8859 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbgDPU5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:57:55 -0400
IronPort-SDR: F+Z2xSN60pUi54Wqzi+G3UreIE3Jof/2ifk5FwKC/EQ+s1T7VNh5o0L762RMDyA0RHfAMO7Wux
 Oi9s/MEXA0VA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:55 -0700
IronPort-SDR: KEnMPUa8lLPqN/XcA4I6zbWBmIj2gzdK42iYgWFpbb1YDwxynCERlGv1Xf/WDh9SLwwzR5IZRb
 2JyZFBjFdD3w==
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="427982519"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:54 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 0/3] Split lock enumeration cleanup and fixes
Date:   Thu, 16 Apr 2020 13:57:51 -0700
Message-Id: <20200416205754.21177-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to revisit the sequence of operations when testing for the
split lock detect feature. It is model specific, so we must check
the model number before looking at CORE_CAPABILITIES.

I marked it all for stable ... some tweaking would be needed if
the  X86_MATCH_INTEL stuff from v5.7 doesn't get backported.

Tony Luck (3):
  x86/split_lock: Update to use X86_MATCH_INTEL_FAM6_MODEL()
  x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
  x86/split_lock: Add Tremont family CPU models

 arch/x86/kernel/cpu/intel.c | 41 +++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

-- 
2.21.1

