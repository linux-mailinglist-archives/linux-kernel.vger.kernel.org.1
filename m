Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE12BA21E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgKTF7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:59:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:46236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgKTF7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:59:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605851988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4Y4Wnq1UGB9RNhSifrdmnGmDAtM2j7xXdf7kH9LivWw=;
        b=vEMkUgS5AVxLFI5pSm7zN2Bo7HxVN40A2ppZ/3Iv2yCpBhAz53lRbj6N48N+lWCSsLmjqv
        MwvNOU7ej3Hoh6W+Ne2vInmIkxaN7lCae6EfrVVkrExbYaac34a2jVl0hvWbmo7PLCuDno
        tcksr+CkmRYCxaCziHtuROZ/1LKLGvU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 173E5AC23;
        Fri, 20 Nov 2020 05:59:48 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.10-rc5
Date:   Fri, 20 Nov 2020 06:59:47 +0100
Message-Id: <20201120055947.613-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc5-tag

xen: branch for v5.10-rc5

It contains a single fix for avoiding WARN splats when booting a Xen
guest with nosmt.

Thanks.

Juergen

 arch/x86/xen/spinlock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Brian Masney (1):
      x86/xen: don't unbind uninitialized lock_kicker_irq
