Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC62988AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769633AbgJZInJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1769625AbgJZInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603701787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdIefJ/S5T1RvOULWYU5XkYeJYKRh3p/OM7cFDJ9io4=;
        b=CCPfFslS/NxVOdEwBoGWzsKfl5CFR5ZcJmpOz6fpQduKGK+/nw8ktIyxgt4T1TqizT3fwD
        aM4wGBjeroEq9Vjk0yOZTCXe9U8oPtPtjbl+DQop0FcbKeRG725b9JILFE+mY11DGPcdA1
        CqPe5JuJ27+/H5vB5xtXrMaFy9X8wIU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-4g3ZzPDDMOW_QDKQ9dDntw-1; Mon, 26 Oct 2020 04:43:04 -0400
X-MC-Unique: 4g3ZzPDDMOW_QDKQ9dDntw-1
Received: by mail-wr1-f72.google.com with SMTP id m20so8050285wrb.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdIefJ/S5T1RvOULWYU5XkYeJYKRh3p/OM7cFDJ9io4=;
        b=FCcmtM690Trb5hEODw1ez6YLs2Zy30D2nXz2qOS1VECTpb/O+gxYbUy6CVKYKw4txV
         g+i1HiqC6mpk+mk4rh9xg1RFuJepEak4Vfdxyqu0SXA94IfQnMkWRt0u7xVxQi/Qf71W
         KuiL+qNL0Z9rizxzyg9RS76erhlM95YL+io4PmAxmnUYkamoNGF5MHS+lodH9tEJ23h6
         yCxS7juDjt3AoIeCAL4HXQ+j8Ej9WD5y36k2kD1Jbqvrp5lDG9nYuHxWhWycnApMoYxY
         ijXerF4Vti+V3aC0SF5T1vkJOTI4UnHa1k3vYtCBDxFqBNSHmC+fbwZ3bVP6HUkE94L5
         MMeQ==
X-Gm-Message-State: AOAM531akAWFrrW1DHq+OkhpmOi+kTvusYdrVBbRHrCQtNTmNmVNcJbl
        cdxr4+KAOyVXh/wk1rz9MIMnAq58QAYa9H18pABJKDs7WdCJP4drF33/EQwNXcHpuSO3vKtX7nx
        GfDToqCt3dNM2CkInDc2FcTLV
X-Received: by 2002:adf:fd49:: with SMTP id h9mr17312836wrs.115.1603701783548;
        Mon, 26 Oct 2020 01:43:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6qoLrHt7rz+8meQEIZn3c7vEx/gDRaWJUKYdtFkGhU3fruxF70yzU08kRzQLI3t1PCPEXxA==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr17312822wrs.115.1603701783324;
        Mon, 26 Oct 2020 01:43:03 -0700 (PDT)
Received: from steredhat (host-79-17-248-215.retail.telecomitalia.it. [79.17.248.215])
        by smtp.gmail.com with ESMTPSA id k18sm20625387wrx.96.2020.10.26.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 01:43:02 -0700 (PDT)
Date:   Mon, 26 Oct 2020 09:43:00 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsock: ratelimit unknown ioctl error message
Message-ID: <20201026084300.5ag24vck3zeb4mcz@steredhat>
References: <20201023122113.35517-1-colin.king@canonical.com>
 <20201023140947.kurglnklaqteovkp@steredhat>
 <e535c07df407444880d8b678bc215d9f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e535c07df407444880d8b678bc215d9f@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 09:30:59PM +0000, David Laight wrote:
>
>From: Stefano Garzarella
>> Sent: 23 October 2020 15:10
>>
>> On Fri, Oct 23, 2020 at 01:21:13PM +0100, Colin King wrote:
>> >From: Colin Ian King <colin.king@canonical.com>
>> >
>> >When exercising the kernel with stress-ng with some ioctl tests the
>> >"Unknown ioctl" error message is spamming the kernel log at a high
>> >rate. Rate limit this message to reduce the noise.
>> >
>> >Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index 9e93bc201cc0..b8feb9223454 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -2072,7 +2072,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
>> > 		break;
>> >
>> > 	default:
>> >-		pr_err("Unknown ioctl %d\n", cmd);
>> >+		pr_err_ratelimited("Unknown ioctl %d\n", cmd);
>>
>> Make sense, or maybe can we remove the error message returning only the
>> -EINVAL?
>
>Isn't the canonical error for unknown ioctl codes -ENOTTY?
>

Oh, thanks for pointing that out!

I had not paid attention to the error returned, but looking at it I 
noticed that perhaps the most appropriate would be -ENOIOCTLCMD.
In the ioctl syscall we return -ENOTTY, if the callback returns 
-ENOIOCTLCMD.

What do you think?

Stefano

