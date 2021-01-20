Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010E12FD393
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390537AbhATPKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:10:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:55910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390847AbhATPC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:02:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611154917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=m7srsmxDA9KjSDC+TJIunYM98xh9J4fMt0s9IFyl2Ss=;
        b=o1+M23ZxBCc3ekTTopL0BHt4F3NXO4bgZ0Gcrlr40wCCipOIP5yuY8BHvdiXQq+pAbuZFO
        0paSsLSgFB5IS6IJj/pRt2WskChd14GJ62QG3su20kdUuKgQj2AxOSE7jyRxhGqn3Tuk8T
        d2j9e2lRXOSRYhtMR5IJPhYlZO93bS8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7778AC85;
        Wed, 20 Jan 2021 15:01:57 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.11-rc5
Date:   Wed, 20 Jan 2021 16:01:57 +0100
Message-Id: <20210120150157.5289-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc5-tag

xen: branch for v5.11-rc5

It contains a fix for build failure showing up in some configurations.


Thanks.

Juergen

 arch/x86/xen/smp_hvm.c | 2 ++
 1 file changed, 2 insertions(+)

Randy Dunlap (1):
      x86/xen: fix 'nopvspin' build error
