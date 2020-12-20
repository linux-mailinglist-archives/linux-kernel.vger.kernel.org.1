Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD352DF721
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 00:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgLTXfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 18:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgLTXfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 18:35:07 -0500
From:   Greg Ungerer <gerg@linux-m68k.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
Subject: [git pull] m68knommu changes for v5.11
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <b38f2450-9e60-8312-5eb9-220f8956218d@linux-m68k.org>
Date:   Mon, 21 Dec 2020 09:34:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.11.

Regards
Greg



The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

   Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.11

for you to fetch changes up to 8b22820efb35f93d98638563b0a8f4094e8ee399:

   m68k: m68328: remove duplicate code (2020-12-07 09:37:58 +1000)

----------------------------------------------------------------
Fixes include:
. cleanup of 68328 code
. align BSS section to 32bit

----------------------------------------------------------------
Arnd Bergmann (2):
       m68k: m68328: move platform code to separate files
       m68k: m68328: remove duplicate code

Greg Ungerer (1):
       m68knommu: align BSS section to 4-byte boundaries

  arch/m68k/68000/Makefile           |   9 +-
  arch/m68k/68000/dragen2.c          | 100 ++++++++++++++++++++
  arch/m68k/68000/m68328.c           |  32 ++++---
  arch/m68k/68000/m68328.h           |   5 +
  arch/m68k/68000/m68EZ328.c         |  77 ---------------
  arch/m68k/68000/m68VZ328.c         | 189 -------------------------------------
  arch/m68k/68000/ucsimm.c           |  38 ++++++++
  arch/m68k/Kconfig.cpu              |   8 +-
  arch/m68k/Kconfig.machine          |  16 ++--
  arch/m68k/kernel/setup_no.c        |   9 ++
  arch/m68k/kernel/vmlinux-nommu.lds |   2 +-
  11 files changed, 192 insertions(+), 293 deletions(-)
  create mode 100644 arch/m68k/68000/dragen2.c
  create mode 100644 arch/m68k/68000/m68328.h
  delete mode 100644 arch/m68k/68000/m68EZ328.c
  delete mode 100644 arch/m68k/68000/m68VZ328.c
  create mode 100644 arch/m68k/68000/ucsimm.c
