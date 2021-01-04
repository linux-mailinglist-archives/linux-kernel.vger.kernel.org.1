Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0CF2E8F45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 02:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbhADBsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 20:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbhADBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 20:48:17 -0500
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D8EC061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 17:47:36 -0800 (PST)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kwEy1-00047g-RD; Mon, 04 Jan 2021 02:47:29 +0100
Date:   Mon, 4 Jan 2021 02:47:29 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Ilkka Prusi' <ilkka.prusi@pp.inet.fi>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc1
Message-ID: <20210104014729.GA13829@angband.pl>
References: <0e0e5e88-1ff2-ef57-cfc3-a53c5a0f76c8@pp.inet.fi>
 <1930c2a3f18440ccb4890b7b01a33b94@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1930c2a3f18440ccb4890b7b01a33b94@AcuMS.aculab.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 05:45:16PM +0000, David Laight wrote:
> From: Ilkka Prusi
> > Note that /sbin is now just a symlink to /usr/sbin on Debian since 10 (Buster) as per FHS[1][2].
> > 
> > [1] https://wiki.linuxfoundation.org/lsb/fhs
> > [2] https://arstechnica.com/information-technology/2019/09/debian-10-playing-catch-up-with-the-rest-
> > of-the-linux-world-thats-a-good-thing/
> 
> Which is exactly 100% backwards :-)

I agree with you that, if all, it's /usr/sbin which should be a symlink,
to reduce typing and to get rid of a vestige of _The_ Unix machine having
/bin spill to a disk that used to have user homes.

But, /sbin is a symlink on only _some_ Debian installations.  There's
currently a discussion whether to go deeper into this scheme, abandon it
or do nothing.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ .--[ Makefile ]
⣾⠁⢠⠒⠀⣿⡁ # beware of races
⢿⡄⠘⠷⠚⠋⠀ all: pillage burn
⠈⠳⣄⠀⠀⠀⠀ `----
