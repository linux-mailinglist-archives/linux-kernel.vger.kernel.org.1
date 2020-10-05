Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA62283569
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgJEMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJEMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:12:19 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A4C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:12:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 74EBC23F8B9;
        Mon,  5 Oct 2020 14:12:17 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.996
X-Spam-Level: 
X-Spam-Status: No, score=-2.996 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.096, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UNJ50ltrtRyG; Mon,  5 Oct 2020 14:12:16 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id C1D5623F823;
        Mon,  5 Oct 2020 14:12:15 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v3 00/32] Make charlcd device independent
Date:   Mon,  5 Oct 2020 14:11:28 +0200
Message-Id: <20201005121200.3427363-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This tries to make charlcd device independent. At the moment hd44780
device specific code is contained deep in charlcd. This moves this out
into a hd44780_common module, where the two hd44780 drivers we have at
the moment (hd44780 and panel) can use this from. The goal is that at
the end other drivers can use the charlcd interface.
I add one such driver at the end with the last patch.
I submitted this already some time ago, where the wish was so split
this into smaller chunks what I try to do with this new patchset.
Most of the patches pick one specific function in charlcd and move the
device specific code into hd44780_common.

As a note to patch 30:
This might slightly change behaviour.
On hd44780 displays with one or two lines the previous implementation
did still write characters to the buffer of the display even if they are
currently not visible. The shift_display command could be used so set
the "viewing window" to a new position in the buffer and then you could
see the characters previously written.
This described behaviour does not work for hd44780 displays with more
than two display lines. There simply is not enough buffer.
So the behaviour was a bit inconsistens across different displays.
The new behaviour is to stop writing character at the end of a visible
line, even if there would be room in the buffer. This allows us to have
an easy implementation, that should behave equal on all supported
displays. This is not hd44780 hardware dependents anymore.

Link: https://lore.kernel.org/lkml/20191016082430.5955-1-poeschel@lemonage.de/
Link: https://lore.kernel.org/lkml/CANiq72kS-u_Xd_m+2CQVh-JCncPf1XNXrXAZ=4z+mze8fwv2kw@mail.gmail.com/

Lars Poeschel (32):
  auxdisplay: Use an enum for charlcd  backlight on/off ops
  auxdisplay: Introduce hd44780_common.[ch]
  auxdisplay: Move hwidth and bwidth to struct hd44780_common
  auxdisplay: Move ifwidth to struct hd44780_common
  auxdisplay: Move write_data pointer to hd44780_common
  auxdisplay: Move write_cmd pointers to hd44780 drivers
  auxdisplay: Move addr out of charlcd_priv
  auxdisplay: hd44780_common_print
  auxdisplay: provide hd44780_common_gotoxy
  auxdisplay: add home to charlcd_ops
  auxdisplay: Move clear_display to hd44780_common
  auxdisplay: make charlcd_backlight visible to hd44780_common
  auxdisplay: Make use of enum for backlight on / off
  auxdisplay: Move init_display to hd44780_common
  auxdisplay: implement hd44780_common_shift_cursor
  auxdisplay: Implement hd44780_common_display_shift
  auxdisplay: Implement a hd44780_common_display
  auxdisplay: Implement hd44780_common_cursor
  auxdisplay: Implement hd44780_common_blink
  auxdisplay: cleanup unnecessary hd44780 code in charlcd
  auxdisplay: Implement hd44780_common_fontsize
  auxdisplay: Implement hd44780_common_lines
  auxdisplay: Remove unnecessary hd44780 from charlcd
  auxdisplay: Move char redefine code to hd44780_common
  auxdisplay: Call charlcd_backlight in place
  auxdisplay: hd44780_common: Reduce clear_display timeout
  auxdisplay: hd44780: Remove clear_fast
  auxdisplay: charlcd: replace last device specific stuff
  auxdisplay: Change gotoxy calling interface
  auxdisplay: charlcd: Do not print chars at end of line
  auxdisplay: lcd2s DT binding doc
  auxdisplay: add a driver for lcd2s character display

 .../bindings/auxdisplay/modtronix,lcd2s.yaml  |  58 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/auxdisplay/Kconfig                    |  31 ++
 drivers/auxdisplay/Makefile                   |   2 +
 drivers/auxdisplay/charlcd.c                  | 412 +++++-------------
 drivers/auxdisplay/charlcd.h                  |  86 +++-
 drivers/auxdisplay/hd44780.c                  | 120 +++--
 drivers/auxdisplay/hd44780_common.c           | 368 ++++++++++++++++
 drivers/auxdisplay/hd44780_common.h           |  34 ++
 drivers/auxdisplay/lcd2s.c                    | 409 +++++++++++++++++
 drivers/auxdisplay/panel.c                    | 180 ++++----
 11 files changed, 1252 insertions(+), 450 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
 create mode 100644 drivers/auxdisplay/hd44780_common.c
 create mode 100644 drivers/auxdisplay/hd44780_common.h
 create mode 100644 drivers/auxdisplay/lcd2s.c

-- 
2.28.0

