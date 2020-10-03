Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142D52825AE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgJCRr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgJCRr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 13:47:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219A6C0613D0;
        Sat,  3 Oct 2020 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=q3vIRNxwue09o5j0ePMASMuF4lATCofRnWcR35oy51g=; b=laNE3xKf5FYMx/+6rp8A5/Cr3H
        9CzqgaCHmRQz8S1heipgJFiNlytC3OEXbYXJD8oVdzhrKI7zRbTuASIwUJ4aduVloxkfHYhWu2q7h
        QY2Psr099ap9bK0mbU/WhsTYWvolv4MOS1EHbAqP2NAhMvlOyYorcSW9VemycU9NWZ2ASS/PH7E18
        KNNylDe2XhDN/pHxJd3hFNeYG9DsB+2od5f6UyBtvEgYxxXQO4RNx0p+GAnBhmQohcx2JnpnMAD8e
        YHcxqDCACoNIDl3FeZowGakETB7cpc77sqD678agyRHFfcxt/ZYchE5w74js13XVY9PZTH7vQTUPq
        +wUG3Gbw==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOlcy-0002Ox-Um; Sat, 03 Oct 2020 17:47:25 +0000
Subject: Re: [RFC PATCH v1 08/26] docs: reporting-bugs: make readers check the
 taint flag
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <eed27c4faa31d98bd37db18ba2ae90f1767c7102.1601541165.git.linux@leemhuis.info>
 <8129d3a7-3649-b9cc-1615-402f12ee370a@infradead.org>
 <f7f0b065-b022-7178-f9ba-f05c961ff57e@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <05d06d89-ee79-f551-35a4-616eb3864e95@infradead.org>
Date:   Sat, 3 Oct 2020 10:47:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f7f0b065-b022-7178-f9ba-f05c961ff57e@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/20 2:56 AM, Thorsten Leemhuis wrote:
> Many thx for you comments. Consider all the obvious spelling and
> grammatical mistakes you pointed out fixed, I won't mention all of them
> in this reply to keep things easier to follow.
> 
> Am 02.10.20 um 19:08 schrieb Randy Dunlap:
>> On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:
> 
>>> +driver, VirtualBox, or other software that installs its own kernel modules: you
>>> +will have to remove these modules and reboot the system, as they might in fact
>>> +be causing the issue you face.
>> You will need to reboot the system and try to reproduce the issue without loading
>> any of these proprietary modules.
> 
> Hmmm. Preventing the Nvidia module from loading without disabling or
> uninstalling the other parts of the graphics driver can easily to a
> situation where the GUI is not starting. And blacklisting all modules
> that VirtualBox needs on the host requires quite a bit of tying at the
> boot loader iirc. So how about this:
> 
> Quite a few kernels are also tainted because an unsuitable kernel module
> was loaded. This for example is the case if you use Nvidia's proprietary
> graphics driver, VirtualBox, or other software that installs its own
> kernel modules, as they might be causing the issue you face. You thus
> have to prevent those modules from loading for the reporting process.
> Most of the time the easiest way to do that is: temporarily uninstall
> such software including any modules they might have installed.
> Afterwards reboot.

Sure, OK.

thanks.
-- 
~Randy

