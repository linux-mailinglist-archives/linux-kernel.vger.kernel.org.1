Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1428D648
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgJMVqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 17:46:14 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:50328 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgJMVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:46:13 -0400
Received: from macbookpro-ed.wildgooses.lan (unknown [212.69.38.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4C9pyV0SSxzTh4v;
        Tue, 13 Oct 2020 22:46:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1602625571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZcwqzV2Rk08YLHn29RX80Ba01R4KbmU++jWb/FUn32Q=;
        b=nuhXHW7LRx79yweJHYOw6VoO/SOJ3VSOkpIvR3NrzwJRa/sK028pL8YnDTbIoGnhDoYvZE
        rg+5uCR8W4SN+2jaLWGcXwWS4rLkYoKYDcutKHQc5epg37pj1am+Xu5oPYZNr39iJiziGV
        fzVwqaLxwZ8+Npz3h2fohfamDlAmJek=
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
 <9fb836bc-7d8a-b6e2-8d73-8e74a8f2e38b@redhat.com>
From:   Ed W <lists@wildgooses.com>
Message-ID: <2ecbe677-8f80-17a1-dbf9-dfffa867805c@wildgooses.com>
Date:   Tue, 13 Oct 2020 22:46:09 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <9fb836bc-7d8a-b6e2-8d73-8e74a8f2e38b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2020 09:48, Hans de Goede wrote:

> On 10/12/20 9:39 PM, Enrico Weigelt, metux IT consult wrote:
>> On 22.09.20 00:17, Ed W wrote:
>>> Hi, I've been adding support for the PC Engines APU5 board, which is a variant of the APU 2-4
>>> boards
>>> with some nice features. The current platform driver for pcengines boards has some redundant
>>> features with regards to recent bios/firmware packages for the board as they now set the ACPI
>>> tables
>>> to indicate GPIOs for keys and leds.
>>
>> NAK. Breaks existing userlands in the field (literally field), forcing
>> users to fw upgrade is not an option (field roll would be realy expensive).
>
> Thank you Enrico, I was wondering the same (what about userspace breakage)
> when I was looking at this patch. It is good to have confirmation that
> userspace breakage is a real issue here.


This isn't the whole story.

The original naming was board specific. Then Enrico (not unreasonably - I actually prefer his
naming) changed the naming to be non board specific. Then within 2 months PC Engines introduced ACPI
based config using the old names.

So if we are holding "userspace breakage" as the gold standard, then the original (also the current)
names have actually been around longest and likely cause the least userspace breakage.

Also, some other pieces of this module have already been removed (SIM Swap), so there is an existing
precedent for "userspace breakage" and trimming down this platform driver.


In big picture terms, changing the name of the LED device doesn't seem a huge concern to me... A
udev rule can setup compatibility forwards/backwards quite trivially I think?

Kind regards

Ed W

