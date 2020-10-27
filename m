Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCD29A8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896048AbgJ0Jvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896012AbgJ0Jvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:41 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F61F20759;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=hi1aczpcTujPkeB1XjLIT9pw1YvDNzWxbCRXWh+zmzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1C1zmpOKFZry8h3pojoTZWkDqiyrL6Im4uIMCr0CHw3kfDHaEHTGUieXVjrib+ynq
         ypTLeQXqwgpDFbX07vKXLcvqh8FmjvggVl38jKaBDtnqS+eHSVcDzLySMPYbdRj62B
         7peDNeC+xHZSpofhqxrtswRZfPLZl5cbGxHzTbgs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FEc-0i; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Luke Nelson <lukenels@cs.washington.edu>,
        Mahesh Bandewar <maheshb@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Simon Horman <horms@verge.net.au>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/32] docs: admin-guide: net.rst: add a missing blank line
Date:   Tue, 27 Oct 2020 10:51:08 +0100
Message-Id: <b2545be4a4c71269d10278b5990c3e06c4b65f84.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing blank line after a literal block, which
causes this warning:

	Documentation/admin-guide/sysctl/net.rst:303: WARNING: Literal block ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/net.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 57fd6ce68fe0..f2ab8a5b6a4b 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -300,6 +300,7 @@ Note:
       0:    0     1     2     3     4     5     6     7
   RSS hash key:
   84:50:f4:00:a8:15:d1:a7:e9:7f:1d:60:35:c7:47:25:42:97:74:ca:56:bb:b6:a1:d8:43:e3:c9:0c:fd:17:55:c2:3a:4d:69:ed:f1:42:89
+
 netdev_tstamp_prequeue
 ----------------------
 
-- 
2.26.2

