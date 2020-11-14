Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776092B2AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 04:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKNDQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 22:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKNDQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 22:16:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 19:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0/KJqz8hu47WbA5FdnejOOtD0NK3mSmNVO2zFIHMmuo=; b=3RyB6zdxnCz7gFnT7+CeKWOF6/
        4XRkDMsYza0TaLF6KTCBT6PLdxfXgbGF3rtmSxCJhjMEXIepF/CxIq7aD21gAnnyclsJiOYzo0H1u
        tbf+fFyALRXtnCeM/q/1V+Ay65sREalvZQ6b6BeDcyzb8n4QBWm/5ZKKn+ZHj1v4TRrQ8iPw+JEDW
        fQ8BrzPTsv3wkyO9ztrawNXFwJHlfx8b1NP+Gn7eI8vwmFo+0H9m0ojFCrqjxbdUGxiEeB9kTIHX/
        qNpWjxmU7rnIX+Pe9sA1E9gjoydPfFDYhqP4rzG6OJZJ9smRn1ri4/2zjATj7xFCXNfa45Tyd7VIS
        avF1iseA==;
Received: from [2601:1c0:6280:3f0::f32]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdm1g-0005d4-3a; Sat, 14 Nov 2020 03:14:56 +0000
Subject: Re: [SPECIFICATION RFC] The firmware and bootloader log specification
To:     Daniel Kiper <daniel.kiper@oracle.com>, coreboot@coreboot.org,
        grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        systemd-devel@lists.freedesktop.org,
        trenchboot-devel@googlegroups.com, u-boot@lists.denx.de,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     alecb@umass.edu, alexander.burmashev@oracle.com,
        allen.cryptic@gmail.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, btrotter@gmail.com,
        dpsmith@apertussolutions.com, eric.devolder@oracle.com,
        eric.snowberg@oracle.com, hpa@zytor.com, hun@n-dimensional.de,
        javierm@redhat.com, joao.m.martins@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, leif@nuviainc.com,
        lukasz.hawrylko@intel.com, luto@amacapital.net,
        michal.zygowski@3mdeb.com, mjg59@google.com, mtottenh@akamai.com,
        phcoder@gmail.com, piotr.krol@3mdeb.com, pjones@redhat.com,
        pmenzel@molgen.mpg.de, roger.pau@citrix.com,
        ross.philipson@oracle.com, tyhicks@linux.microsoft.com
References: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef83facc-b08d-a43d-aff1-e0492ab38064@infradead.org>
Date:   Fri, 13 Nov 2020 19:14:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 3:52 PM, Daniel Kiper wrote:
> Hey,
> 
> 
> Here is the description (pseudocode) of the structures which will be
> used to store the log data.
> 
> Anyway, I am aware that this is not specification per se.


Yes, you have caveats here. I'm sure that you either already know
or would learn soon enough that struct struct bf_log has some
padding added to it (for alignment) unless it is packed.
Or you could rearrange the order of some of its fields
and save 8 bytes per struct on x86_64.


>   struct bf_log
>   {
>     uint32_t   version;
>     char       producer[64];
>     uint64_t   flags;
>     uint64_t   next_bf_log_addr;
>     uint32_t   next_msg_off;
>     bf_log_msg msgs[];
>   }
> 
>   struct bf_log_msg
>   {
>     uint32_t size;
>     uint64_t ts_nsec;
>     uint32_t level;
>     uint32_t facility;
>     uint32_t msg_off;
>     char     strings[];
>   }


cheers.
-- 
~Randy

