Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB52CA357
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgLANAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:00:35 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44918 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgLANAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:00:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DED5CFB05;
        Tue,  1 Dec 2020 13:59:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MgI_jk9lB2pJ; Tue,  1 Dec 2020 13:59:50 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4289E4068E; Tue,  1 Dec 2020 13:59:50 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 0/2] usb: typec: tps6598x: Export some power supply properties
Date:   Tue,  1 Dec 2020 13:59:48 +0100
Message-Id: <cover.1606827507.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This allows downstream supplies and userspace to detect whether external power
is supplied.

The Librem 5 has the tp65982 in front of bq25980 charge controller.  Since that
is capable of sinking and sourcing power the online property helps to decide
what to do. It also makes upower happy.

There will be follow up patches providing more properties but these need some
more time to cook and i wanted to check if this is the right way to go?

changes from v3
  - As per review comments from Andy Shevchenko
    https://lore.kernel.org/linux-usb/CAHp75VeLZtm85Y=3QMkPGb332wn05-zr-_mrrwXvnqLhazR1Gg@mail.gmail.com/
    - Use positive conditionals
  - Add reviewed by from Heikki Krogerus
    https://lore.kernel.org/linux-usb/20201130102720.GA2911464@kuha.fi.intel.com/T/#u
    https://lore.kernel.org/linux-usb/20201130102942.GB2911464@kuha.fi.intel.com/T/#u
  - Fix typc vs typec typo in commit message

changes from v2
  - As per kernel test robot
    https://lore.kernel.org/linux-usb/202011271005.zJVawX74-lkp@intel.com/
    - Flip USB_ROLE_SWITCH and REGMAP_I2C from 'depends on' to 'select'
      This matches tcpm and avoids a config symbol recursion which went
      unnoticed on my arm64 build but trips up x86_64.

changes from v1
  - As per review comments from Heikki Krogerus
    https://lore.kernel.org/linux-usb/20201126123552.GP1008337@kuha.fi.intel.com/
    - select POWER_SUPPLY
    - use POWER_SUPPLY_USB_TYPE_PD when a PD contract got negotiated

To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-usb@vger.kernel.org,linux-kernel@vger.kernel.org,Andy Shevchenko <andy.shevchenko@gmail.com>

Guido Günther (2):
  usb: typec: tps6598x: Select USB_ROLE_SWITCH and REGMAP_I2C
  usb: typec: tps6598x: Export some power supply properties

 drivers/usb/typec/Kconfig    |   5 +-
 drivers/usb/typec/tps6598x.c | 105 +++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 2 deletions(-)

-- 
2.29.2

