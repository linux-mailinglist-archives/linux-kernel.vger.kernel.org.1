Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77328BB94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbgJLPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:10:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45882 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389269AbgJLPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:10:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 64D8B1F44AF0
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
To:     Willy Tarreau <w@1wt.eu>, Borislav Petkov <bp@alien8.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?Diego_Elio_Petten=c3=b2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernelci@groups.io
References: <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
 <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
 <20201012035846.GB11282@1wt.eu>
 <b188f977-b11e-f570-599a-7bcf364be0fd@collabora.com>
 <20201012143212.GC22829@zn.tnic> <20201012144040.GB11614@1wt.eu>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <a165781d-d1c8-04e2-0b60-8d776a21a625@collabora.com>
Date:   Mon, 12 Oct 2020 16:10:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012144040.GB11614@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 15:40, Willy Tarreau wrote:
> On Mon, Oct 12, 2020 at 04:32:12PM +0200, Borislav Petkov wrote:
>> On Mon, Oct 12, 2020 at 11:22:10AM +0100, Guillaume Tucker wrote:
>>> However, it was found while adding some x86 Chromebooks[1] to
>>> KernelCI that x86_64_defconfig lacked some basic things for
>>> anyone to be able to boot a kernel with a serial console enabled
>>> on those.
>>
>> Hold on, those are laptops, right? How come they do have serial console?
>> Because laptops don't have serial console - that has been the eternal
>> problem with debugging kernels on laptops.

Yes the link you pointed at is a prerequisite to enable serial
console in the firmware (Coreboot/Depthcharge).

> Well, to be precise, they don't have *anymore*. I used to exclusively
> select laptops having a serial port given that I was using it daily with
> routers, until I had to resign when I abandonned my good old NC8000 :-/

You can get serial console on recent enough Chromebooks with a
debug interface such as SuzyQable:

  https://www.sparkfun.com/products/14746

It's not a USB Type-C adapter, it has a debug interface which
works with Chromebooks that support Case-Closed Debugging.
Anyone can do that without modifying the Chromebook, and with a
bit of patience to go through the documentation[1]...

The KernelCI sample results from my previous email were run using
just that: off-the-shelf Chromebooks + SuzyQ + rebuilt firmware
for interactive console and tftp boot + kernel with the config
options in Enric's patch.

Thanks,
Guillaume


[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/cr50_stab/docs/case_closed_debugging_cr50.md
