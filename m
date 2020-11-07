Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ABE2AA256
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 04:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgKGDjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 22:39:07 -0500
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:55917 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgKGDjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 22:39:07 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id 1E156582166;
        Sat,  7 Nov 2020 11:29:37 +0800 (CST)
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
Date:   Fri,  6 Nov 2020 19:29:22 -0800
Message-Id: <20201107032924.25044-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTRkdTUxJSkgdTBgZVkpNS09MSkJMTExPTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006FCo6Hj8pKxw3GlEdTTAT
        LDlPChdVSlVKTUtPTEpCTExMQ0hCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUpDSEI3Bg++
X-HM-Tid: 0a75a0c0965598b6kuuu1e156582166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg:

This patch sereies delete code which never run:
{
case XXX:
	return XXX;
	break; //The break is meanless, so just delete it.
case YYY:
	goto YYY;
	break; //The break is meanless, so just delete it.
......
}

Bernard Zhao (2):
  tty/serial: delete break after return
  drivers/tty: delete break after goto/return

 drivers/tty/nozomi.c     | 4 ----
 drivers/tty/serial/imx.c | 5 -----
 2 files changed, 9 deletions(-)

-- 
2.29.0

