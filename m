Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E792A5E22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKDGdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:33:38 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:61028 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgKDGdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:33:38 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 441A54827E9;
        Wed,  4 Nov 2020 14:33:35 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     opensource.kernel@vivo.com, bernard@vivo.com
Subject: [PATCH 0/2] drivers/tty: delete break after return
Date:   Tue,  3 Nov 2020 22:33:22 -0800
Message-Id: <20201104063327.15572-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkkYGEhDSx8YHx8YVkpNS09PTEpNSk5OT0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6ARw5Lz8dKxgjGT4IHTlD
        FykwCk1VSlVKTUtPT0xKTUpOQkxJVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUpNQkM3Bg++
X-HM-Tid: 0a7591f5effc93bakuws441a54827e9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sereies delete break after return, which will never run.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
*** BLURB HERE ***

Bernard Zhao (2):
  drivers/tty: delete break after return
  drivers/tty: delete break after return

 drivers/tty/nozomi.c     | 4 ----
 drivers/tty/serial/imx.c | 5 -----
 2 files changed, 9 deletions(-)

-- 
2.29.0

