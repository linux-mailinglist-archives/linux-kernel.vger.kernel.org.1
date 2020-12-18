Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF382DEB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgLRWAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 17:00:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgLRWAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:00:10 -0500
Received: from [IPv6:2a00:5f00:102:0:944a:5cff:fe54:340e] (unknown [IPv6:2a00:5f00:102:0:944a:5cff:fe54:340e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E3E4B1F4663F;
        Fri, 18 Dec 2020 21:59:28 +0000 (GMT)
Subject: Re: kernelci/staging-next bisection: sleep.login on
 rk3288-rock2-square #2286-staging
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernelci-results-staging@groups.io,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
 <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
 <20201213082314.GA198221@linux.ibm.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <0633d44a-3796-8a1b-e5dc-99fc62aa4dc7@collabora.com>
Date:   Fri, 18 Dec 2020 21:59:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201213082314.GA198221@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2020 08:23, Mike Rapoport wrote:
> Hi Guillaume,
> 
> On Fri, Dec 11, 2020 at 09:53:46PM +0000, Guillaume Tucker wrote:
>> Hi Mike,
>>
>> Please see the bisection report below about a boot failure on
>> rk3288 with next-20201210.
>>
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
>>
>> There's nothing in the serial console log, probably because it's
>> crashing too early during boot.  This was confirmed on two rk3288
>> platforms on kernelci.org: rk3288-veyron-jaq and
>> rk3288-rock2-square.  There's no clear sign about other platforms
>> being impacted.
>>
>> If this looks like something you want to investigate but you
>> don't have a platform at hand to reproduce it, please let us know
>> if you would like the test to be re-run on kernelci.org with some
>> debug config turned on, or if you have a fix to try.
> 
> I'd apprciate if you can build a working kernel with
> CONFIG_DEBUG_MEMORY_INIT=y and run it with 
> 
> 	memblock=debug mminit_loglevel=4
> 
> in the command line.
> 
> If I understand correctly, DEBUG_LL is not an option for these platforms
> so if earlyprintk didn't display the log there is not much to do about
> it.

OK, sorry for the delay.  I've built a kernel and booted it as
you requested, and also found that the issue was due to this
memory area defined in arch/arm/boot/dts/rk3288.dtsi:

        reserved-memory {
                #address-cells = <2>;
                #size-cells = <2>;
                ranges;

                /*
                 * The rk3288 cannot use the memory area above 0xfe000000
                 * for dma operations for some reason. While there is
                 * probably a better solution available somewhere, we
                 * haven't found it yet and while devices with 2GB of ram
                 * are not affected, this issue prevents 4GB from booting.
                 * So to make these devices at least bootable, block
                 * this area for the time being until the real solution
                 * is found.
                 */
                dma-unusable@fe000000 {
                        reg = <0x0 0xfe000000 0x0 0x1000000>;
                };
        };

So I've put a hack[1] on top of 950c37691925 to skip adding a
node in memblock_enforce_memory_reserved_overlap() if the base
address is 0xfe000000, which got the kernel booting.  Here's the
console log:

  https://people.collabora.com/~gtucker/tmp/2966825.txt

and the full test job details, if this helps:

  https://lava.collabora.co.uk/scheduler/job/2966825


I haven't really looked much further than that, but I'll be
available on Monday to help run other tests if needed.

Thanks,
Guillaume

[1] https://people.collabora.com/~gtucker/tmp/2966825.patch
