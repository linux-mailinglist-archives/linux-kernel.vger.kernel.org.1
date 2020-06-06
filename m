Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5431F0739
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgFFPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 11:13:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgFFPNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:13:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED952B12C;
        Sat,  6 Jun 2020 15:13:25 +0000 (UTC)
Date:   Sat, 6 Jun 2020 17:13:20 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmi update for v5.8
Message-ID: <20200606171320.6023bedd@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem updates for Linux v5.8 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 drivers/firmware/dmi-id.c       |  6 ++++++
 drivers/firmware/dmi_scan.c     | 30 ++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |  2 ++
 scripts/mod/file2alias.c        |  2 ++
 4 files changed, 40 insertions(+)

---------------

Erwan Velu (1):
      firmware/dmi: Report DMI Bios & EC firmware release

Thanks,
-- 
Jean Delvare
SUSE L3 Support
