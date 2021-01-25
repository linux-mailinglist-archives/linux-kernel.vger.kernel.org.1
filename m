Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D73025C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbhAYNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:53:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbhAYNtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC0BA2087E;
        Mon, 25 Jan 2021 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=M0dDfnchJRBjOZVMlgydXFdaoa8BoZIm9o4O0Wwmktc=;
        h=From:To:Cc:Subject:Date:From;
        b=KZrmKyWpqu4yPsJZJa0DDJB0x8dhDk8cmzp2889/gVgmeHw7xHxTRfm7G8vCE+e7v
         UZZ2yLjk+owFZJ8jlHJ+5b3l5pwcEAu4qfQQJPcsPhaeO1Mo5HiYq6O16qJHb+jkmK
         pkXiLQC0513WO4gOvzgRIvnU30I1/xhTD1jYbsP6L5Uj9v42iSmfX4QygjXonDYlm6
         8LrDWz9PeLcF6NS7oaVxSopmkycF6CLvfNcaKX7j6A7EQjqv6ivtGSuigU+LpPbpQU
         m2Mxro9XccJgJo5fjn5ZQRSDTskT5pPVoYw9qSd65WSSgsld886oaAOeZ8h9zfxO5T
         7wl3De5zKJNww==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EL-00034M-Dh; Mon, 25 Jan 2021 14:48:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/7] USB: serial: cp210x: modem-control fixes
Date:   Mon, 25 Jan 2021 14:48:10 +0100
Message-Id: <20210125134817.11749-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the modem-control handling and its interaction with
hardware flow control in the cp210x driver.

Johan

Johan Hovold (7):
  USB: serial: cp210x: suppress modem-control errors
  USB: serial: cp210x: fix modem-control handling
  USB: serial: cp210x: drop shift macros
  USB: serial: cp210x: clean up flow-control debug message
  USB: serial: cp210x: clean up printk zero padding
  USB: serial: cp210x: fix RTS handling
  USB: serial: cp210x: clean up auto-RTS handling

 drivers/usb/serial/cp210x.c | 113 ++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 24 deletions(-)

-- 
2.26.2

