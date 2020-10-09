Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67D22886CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgJIKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbgJIKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:24:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F13C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 03:24:42 -0700 (PDT)
Received: from [134.101.218.207] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kQpOt-0004eZ-PE; Fri, 09 Oct 2020 12:13:23 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V4 0/4] mac80211: add multiple bssid support
Date:   Fri,  9 Oct 2020 12:13:13 +0200
Message-Id: <20201009101317.4657-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V4
* move multiple bssid config from add_interface to start_ap
* add ema support

John Crispin (4):
  nl80211: add basic multiple bssid support
  mac80211: add multiple bssid support to interface handling
  mac80211: add multiple bssid/EMA support to beacon handling
  mac80211: don't allow CSA on non-transmitting interfaces

 include/net/cfg80211.h       |  33 ++++++++
 include/net/mac80211.h       | 118 +++++++++++++++++++++++++-
 include/uapi/linux/nl80211.h |  21 +++++
 net/mac80211/cfg.c           | 113 ++++++++++++++++++++++++-
 net/mac80211/debugfs.c       |   1 +
 net/mac80211/ieee80211_i.h   |   2 +
 net/mac80211/iface.c         |   6 ++
 net/mac80211/tx.c            | 157 +++++++++++++++++++++++++++++++----
 net/wireless/nl80211.c       |  34 ++++++++
 9 files changed, 464 insertions(+), 21 deletions(-)

-- 
2.25.1

