Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97012D619B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392259AbgLJQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389857AbgLJQFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:05:33 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     heikki.krogerus@linux.intel.com, linux@roeck-us.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: [PATCH 0/5] USB: typec: various patches
Date:   Thu, 10 Dec 2020 17:05:16 +0100
Message-Id: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In digging through a large set of proposed typec patches for the Android
common kernel, I've picked out 5 "easy" patches that should all go
upstream (they all should go upstream, just will take a while to clean
them up it seems...)

Badhri Jagan Sridharan (2):
  USB: typec: tcpm: Prevent log overflow by removing old entries
  USB: typec: tcpci: Add Bleed discharge to POWER_CONTROL definition

Kyle Tso (2):
  USB: typec: tcpm: Fix PR_SWAP error handling
  USB: typec: tcpm: Add a 30ms room for tPSSourceOn in PR_SWAP

pumahsu (1):
  USB: typec: tcpm: Hard Reset after not receiving a Request

 drivers/usb/typec/tcpm/tcpci.h |  1 +
 drivers/usb/typec/tcpm/tcpm.c  | 30 +++++++++++++++---------------
 include/linux/usb/pd.h         |  1 +
 3 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.29.2

