Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379CD1BD515
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgD2GwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 02:52:15 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:41366 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgD2GwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:52:15 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d18 with ME
        id YWsB2200G0F2omL03WsBHc; Wed, 29 Apr 2020 08:52:13 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 29 Apr 2020 08:52:13 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4 v2] firmware: stratix10-svc: Fix some error handling code
Date:   Wed, 29 Apr 2020 08:52:01 +0200
Message-Id: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie was previously sent as a single patch.
After a comment from Dan Carpenter about an error handling path that could be
improved, I've looked deeper at the code and found other issues.

The previous patch corresponds to patch 3/4 in this serie.
This v2 takes Dan's comment into account and fix another resource leak.

Patch 1/4: svc_create_memory_pool returns an error code on error, not NULL 
Patch 2/4: undo a memremap on error path and remove funtion
Patch 3/4: improve error handling in the probe function
Patch 4/4: unrelated clean-up

Christophe JAILLET (4):
  firmware: stratix10-svc: Fix genpool creation error handling
  firmware: stratix10-svc: Unmap some previously memremap'ed memory
  firmware: stratix10-svc: Fix some error handling paths in
    'stratix10_svc_drv_probe()'
  firmware: stratix10-svc: Slighly simplify call

 drivers/firmware/stratix10-svc.c | 42 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

-- 
2.25.1

