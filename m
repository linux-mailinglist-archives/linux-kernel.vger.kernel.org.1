Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5F2F8FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 00:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbhAPXXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 18:23:09 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:60458 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbhAPXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 18:23:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E5B7922598;
        Sat, 16 Jan 2021 18:22:15 -0500 (EST)
Date:   Sun, 17 Jan 2021 10:22:15 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Rob Landley <rob@landley.net>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: Old platforms never die, was Re: Old platforms: bring out your
 dead
In-Reply-To: <897dbd50-ce42-8fdb-8777-fab08185e324@landley.net>
Message-ID: <alpine.LNX.2.23.453.2101171017320.6@nippy.intranet>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de> <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de> <alpine.LNX.2.23.453.2101131035500.6@nippy.intranet>
 <897dbd50-ce42-8fdb-8777-fab08185e324@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021, Rob Landley wrote:

> Speaking of which, my qemu m68k system has failed to boot ever since commit:
> 
> commit f93bfeb55255bddaa16597e187a99ae6131b964a
> Author: Finn Thain <fthain@telegraphics.com.au>
> Date:   Sun Jun 28 14:23:12 2020 +1000
> 
>     macintosh/via-macii: Poll the device most likely to respond
> 

Yes, that patch series broke your emulator by fixing kernel bugs. Please 
refer to this message for some background and some solutions--
https://lore.kernel.org/linux-m68k/alpine.LNX.2.23.453.2008100844450.8@nippy.intranet/
