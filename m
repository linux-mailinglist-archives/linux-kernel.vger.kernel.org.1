Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E877B29BE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1794650AbgJ0PMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:12:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1791007AbgJ0PFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:05:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A0CEAC1F;
        Tue, 27 Oct 2020 15:05:47 +0000 (UTC)
Date:   Tue, 27 Oct 2020 16:05:46 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] MAINTAINERS: The DMI/SMBIOS tree has moved
Message-ID: <20201027160546.192dcc67@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I switched from quilt to git as requested by Stephen Rothwell. Update
the link to the new place.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.10-rc1.orig/MAINTAINERS	2020-10-25 23:14:11.000000000 +0100
+++ linux-5.10-rc1/MAINTAINERS	2020-10-27 15:57:01.310612464 +0100
@@ -5286,7 +5286,7 @@ F:	drivers/hwmon/dme1737.c
 DMI/SMBIOS SUPPORT
 M:	Jean Delvare <jdelvare@suse.com>
 S:	Maintained
-T:	quilt http://jdelvare.nerim.net/devel/linux/jdelvare-dmi/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-next
 F:	Documentation/ABI/testing/sysfs-firmware-dmi-tables
 F:	drivers/firmware/dmi-id.c
 F:	drivers/firmware/dmi_scan.c


-- 
Jean Delvare
SUSE L3 Support
