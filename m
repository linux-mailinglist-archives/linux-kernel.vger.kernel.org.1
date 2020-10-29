Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93E429E839
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgJ2KEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2KEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:04:07 -0400
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:04:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 39F5723F9D3;
        Thu, 29 Oct 2020 11:04:05 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.945
X-Spam-Level: 
X-Spam-Status: No, score=-2.945 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.045, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vy9hWqV97SFU; Thu, 29 Oct 2020 11:04:03 +0100 (CET)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 2505923F2CE;
        Thu, 29 Oct 2020 11:04:03 +0100 (CET)
Date:   Thu, 29 Oct 2020 11:03:57 +0100
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] Make charlcd device independent
Message-ID: <20201029100357.6so4jehdj3fj2fc3@lem-wkst-02.lemonage>
References: <20201029095033.310788-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029095033.310788-1-poeschel@lemonage.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was sent wrong. Should be v5. Drop this one.

Sorry and thanks,
Lars

On Thu, Oct 29, 2020 at 10:50:07AM +0100, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> This tries to make charlcd device independent. At the moment hd44780
> device specific code is contained deep in charlcd. This moves this out
> into a hd44780_common module, where the two hd44780 drivers we have at
> the moment (hd44780 and panel) can use this from. The goal is that at
> the end other drivers can use the charlcd interface.
> I add one such driver for a modtronix lcd displau  with the last patch.
> I submitted this already some time ago, where the wish was so split
> this into smaller chunks what I try to do with this patchset.
> 
> This is v5 of the patchset. I address a few review comments with this.
> I fixed some typos, but more importantly Miguel spotted that I reverted
> commit 3f03b6498 ("auxdisplay: charlcd: Reuse hex_to_bin() instead of
> custom code") during rebasing. This is corrected now.
> 
> As a note to patch 23:
> This might slightly change behaviour.
> On hd44780 displays with one or two lines the previous implementation
> did still write characters to the buffer of the display even if they are
> currently not visible. The shift_display command could be used so set
> the "viewing window" to a new position in the buffer and then you could
> see the characters previously written.
> This described behaviour does not work for hd44780 displays with more
> than two display lines. There simply is not enough buffer.
> So the behaviour was a bit inconsistens across different displays.
> The new behaviour is to stop writing character at the end of a visible
> line, even if there would be room in the buffer. This allows us to have
> an easy implementation, that should behave equal on all supported
> displays. This is not hd44780 hardware dependent anymore.
> 
> Link: https://lore.kernel.org/lkml/20191016082430.5955-1-poeschel@lemonage.de/
> Link: https://lore.kernel.org/lkml/CANiq72kS-u_Xd_m+2CQVh-JCncPf1XNXrXAZ=4z+mze8fwv2kw@mail.gmail.com/
> 
> Changes in v5:
> - patch 1: Fix a commit message typo: of -> on
> - patch 2: Remove some unnecessary newlines
> - patch 8: Fix some typos
> - patch 14: Fix commit message typo: it's -> its
> - patch 15: this patch is squashed together from the former individual
>   hd44780_common_ function patches
> - patch 16: combined two cleanup patches
> - patch 17: I did previously undo commit 3f03b6498 which was a mistake.
>   This is now corrected.
> - patch 24: Picked up Robs Reviewed-by
> - patch 25: use hex_to_bin like in commit 3f03b6498 but for the lcd2s.c
>   file
> 
> Changes in v4:
> - modtronix -> Modtronix in new lcd2s driver
> - Kconfig: remove "default n" in new lcd2s driver
> 
> Changes in v3:
> - Fix some typos in Kconfig stuff
> - Fix kernel test robot reported error: Missed EXPORT_SYMBOL_GPL
> - new patch to reduce display timeout
> - better patch description to why not move cursor beyond end of a line
> - Fixed make dt_binding_doc errors
> 
> Changes in v2:
> - split whole patch into many smaller chunks
> - device tree doc in yaml
> 
> Lars Poeschel (25):
>   auxdisplay: Use an enum for charlcd  backlight on/off ops
>   auxdisplay: Introduce hd44780_common.[ch]
>   auxdisplay: Move hwidth and bwidth to struct hd44780_common
>   auxdisplay: Move ifwidth to struct hd44780_common
>   auxdisplay: Move write_data pointer to hd44780_common
>   auxdisplay: Move write_cmd pointers to hd44780 drivers
>   auxdisplay: Move addr out of charlcd_priv
>   auxdisplay: hd44780_common_print
>   auxdisplay: provide hd44780_common_gotoxy
>   auxdisplay: add home to charlcd_ops
>   auxdisplay: Move clear_display to hd44780_common
>   auxdisplay: make charlcd_backlight visible to hd44780_common
>   auxdisplay: Make use of enum for backlight on / off
>   auxdisplay: Move init_display to hd44780_common
>   auxdisplay: implement various hd44780_common_ functions
>   auxdisplay: cleanup unnecessary hd44780 code in charlcd
>   auxdisplay: Move char redefine code to hd44780_common
>   auxdisplay: Call charlcd_backlight in place
>   auxdisplay: hd44780_common: Reduce clear_display timeout
>   auxdisplay: hd44780: Remove clear_fast
>   auxdisplay: charlcd: replace last device specific stuff
>   auxdisplay: Change gotoxy calling interface
>   auxdisplay: charlcd: Do not print chars at end of line
>   auxdisplay: lcd2s DT binding doc
>   auxdisplay: add a driver for lcd2s character display
> 
>  .../bindings/auxdisplay/modtronix,lcd2s.yaml  |  58 +++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/auxdisplay/Kconfig                    |  30 ++
>  drivers/auxdisplay/Makefile                   |   2 +
>  drivers/auxdisplay/charlcd.c                  | 412 +++++-------------
>  drivers/auxdisplay/charlcd.h                  |  86 +++-
>  drivers/auxdisplay/hd44780.c                  | 120 +++--
>  drivers/auxdisplay/hd44780_common.c           | 361 +++++++++++++++
>  drivers/auxdisplay/hd44780_common.h           |  33 ++
>  drivers/auxdisplay/lcd2s.c                    | 403 +++++++++++++++++
>  drivers/auxdisplay/panel.c                    | 180 ++++----
>  11 files changed, 1237 insertions(+), 450 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
>  create mode 100644 drivers/auxdisplay/hd44780_common.c
>  create mode 100644 drivers/auxdisplay/hd44780_common.h
>  create mode 100644 drivers/auxdisplay/lcd2s.c
> 
> -- 
> 2.28.0
> 
