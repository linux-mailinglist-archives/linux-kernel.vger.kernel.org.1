Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F4828BE36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbgJLQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:43:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55632 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403844AbgJLQnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:43:13 -0400
Received: from zn.tnic (p200300ec2f0692001c25a8ecc208ce91.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:1c25:a8ec:c208:ce91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E5221EC038E;
        Mon, 12 Oct 2020 18:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602520992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=02Nq2GzruJylEKWJf8PrXOs4tMxUNALrCv4iiieD2DM=;
        b=RFVMFif8o66KZF+g46AeV1XTCzg3gNUGY8K8nUJhFCGRoHrJCAb17Jzfang+biVkh3aNys
        1MtoZh/ZDPNTW2pwMK4pmfs4z0ksh0NDuiEqqaS/rvplzAKeraO1JA6S2lhUxrVJEzfnMX
        afptsXqx6m344ZZhU6A0xXc3MEeubkE=
Date:   Mon, 12 Oct 2020 18:43:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernelci@groups.io
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
Message-ID: <20201012164308.GF22829@zn.tnic>
References: <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
 <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
 <20201012035846.GB11282@1wt.eu>
 <b188f977-b11e-f570-599a-7bcf364be0fd@collabora.com>
 <20201012143212.GC22829@zn.tnic>
 <20201012144040.GB11614@1wt.eu>
 <a165781d-d1c8-04e2-0b60-8d776a21a625@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a165781d-d1c8-04e2-0b60-8d776a21a625@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 04:10:45PM +0100, Guillaume Tucker wrote:
> You can get serial console on recent enough Chromebooks with a
> debug interface such as SuzyQable:
> 
>   https://www.sparkfun.com/products/14746
> 
> It's not a USB Type-C adapter, it has a debug interface which
> works with Chromebooks that support Case-Closed Debugging.
> Anyone can do that without modifying the Chromebook, and with a
> bit of patience to go through the documentation[1]...
> 
> The KernelCI sample results from my previous email were run using
> just that: off-the-shelf Chromebooks + SuzyQ + rebuilt firmware
> for interactive console and tftp boot + kernel with the config
> options in Enric's patch.

That sounds interesting, thanks for elaborating.

At the same time, you see how this setup is very hw-specific and not
really common and those options do not really belong in a defconfig but
in a kernelCI snippet, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
