Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F652858BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgJGGiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgJGGiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:38:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602052685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3kOyoKtsiwS+tjIZ6dzqH1KCmgJdwgCsiyneWCC8R6M=;
        b=avIV58ZPj1GRAdoykPhUo3Pb+VuebfM0SYxiddm2n+p0Cvd77cb6VdKI7RCVOsx232QccN
        jcxMzjWOhbuYQMQdUmP6lUEzjthAElIa36MGYYx42V3FgYU67XNi6sminKmixQ4fV01Wwu
        SbYRFgneC0vPBvNzoU/ByaqpJ96KozU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16D46AC0C;
        Wed,  7 Oct 2020 06:38:05 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.9-rc9
Date:   Wed,  7 Oct 2020 08:38:04 +0200
Message-Id: <20201007063804.21597-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9b-rc9-tag

xen: branch for v5.9-rc9

It contains one fix for a regression when booting as a Xen guest on
ARM64 introduced probably during the 5.9 cycle. It is very low risk as
it is modifying Xen specific code only. The exact commit introducing
the bug hasn't been identified yet, but everything was fine in 5.8 and
only in 5.9 some configurations started to fail.


Thanks.

Juergen

 arch/arm/xen/enlighten.c | 2 +-
 include/xen/arm/page.h   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

Masami Hiramatsu (1):
      arm/arm64: xen: Fix to convert percpu address to gfn correctly
