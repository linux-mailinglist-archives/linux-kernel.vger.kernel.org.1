Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B54201E85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 01:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgFSXRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 19:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730253AbgFSXRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 19:17:36 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C401E22454;
        Fri, 19 Jun 2020 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592608656;
        bh=B9FqHTgSnllLhsqibG6EHGoZbsrawisgzb3lcvFVlDU=;
        h=Date:From:To:Cc:Subject:From;
        b=hY8yS7BDITPqc8AJ27en7GVL0Csa5KWFPnL1KVYDMr+H56nc7LJ5GgvNxNcr0y1N4
         OwnrT9SfP7qTFkRrc+4JAmxWuCU8fwCsXdYxS2+IxK4xUpExwY4Vb3g6UNwwF9aGIA
         202nKnEbTHM7LiKHNMOGGG7YHu6O6VYQ+YPZKfbY=
Date:   Fri, 19 Jun 2020 16:17:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>,
        Nicolai Stange <nicstange@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: debugfs_create_u32_array() memory leaks
Message-ID: <20200619161734.25e99fa4@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to use debugfs_create_u32_array() in drivers/net/netdevsim
and it causes memory leaks:

unreferenced object 0xffff8880546642a0 (size 16):
  comm "test_udp_tuns.s", pid 2146, jiffies 4294928368 (age 3772.435s)
  hex dump (first 16 bytes):
    84 52 6a 4d 80 88 ff ff 04 00 00 00 f3 78 7e 89  .RjM.........x~.
  backtrace:
    [<000000006962a447>] debugfs_create_u32_array+0x3f/0x90

I can see that debugfs_create_u32_array() allocates a structure at
create time that ends up assigned to inode->i_private, but I don't 
see it freed anywhere.

Am I missing something? I'm pretty sure files get removed, cause the
driver calls debugfs_remove_recursive() and no other file types leaks.
