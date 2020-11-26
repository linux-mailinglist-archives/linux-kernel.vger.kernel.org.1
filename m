Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F82C56D9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391022AbgKZOOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390022AbgKZOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:14:34 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B43C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l+r/ujMibWxRMGoyxuToDzSWZqq35vXIRnqSxtmnTk8=; b=zRe5uvbkZY2/VpqCTglS7P2Hu
        qj90YaWrDXLJuyMqXJTJxJPXE2mngGjgymCVJR8Ul82lwIoeirlzmzM5lLnD61mY8WPMW0lGfsDki
        WCImjakz0JYoKOs/ta2gBwdNLm7FWbUEEjSOZXxwJ2VrXnZHgR1oWPugd82qsERhDeEEckMFVqUHF
        1mTC4TX178jp1/UGvCrdahhKP9et4IdxfRVJA1p5bWpEzKiyVBUJPJowRbezRrdfetnLbZKyE6dKE
        4Tl5VPakkrgJiEfHmZnFSTdVsK2YcCe0rDuBodsk+QpesN/V/pbi71EpatN2gMSa9iwAmdd/eDvrT
        T6IBv8qJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36344)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kiI2Y-0001qm-J8; Thu, 26 Nov 2020 14:14:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kiI2X-000108-Af; Thu, 26 Nov 2020 14:14:29 +0000
Date:   Thu, 26 Nov 2020 14:14:29 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next 20201126 - build error on arm allmodconfig
Message-ID: <20201126141429.GL1551@shell.armlinux.org.uk>
References: <24105.1606397102@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24105.1606397102@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 08:25:02AM -0500, Valdis Klētnieks wrote:
> Seems something is giving it indigestion regarding asmlinkage...
> 
>   CC      arch/arm/mm/kasan_init.o
> In file included from ./include/linux/kasan.h:15,
>                  from arch/arm/mm/kasan_init.c:11:
> ./arch/arm/include/asm/kasan.h:26:11: error: expected ';' before 'void'
>  asmlinkage void kasan_early_init(void);
>            ^~~~~
>            ;
> make[2]: *** [scripts/Makefile.build:283: arch/arm/mm/kasan_init.o] Error 1
> make[1]: *** [scripts/Makefile.build:500: arch/arm/mm] Error 2
> make: *** [Makefile:1803: arch/arm] Error 2
> 
> Git bisect points at:
> 
> commit 2df573d2ca4c1ce6ea33cb7849222f771e759211
> Author: Andrey Konovalov <andreyknvl@google.com>
> Date:   Tue Nov 24 16:45:08 2020 +1100
> 
>     kasan: shadow declarations only for software modes
> 
> Looks like it's this chunk:
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 59538e795df4..26f2ab92e7ca 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -11,7 +11,6 @@ struct task_struct;
> 
>  #ifdef CONFIG_KASAN
> 
> -#include <linux/pgtable.h>
>  #include <asm/kasan.h>
> 
> Testing shows putting that #include back in makes it compile correctly,
> but it's not obvious why putting that back makes 'asmlinkage' recognized.
> 
> "You are in a twisty little maze of #includes, all different"... :)

The real answer is for asm/kasan.h to include linux/linkage.h

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
