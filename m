Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475AB1E946C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 01:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgE3XQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 19:16:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51054 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbgE3XQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:16:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 48A0127F0C; Sat, 30 May 2020 19:16:28 -0400 (EDT)
Message-Id: <cover.1590880333.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/4] Mac IOP driver fixes
Date:   Sun, 31 May 2020 09:12:13 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series has several bug fixes for the IOP driver and some
improvements to the debug level log messages.

Geert, please consider pushing these fixes for v5.8, if not the
whole series.


Finn Thain (4):
  m68k/mac: Don't send IOP message until channel is idle
  m68k/mac: Fix IOP status/control register writes
  m68k/mac: Don't send uninitialized data in IOP message reply
  m68k/mac: Improve IOP debug messages

 arch/m68k/mac/iop.c | 60 ++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

-- 
2.26.2

