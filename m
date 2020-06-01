Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C081E9F97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgFAHyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 03:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgFAHy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:54:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DECC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:54:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EA4312A1B92;
        Mon,  1 Jun 2020 08:54:26 +0100 (BST)
Date:   Mon, 1 Jun 2020 09:54:23 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] i3c: Changes for 5.8
Message-ID: <20200601095423.00ffb5e1@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C PR for 5.8.

Regards,

Boris

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.8

for you to fetch changes up to b4203ce0556348dcfe29f897d1dbe65102874d89:

  i3c master: GETMRL's 3rd byte is optional even with BCR_IBI_PAYLOAD (2020-04-16 14:27:46 +0200)

----------------------------------------------------------------
Fix GETMRL's logic

----------------------------------------------------------------
Nicolas Pitre (1):
      i3c master: GETMRL's 3rd byte is optional even with BCR_IBI_PAYLOAD

 drivers/i3c/master.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
