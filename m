Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ADB1AF502
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 22:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDRUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 16:55:10 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:49996 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgDRUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:55:10 -0400
Received: from [192.168.1.41] ([90.126.162.40])
        by mwinf5d33 with ME
        id ULv22200V0scBcy03Lv3qd; Sat, 18 Apr 2020 22:55:06 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Apr 2020 22:55:06 +0200
X-ME-IP: 90.126.162.40
Subject: Re: [PATCH] m68k/PCI: Fix a memory leak in an error handling path
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-m68k@lists.linux-m68k.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Newsgroups: gmane.linux.ports.m68k,gmane.linux.kernel.janitors,gmane.linux.kernel
References: <2e00c1f1-8faa-5045-ddf5-2bf943f714f2@web.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <ea3d9b35-4409-fb86-8855-0ddb73989829@wanadoo.fr>
Date:   Sat, 18 Apr 2020 22:55:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2e00c1f1-8faa-5045-ddf5-2bf943f714f2@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/04/2020 à 22:00, Markus Elfring a écrit :
>> If 'ioremap' fails, we must free 'bridge', as done in other error handling
>> path bellow.
> I suggest to improve this change description.

I suggest you stop proposing over and over useless comments.
Please just ignore my proposals as I do for your boring, never 
constructing, replies.


> * Please avoid a typo.
>
> * Is an imperative wording preferred?
>
* is Melissa still around?

> …
>> +++ b/arch/m68k/coldfire/pci.c
>> @@ -216,8 +216,10 @@ static int __init mcf_pci_init(void)
> …
>
> I propose to move the pci_free_host_bridge() call for the desired

I propose to let patch submitter and maintainer decide about it.
I don't need your point of view. I guess that maintainers don't either.

No need to waste time trying to engage any discussion with me.
This is the first and very last exchange we will ever have.

Best regards,
CJ


> exception handling to the end of this function implementation.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=c0d73a868d9b411bd2d0c8e5ff9d98bfa8563cb1#n450
>
> Regards,
> Markus
>

