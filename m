Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8429922E897
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgG0JPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 05:15:02 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:7826 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgG0JPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595841302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XRiTkYPt/VoC9tJRw/kDVebohjydPMQ3t9eNfBCqXdU=;
  b=STvto1AxaQLTw9BjKHe8fBL4p2oghk+0GC79YIa6ImBc7N6Vg3TUYINi
   Sxir1Gxu5BSdJk4XxkmS+QpdggouiOViH58FBo2ISVpu/advU2lTwQlx8
   BpHkPnjB4aNneS/io6im6D1DP1K6eK1BdKY0XTT9IZkHLTKRzWda8IIAH
   M=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: +KtSj5NtdshyL3nTLDYcTIfIGM+JtKqneYpA9XnR9mJ4w6Dz8isYXOKKcOnhJLDLSXBqEv1fu+
 VGNP0SE2q8zhO30K32oMsHQOp5hhNZgELfIOa6tfnys3f8oHgqbDGYwofr/TbczILeDIXfHUgr
 poQ3JWUpCw9BwPfD/E3zFgF8Q+/611RVo0J/BqOLVTTTJF+W3UTMRcEOfKG22Cws4bhIWNmy3J
 JevId2zYkDY2i1+FaHRkeOidBsqqHNX/ZvPjexde2s079X6tbdIdRziNV21pXv8TcP/6O/J26r
 2U4=
X-SBRS: 2.7
X-MesageID: 23233911
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,402,1589256000"; 
   d="scan'208";a="23233911"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v3 0/4] xen/balloon: fixes for memory hotplug
Date:   Mon, 27 Jul 2020 11:13:38 +0200
Message-ID: <20200727091342.52325-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series contain some fixes in order to split Xen
unpopulated memory handling from the ballooning driver if ZONE_DEVICE is
available, so that physical memory regions used to map foreign pages are
not tied to memory hotplug.

First two patches are bugfixes that IMO should be backported to stable
branches, third patch is a revert of a workaround applied to the balloon
driver and last patch introduces an interface based on ZONE_DEVICE in
order to manage regions to use for foreign mappings.

Thanks, Roger.

Roger Pau Monne (4):
  xen/balloon: fix accounting in alloc_xenballooned_pages error path
  xen/balloon: make the balloon wait interruptible
  Revert "xen/balloon: Fix crash when ballooning on x86 32 bit PAE"
  xen: add helpers to allocate unpopulated memory

 drivers/gpu/drm/xen/xen_drm_front_gem.c |   9 +-
 drivers/xen/Makefile                    |   1 +
 drivers/xen/balloon.c                   |  30 ++--
 drivers/xen/grant-table.c               |   4 +-
 drivers/xen/privcmd.c                   |   4 +-
 drivers/xen/unpopulated-alloc.c         | 185 ++++++++++++++++++++++++
 drivers/xen/xenbus/xenbus_client.c      |   6 +-
 drivers/xen/xlate_mmu.c                 |   4 +-
 include/xen/xen.h                       |   9 ++
 9 files changed, 221 insertions(+), 31 deletions(-)
 create mode 100644 drivers/xen/unpopulated-alloc.c

-- 
2.27.0

