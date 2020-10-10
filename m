Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D09289F6A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgJJIut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgJJIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:44:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC6C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 01:26:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w21so2910496plq.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dr5qY8NyHjVYH13UhDsjPOas2xGcDA+M5geFB4xe7/8=;
        b=i4JuzuCUv9W34k/rlxlw+/z5GmaiprqIaJcQgDzpAaos3Y7kpGKh1+OwC6XnNeKCe7
         QeItm+DczVgCcOkW5fZY6aCQ4S94F3jQfywY+CL2PKof+ro8UVsBMHex9xU02FliTBAK
         PpH5PPFrJRGd6nkhPCrlCNNK5jqsfchhQMxyvNHDQNWIDrpQfdFIJ56wAiVJ+HCW0IC2
         qZBLbXR3lL7nS79Qr9qAI8i2S6bJk08wor+uD1coQ3gc4XtqmZA6fX7ieOtsWZsk1Gpb
         BVtdUWOWBuN9xsKDM73llWrYrUSWWuPgJOGENL7thsbmkAOZrynDiRikfuFtptR245Ca
         cMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dr5qY8NyHjVYH13UhDsjPOas2xGcDA+M5geFB4xe7/8=;
        b=Zq53HHIuVtinnlyW0lAN+w/N/DOzK8td7Oqb72kbbFKhZaA8wfwRHNR2E9nzXh92Je
         hSIqQcmcp1+Sk1d83xmB69vWKTUeVdNTNiJd8pxdZg/h9RhmolMw8+oA5ToRNL2Eve3f
         epXVPGZrGKtAShlMP+MUYf1HL+TXDf5OS54clR8E4+eGnKwHS1KqZwZY81zwwLJsNxcY
         uRfJHbZIDuvwatTKYv3mq0cYx5WFy/zGxrJr3s8JrpjjAYrwsgnj/haRpN/z3mdTbOrI
         wb75rP+/sW5iiUEJxr45vBwoVff7DzIQ5NEH2tcG0aLa3G2xC+/n2qLuDlbWihE/5CB0
         P3wg==
X-Gm-Message-State: AOAM530DTFgdAvnm1R5ussYTeVDFRlA5BAWF5CcP1spFburGoiz/KBwM
        OtqddMuIkBWrS+l8T5RcS/xX0WszUZbLH3m51Rc=
X-Google-Smtp-Source: ABdhPJzYMoq3NBhxi7krevICequtWJEfWgUgrtHrAsDTen8PZkYoq9k8IB4yxGcw4QJ+afcOnH6Fnw==
X-Received: by 2002:a17:902:7001:b029:d3:f0d8:d271 with SMTP id y1-20020a1709027001b02900d3f0d8d271mr15533920plk.48.1602318392700;
        Sat, 10 Oct 2020 01:26:32 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.200.2])
        by smtp.gmail.com with ESMTPSA id w135sm3681015pfc.103.2020.10.10.01.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 01:26:31 -0700 (PDT)
Subject: Re: [PATCH] staging: comedi: check validity of wMaxPacketSize of usb
 endpoints found
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        Ian Abbott <abbotti@mev.co.uk>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20201009162030.293781-1-anant.thazhemadam@gmail.com>
 <20201010070007.GB132110@kroah.com>
 <b84879e9-425e-6354-d21a-cd7c5d237be5@gmail.com>
 <20201010080904.GA140279@kroah.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <0abda8b5-a05c-814f-6230-c88e81d5a3d0@gmail.com>
Date:   Sat, 10 Oct 2020 13:56:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201010080904.GA140279@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/20 1:39 pm, Greg Kroah-Hartman wrote:
> On Sat, Oct 10, 2020 at 07:29:13AM +0530, Anant Thazhemadam wrote:
>> Hi,
>>
>> On 10-10-2020 12:30, Greg Kroah-Hartman wrote:
>>> On Fri, Oct 09, 2020 at 09:50:29PM +0530, Anant Thazhemadam wrote:
>>>> While finding usb endpoints in vmk80xx_find_usb_endpoints(), check if 
>>>> wMaxPacketSize = 0 for the endpoints found.
>>>>
>>>> Some devices have isochronous endpoints that have wMaxPacketSize = 0
>>>> (as required by the USB-2 spec).
>>>> However, since this doesn't apply here, wMaxPacketSize = 0 can be
>>>> considered to be invalid.
>>>>
>>>> Reported-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
>>>> Tested-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
>>>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>>>> ---
>>> You sent 2 patches with the same subject, which one is the "latest" one?
>> This patch (that you have replied to) is the "latest" one.
>>
>>> Please always version your patches and put below the --- line what
>>> changed from the previous version, so that maintainers have a chance to
>>> know which to accept...
>> The other patch (with the same subject line) wasn't supposed to be sent out.
>> I realized there was a coding style error in that while sending, and cancelled
>> sending it, but it got sent nonetheless.
>> I would have included a v2 tag in this patch itself, but I didn't realize that the
>> previous one got sent until afterwards. :(
>> I'm sorry for that.
>>
>>> Can you fix this up and send a v3?
>> Shouldn't I resend this patch as a v2 instead? Since there wouldn't be any
>> changes from v2 (this patch) to v3 otherwise (unless of course, somebody could
>> suggest some more changes that could be made to this patch itself).
> The change would be that you are correctly listing the version
> information, so it would be v3 :)
>
Understood, thank you. I will send in a v3 as advised. :)

Thanks,
Anant

