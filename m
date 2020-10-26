Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF30299736
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJZTlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgJZTlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:41:36 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CFD20760;
        Mon, 26 Oct 2020 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741295;
        bh=kPKgYhCjPZ0Kd73SAPgJfiOLIpQSjX80yttk+Qioh7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my0MbNi12566RXnUFJGMFBmXUZAzUqQVSwEb6bcCMZp/bvhJyzEhGSjso6EoVQeTr
         kgSOdppAc3IkQlNhAuXhlfS68RK4w79k9hIpcJppvA41zg3yIvnXHXAZ/emQfxGmgm
         W1DwjQ46787tiBaNkW2G6r+FBfloYe3ZjtyO/wY0=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH 2/4] drm/imx: tve remove extraneous type qualifier
Date:   Mon, 26 Oct 2020 20:41:02 +0100
Message-Id: <20201026194110.3817470-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026194110.3817470-1-arnd@kernel.org>
References: <20201026194110.3817470-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang warns about functions returning a 'const int' result:

drivers/gpu/drm/imx/imx-tve.c:487:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

Remove the extraneous 'const' qualifier here. I would guess that the
function was intended to be marked __attribute__((const)) instead,
but that would also be wrong since it call other functions without
that attribute.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/imx/imx-tve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index ef3c25d87d87..2a8d2e32e7b4 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -484,7 +484,7 @@ static const char * const imx_tve_modes[] = {
 	[TVE_MODE_VGA] = "vga",
 };
 
-static const int of_get_tve_mode(struct device_node *np)
+static int of_get_tve_mode(struct device_node *np)
 {
 	const char *bm;
 	int ret, i;
-- 
2.27.0

