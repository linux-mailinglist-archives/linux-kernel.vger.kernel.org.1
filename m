Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B012FCFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbhATMLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:11:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:34577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbhATLig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611142605;
        bh=aVET+wz+kjusraCq29ri48PapN98Xe4kIWgZypXqinI=;
        h=X-UI-Sender-Class:From:Subject:Date:Cc:To;
        b=KI/45I/mS+fQeNcG0F9vvcYqiUOzAsK96hgWYLOK3NaAdAd2d+0t0br3qq6+BmCec
         UDoTgQgBXoDrcPawRi1KFfjTVxFfgKZlmVkFGjZukZ/Zc9mR5VzT75cZIYQXJSwN7W
         zCQtcIq+5b22NP+LKeulymGUJLn1UXzBTy7OT2vU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mj8qj-1lhHAm2suz-00fFKD; Wed, 20
 Jan 2021 12:36:45 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: [PATCH 0/3] Preparations for Linux on Apple Silicon
Message-Id: <70D1FB71-240D-4FC4-81BC-0954062A4D11@caramail.com>
Date:   Wed, 20 Jan 2021 12:36:42 +0100
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:0ZbjSfBHge3wfOs5O8Uj0W1dOQ4a0QrcA0NmJEtRctMYxWd9TqK
 0eO0jD/QUMHnjcNngoCoSY0ClG+KWdc3jcO2OuXbSZMnCtr9Bw2xqzWs3EStX9fMP2Dwa1I
 j1ZAOd2zEDjOIGqzWfypcHP5tkCuOqDSnN1lWSj1lyfTQP65tp3dHhN16oyT74V9gASSlXP
 fUFwJCj+8twAxk2U30FyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zXztcCdzYNA=:3y0w6GKGCG8LecEyvqkO4N
 8eqOpMtU/lJRa0tCAqzZCW4dFno82geYqZKJkZW6fMDjg8h5M2y+jJ36ByyIE3wRh+xlzf/54
 Id0+8W76UzVDZag5jltjTlRW/Xc3fVxQMPFG5frHvn7i3xj6EBOZBlNUvmBTDZzFt2GKBGIOG
 G62sdKT0GRpuDXesZs2iCemr+EjrNlJm8PT4iQhCWj2fTvOPfKBzfKopyS0xeoWRCQHaGRZRj
 rQK6W9BN5vVm7Vy9mZLYb8RyE2uaswWb219AMDDrncCCtTkRq9q6SnKdI1mGvDAlaQEqzAp3v
 fi/S/3q1glcHTeg2DKhCw9VNpn+B5pLtq+5KXO+LN5QUoEvJU5auJAQcIYOv85iBlmVGbRuk+
 caVEqc3sT6h5l1SBtp4HLolkOCHhpaWuWYn0wCwezknuWm4ZomKFvh/p++CnvzzIe/TgO0AOc
 a0u3C+I3lnd7KCWn14PP3/baVBjnm2qoQgy/4eFqj/Ce8NK0UzVdIOrYI0+ePJWzaaeymx0EK
 54Lck4dNHiRhyP82e8mJLiGWP21HJ7m960/S/UPp55GCDrKyl/ScKfYeq5ZbIkT3lJLKOx532
 j4iMTlBXMehPQm10jjpXF9JQz+FjjgGEvUFJVk5aLfiQnnzC7BZ/0PxnaOwbvNUDEUPGtpmD0
 KgJGqj+fInpMv84/cJZRQSVn6K0FYq2OLC0Ji5xVZFt5wlVZLIIxM1KZS+iN12DYpzjNG3cY9
 bIlS/trs+BQA4N2ph2fMQxlz5dEKOce+Y79CxCRheIRCMvtqHPRyDnvjZRqHbquZ0++sIi2un
 zsL5ByHmBdYk8gmrMV+rTXDX1xiTKrAe5dUx+ZXqxvS08Tw1aApNw2mL7imrxiDaK42en66LO
 3Q8gXYTtMHnLRYW4Tt64IkqB25zntHU6gdyUKQgQQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains the changes to common Linux
kernel code that are required to boot Linux on Apple Silicon
Mac computers.

The changes:

- Support for FIQ interrupts in-kernel

This is required for the timer and IPIs on Apple SoCs.

- WFI hook

Apple processors do not keep register state across WFI.
As such, put a mechanism in cpu_ops to put a custom
sleep function instead.

- use nGnRnE instead of nGnRE on Apple processors

Device-nGnRE writes go to nowhere on Apple processors, as
such use MAIR to change those to Device-nGnRE writes.

Mohamed Mediouni (1):
  arm64: mm: use nGnRnE instead of nGnRE on Apple processors

Stan Skowronek (2):
  arm64/kernel: FIQ support
  arm64: kernel: Add a WFI hook.

 arch/arm64/include/asm/arch_gicv3.h |  2 +-
 arch/arm64/include/asm/assembler.h  |  8 ++--
 arch/arm64/include/asm/cpu_ops.h    |  2 +
 arch/arm64/include/asm/daifflags.h  |  4 +-
 arch/arm64/include/asm/irq.h        |  4 ++
 arch/arm64/include/asm/irqflags.h   |  6 +--
 arch/arm64/kernel/cpu_ops.c         |  6 +++
 arch/arm64/kernel/entry.S           | 74 ++++++++++++++++++++++++++---
 arch/arm64/kernel/irq.c             | 14 ++++++
 arch/arm64/kernel/process.c         | 13 +++--
 arch/arm64/mm/proc.S                | 26 ++++++++++
 11 files changed, 140 insertions(+), 19 deletions(-)

=2D-
2.29.2

