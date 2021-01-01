Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2222E82E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 05:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAAEPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 23:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhAAEPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 23:15:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07137C061573;
        Thu, 31 Dec 2020 20:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MrqRlFnmAr3VO2kikjWYwVGKANP+pM6Y3zXnpk6GwW8=; b=OUvivIw3gcgN56o2JgejJMVBYy
        o+iQ18C+kRx+P9ZvX4S6HvnKNhitdQcAt5k/oX2HjLas5kwyNibSh/KxBA09hsn5XYa1UvM7eNnt/
        Ok0vt9+X5z72MfXhgZSP0hH8w9PbaW0uLo+ZJxDBkZUT/N/Ait8qV2kO4UqqcqV2DABMaaP6An/XJ
        IpyzMs6paBZ1IV5pWz6CDvCDXXtKD+JHWVyoUemxW3G58n65MqX0Eh5Wwl32K8GoHfzxOnGGTOvPK
        DyWW39ysvor44Z/vbEH1RSOPJudkBFLY8m/T3EOIPU+CAiZLrEF99L4gYXZyz/HlvCxTN4GrWfRk2
        cCP+RFyQ==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kvBpw-0006Q6-24; Fri, 01 Jan 2021 04:14:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH RESEND] ia64: remove duplicate entries in generic_defconfig
Date:   Thu, 31 Dec 2020 20:14:42 -0800
Message-Id: <20210101041442.4591-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ia64 generic_defconfig duplicate entries, as warned by:

  + arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA:  => 58
  + arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA_PIIX:  => 59

These 2 symbols still have the same value as in the removed lines.

Fixes: c331649e6371 ("ia64: Use libata instead of the legacy ide driver in defconfigs")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
#Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/configs/generic_defconfig |    2 --
 1 file changed, 2 deletions(-)

--- lnx-511-rc1.orig/arch/ia64/configs/generic_defconfig
+++ lnx-511-rc1/arch/ia64/configs/generic_defconfig
@@ -55,8 +55,6 @@ CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_QLOGIC_1280=y
-CONFIG_ATA=y
-CONFIG_ATA_PIIX=y
 CONFIG_SATA_VITESSE=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
