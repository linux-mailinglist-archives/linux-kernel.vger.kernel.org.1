Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211B7299539
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789671AbgJZSZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1784607AbgJZSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603736703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTOPOTQ28R0upPb6yV12OFPjWFChCPsyJnX2G5n47O4=;
        b=bU68PkymlZMLf11h+64YPP0KDb/tMSmiMxTp9cppd6rixMwXUWeobX+XZmx+4cFAEt3wuJ
        r/xIGYCvgdUVVf2oM8bi/vq7ZRiATJcJEIttu5GK3pkazXBg8ExrO2uEMbn9DvSs2SDUaq
        afJgsMbkoin7zVluoHYDiOXFAXAGDeM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-BOWxfO-LOoKM6JdadJKEzQ-1; Mon, 26 Oct 2020 14:25:01 -0400
X-MC-Unique: BOWxfO-LOoKM6JdadJKEzQ-1
Received: by mail-wm1-f69.google.com with SMTP id l17so6304760wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTOPOTQ28R0upPb6yV12OFPjWFChCPsyJnX2G5n47O4=;
        b=Osqoo9Jy4JXFB2TWeumB+wVBHo6VID2h+kmO9wAIc6Mn+H2i+dkCVkRW9tyKtO3kgl
         VgaMqg7uEstXK74FddjasK3uz4n9CcHKaEQ3+H0NWPJvu/1SqH53LIFl0ZAeujoQmxA5
         00dE+xlLAHeUcWTtgzz51GzpUjzlDfdq83lNU3msHFFY5QomoKiVvy0kBWyP7/A37eD9
         Aw0nxscm6kBM+5hUQcwjw0OMF02MNDgBlUL5EJwWRAp5HwnVPseuSroguVZFvhogKysm
         f70LVBUPcc+kaH+pc4GBKOn649YP6rb49rjp8sp3SrSYBJ53amne38xRc9DhaAqy00Sb
         LGVQ==
X-Gm-Message-State: AOAM531r+XoAQ50Mtwbg0MOn5maqdSSTqkF9TYEx304XtMsUG4W9VMSa
        PeHVYU+e/QgqKCz5+hPBWpohK5uFT0w2BO2dXawqIr6OZm0388mycVI9LMQ7gLzp/Uhh9kreYbb
        s/WSDCeAvGOzOFwrNoyaP7ubu
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr18215192wmb.55.1603736700657;
        Mon, 26 Oct 2020 11:25:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkli58w2YGvlcCf87uJq2IZGE8a3ti/dpYthSyydRCGsmb5nUsUwgCQtZdQpS8BkX/Q79nMQ==
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr18215171wmb.55.1603736700414;
        Mon, 26 Oct 2020 11:25:00 -0700 (PDT)
Received: from steredhat (host-79-17-248-215.retail.telecomitalia.it. [79.17.248.215])
        by smtp.gmail.com with ESMTPSA id v6sm23367090wrp.69.2020.10.26.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:24:59 -0700 (PDT)
Date:   Mon, 26 Oct 2020 19:24:57 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Colin King <colin.king@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsock: ratelimit unknown ioctl error message
Message-ID: <20201026182457.fy6uxrjgs5bpzmnr@steredhat>
References: <20201023122113.35517-1-colin.king@canonical.com>
 <20201023140947.kurglnklaqteovkp@steredhat>
 <e535c07df407444880d8b678bc215d9f@AcuMS.aculab.com>
 <20201026084300.5ag24vck3zeb4mcz@steredhat>
 <d893e3251f804cffa797b6eb814944fd@AcuMS.aculab.com>
 <20201026093917.5zgginii65pq6ezd@steredhat>
 <3e34e4121f794355891fd7577c9dfbc0@AcuMS.aculab.com>
 <20201026100112.qaorff6c6vucakyg@steredhat>
 <20201026105548.0cc911a8@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201026105548.0cc911a8@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:55:48AM -0700, Jakub Kicinski wrote:
>On Mon, 26 Oct 2020 11:01:12 +0100 Stefano Garzarella wrote:
>> On Mon, Oct 26, 2020 at 09:46:17AM +0000, David Laight wrote:
>> >From: Stefano Garzarella
>> >> Sent: 26 October 2020 09:39
>> >>
>> >> On Mon, Oct 26, 2020 at 09:13:23AM +0000, David Laight wrote:
>> >> >From: Stefano Garzarella
>> >> >> Sent: 26 October 2020 08:43
>> >> >...
>> >> >> >Isn't the canonical error for unknown ioctl codes -ENOTTY?
>> >> >> >
>> >> >>
>> >> >> Oh, thanks for pointing that out!
>> >> >>
>> >> >> I had not paid attention to the error returned, but looking at it I
>> >> >> noticed that perhaps the most appropriate would be -ENOIOCTLCMD.
>> >> >> In the ioctl syscall we return -ENOTTY, if the callback returns
>> >> >> -ENOIOCTLCMD.
>> >> >>
>> >> >> What do you think?
>> >> >
>> >> >It is 729 v 443 in favour of ENOTTY (based on grep).
>> >>
>> >> Under net/ it is 6 vs 83 in favour of ENOIOCTLCMD.
>> >>
>> >> >
>> >> >No idea where ENOIOCTLCMD comes from, but ENOTTY probably
>> >> >goes back to the early 1970s.
>> >>
>> >> Me too.
>> >>
>> >> >
>> >> >The fact that the ioctl wrapper converts the value is a good
>> >> >hint that userspace expects ENOTTY.
>> >>
>> >> Agree on that, but since we are not interfacing directly with userspace,
>> >> I think it is better to return the more specific error (ENOIOCTLCMD).
>> >
>> >I bet Linux thought it could use a different error code then
>> >found that 'unknown ioctl' was spelt ENOTTY.
>>
>> It could be :-)
>>
>> Anyway, as you pointed out, I think we should change the -EINVAL with
>> -ENOTTY or -ENOIOCTLCMD.
>>
>> @Jakub what do you suggest?
>
>ENOIOCTLCMD is a kernel-internal high return code (515) which should
>be returned by the driver, but it's then caught inside the core and
>translated to ENOTTY which is then returned to user space.
>
>So you're both right, I guess? But the driver should use ENOIOCTLCMD.
>

Thanks for clarify!

@Colin, can you send a v2 removing the error message and updating the 
return value?

Thanks,
Stefano

