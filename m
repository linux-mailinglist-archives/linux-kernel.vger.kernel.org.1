Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04123303AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404602AbhAZK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:57:14 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:41822 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbhAZDcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 22:32:54 -0500
X-Greylist: delayed 2348 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 22:32:53 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1l4ERQ-004Msq-5n; Tue, 26 Jan 2021 03:50:52 +0100
Date:   Tue, 26 Jan 2021 03:50:52 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210126025052.GA1040564@angband.pl>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.
> 
> Yet, various unofficial reports indicate it will be supported for 6
> years.  And AOSP has already declared the use of 5.10 kernel in their
> Android S and T releases.

5.10 will also be used for Debian Bullseye.

-- 
⢀⣴⠾⠻⢶⣦⠀ .--[ Makefile ]
⣾⠁⢠⠒⠀⣿⡁ # beware of races
⢿⡄⠘⠷⠚⠋⠀ all: pillage burn
⠈⠳⣄⠀⠀⠀⠀ `----
