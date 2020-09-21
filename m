Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB342728C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgIUOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgIUOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:47:37 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:47:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 9BCC223F03F;
        Mon, 21 Sep 2020 16:47:33 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.012
X-Spam-Level: 
X-Spam-Status: No, score=-3.012 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.112, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MVJH7DocHExI; Mon, 21 Sep 2020 16:47:32 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id F3B3D23F0E6;
        Mon, 21 Sep 2020 16:47:31 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 00/33] Make charlcd device independent
Date:   Mon, 21 Sep 2020 16:46:12 +0200
Message-Id: <20200921144645.2061313-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20191016082430.5955-1-poeschel@lemonage.de>
References: <20191016082430.5955-1-poeschel@lemonage.de>
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
I submitted this already some time ago [1], where the wish was so split
this into smaller chunks what I try to do with this new patchset.
Most of the patches pick one specific function in charlcd and move the
device specific code into hd44780_common.

[1] https://marc.info/?l=linux-kernel&m=157121432124507

Lars Poeschel (33):
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
  auxdisplay: Move clear_fast to hd44780
  auxdisplay: remove naive display clear impl
  auxdisplay: hd44780: Remove clear_fast
  auxdisplay: charlcd: replace last device specific stuff
  auxdisplay: Change gotoxy calling interface
  auxdisplay: charlcd: Do not print chars at end of line
  auxdisplay: lcd2s DT binding doc
  auxdisplay: add a driver for lcd2s character display

 .../bindings/auxdisplay/modtronix,lcd2s.yaml  |  55 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/auxdisplay/Kconfig                    |  31 ++
 drivers/auxdisplay/Makefile                   |   2 +
 drivers/auxdisplay/charlcd.c                  | 406 +++++------------
 drivers/auxdisplay/charlcd.h                  |  86 +++-
 drivers/auxdisplay/hd44780.c                  | 120 +++--
 drivers/auxdisplay/hd44780_common.c           | 367 ++++++++++++++++
 drivers/auxdisplay/hd44780_common.h           |  34 ++
 drivers/auxdisplay/lcd2s.c                    | 409 ++++++++++++++++++
 drivers/auxdisplay/panel.c                    | 125 ++++--
 11 files changed, 1254 insertions(+), 383 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
 create mode 100644 drivers/auxdisplay/hd44780_common.c
 create mode 100644 drivers/auxdisplay/hd44780_common.h
 create mode 100644 drivers/auxdisplay/lcd2s.c

-- 
2.28.0

