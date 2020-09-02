Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6F25B429
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 20:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIBS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 14:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBS6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:58:17 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2986208C7;
        Wed,  2 Sep 2020 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599073096;
        bh=jZpDF9NPKu9cn/SUdzlY3qKfPGe/l8VUeZcIKi8NeZs=;
        h=Date:From:To:cc:Subject:From;
        b=bP+p3D9AhDjjeUFMCkbX7XbTTWP6Ldq6jsdijeCra+sh1NwzyMfITP9D134cyFDbN
         f81OCPP7KtWjMB1gS7u3a1PLAX0nm1KYIrwhU8V7FG747e5uQnRDUL+OVr7ywegw8+
         +1BWM5rpnSmN1wz7fEfpTzK6imkkFT/kImVV3lAg=
Date:   Wed, 2 Sep 2020 20:58:13 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2009022051130.4671@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem fixes. Most importantly:

=====
- Data sanitization and validtion fixes for report descriptor parser from 
  Marc Zyngier
- memory leak fix for hid-elan driver from Dinghao Liu
- two device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Dinghao Liu (1):
      HID: elan: Fix memleak in elan_input_configured

Marc Zyngier (2):
      HID: core: Correctly handle ReportSize being zero
      HID: core: Sanitize event code and type when mapping input

Nicholas Miell (1):
      HID: microsoft: Add rumble support for the 8bitdo SN30 Pro+ controller

Nirenjan Krishnan (1):
      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for all Saitek X52 devices

 drivers/hid/hid-core.c       | 15 +++++++++++++--
 drivers/hid/hid-elan.c       |  2 ++
 drivers/hid/hid-ids.h        |  3 +++
 drivers/hid/hid-input.c      |  4 ++++
 drivers/hid/hid-microsoft.c  |  2 ++
 drivers/hid/hid-multitouch.c |  2 ++
 drivers/hid/hid-quirks.c     |  2 ++
 include/linux/hid.h          | 42 +++++++++++++++++++++++++++++-------------
 8 files changed, 57 insertions(+), 15 deletions(-)

-- 
Jiri Kosina
SUSE Labs

