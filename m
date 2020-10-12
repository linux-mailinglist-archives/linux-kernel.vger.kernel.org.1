Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD97E28B223
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgJLKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJLKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:22:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5417C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:22:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 918271F447D8
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
To:     Willy Tarreau <w@1wt.eu>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
 <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
 <20201012035846.GB11282@1wt.eu>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <b188f977-b11e-f570-599a-7bcf364be0fd@collabora.com>
Date:   Mon, 12 Oct 2020 11:22:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012035846.GB11282@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 04:58, Willy Tarreau wrote:
> Hi Enric,
> 
> On Sun, Oct 11, 2020 at 07:05:55PM +0200, Enric Balletbo i Serra wrote:
>> For arm64 (i.e : arm64_defconfig):
>>     1. Someone renames CONFIG_A to CONFIG_AB, sends a patch, and as he did a
>> grep, the patch modifies all the defconfigs.
>>     2. The patch is accepted and merged in linux-next.
>>     3. KernelCI builds linux-next, boots the kernel on the hardware and all the
>> tests continue passing.
>>
>>
>> For x86:
>>     1. Someone renames CONFIG_A to CONFIG_AB, sends a patch and as he did a grep
>> the patches modifies all the defconfigs.
>>     2. The patch is accepted and merged in linux-next.
>>     3. KernelCI builds linux-next, boots the kernel on the hardware, and some
>> tests start to fail or are skipped.
>>     4. The maintainer is noticed about the behavior change, so he will need to
>> look at the problem, and find it.
>>     5. The maintainer sends a patch.
>>     6. The patch is accepted, but he needs to tag the release as per kernel <
>> x.y.z version it should use CONFIG_A and for kernel > x.y.z it should pick
>> CONFIG_AB.
>>     7. KernelCI builds linux-next, boots the kernel on the hardware and all the
>> tests pass again.
> 
> Previously I thought I understood your needs, but now I don't anymore. You
> seem to be saying that you're not testing *anything* outside of defconfig,
> and that as such you'd like defconfig to be complete enough to provide good
> coverage. This sounds a bit odd to me. And what if in the arm64 case, the
> CONFIG_YOUR_V4L2_DEVICE is *not* added to defconfig ? You're in the same
> situation.
> 
> We all know it's not fun to have to deal with local config snippets, but
> as soon as you plan to boot on a specific hardware, this is unavoidable.
> Also, config symbols are rarely renamed. Most often they are moved under
> new entries (e.g. CONFIG_VENDOR_FOO) which are enabled by default, so
> that updating your old configuration using "make olddefconfig" is enough
> to update it.
> 
> What I'm understanding from your proposed change is not to support
> KernelCI, but to support Chromebooks by default. This could make more
> sense if that's a relevant platform whose support is currently limited
> by default, I'm not able to judge that, but at least it seems to me
> this would make more sense than having specific configs for KernelCI.

This is correct, KernelCI doesn't really need these configs to be
upstreamed.  It's useful as Enric pointed out, but there are
already several specific config fragments being managed by the
KernelCI build system as one would expect, and we can take care
of one more if need be.

However, it was found while adding some x86 Chromebooks[1] to
KernelCI that x86_64_defconfig lacked some basic things for
anyone to be able to boot a kernel with a serial console enabled
on those.  That is what this patch is really about.  When doing
upstream kernel development and building your own kernel, it is
obviously a very useful thing to have.

Agreed, it is easy enough for a developer to turn these configs
on when required.  But it's not entirely trivial to find out
which configs to turn on, especially when you don't have access
to the kernel log.  I went through the Chrome OS 4.14 kernel
config fragments to get there.  Everyone would probably not
agree, but it does seem to me that the convenience of having it
upstream outweighs the costs.

If it's about size or performance, anyone can compare the kernel
image sizes and other things with the KernelCI (staging) build
artifacts based on v5.9[2].

As mentioned earlier in this thread, there aren't any written
rules about what goes into x86_64_defconfig and what does not.
Based on past history, and looking at it from a developer's point
of view rather than KernelCI, does it make sense in this case?

Thanks,
Guillaume


[1] HP Intel x360 "octopus" and AMD 11A-G6-EE "grunt":
    https://staging.kernelci.org/test/plan/id/5f8101a97ba4fdae00cafbb0/
    https://staging.kernelci.org/test/plan/id/5f81003f56c3586920cafbb4/

[2] Plain x86_64_defconfig:
    https://storage.staging.kernelci.org/kernelci/staging-mainline/staging-mainline-20201011.0/x86_64/x86_64_defconfig/gcc-8/
    with "x86 Chromebook" fragment:
    https://storage.staging.kernelci.org/kernelci/staging-mainline/staging-mainline-20201011.0/x86_64/x86_64_defconfig+x86-chromebook/gcc-8/

