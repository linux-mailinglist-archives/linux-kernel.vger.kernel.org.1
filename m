Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A18295495
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441217AbgJUVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:54:10 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:44274 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409614AbgJUVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:54:10 -0400
Received: from macbookpro-ed.wildgooses.lan (unknown [212.69.38.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4CGkly6PNbzTgHH;
        Wed, 21 Oct 2020 22:54:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1603317248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7ncov7sQksgrPVWneTs4WO5bnKPjl84aRr2s6zw/yc=;
        b=jAgyQNFVgFPEa+ChlrlxcoSOQ5HQdUt8MmUV4okrrbNjfiWaJ9D+hyHZQq2QuqLvtUNn7i
        WsEFY6Xw4DYZEVEZgiXlsB/0oWAjBoxTg5LtAb7YSpwpE2AClWUTIZPJbEsIl+01c0AuQk
        quRKfIZcK1NzJHBCy7Gxg3pVUTqeLnM=
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
 <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
 <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
 <e953f3ee-2db1-1523-cd84-6acb26751a15@wildgooses.com>
 <d0d91191-cad2-94a1-6373-0f3ff4e38376@redhat.com>
From:   Ed W <lists@wildgooses.com>
Message-ID: <795ae78b-26cf-f58d-6981-f68d7599ccdf@wildgooses.com>
Date:   Wed, 21 Oct 2020 22:54:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <d0d91191-cad2-94a1-6373-0f3ff4e38376@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 12:29, Hans de Goede wrote:
> Hi,
>
> On 10/14/20 1:21 PM, Ed W wrote:
>> On 14/10/2020 09:41, Hans de Goede wrote:
>>>
>>> So I have a suggested compromise:
>>>
>>> Keep the current LED/gpio setup code, but make executing it condition=
al
>>> on the BIOS version and skip the LED/gpio setup when the new BIOS is
>>> present to avoid having duplicate LED entries, etc. in that case.
>>>
>>> I guess this would still break userspace because if I understand thin=
gs
>>> correctly the new ACPI based setup uses different LED names ? That
>>> seems unfortunate, but I guess that from the kernel pov we can just
>>> blame the BIOS for this, and since we definitely do not want duplicat=
e
>>> LED entries for the same LED, this seems the least bad choice.
>>>
>>> Enrico, would that work for you ?
>>
>>
>> I'm cool with this. Enrico?
>>
>> I may have some time imminently to have a stab at a new patch. Obvious=
ly any help structuring this
>> would be appreciated - it feels clumsy using the existing detection me=
chanism, I think whatever I
>> come up with you should kick back and recommend a new board detection =
structure, but perhaps we can
>> shortcut that step with a few comments up front?
>
> I'm afraid I do not have any wisdom to share here. I would use the DMI =
bios-version
> or bios-date strings for the detection, but I guess that is obvious.=20


Hi Hans & Enrico

OK, I've just sent a new patch which conditionally configures GPIOs for b=
oards with older firmware's
(older than 4.10.0).

This is followed up by the patch I really want to try and get in, which i=
s to add support for APU5
and APU6. Particularly APU5 is quite interesting to me and significantly =
different to previous
boards in that it has a lot more mpcie slots that can be used for LTE mod=
ules or wifi cards. This
creates the realisation that the reset and sim-swap lines are always wire=
d to the LTE slots, not to
the mpcie slots (although often they overlap in functionality), so naming=
 is corrected here. That
said, I don't think the reset lines function on most iterations of boards=
, so possibly supporting
those lines with GPIOs is redundant anyway...

APU6 is also a special order and is essentially the same as an APU4, so I=
 have added detection for
this also.

I don't know if it's useful, but I uploaded a couple of scripts for beepi=
ng and flashing the leds.
Here I just used globs to handle the different naming on the different bo=
ards (since I need to
handle the older Alix boards as well). Enrico, is this useful to you?

=C2=A0=C2=A0=C2=A0 https://github.com/nippynetworks/gpio-utils


As an aside, these boards are super easy to flash as they support flashro=
m. So I'm personally giving
some thought to bundling an updater into our software build. The generic =
bios is quite slow to
startup and I would like to prepare a customised version with shorter tim=
eouts. Happy to work with
you on something separately if this is interesting?

Hans, thanks if you can look this over.

Regards

Ed W


