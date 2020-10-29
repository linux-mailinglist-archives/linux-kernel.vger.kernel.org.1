Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C084429EF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgJ2PQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:16:00 -0400
Received: from smtp1.axis.com ([195.60.68.17]:5868 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgJ2PPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=719; q=dns/txt; s=axis-central1;
  t=1603984555; x=1635520555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ku9R/lK0l51HGyu3c3HcwmGlQ0lAO44O+a5Ia8y4tVw=;
  b=Jge6FA3CGdHeUW/IEWQNFh5ADxx8Yx6ZxYSmyBdcMHdhlEh2FLwwYx1I
   MxeX1z1B3p02xky1X0eP8D+Rv8BP9LJhPkKFAjS+M9aNNFjAPdpTQexgX
   hbqTK4NPRHYL4HzWgNvN0qf0AgTSCddMsLaa3ybUe4noADcdqTBOHzlt7
   aU7mogtDc1+F7GFo/LV1JCfoFZf3o2eZDt5S4Q9GBXUgO6jPlfH029mrB
   sXNpFw/d6paaTLXC/ms0sPVQ6LrAp+QRBKu70MlUQYclYponZwT809Zqd
   BKWs4+wRzcAcnaEFhgbyYmcsQGXMjp8uozITjn9wNESd9XlBa40emB1sz
   g==;
IronPort-SDR: eTu/JPLUQWgwvRlfa77ibzS0ODeiXeCRABXElhYRlK6xhX2c+zF6so36H7IFFnNTSYx+pxjDZQ
 rQmA7DKuJ6kGY6NPEQRtYb4zuNI89M4JoiVelnPSDISdJIBWkaMLKV04mraMOlpxgbzMLKmCxP
 NPzfdRLfE6IWVkhJxnXkFEZg9FVAU5//Uygh3mBFhCJI36BMcvOGwtP9236z2xsCggFd78d/Sl
 0+HmqKdyzZq/nayXEWQCKwonCNnuLgjt4PLmuXd5S2xYGy8fyEZQ0Q5aclG/H/TUVSU5DsLVog
 fY4=
X-IronPort-AV: E=Sophos;i="5.77,430,1596492000"; 
   d="scan'208";a="14562031"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <support.opensource@diasemi.com>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/2] DA9121 regulator support
Date:   Thu, 29 Oct 2020 16:15:36 +0100
Message-ID: <20201029151538.23463-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the DA9121, a "High-Performance, 10 A, Dual-Phase
DC-DC Converter".  The datasheet is currently available here:

 https://www.dialog-semiconductor.com/sites/default/files/da9121_datasheet_2v3.pdf

Vincent Whitchurch (2):
  dt-bindings: regulator: Add DA9121
  regulator: Add support for DA9121 regulator

 .../bindings/regulator/dlg,da9121.yaml        |  42 +++++++
 drivers/regulator/Kconfig                     |  12 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/da9121-regulator.c          | 111 ++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
 create mode 100644 drivers/regulator/da9121-regulator.c

-- 
2.28.0

