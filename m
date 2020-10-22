Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FB295C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896034AbgJVJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:38:41 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:35566 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505549AbgJVJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:38:40 -0400
Received: from macbookpro-ed.wildgooses.lan (unknown [212.69.38.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4CH2Ns0M4vzTgZ7;
        Thu, 22 Oct 2020 10:38:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1603359518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTOJClBcVAFpfY4OoxPdAHYjx+AR4QSvVJde4Nim/Kk=;
        b=MIH6KtO+RetV+W1FHpOQbEUR+TSZNwZXAlEjIEjtiEJniSVXr1jYZHV+4bVkmlKo1nvlf8
        KMzmpzb7g0zmoosNs4cjxJlLtfwqdP0Xk+JYLKAkx4xU8BVGJoxyNyv8V+Vp7E2sevOsxt
        38iHMMrsPFB1UNBsLmdVlzsHBFpFRRI=
Subject: Re: [PATCH 1/2] x86: Conditional init of pcengines leds/keys gpios
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     fe@dev.tdt.de, hdegoede@redhat.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
 <20201021214151.32229-1-lists@wildgooses.com>
 <0720575c-88c3-4f88-caa7-4707139702a1@metux.net>
From:   Ed W <lists@wildgooses.com>
Message-ID: <5684534f-1280-4c37-af94-1e1bc7484585@wildgooses.com>
Date:   Thu, 22 Oct 2020 10:38:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <0720575c-88c3-4f88-caa7-4707139702a1@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 10:22, Enrico Weigelt, metux IT consult wrote:
> On 21.10.20 23:41, Ed Wildgoose wrote:
>
> Hi,
>
>> The pcengines bios/firmware includes ACPI tables (since 4.10.0.1) which
>> will cause the kernel to automatically create led + gpio_key devices for
>> the platform. This means that the platform setup now creates duplicates
>> of all these led/key devices.
>>
>> Driver conditionally initialises leds/keys only for older bios.
> still breaks existing userlands as device names change - LEDs as well as
> keys, and keycodes also change.
>
> IOW: userland needs to be depending on specific BIOS versions.
>
>
> --mtx


As a compromise can you change your userland to cope with dynamic names? I see two simple ways:

1) udev rule to set name as you wish

2) I uploaded a little script which uses simple globs to just figure out the base name depending on
the board (also handles different board types entirely as well)


I realise you have some stuff running with this, I don't know your situation specifically, but this
feels like a really, really, small change to work around? Can you elaborate a little on why your
users will be updating kernels without updating user code? Is there really no way to stick a
compatibility udev rule in for your situation?

To recap though, the situation for many years was that the naming convention was board specific.
There is then just a small window (less than a year I think?) where users saw the name change to be
non board specific (ie your new module). I would hazard a guess that given the speed of mainstream
releases, few end users actually saw this change yet, or would notice? Those who did already
accommodated the name change, so I would hazard a guess they can cope with the revert? (or not even
notice?)


Look, just propose a solution, I don't really mind. To me this is SUCH a TRIVIAL rename that I've
already incorporated support for both naming conventions into my apps. I just want to get APU5/6
support in, which is affecting some real boards I want to use in volume. I don't feel the current
situation of duplicate devices should stay though.

My opinion is that we punt "this breaks userland" to being the board vendors problem now. The board
is configured largely through ACPI, so if the upstream changes the ACPI, then it's on them, not us.
This seems to be the direction the kernel is heading, with ACPI and device trees being used to
configure the boards, in preference to heavy platform drivers?


Hans, can you arbitrate here please? Your previous suggestion was to implement a compatibility shim
for older BIOS, that's done here. Happy to implement something else, just need a guide?

Thanks all

Ed W

