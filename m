Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4452029A750
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895338AbgJ0JHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:07:42 -0400
Received: from ozlabs.ru ([107.174.27.60]:42990 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408749AbgJ0JHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:07:42 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id F3461AE80024;
        Tue, 27 Oct 2020 05:06:27 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [RFC PATCH kernel 0/2] irq: Add reference counting to IRQ mappings
Date:   Tue, 27 Oct 2020 20:06:53 +1100
Message-Id: <20201027090655.14118-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is an attempt to fix a bug with PCI hot unplug with
a bunch of PCIe bridges and devices sharing INTx.

This did not hit us before as even if we did not
call irq_domain_ops::unmap, the platform (PowerVM) would not
produce an error but with POWER9's XIVE interrupt controller
there is an error if unmap is not called at all (2/2 fixes that)
or an error if we unmapped an interrupt which is still in use
by another device (1/2 fixes that).

One way of fixing that is doing reference counting in
the POWERPC code but since there is a kobj in irq_desc
already, I thought I'll give it a try first.


This is based on sha1
4525c8781ec0 Linus Torvalds "scsi: qla2xxx: remove incorrect sparse #ifdef".

Please comment. Thanks.



Alexey Kardashevskiy (1):
  irq: Add reference counting to IRQ mappings

Oliver O'Halloran (1):
  powerpc/pci: Remove LSI mappings on device teardown

 arch/powerpc/kernel/pci-common.c | 21 +++++++++++++++++++
 kernel/irq/irqdesc.c             | 35 +++++++++++++++++++++-----------
 kernel/irq/irqdomain.c           | 27 ++++++++++++------------
 3 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.17.1

