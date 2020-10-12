Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69D428BAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgJLOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:32:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbgJLOcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:32:18 -0400
Received: from zn.tnic (p200300ec2f06920008362ea164c1c332.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:836:2ea1:64c1:c332])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB9FA1EC0354;
        Mon, 12 Oct 2020 16:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602513136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=97Dm5EM+DI0yMZnhnHJXD/nSSVckzIbKcsRoTJP5Vdo=;
        b=qcHXETlWr5VYHugu4AsTQ+XtjrDDmq/IfZnNCFn92XP3Y+j3f/xW9oDssjZuMUXFGbybZA
        FwofYpOZh6i2ff4SuaKD/M7wtussmMQZia+SJHQHgG1+UvZ9MQZbJyXk6yWNtBlqP/6WYc
        An6Svbyg2/f/T5XOFFDEMkZGsCTB3B8=
Date:   Mon, 12 Oct 2020 16:32:12 +0200
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
Message-ID: <20201012143212.GC22829@zn.tnic>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
 <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
 <20201012035846.GB11282@1wt.eu>
 <b188f977-b11e-f570-599a-7bcf364be0fd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b188f977-b11e-f570-599a-7bcf364be0fd@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:22:10AM +0100, Guillaume Tucker wrote:
> However, it was found while adding some x86 Chromebooks[1] to
> KernelCI that x86_64_defconfig lacked some basic things for
> anyone to be able to boot a kernel with a serial console enabled
> on those.

Hold on, those are laptops, right? How come they do have serial console?
Because laptops don't have serial console - that has been the eternal
problem with debugging kernels on laptops. Or do they do some sort of
serial over USB emulation and this is something which only chromebooks
have?

Or is that how it is done:

https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/serial-debugging-howto

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
