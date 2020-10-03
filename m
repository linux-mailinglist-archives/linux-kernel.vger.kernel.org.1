Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34E282205
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 09:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgJCHcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 03:32:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCHcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 03:32:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601710374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/+WtWwRXTD0BjBTHb1/FJ6JZp3AokR9+zD+bpTXewJY=;
        b=GlzssYPKtZlr4ZpQYxu6NlxGBF78a5Xni4mwOrQB7WCX/va+IwlAEog0YjtpuFXaUDFShD
        1K0y3l2xgYbm2Xi88Wu703O+Q2nb3QNN7CKYbUFxTeX+/9LqnI9nodyev5No1P9qJovkN1
        niF1OPRlribG7yIN7bEIt5vnx/CU60s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F068B1AC;
        Sat,  3 Oct 2020 07:32:54 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.9-rc8
Date:   Sat,  3 Oct 2020 09:32:53 +0200
Message-Id: <20201003073253.1861-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9b-rc8-tag

xen: branch for v5.9-rc8

In contains a fix for a regression introduced with 5.9-rc3 which caused
a system running as fully virtualized guest under Xen to crash when
using legacy devices like a floppy.

Thanks.

Juergen

 drivers/xen/events/events_base.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

Juergen Gross (1):
      xen/events: don't use chip_data for legacy IRQs
