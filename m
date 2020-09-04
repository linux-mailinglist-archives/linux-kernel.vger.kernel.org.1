Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB60025E422
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 01:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgIDX0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 19:26:36 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34838 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgIDX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:26:28 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 7745D2ACD4; Fri,  4 Sep 2020 19:26:27 -0400 (EDT)
Message-Id: <cover.1599260540.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/5] powerpc/tau: TAU driver fixes
Date:   Sat, 05 Sep 2020 09:02:20 +1000
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes various bugs in the Thermal Assist Unit driver.
It was tested on 266 MHz and 292 MHz PowerBook G3 laptops.


Finn Thain (5):
  powerpc/tau: Use appropriate temperature sample interval
  powerpc/tau: Convert from timer to workqueue
  powerpc/tau: Remove duplicated set_thresholds() call
  powerpc/tau: Check processor type before enabling TAU interrupt
  powerpc/tau: Disable TAU between measurements

 arch/powerpc/include/asm/reg.h |   2 +-
 arch/powerpc/kernel/tau_6xx.c  | 147 +++++++++++++--------------------
 arch/powerpc/platforms/Kconfig |  14 +---
 3 files changed, 62 insertions(+), 101 deletions(-)

-- 
2.26.2

