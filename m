Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3572F3747
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbhALRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhALRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:35:05 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA3C061795;
        Tue, 12 Jan 2021 09:34:25 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kzNYg-00024B-UN; Tue, 12 Jan 2021 18:34:19 +0100
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
 <6ca51584-1739-e532-d40e-e4447065ea1e@infradead.org>
 <dc2b0eaa-26e9-f686-ae7b-7e777cb3d55f@leemhuis.info>
 <5ed98052-28ea-4701-10d4-b7fde106c1fd@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
Message-ID: <ee7fc5b7-3fcb-b0a7-3ae1-b7b11e350be2@leemhuis.info>
Date:   Tue, 12 Jan 2021 18:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5ed98052-28ea-4701-10d4-b7fde106c1fd@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1610472865;8e46fe0e;
X-HE-SMSGID: 1kzNYg-00024B-UN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.01.21 um 00:42 schrieb Randy Dunlap:
> On 1/11/21 10:55 AM, Thorsten Leemhuis wrote:
>> Am 11.01.21 um 19:14 schrieb Randy Dunlap:
>>> On 1/10/21 4:10 AM, Thorsten Leemhuis wrote:
>
>>> Andrew Morton takes MM bugs and Cc:s them to linux-mm mailing list
>>> and then asks for discussion to continue on the mailing list.
>> Then what use it bugzilla here? Wouldn't it be better for people to go
>> straight to the list?
> Might as well, yes.

Yeah, and that's among the reasons why I wrote the new document on
reporting bugs/issues (which explains how to report issues by mail) and
additionally work (at least for now) towards discouraging people from
using bugzilla.kernel.org.

>> Just trying to understand things better here, as there are other things
>> that look strange to me and were mentioned in the patch description. For
>> example: Why are there only 200 products and components on
>> bugzilla.kernel.org (some of them for historic things like the
>> ac-kernels) while the MAINTAINERS file has more than 2200 entries?
> I wouldn't want a separate entry for each  SPI/GPIO/regulator/USB etc.
> device. That's just IMO...

I can relate to that view, but OTOH that would means a middleperson is
needed to get in contact with the maintainer. Which is fine concept, as
that person could be a kind of 1st level support that shields higher
level people like developers and maintainers from bad bug reports.

But I guess that would be a boring job which I nobody will do over
longer periods of time just for fun. Sure, the LF or someone else could
hire someone (see the mail from Konstantin in this thread; will reply to
that later); but I wonder if we have more pressing issues where the
money would better be spend better. And even if not: getting that money
and hiring someone would take some time...

>>> could/should probably see if we can add more project-specific
>>> mailing lists to the automatic reporting 
>> Guess that would mean taking to a lot of maintainers/mailing list admins
>> if they are okay with that. Who would do that?
> whoever is motivated to do so.

Not me. ;-) That bugzilla.kernel.org is not working to well is known for
years now, without anyone stepping up to improve the situation for real.
Maybe my work/this discussion gets something rolling. But I guess until
I see that happen I continue working towards discouraging people from
using bugzilla.kernel.org, as otherwise things will just stay as they
are, which IMHO is a bad idea with the state of things.

Ciao, Thorsten
