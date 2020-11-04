Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF102A629A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgKDKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:53:47 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:35316 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:53:45 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.156])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id ABD7B482CFA;
        Wed,  4 Nov 2020 18:53:42 +0800 (CST)
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
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH 0/2] drivers/tty: delete break after return or goto
Date:   Wed,  4 Nov 2020 02:53:29 -0800
Message-Id: <20201104105331.16654-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh4dSB5OSEseHUhKVkpNS09PQ0xJSUlCTUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Dww5Ej8iAR8fKUwCCAo3
        SzgKCzlVSlVKTUtPT0NMSUlIT0NMVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5NWVdZCAFZQUpCS0k3Bg++
X-HM-Tid: 0a7592e4167893bakuwsabd7b482cfa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sereies optimise code like:
{
case XXX:
	return XXX;
	break; //The break is meanless, so just delete it.
case YYY:
	goto YYY;
	break; //The break is meanless, so just delete it.
......
}

Signed-off-by: Bernard Zhao <bernard@vivo.com>

---
Bernard Zhao (2):
  drivers/tty/nozomi.c: delete no use break after goto
  drivers/tty/serial/imx.c: delete no use break after return

 drivers/tty/nozomi.c     | 4 ----
 drivers/tty/serial/imx.c | 5 -----
 2 files changed, 9 deletions(-)

-- 
2.29.0

