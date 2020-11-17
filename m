Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612A92B72A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKQXuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:50:04 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:64212 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605657004; x=1637193004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NsooXFHOWr3MCcXHpiOu1H77DgrvYEDFl8FNJtf2Dtc=;
  b=ObiPXgndJ3c3PdFsNcUTu5x/ZQ8lGWrGnNXz0yjvrcAekUFQAv0BPhvF
   +f8Kzh5B8yLhe05nmxMdNIB/l3aNzyIs0DA2hy0gIQ594KsxXrd7Ay8rf
   qTvYoMCl5Zd4obbe2ojGa4DCcCIQ9WplPgI+vjckT9y8CgNUNUbQeLl2C
   o=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="88141683"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Nov 2020 23:49:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 01AF6120DAD;
        Tue, 17 Nov 2020 23:49:56 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:56 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:56 +0000
Received: from localhost (10.143.193.228) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Nov 2020 23:49:55 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v1 3/3] Documentation/l1d_flush: Fix up warning with labels
Date:   Wed, 18 Nov 2020 10:49:34 +1100
Message-ID: <20201117234934.25985-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117234934.25985-1-sblbir@amazon.com>
References: <20201117234934.25985-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a label to spec_set_ctrl to remove the build warning.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
To be applied on top of tip commit id
767d46ab566dd489733666efe48732d523c8c332

 Documentation/admin-guide/hw-vuln/l1d_flush.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
index c6a0713c8271..108bd2bdc196 100644
--- a/Documentation/admin-guide/hw-vuln/l1d_flush.rst
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -22,8 +22,8 @@ mechanism
 Usage Guidelines
 ----------------
 
-Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst` for
-details.
+Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst
+<set_spec_ctrl>` for details.
 
 **NOTE**: The feature is disabled by default, applications need to
 specifically opt into the feature to enable it.
-- 
2.17.1

