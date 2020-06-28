Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA99B20C552
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 04:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgF1CGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 22:06:21 -0400
Received: from foss.arm.com ([217.140.110.172]:58142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgF1CGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:06:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32D08106F;
        Sat, 27 Jun 2020 19:06:20 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.40.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EE2B3F73C;
        Sat, 27 Jun 2020 19:06:16 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Steve.Capper@arm.com,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [RFC PATCH 0/2] 9p: retrieve fid from file if it exsits
Date:   Sun, 28 Jun 2020 10:06:06 +0800
Message-Id: <20200628020608.36512-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the current implementation in setattr in 9p, fid will always be retrieved
from dentry, which may be against the original intension of user and lead to
bug.
also, remove no used code in 9p.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

Jianyong Wu (2):
  9p: retrive fid from file when file instance exist.
  9p: remove unused code in 9p

 fs/9p/vfs_inode.c      | 58 +++---------------------------------------
 fs/9p/vfs_inode_dotl.c |  5 +++-
 2 files changed, 8 insertions(+), 55 deletions(-)

-- 
2.17.1

