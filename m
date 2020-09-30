Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6073A27DE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgI3CN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:13:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:21945 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbgI3CNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:13:25 -0400
IronPort-SDR: ESVx8QTJrzDO8SK1EyI/TQmLRiRx1/KRzrxEt+FNJIpVp3vEXTzpzHUbVjiy8kd5XvPzm0lBtN
 XB83eB+x9ASA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149992008"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="149992008"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:13:21 -0700
IronPort-SDR: oD+wpQ83lgHjtLryVk13QOBizqvTGEj8ruT7JYbX9kE18aTEoPnZHRpeUxoQhxKDxo/eDZJEGx
 Bqsa/arKLgvw==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457486652"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:13:21 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mce severity quirk & cleanup
Date:   Tue, 29 Sep 2020 19:13:11 -0700
Message-Id: <20200930021313.31810-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200927221917.GB4746@zn.tnic>
References: <20200927221917.GB4746@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part 0001 is a cleaned up version of a suggested patch from Boris.
Changes:
	Moved the new rule after the "standard" action optional rules
	[The old location was OK, but this feels better]
	Added comment explaining what the new rule does
	Make formatting match existing style
	Add some spaces after commas the appease checkpatch
	Fix logic to match bank number range
	Change cpu_stepping to cpu_minstepping
	Change logic so rule applies to any stepping >= cpu_minstepping
	Dropped CamelCase from string (s/"UnCorrected/Uncorrected/)
But those were all minor so I left Boris as Author. Which means
the checkpatch hates this because it doesn't have a Signed-off-by: Boris.

Part 0002 is just a cleanup I noticed while reading through the rules
to decide where to put the new one. This AMD rule has been hiding in
plain sight for years. Drop it.

Borislav Petkov (1):
  x86/mce: Add Skylake quirk for patrol scrub reported errors

Tony Luck (1):
  x86/mce: Drop AMD specific "DEFERRED" case from Intel severity rule
    list

 arch/x86/kernel/cpu/mce/severity.c | 32 ++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.21.1

