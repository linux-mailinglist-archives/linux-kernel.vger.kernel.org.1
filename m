Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91DE1E64E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403834AbgE1O4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403780AbgE1O4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:56:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B4C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:56:11 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeJx3-0002Pv-SQ; Thu, 28 May 2020 16:56:09 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3DC2AFF834;
        Thu, 28 May 2020 16:56:09 +0200 (CEST)
Message-Id: <20200528145315.727724091@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 28 May 2020 16:53:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 0/5] x86/idt: Cleanups and consolidation
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT functionality is spread out to places which results in way too many
globals.

This series cleans that up, fixes comments and a few other oddities which I
noticed while working on that code.

Thanks,

	tglx

---
 include/asm/desc.h  |   47 --------------------
 kernel/cpu/common.c |   17 -------
 kernel/idt.c        |  120 +++++++++++++++++++++++++++++++++++++---------------
 kernel/traps.c      |   11 ----
 4 files changed, 88 insertions(+), 107 deletions(-)


