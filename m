Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C291CD296
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgEKHbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 03:31:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:47404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgEKHbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:31:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0E8BAC20;
        Mon, 11 May 2020 07:31:56 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 0/2] xen/xenbus: some cleanups
Date:   Mon, 11 May 2020 09:31:49 +0200
Message-Id: <20200511073151.19043-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid allocating large amount of data on the stack in
xenbus_map_ring_valloc() and some related return value cleanups.

Juergen Gross (2):
  xen/xenbus: avoid large structs and arrays on the stack
  xen/xenbus: let xenbus_map_ring_valloc() return errno values only

 drivers/xen/xenbus/xenbus_client.c | 133 ++++++++++++++---------------
 1 file changed, 64 insertions(+), 69 deletions(-)

-- 
2.26.1

