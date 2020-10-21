Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C69029493B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502227AbgJUIQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:16:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731252AbgJUIQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:16:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60CEEAD20;
        Wed, 21 Oct 2020 08:16:02 +0000 (UTC)
Date:   Wed, 21 Oct 2020 10:16:01 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmi update for v5.10
Message-ID: <20201021101601.70393ac4@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem updates/fixes for Linux v5.10 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 drivers/firmware/dmi_scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---------------

Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: DMI/SMBIOS SUPPORT

Thanks,
-- 
Jean Delvare
SUSE L3 Support
