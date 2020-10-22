Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD929597A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508790AbgJVHm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:42:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506906AbgJVHm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:42:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603352545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FBBqK8HW3BIG0quz5o+GZ5G2pN19linyD06f3Ehf/3E=;
        b=Ku/7Poc7X6u54p4uLBdhgxlQmb+7ztGf4Y5XEcudfV9uDHBPLfP+yYzYjwltr+6HoxAx00
        U8V2bJtnD3lNNDInjMXYmr+eYx10+JmswutopyP/xpQsysO6ymER2ClLDV3NEERFMUEHlX
        yGSnKxIue8rBtuqwUSMoyv8L2q/GI+g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BDAE6B1A0;
        Thu, 22 Oct 2020 07:42:25 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/5] xen: event handling cleanup
Date:   Thu, 22 Oct 2020 09:42:09 +0200
Message-Id: <20201022074214.21693-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some cleanups in Xen event handling code.

Juergen Gross (5):
  xen: remove no longer used functions
  xen/events: make struct irq_info private to events_base.c
  xen/events: only register debug interrupt for 2-level events
  xen/events: unmask a fifo event channel only if it was masked
  Documentation: add xen.fifo_events kernel parameter description

 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/x86/xen/smp.c                            | 19 ++--
 arch/x86/xen/xen-ops.h                        |  2 +
 drivers/xen/events/events_2l.c                |  7 +-
 drivers/xen/events/events_base.c              | 90 +++++++++++++------
 drivers/xen/events/events_fifo.c              |  9 +-
 drivers/xen/events/events_internal.h          | 70 ++-------------
 include/xen/events.h                          |  8 --
 8 files changed, 100 insertions(+), 112 deletions(-)

-- 
2.26.2

