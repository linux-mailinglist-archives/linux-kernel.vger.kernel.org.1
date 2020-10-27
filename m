Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2929BD86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811785AbgJ0QmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:42:23 -0400
Received: from aposti.net ([89.234.176.197]:47424 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1811767AbgJ0QmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:42:21 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [RESEND PATCH 0/4] MUSB and jz4740-musb fixes
Date:   Tue, 27 Oct 2020 16:41:56 +0000
Message-Id: <20201027164200.18602-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

The first two patches of this series have already been sent before but
were never merged, hence the RESEND. This is not really a V2 as nothing
changed there.

Patches 3/4 are new.

Cheers,
-Paul

Paul Cercueil (4):
  usb: musb: Fix runtime PM race in musb_queue_resume_work
  usb: musb: Fix NULL check on struct musb_request field
  usb: musb: dma: Remove unused variable
  musb: jz4740: Add missing CR to error strings

 drivers/usb/musb/jz4740.c      | 14 +++++++-------
 drivers/usb/musb/musb_core.c   | 31 +++++++++++++++++--------------
 drivers/usb/musb/musb_gadget.c |  2 +-
 drivers/usb/musb/musbhsdma.c   |  4 ----
 4 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.28.0

