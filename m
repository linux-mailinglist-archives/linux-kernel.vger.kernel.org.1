Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBA28BE25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbgJLQjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:39:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390257AbgJLQjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:39:42 -0400
Received: from zn.tnic (p200300ec2f0692001c25a8ecc208ce91.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:1c25:a8ec:c208:ce91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D1941EC038E;
        Mon, 12 Oct 2020 18:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602520781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1m0DH5UmCJSF9Rl3zv+K8pYVBHTdSbiBTatTJ7kA1o=;
        b=pOCV8CU0oAPuXx2XOKXVGjHpBDlF17JCalFaxhsB64sDSOq5oKuvRF80HenpYk5muNWQIl
        Xi7jGMFliPndYpWJpnlp/Dfz4tWAx+l024PSIxqKy1LG4KQzzw3KTZ3gY/oPoILaVs9Skb
        2bCLcZP5p9CfBmmfDkPQFi2ukmsbDtI=
Date:   Mon, 12 Oct 2020 18:39:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
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
Message-ID: <20201012163932.GE22829@zn.tnic>
References: <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
 <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
 <20201012035846.GB11282@1wt.eu>
 <b188f977-b11e-f570-599a-7bcf364be0fd@collabora.com>
 <20201012143212.GC22829@zn.tnic>
 <20201012144040.GB11614@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201012144040.GB11614@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 04:40:40PM +0200, Willy Tarreau wrote:
> Well, to be precise, they don't have *anymore*. I used to exclusively
> select laptops having a serial port given that I was using it daily with
> routers, until I had to resign when I abandonned my good old NC8000 :-/

Yah, with all those new features crap they add to modern laptops, you'd
think they put in a serial port for 2¢ but nope... ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
