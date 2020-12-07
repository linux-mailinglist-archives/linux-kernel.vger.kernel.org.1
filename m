Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07712D0D32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLGJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:40:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgLGJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607333923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcoaZt0x7OJTZC6iPILV6dMHi4/WOJfGXYD3G5AOGEM=;
        b=Q1aNlS3ghwdECTTtmrcLOURTIccBYVOjglXv7KL9onECSBbFyeJPHCibhyO9xbvlL8yHx9
        HQqjhBzyQW6gN6RXLtNyfTF0Y/g5YlPm4puElbDxgvrMJkd2Teamz7yFaXFJ4+rwXbGfvg
        4JLwX/UxPe4pSE4wetXDzAO8jDZl2H0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-FcLR0oiUOTSlWMwoFHBkpA-1; Mon, 07 Dec 2020 04:38:41 -0500
X-MC-Unique: FcLR0oiUOTSlWMwoFHBkpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8A3106F8DD;
        Mon,  7 Dec 2020 09:38:37 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6DAB614FD;
        Mon,  7 Dec 2020 09:38:36 +0000 (UTC)
Subject: Re: 5.10 RC 7: grub2 out of memory
To:     Elias Carter <edcarter@ualberta.ca>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <CAJWrxn12rrMtomPUcu4GsDeTe5vpGKsR-F6=hM1Y8a=iAY+gag@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <56e933e4-a495-1497-eb48-b9b8f0da46d3@redhat.com>
Date:   Mon, 7 Dec 2020 10:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJWrxn12rrMtomPUcu4GsDeTe5vpGKsR-F6=hM1Y8a=iAY+gag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.20 10:16, Elias Carter wrote:
> I just compiled and installed 5.10 RC 7 and got a message from grub2:
> "out of memory, press any key to continue" shortly followed by a
> kernel panic (see attached screenshot).
> 
> The 5.4.0-56-generic kernel from Ubuntu works on my machine fine.
> 
> Things I have tried so far:
> - setting grub video mode to "console"
> - setting grub video resolution to 800x600
> - regenerating the initramfs for 5.10 RC 7
> - verifying that /boot has free space
> - changing boot mode from UEFI to legacy BIOS
> 
> I have attached the following:
> 1.) dmesg ran from using the 5.4 kernel (since I cant boot into 5.10 RC 7)
> 2.) my 5.10 RC 7 kernel .config
> 3.) screenshot of kernel panic after "out of memory" grub2 message
> 4.) my /etc/default/grub
> 
> Please let me know if you would like any more information or testing of patches.

The kernel crashes because it's unable to mount root - I suspect the
initrd is not loaded, because I would have expected systemd messages
before trying to mount root (after loading additional drivers from the
initrd). I assume grub2 fails to load the (now too big?) initrd - you
could try compiling out debug symbols and give it a try.

What's the size difference between old vs. new kernel and old vs. new
initrd?


Similar report for aarch64 was at

https://bugzilla.redhat.com/show_bug.cgi?id=1615969

which turned out to be a grub2 issue. Which distro/grub2 version etc are
you running?

-- 
Thanks,

David / dhildenb

