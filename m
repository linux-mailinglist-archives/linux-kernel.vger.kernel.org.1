Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061CE287BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgJHSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgJHSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:31:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3284C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cN6ZwJs0Pwl21647+oi9PMK1ab0yD5u4USBWVMShrKM=; b=cyJrBwpxSsf4A5jVZx1MOgV4FU
        JMiQf9t1xVGX13AvaVy41iO7/IL5MsD6V71n+motAdOXxN3iGwCRCW1ShFA5Cf1bEwN84wiT2mqFo
        XohTKbOgiFFG2Qjn82dtbMJLHPCfk3kOjti14xTd5njOlAlcAWK72rd7QzRALiVDdtQu+8galups6
        4QuEPU1+ePvFwasFQ9X0pcKobMHrhVLd7ueMctAXfdM9lkceZP7DAjDmYiUPHbk2jlj9RhI32Pm4k
        2bz9I/OqSZvKzAvrmRFLytiVIyNMVYl0lBSgmRtL9dqiP+YackPwc6p9/iCncWqP3zzUtNLSl2ZBC
        ZSUyU7DQ==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQahR-0007I3-1A; Thu, 08 Oct 2020 18:31:33 +0000
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
To:     Borislav Petkov <bp@alien8.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?Diego_Elio_Petten=c3=b2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Willy Tarreau <w@1wt.eu>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
Date:   Thu, 8 Oct 2020 11:31:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201008164044.GE5505@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 9:40 AM, Borislav Petkov wrote:
> On Thu, Oct 08, 2020 at 06:22:06PM +0200, Enric Balletbo i Serra wrote:
>> As part of KernelCI, we added a bunch of different x86 based Chromebooks
>> to do test booting and runtime testing. It will be useful have serial
>> support for these platforms in the default defconfig, as this, is the
>> defconfig used by default for the different maintainer's tree.
>>
>> SERIAL_8250_DW is the actual support for the console, but to have
>> support we need to enable X86_AMD_PLATFORM_DEVICE for specific AMD
>> boards and MFD_INTEL for specific Intel boards.
>>
>> While here, also enable USB_RTL8152 config which enables a common
>> USB-Ethernet adapter used very commonly in the KernelCI labs.
> 
> To me defconfig sounds like the config which contains items which are
> needed on the majority of x86 hardware out there.

to run in normal (or common) user mode(s).

Nothing to do with automated testing like syzbot or CI IMO.

> Are those which you enable that common and if not, why can't your build
> supply a custom .config instead?

I suppose that we are lacking a definition of a defconfig, but again, IMO,
these Kconfig symbols don't meet the need for normal users.


-- 
~Randy

