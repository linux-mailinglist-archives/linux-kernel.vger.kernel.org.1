Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9B292AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgJSPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:44:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45553 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgJSPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:44:40 -0400
Received: from [192.168.1.155] ([77.2.107.242]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBE3k-1kaYgU0oYg-00Ckb9; Mon, 19 Oct 2020 17:44:28 +0200
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Hans de Goede <hdegoede@redhat.com>, Ed W <lists@wildgooses.com>,
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
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <e727d039-8dea-1a40-48b9-792b6053807c@metux.net>
Date:   Mon, 19 Oct 2020 17:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dXpUIHRfWT5BcBULeI6C3vO+0OYCk7YAbl0tD+Ga1iGSzCkFhdH
 bzPyS5WuDKman6O01IM2eCaulW1iS2zj7dpI1OjC6XCnW5vV2tHyAIYojHH0FWVHKUx1Q3E
 /2oSPKIf3Y+Yw7hs5fJkPyPYueLm41VrKQ4DNAG3zcVwohlqly5TUtA3+O1oU+hrImDQGdG
 QkoZ4tya3l1VD9/Nezkzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oi9ueL6afnM=:l/JGmFuLohUNZ5OkGYAQz4
 kocRukoezDLcXg5WFzU+t+FY5AEsjWdCA980yc6MD/sUuopivybknohnp3jKFnl0jytPk3yQV
 n7T5kmzCW5PyMcl4fe1NWPIUCT92P1YTMmrrclaAoDmKZnfGRc0uHOZfwbUO4/D36XUe2E/Qk
 RfojzivK3wYRyqQbKJ6ae8PlIH3UfKehmLWqZvmXuebRaEVyeCabayzPq7ihgqwp4PbHGmOR4
 sW9cw28I1BoTQ9MlK/TfmWbeiEiBLVlGci9BY3e8aheb+aXGepZpSfjMHYez9k2k8MPc0dJBN
 ug0NDP4ZSeWMpKIoLQ25inGmCV8CMu5VK/esdYNsub/L6JxDPwTPSnuDOeT/J+WwQPbgfVd+K
 AJnj8KEvIXIOMGfSqx8KehEsXoceHcd4snG+lYcWFrQMvDGkEcnfpLYxD0C9/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.20 10:41, Hans de Goede wrote:

Hi,

> Keep the current LED/gpio setup code, but make executing it conditional
> on the BIOS version and skip the LED/gpio setup when the new BIOS is
> present to avoid having duplicate LED entries, etc. in that case.
> 
> I guess this would still break userspace because if I understand things
> correctly the new ACPI based setup uses different LED names ? That
> seems unfortunate, but I guess that from the kernel pov we can just
> blame the BIOS for this, and since we definitely do not want duplicate
> LED entries for the same LED, this seems the least bad choice.

Sorry, but not fine. When a newer box is taken from storage into
production (eg. replacement or new installation), application breaks.
LED isn't the only problem, also affects buttons.

The whole reaons why I invested all the time for writing general
purpose drivers (fch-gpio is separate from board driver) and bringing
it to mainline was having clean and generic support for these boards,
instead of having to carry around special patch queues forever and
in near future just using stock distro kernel. I guess that's the
main reason for very most mainlined drivers. This will be defeated
as soon as the whole thing becomes board/bios specific again.

I purposely slept ofter the naming several times, to make sure it's
future proof and tells exactly what these leds are for. Otherwise I
could just have picked numbers and fruits.

Please don't change the names. Field relies on them.

Actually, I've already considered adding another workaround for removing
the ACPI gpio/leds. Haven't had the time for a close analysis the acpi
bytecode actually does, and what the kernel actually makes out of it.
As soon as I encounter an conflict (eg. locks the iomem from gpio-amd
fch, messes up gpio states, etc), I'll have to go that route. There
already have been bug reports in that direction (eg. simsw and reset
issues), which I could not yet reproduce (on the older bios versions).



--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
