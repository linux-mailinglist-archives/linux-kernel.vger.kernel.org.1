Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9020B6DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFZRYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 13:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZRYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:24:32 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43412065F;
        Fri, 26 Jun 2020 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192272;
        bh=48ef7qge/7W4hOz5TEC0gCJi8dSrC9BDoAS5jwJ9+jc=;
        h=From:To:Cc:Subject:Date:From;
        b=oIEMGVUPNYAwKupcFz1JcVQnTOgdilV9g7gLr0SQFLvRW6zZOsq5Vc1Z/1HIy0rqP
         ZWMty4pDYpGyM0G+KdLZv8D61Rfh/WIwJbMASCv8+A5loFZXKzEQnneK5qyn/EijpR
         E+/328UR6+bvVMyDzvGhGhlrwkUHsQGn02HMXbVE=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH fsgsbase v2 0/4] x86/fsgsbase: Some fixes
Date:   Fri, 26 Jun 2020 10:24:26 -0700
Message-Id: <cover.1593192140.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These apply to tip:x86/fsgsbase.

The first two are trivial selftest fixes.  The third one fixes an actual
regression.  The forth one fixes a crash on boot on Xen PV.

Andy Lutomirski (4):
  selftests/x86/fsgsbase: Fix a comment in the ptrace_write_gsbase test
  selftests/x86/fsgsbase: Add a missing memory constraint
  x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase and gsbase
  x86/fsgsbase: Fix Xen PV support

 arch/x86/include/asm/fsgsbase.h               |   2 +
 arch/x86/kernel/process_64.c                  |  24 +-
 arch/x86/kernel/ptrace.c                      |  43 ++-
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/fsgsbase.c        |   6 +-
 .../testing/selftests/x86/fsgsbase_restore.c  | 245 ++++++++++++++++++
 6 files changed, 298 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/x86/fsgsbase_restore.c

-- 
2.25.4

