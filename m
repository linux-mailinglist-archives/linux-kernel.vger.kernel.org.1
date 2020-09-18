Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6E270000
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIROfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIROfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:35:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5307C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:35:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so5567348wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T3sstV3ZPKGqOzfwr4c/woq8OqWF4H3bHOX6f88+4eA=;
        b=EfIOVhFIHIxUarE2g7KgsvI1jjVyg8SF6yZWQUqakWLXED80cjpPmbw4IUW2Au6hLw
         6WO9zZfiwpVGKZhLxdBDE+EHzRuEm9AJky4I2QnVsWqZ2vumNMhDCmfWp6byQLFgZkMG
         9GSHRlTUyY13zuSoXaV4g5fSd6E3DFD3oKhGpwDBGdr4LnHseEFTqIkU5oc4SP0OJtYx
         ACXjEvBdTmaEzA0aCtUIFInH2aA+MMJSepOPr2XvQ2GtWmSbDnfO9sBdcLOhKqUiTI7e
         alCesEg/4YqYA43awGuTnm/XluqGkg3sxHf0t8HnLctWKHFkyI93EkXMG1AIQO9c2o/U
         87UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T3sstV3ZPKGqOzfwr4c/woq8OqWF4H3bHOX6f88+4eA=;
        b=YbbqLtpYxD0avuDxk/m1peSUVpF+QMLxjMh1ffEf3TOqb1sfW4c9qOFxQreNt6XOZI
         CFTS07aHGisr4zwTGb50A3Jxx95k7xpTReZ6CrjtRXljsEyZ/yhwGbg2aygHW8H8c8wh
         a2SPUknbBDobF2KyeLfvm/YOySq0vrB5zR/97m7YifIe3EabxJb3CUZbGKlwcjJfuh7y
         8YOlY2JV6B9NAX+6I213XDCjnsVvvTcXLy9oRhec0s+VIDm5p2qNCOW+9drWxojyA6Bj
         /TMKaMBmIH6ovovDFkAGaDwMFkH7kE/ux9NjAZEwS+pm8tPl7xWx3kyAydtpI/PBcUG0
         libA==
X-Gm-Message-State: AOAM532ZVd8xg39YbHN21fUppWaDKOE8DNThTFlusBf/h4KL5HWxI9z1
        UMpISt634GbI+rX0SCaVDcl0rJDvjKw=
X-Google-Smtp-Source: ABdhPJwpc769Bp4kEBM7SAuo3cxxSHzcAt66NZx74LS21oM4MlFwUXZ9X5iVsKw8WIhpzI75chUVoQ==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr15985812wme.4.1600439751600;
        Fri, 18 Sep 2020 07:35:51 -0700 (PDT)
Received: from [192.168.1.20] (host81-151-13-9.range81-151.btcentralplus.com. [81.151.13.9])
        by smtp.googlemail.com with ESMTPSA id o4sm5303271wru.55.2020.09.18.07.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 07:35:50 -0700 (PDT)
Subject: Re: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in
 rtsx_pci_init_ocp()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ricky_wu@realtek.com, arnd@arndb.de, bhelgaas@google.com,
        vaibhavgupta40@gmail.com, rui_feng@realsil.com.cn, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
References: <20200824030006.30033-1-ricky_wu@realtek.com>
 <c06d7691-01ab-303c-e687-dd8c51a8a9c5@gmail.com>
 <20200914155830.GA3525000@kroah.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <e52d7258-e760-81ac-9093-abe7c3504ee2@googlemail.com>
Date:   Fri, 18 Sep 2020 15:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914155830.GA3525000@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mmm, gmail on android seems to have snuck some html into my reply, so here goes again...

On 14/09/2020 16:58, Greg KH wrote:
> On Sun, Sep 13, 2020 at 09:40:56AM +0100, Chris Clayton wrote:
>> Hi Greg and Arnd,
>>
>> On 24/08/2020 04:00, ricky_wu@realtek.com wrote:
>>> From: Ricky Wu <ricky_wu@realtek.com>
>>>
>>> this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
>>> missing card reader
>>>
>>
>> In his changelog above, Ricky didn't mention that this patch fixes a regression that was introduced (in 5.1) by commit
>> bede03a579b3.
>>
>> The patch that I posted to LKML contained the appropriate Fixes, etc tags. After discussion, the patch was changed to
>> remove the code that effectively disables the RTS5229 cardreader on (at least some) Intel NUC boxes. I prepared the
>> patch that Ricky submitted but he didn't include my Signed-off-by or the Fixes tag. I think the following needs to be
>> added to the changelog.
>>
>> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
>> Link: https://marc.info/?l=linux-kernel&m=159105912832257
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
>> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
>>
>> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on the Intel NUC6CAYH box.
>>
>> My main point, however, is that the patch is also needed in the 5.4 (longterm) and 5.8 (stable) series kernels.
> 
> It's too late to change the commit log now that it is in my tree, but
> once it hits Linus's tree for 5.9-rc1, I can backport it to those stable
> trees if someone reminds me :)
> 

Thanks, Greg. I'll send the reminder.

Chris
> thanks,
> 
> greg k-h
> 
