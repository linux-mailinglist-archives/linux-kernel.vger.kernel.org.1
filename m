Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394E029E7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgJ2JzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:55:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:1046 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgJ2JzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:55:14 -0400
IronPort-SDR: +gWeyZnKCJPDdw2Y89dHyV0mvBuGyD0JPEfKr05Ol6ehuZmUd/kagNUEerMul06RMv+PbiLGEX
 xnVBE2X2pbpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="156178770"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="156178770"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:55:13 -0700
IronPort-SDR: y3UNQJb10QSQQIGOUQN/ULADFSnJyyuoSiEfwZkYOLUrdz6dRSZlO+X4W0e3K1lrbi4cD2hg/1
 qZwcsIRbkj8w==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="536607304"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:55:11 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 0/3] mei: bus: null derefence in rx
Date:   Thu, 29 Oct 2020 11:54:41 +0200
Message-Id: <20201029095444.957924-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix race in receive callback for drivers on me client
bus, that results in null dereferencing and improve 
the error handling.
The first patch 'mei: protect mei_cl_mtu from null dereference'
itself is sufficient to prevent the failure and is intended
for stable.


Alexander Usyskin (3):
  mei: protect mei_cl_mtu from null dereference
  mei: bus: do not start a read for disconnected clients
  mei: bus: deinitialize callback functions on init failure

 drivers/misc/mei/bus.c    | 18 ++++++++++++++----
 drivers/misc/mei/client.h |  4 ++--
 2 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.25.4

