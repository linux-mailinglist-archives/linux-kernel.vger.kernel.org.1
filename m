Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F902D0EC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgLGLQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:16:29 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58165 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgLGLQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:16:29 -0500
X-Originating-IP: 109.220.208.103
Received: from localhost.localdomain (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DC6421C0005;
        Mon,  7 Dec 2020 11:15:42 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guohua Zhong <zhongguohua1@huawei.com>, patrick@baymotion.com,
        joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     wangle6@huawei.com, young.liuyang@huawei.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        nixiaoming@huawei.com
Subject: Re: [PATCH v4] phram: Allow the user to set the erase page size.
Date:   Mon,  7 Dec 2020 12:15:41 +0100
Message-Id: <20201207111541.8887-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201207095529.20896-1-zhongguohua1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 103e505981981e8f9ba0435980e368998acec74f
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-07 at 09:55:29 UTC, Guohua Zhong wrote:
> From: Patrick O'Grady <patrick@baymotion.com>
> 
> Permit the user to specify the erase page size as a parameter.
> This solves two problems:
> 
> - phram can access images made by mkfs.jffs2.  mkfs.jffs2 won't
> create images with erase sizes less than 8KiB; many architectures
> define PAGE_SIZE as 4KiB.
> 
> - Allows more effective use of small capacity devices.  JFFS2
> needs somewhere between 2 and 5 empty pages for garbage collection;
> and for an NVRAM part with only 32KiB of space, a smaller erase page
> allows much better utilization in applications where garbage collection
> is important.
> 
> Signed-off-by: Patrick O'Grady <patrick@baymotion.com>
> Reviewed-by: Joern Engel <joern@logfs.org>
> Link: https://lore.kernel.org/lkml/CAJ7m5OqYv_=JB9NhHsqBsa8YU0DFRoP7C+W10PY22wonAGJK=A@mail.gmail.com/
> [Guohua Zhong: fix token array index out of bounds and update patch for kernel master branch]
> Signed-off-by: Guohua Zhong <zhongguohua1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
