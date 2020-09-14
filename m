Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD826924A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgINQ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:58:34 -0400
Received: from node.akkea.ca ([192.155.83.177]:44358 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgINQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:56:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 7E3024E2056;
        Mon, 14 Sep 2020 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600102041; bh=fxhz9YwO5XJH2hLeJM1ruD1l/zt98gVzzUx2K7IMdw4=;
        h=From:To:Cc:Subject:Date;
        b=OBFhYAD1AzFovgnP8HqHm0OosdAjdqZ6lsilMPuCoOuGIUKEjXt4SMe6bREKh2x0l
         0FSWpQbScNpBZ51JvpFTMWTHJX4jNs+RkNzxoKGctkM7oNTvpjLkuJROZYCUU5nfJf
         38SZK8WOrf37Sffp8VOw+CDqjWe5pMSBYjPibkMg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FKHYRESkzSGd; Mon, 14 Sep 2020 16:47:20 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 9AF2A4E201A;
        Mon, 14 Sep 2020 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600102040; bh=fxhz9YwO5XJH2hLeJM1ruD1l/zt98gVzzUx2K7IMdw4=;
        h=From:To:Cc:Subject:Date;
        b=NBvYhWbS/7RyE+eges0GEmILai84po6DJ8AkZl/ktWIdJmxyDkpYMRWhpAjSqQ5Ze
         jEXMU5BTpKWfiEv8RwQn9IhvzfSrFxw+XFuICeArnHX3dZp5rYBHcgGh51YkadFoD8
         WYOvrBKBGSR/20+mebJMLEQexscsALF0g3SrGPtU=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH 0/4] RFC: USB C extcon patchset for the tps6598x
Date:   Mon, 14 Sep 2020 09:46:35 -0700
Message-Id: <20200914164639.1487650-1-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a complex set of hardware components to manage our USB C data and
power. For these to work together we decided to use extcon to communicate
the system changes as various cables and devices are plugged in/out. We did
look at usb_roleswitch and the charging framework but thought it would be
preferable to keep all of the information together in one system.

The components we have in the system are:

1) TPS65982 type USB type C controller
2) dwc3 IP in the imx8mq
3) BQ25895 battery charger

I'll break this into 2 parts the data role and the power role.

For the data role the TPS65982 senses connect and disconnect as well as data
source/sink. It is also controlling the USB 3 data lanes. The display port and
USB 3 muxing is handled by a different chip and we'll submit patches for that
later on. The dwc3 controls the USB 2 data lanes.

On the power side there are even more moving pieces. The TPS65982 negotiates
the power delivery contract, the dwc3 senses the BC1.2 charging current and the
BQ25895 sets whether we are sinking or sourcing current and what the current
limit is of the sink and source.

For both the data and power roles no single chip has all of the required
information. Is using extcon the correct way of doing this and if not what
are the alternatives ?

The extcon extensions allow us to communicate the the power roles amongst
the various chips.

This patch series has been tested with the 5.9-rc4 kernel on the Purism
Librem5 HW. Assuming this is the correct way to use extcon there will be
follow on patches to the BQ25895 and dwc3 drivers.

Strictly speaking only the first 3 patches are needed for extcon support, the
forth patch decodes the power delivery contracts which makes use of the extcon
system.


Angus Ainslie (4):
  extcon: Add USB VBUS properties
  usb: typec: tps6589x: register as an extcon provider
  usb: typec: tps6598x: Add the extcon USB chargers
  usb: typec: tps6598x: Add the power delivery irq

 drivers/usb/typec/tps6598x.c | 488 ++++++++++++++++++++++++++++++++++-
 include/linux/extcon.h       |  17 +-
 2 files changed, 503 insertions(+), 2 deletions(-)

-- 
2.25.1

