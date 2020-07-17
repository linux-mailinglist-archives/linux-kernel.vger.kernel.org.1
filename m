Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2517223B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGQMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 08:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgGQMB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:01:57 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DA52065F;
        Fri, 17 Jul 2020 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594987317;
        bh=mnfntLyEtiq+iUKE1T/sBh9oAXfeZzV6JUguluXcCAw=;
        h=Date:From:To:cc:Subject:From;
        b=I9pqLgX3Y/uerBKEqPUSoOfKOpSAR2vRANsbrBq+NL5vfBnjkwmhG+W7WrBKTvPgX
         /flhQJrgiphbYcI/PvsQlpRqpHJJEUSatglM/WbC6jAxhKqikzrFP7Dhtvn/c7dc6k
         EIyc1lMHfjGKx6NxnWHctktjq5MrmQ50x928B7Q8=
Date:   Fri, 17 Jul 2020 14:01:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2007171358430.23768@cbobk.fhfr.pm>
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

to receive HID subsystem fixes.

=====
- linked list race condition fix in hid-steam driver from Rodrigo Rivas 
  Costa
- assorted deviceID-specific quirks and other small cosmetic cleanups
=====

Thanks.

----------------------------------------------------------------
Caiyuan Xie (1):
      HID: alps: support devices with report id 2

David Rheinsberg (1):
      MAINTAINERS: update uhid and hid-wiimote entry

Dmitry Torokhov (1):
      HID: magicmouse: do not set up autorepeat

Federico Ricchiuto (1):
      HID: i2c-hid: add Mediacom FlexBook edge13 to descriptor override

Hans de Goede (1):
      HID: apple: Disable Fn-key key-re-mapping on clone keyboards

James Hilliard (1):
      HID: quirks: Ignore Simply Automated UPB PIM

Maciej S. Szmigiero (1):
      HID: logitech-hidpp: avoid repeated "multiplier = " log messages

Mazin Rezk (1):
      HID: logitech: Use HIDPP_RECEIVER_INDEX instead of 0xff

Rodrigo Rivas Costa (1):
      HID: steam: fixes race in handling device list.

Sebastian Parschauer (1):
      HID: quirks: Always poll Obins Anne Pro 2 keyboard

 MAINTAINERS                              |  4 ++--
 drivers/hid/hid-alps.c                   |  2 ++
 drivers/hid/hid-apple.c                  | 18 ++++++++++++++++++
 drivers/hid/hid-ids.h                    |  3 +++
 drivers/hid/hid-logitech-dj.c            |  6 +++---
 drivers/hid/hid-logitech-hidpp.c         |  2 +-
 drivers/hid/hid-magicmouse.c             |  6 ++++++
 drivers/hid/hid-quirks.c                 |  2 ++
 drivers/hid/hid-steam.c                  |  6 ++++--
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |  8 ++++++++
 10 files changed, 49 insertions(+), 8 deletions(-)

-- 
Jiri Kosina
SUSE Labs

