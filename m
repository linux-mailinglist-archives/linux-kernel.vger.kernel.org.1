Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622AC2C51D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbgKZKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbgKZKLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:11:50 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66ADC0613D4;
        Thu, 26 Nov 2020 02:11:49 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kiEFW-0004KQ-8H; Thu, 26 Nov 2020 11:11:38 +0100
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <cover.1606137108.git.linux@leemhuis.info>
 <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info>
 <20201124091852.GB11695@lst.de>
 <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
 <20201124093658.GA13174@lst.de>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <f3113ffc-3fae-a53e-4aef-ffdd333a3c6a@leemhuis.info>
Date:   Thu, 26 Nov 2020 11:11:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124093658.GA13174@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1606385509;36d40bdf;
X-HE-SMSGID: 1kiEFW-0004KQ-8H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.11.20 um 10:36 schrieb Christoph Hellwig:
> On Tue, Nov 24, 2020 at 10:31:33AM +0100, Thorsten Leemhuis wrote:
>> Am 24.11.20 um 10:18 schrieb Christoph Hellwig:
>>> On Tue, Nov 24, 2020 at 09:00:01AM +0100, Thorsten Leemhuis wrote:
>>>> For context: Patch 2 of this series adds a text to the Documentation/ directory
>>>> which (for now) uses "GPL-2.0+ OR CC-BY-4.0", as I want to make it easy and
>>>> attractive for others to base their work on it. I'm not strongly attached to
>>>> CC-BY-4.0, but it seemed like the best choice: it's designed for such usage and
>>>> afaics better than using MIT for text files.
>>> And you've not Cced me on that patch 2 or patch 3, which makes Ccing
>>> me on this pretty useless as I can't judge the context.
>> Argh, sorry, slipped through. You can find it here:
>> https://lore.kernel.org/linux-doc/2f314e58cb14c1579f843f8c72bdb4bbb83ac20a.1606137108.git.linux@leemhuis.info/
> 
> [...]  How to we make sure people
> don't accidentally end up including things they can't?

A quick question for this part of your mail; I'm getting on thin ice 
with it (hope I won't regret this), but I guess it's worth it to make me 
understand the problem better:

How is having a CC-BY text that tracks in part from GPL2 text or code in 
this case any different than having MIT code that links or includes 
GPLv2 licensed code? Both CC-BY and MIT are compatible to the GPL (see 
[1]) and the processed result is only available under GPL (see [2]).

Ciao, Thorsten

[1]
https://www.gnu.org/licenses/license-list.en.html#ccby

[2]
https://www.gnu.org/licenses/gpl-faq.html#GPLModuleLicense
