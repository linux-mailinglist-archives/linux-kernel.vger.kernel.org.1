Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15B1284D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgJFOGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgJFOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BB2207EA;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993035;
        bh=d71iacXbZw2ABLpWaZX1uaqcv45PDLhlX1j5I6cVz50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUwDfSDujLWQS8DayiVH3m/HobXQRjmznN/U0cqD4y6KAEQxku0Mp3tTQqXlnYVhO
         BJ5970dRhwNUGBueOW7cfAPlrNVadjyW2gRW5dRUDoPPFYJl2vWrD35OGyQnnrzSAr
         6AD3YyGu1aXWfwxE+7l3E0ZF4hIci0YXp/5hqAmM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZJ-0019Gh-2A; Tue, 06 Oct 2020 16:03:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 48/52] docs: basics.rst: avoid duplicated C function declaration
Date:   Tue,  6 Oct 2020 16:03:45 +0200
Message-Id: <8e101f80a5bd2715b8727e07071b3dbb7b75971b.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_device_id is already documented at pci.rst:

	./Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'PCI/pci'.
	Declaration is 'pci_device_id'.

The kstrtol and kstrtoul are already at kernel-api:

	./Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'kstrtoul'.
	./Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/kernel-api'.
	Declaration is 'kstrtol'.

And the printk is already defined at printk-basics:

	./Documentation/driver-api/basics.rst: WARNING: Duplicate C declaration, also defined in 'core-api/printk-basics'.
	Declaration is 'printk'.

So, exclude those identifiers from basirs.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/basics.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 63bbe3ed5e76..3e2dae954898 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -12,6 +12,8 @@ Driver device table
 
 .. kernel-doc:: include/linux/mod_devicetable.h
    :internal:
+   :no-identifiers: pci_device_id
+
 
 Delaying, scheduling, and timer routines
 ----------------------------------------
@@ -96,9 +98,11 @@ Kernel utility functions
 
 .. kernel-doc:: include/linux/kernel.h
    :internal:
+   :no-identifiers: kstrtol kstrtoul
 
 .. kernel-doc:: kernel/printk/printk.c
    :export:
+   :no-identifiers: printk
 
 .. kernel-doc:: kernel/panic.c
    :export:
-- 
2.26.2

