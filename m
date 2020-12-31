Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFFF2E7E84
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 08:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgLaHDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 02:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgLaHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 02:03:00 -0500
X-Greylist: delayed 1525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Dec 2020 23:02:20 PST
Received: from relay.heise.de (relay.heise.de [IPv6:2a00:e68:14:800::19:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA87C061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 23:02:20 -0800 (PST)
Subject: Re: [PATCH] genirq: Export irq_check_status_bit
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20201230154600.697832-1-arnd@kernel.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Message-ID: <49cdadb1-9624-7a92-f3e7-f403702dc504@leemhuis.info>
Date:   Thu, 31 Dec 2020 07:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201230154600.697832-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMScanToken: 6dcdffc65b05d9a7f26f2c0c644384e3e46d3b73
X-TMASE-Version: DDEI-3.5-8.6.1012-25882.005
X-TMASE-Result: 10--3.183000-10.000000
X-TMASE-MatchedRID: HXSqh3WYKfu8rRvefcjeTXB4kOjNh/grC/ExpXrHizzLkl8e9W70i3jm
        0APnwZU2memipv1u6D8uKMVOeSDBJed7FYYeUBPYqJSK+HSPY+8o/EsCKojU0pSNvrzEd0cAgyW
        NJp//h3U/UQO6d5wrV9L9pf3er7uLKkcZdZbwqhJn3ejPjd19cf/dUP8atA+/Ed+K6O5Nt53QgB
        hawGY6JUK4Kzw5Vavi2Oqz8656LhSjxYyRBa/qJQPTK4qtAgwIIC0OoeD/hCbQLWxBF9DMQcRB0
        bsfrpPI34T9cYMsdwyMQdS/ovhnQZjA0Phg8EMbqFAyVD16PxizIzSzuzYuwRCcskHezVkRLzKR
        3kfFEU/SNaJeiJwMqj76msHO2b/gxb1b0rf3JHB3JEmTicHZtRj5UCuziZqVQXUTGRdR3d+JVXE
        sQ8vgPvhIxIQs/UPl
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.12.20 um 16:45 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Changing some inline functions to use the new irq_check_status_bit
> function out of line breaks calling them from loadable modules:
> 
> ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

Just FYI: Levi Yun sent a similar patch a on Dec, 26 already:
https://lore.kernel.org/lkml/20201226123818.GA693525@ubuntu/

But nothing happened afaics, the festival season is taking its toll. ;-)

I'd like to see this fixed, too, as it broke my
Kernel Vanilla builds for Fedora
(https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories) just a day
after I finally started building packages for aarch64, too. Bad timing. :-D

Ciao, Thorsten


