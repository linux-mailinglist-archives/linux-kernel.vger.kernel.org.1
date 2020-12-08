Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAA2D2964
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgLHK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:59:24 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:53153 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728780AbgLHK7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:59:24 -0500
Received: from [192.168.0.3] (ip5f5af449.dynamic.kabel-deutschland.de [95.90.244.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 91CC820647B77;
        Tue,  8 Dec 2020 11:58:41 +0100 (CET)
Subject: Re: Pass modules to Linux kernel without initrd
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
References: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
 <8aac3537-e84b-057d-94d8-0327261daaf8@metux.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <2f67eee5-b613-43ef-7790-7f29f203c808@molgen.mpg.de>
Date:   Tue, 8 Dec 2020 11:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <8aac3537-e84b-057d-94d8-0327261daaf8@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Enrico,


Am 08.12.20 um 10:38 schrieb Enrico Weigelt, metux IT consult:
> On 08.12.20 10:24, Paul Menzel wrote:
> 
>> Similar to passing firmware and microcode update files to Linux or
>> building these into the Linux kernel image, would it be possible to
>> append the required modules to the Linux kernel image, and Linux would
>> load these?
> 
> Indeed, yes it does. Just set the corresponding CONFIG_ symbols to 'y'
> instead of 'm'. If you don't need to dynamically load any modules
> (already have everything you need compiled-in), you can completely
> disable module support via disabling CONFIG_MODULES.

[…]

Thank you. I know this and do it myself. But, the requirement is to use 
the distribution Linux kernel (package). I am sorry for being unclear.


Kind regards,

Paul
