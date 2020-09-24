Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B729C27789B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgIXSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgIXSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:44:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF573C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:44:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so222341ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rhoVDD+QyZ/VpnmaxdHwHSK4MAMZshD/6BnNM8Pq0iU=;
        b=aGd0Dw+XSskS+D3UBhBG/PSU/87ifJOQEbDOC5Yco6RAmKH0mWtGn4o3TdUdpNwgzt
         +0rJ6z3CgiQlXBvfrOeh7ZCHaVy8ye30/ACe3N3VN3TJuUxznvscb7W/83uG10SX1c5d
         hqNSfJ/wtTfO7sDWqfVRRdKQ6GJQ7FreEt2HTfbUOViyEaamnUXzOStXghL5fmc8zC9y
         4CJXz4CGSndnFMg0YA34oXTT/K9tKmdOBMEGiIqzhPlhjpxWZcZhk/6hR9RybPDnyUSi
         EtFU9IrNp/b/KYVVHdKpZHx1pF+mEjeVVKk6S4yFvBhfrGvt5Xt5heHPkQKE/kFWlOXQ
         AJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rhoVDD+QyZ/VpnmaxdHwHSK4MAMZshD/6BnNM8Pq0iU=;
        b=qJSqDa98IuJrf/z4FDAzjQrQGoDSI3ugVKeugt735ACukA83BNMcxXx0OX6inyD4kX
         fIOGt2Q4sIZ+jFZSAx0Aesr6Ftin3h6YQRZME7ETnHiMEmGG9MsAiYc2XGocKakFqNz4
         pWffCtReoQfB/kMdoBtzZVQgEsfbgkm254Rhlf1sd/fdRrGy8GTJrF3tBqvLxoE/OmGg
         0TBmrVfC8yo7nHzKrb02zHooQ7mnRb2YlWz53uFYJhYFaHVLJ3zwGQ6avsjdr0ryseYF
         5j25yZFWRPsd1FtyP33ozH1iSJqEcfdnZN+k4gO2QDETo5uZOA5lLWMdxAcV7m40QyNq
         0xVQ==
X-Gm-Message-State: AOAM5308KYlfrbDyLpz3xlDnzNbnhr/PzWAPVzNbMwDbHq6sneOrqtP+
        47sK50Jc//TsGxmtrIlCqSg=
X-Google-Smtp-Source: ABdhPJztojqg50cIpr2EFmk2539uhEkflIgsUH4vE1+VuhlS7+OmOo6+3EQMJhXs6DHV5j0QeUPlhg==
X-Received: by 2002:a17:906:6805:: with SMTP id k5mr1253611ejr.397.1600973062457;
        Thu, 24 Sep 2020 11:44:22 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9d2.dip0.t-ipconnect.de. [217.229.169.210])
        by smtp.gmail.com with ESMTPSA id o3sm23827edq.63.2020.09.24.11.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 11:44:21 -0700 (PDT)
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastn?= =?UTF-8?Q?ik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
 <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
 <cfed1f74-653c-565b-ea91-877c4e1f63a0@gmail.com>
 <CAK8P3a0_i=wHnQmfbjCdMgFRSD0eGjEM2uMFft5FJ4M1GSUbHg@mail.gmail.com>
 <5d470a61-bf4d-7ea2-b41f-1163006b1956@gmail.com>
 <CAK8P3a3HWjyaxwN3gyFEcJ9P=iHPvYXsL=C2kEg1hDmJvNm1tQ@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <043f9a77-784d-e887-19e0-57e42ff6bddc@gmail.com>
Date:   Thu, 24 Sep 2020 20:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3HWjyaxwN3gyFEcJ9P=iHPvYXsL=C2kEg1hDmJvNm1tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 9:41 AM, Arnd Bergmann wrote:
> On Thu, Sep 24, 2020 at 12:23 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>> On 9/23/20 8:51 PM, Arnd Bergmann wrote:
>>> On Wed, Sep 23, 2020 at 8:29 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>> On 9/23/20 6:48 PM, Arnd Bergmann wrote:
>>>
>>> The version I showed avoids the pointers and is compatible with
>>> 32-bit user space.
>>
>> I'm not completely convinced yet that the read/write approach is the way
>> I want to do it, especially with Greg suggesting a misc device, but I'll
>> keep your solution in mind.
> 
> In case of a character device, I'd go with an ioctl to keep it extensible.
> 
> The read/write based interface is what I'd use in debugfs.

Perfect, thanks!

I'll follow Greg's suggestion and create a misc device, and then go for
the IOCTL interface as you suggest.

Thanks again,
Max
