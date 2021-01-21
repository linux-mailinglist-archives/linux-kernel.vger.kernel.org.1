Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A92FEB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbhAUNH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbhAUKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 470BD23433;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=U8ydBIs1leOt47Wm9+F882XwGauCR/7D8HJT0x7aOzw=;
        h=From:To:Cc:Subject:Date:From;
        b=s2usR8TO08WVo313XMa3f32skpfdGhMQBnBaI79kXJj7L4MzgK0baK4eVyJWGdgTP
         0otLU/QmXeIsbHZYhqE5qAId2n/Vgbg7FivIdSaossFEupuG6TDpVscwgi5Lkk9Yxp
         W7VkIno+Mq3twjtYkt2EHQV5YmvdHQgzj+a0PA7Xpj7b7j985oxUmTOUHiPr8SCl+j
         5QUaLSpwLlJl1NZP8iuF2sajjl0mV2hwdvreAAUH+2Ta2GBbX2JeqVUJpiPkj/Vgka
         0HFgs8MhK8ileGinx1XQymM0VySHvDRQO16qZjMEpS3LHA4JtwS+M8EjB0j26kMdEJ
         KT7Is2XUMdncA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDc-0004YD-9n; Thu, 21 Jan 2021 11:29:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/10] USB: serial: xr: fix up remaining issues in new driver
Date:   Thu, 21 Jan 2021 11:29:11 +0100
Message-Id: <20210121102922.17439-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the remaining issues in the new MaxLinear driver that
were pointed out here:

	https://lore.kernel.org/r/YAlVLOqzx8otPgOg@hovoldconsulting.com

Johan


Johan Hovold (10):
  USB: serial: xr: fix NULL-deref at probe
  USB: serial: xr: fix interface leak at disconnect
  USB: serial: xr: use subsystem usb_device at probe
  USB: serial: xr: use termios flag helpers
  USB: serial: xr: document vendor-request recipient
  USB: serial: xr: clean up line-settings handling
  USB: serial: xr: simplify line-speed logic
  USB: serial: xr: fix gpio-mode handling
  USB: serial: xr: fix pin configuration
  USB: serial: xr: fix B0 handling

 drivers/usb/serial/xr_serial.c | 102 +++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 43 deletions(-)

-- 
2.26.2

