Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB42D5925
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgLJLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:25:04 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:56064 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgLJLYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:24:17 -0500
Received: from [IPv6:2a01:e34:ed2f:f020:4ea:d408:1aec:e109] (unknown [IPv6:2a01:e34:ed2f:f020:4ea:d408:1aec:e109])
        (Authenticated sender: daniel.lezcano)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id 8A2EB19F4C8;
        Thu, 10 Dec 2020 12:23:20 +0100 (CET)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@free.fr>
Subject: [GIT PULL] timers changes for v5.11 #2
Autocrypt: addr=daniel.lezcano@free.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <65d593c1-93a8-bd43-bfb5-891e7c2f4f2b@free.fr>
Date:   Thu, 10 Dec 2020 12:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider pulling those 3 last changes which fixes some issues on
the drivers.

The following changes since commit fef92cd2bc04c64bb3743d40c0b4be47aedf9e23:

  Merge tag 'timers-v5.11' of
https://git.linaro.org/people/daniel.lezcano/linux into timers/core
(2020-12-04 00:39:45 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.11-2

for you to fetch changes up to 8ae954caf49ac403c177d117fb8e05cbc866aa3c:

  clocksource/drivers/sh_cmt: Fix potential deadlock when calling
runtime PM (2020-12-07 20:10:05 +0100)

----------------------------------------------------------------
- Fix error handling if no clock is available on dw_apb_timer_of (Dinh
Nguyen)

- Fix overhead for erratum handling when the timer has no erratum and
  fix fault programing for the event stream on the arm arch timer
  (Keqian Zhu)

- Fix potential deadlock when calling runtime PM on sh_cmt (Niklas
  Söderlund)

----------------------------------------------------------------
Dinh Nguyen (1):
      clocksource/drivers/dw_apb_timer_of: Add error handling if no
clock available

Keqian Zhu (2):
      clocksource/drivers/arm_arch_timer: Use stable count reader in
erratum sne
      clocksource/drivers/arm_arch_timer: Correct fault programming of
CNTKCTL_EL1.EVNTI

Niklas Söderlund (1):
      clocksource/drivers/sh_cmt: Fix potential deadlock when calling
runtime PM

 drivers/clocksource/arm_arch_timer.c  | 27 ++++++++++++++++++---------
 drivers/clocksource/dw_apb_timer_of.c | 57
+++++++++++++++++++++++++++++++++++++++------------------
 drivers/clocksource/sh_cmt.c          | 18 ++++++++++++++----
 3 files changed, 71 insertions(+), 31 deletions(-)
