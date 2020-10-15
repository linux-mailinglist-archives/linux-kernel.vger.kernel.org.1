Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6060828F84F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbgJOSUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732918AbgJOSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:20:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48448C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:20:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so4723341wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hvXSEZbolt+CTHWvl9yzQd1oWzABXDBqhz4QMQrB3EY=;
        b=m20ou4Cv+pOeaDzv/f4h2a0WDE9qUz5vcgWDF7ua0DLYE+YnZ7Of4ACQx1yOf/YJhb
         c7p9EhY0cHsFpGTrPMSHwDRnYAJPreGXkIw5+sOOJXaDDKkS2swkm+rbVYMq05KmKi1S
         t3Y9PvE2Ya+IVbLHYKl4+Mkbk2B7n0vXQZ44P7Dc8cOh1YZKgOtILUHOY59iqcaieImX
         O3C1x3mk96ESKUY4Rm7mbPQ5APwRS98+1H30PjACtNn1ISt9vJwRkGPJD1Rxar10h7aV
         5KQWd4Fm/lqd7R50JmS6gIVn1L3z1Z8PNAvczUI/m5pVy+NUMWU8/27vL0eFXoQU8bvo
         R8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvXSEZbolt+CTHWvl9yzQd1oWzABXDBqhz4QMQrB3EY=;
        b=QLtjeRD1VCEy7OAxdBX94Rm0Us1ZsdN0FFsx5yfPo3TKaLQrfn6dmkVaIGBtKJkxeF
         o50HA5gaIOAKV4F7XHZXCuCYec5XA4Vc9SoQaEEyHZcn9elBqGmnRiLuSlUx/BEo4OA3
         4fdlPqQv0/GS0eNzYKcYtvqRL7rO4Nm1Zs6mIy7Q4OyLkgFEZo6Hg7BOA2QUo2Ku57dZ
         Bp4PHInmnqZiYBwEIDdozWy8gIDsgwKpkKf87j6MhHjiHjrI1Dhw7FPmitcEic5HBm+v
         6MYvn+MjQsEOxky0FilqIEhz64GAzYqeoDFfYIa6sP3eabiE17/8NYYAz4/Zh2zJ+MXr
         DLcQ==
X-Gm-Message-State: AOAM5320jcWPMUgmXl8lTGMALxQnUFALrvgfWMtVs1+uMnorVAuEky9z
        4jQDTZe1izDdyiS3+7jx/4j9QX7XrD8=
X-Google-Smtp-Source: ABdhPJzw49pIRVjWF6J0+ONJPiyjEWT5pQWdoCyVzeUMbo/Ia4s0MPJbJ8JCtr+eUMSObihcbMdIwQ==
X-Received: by 2002:adf:9f09:: with SMTP id l9mr5637817wrf.355.1602786038706;
        Thu, 15 Oct 2020 11:20:38 -0700 (PDT)
Received: from [192.168.1.20] (host86-161-135-215.range86-161.btcentralplus.com. [86.161.135.215])
        by smtp.googlemail.com with ESMTPSA id 71sm137514wrm.20.2020.10.15.11.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 11:20:38 -0700 (PDT)
Subject: Re: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in
 rtsx_pci_init_ocp()
From:   Chris Clayton <chris2553@googlemail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ricky_wu@realtek.com, arnd@arndb.de, bhelgaas@google.com,
        vaibhavgupta40@gmail.com, rui_feng@realsil.com.cn, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
References: <20200824030006.30033-1-ricky_wu@realtek.com>
 <c06d7691-01ab-303c-e687-dd8c51a8a9c5@gmail.com>
 <20200914155830.GA3525000@kroah.com>
 <e52d7258-e760-81ac-9093-abe7c3504ee2@googlemail.com>
Message-ID: <b0698b1e-227e-1cfb-4ed8-da83a4ed7b18@googlemail.com>
Date:   Thu, 15 Oct 2020 19:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <e52d7258-e760-81ac-9093-abe7c3504ee2@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 18/09/2020 15:35, Chris Clayton wrote:
> Mmm, gmail on android seems to have snuck some html into my reply, so here goes again...
> 
> On 14/09/2020 16:58, Greg KH wrote:
>> On Sun, Sep 13, 2020 at 09:40:56AM +0100, Chris Clayton wrote:
>>> Hi Greg and Arnd,
>>>
>>> On 24/08/2020 04:00, ricky_wu@realtek.com wrote:
>>>> From: Ricky Wu <ricky_wu@realtek.com>
>>>>
>>>> this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
>>>> missing card reader
>>>>
>>>
>>> In his changelog above, Ricky didn't mention that this patch fixes a regression that was introduced (in 5.1) by commit
>>> bede03a579b3.
>>>
>>> The patch that I posted to LKML contained the appropriate Fixes, etc tags. After discussion, the patch was changed to
>>> remove the code that effectively disables the RTS5229 cardreader on (at least some) Intel NUC boxes. I prepared the
>>> patch that Ricky submitted but he didn't include my Signed-off-by or the Fixes tag. I think the following needs to be
>>> added to the changelog.
>>>
>>> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
>>> Link: https://marc.info/?l=linux-kernel&m=159105912832257
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
>>> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
>>>
>>> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card reader on the Intel NUC6CAYH box.
>>>
>>> My main point, however, is that the patch is also needed in the 5.4 (longterm) and 5.8 (stable) series kernels.
>>
>> It's too late to change the commit log now that it is in my tree, but
>> once it hits Linus's tree for 5.9-rc1, I can backport it to those stable
>> trees if someone reminds me :)
>>

This is the reminder you suggested. The patch is now in Linus's tree and the commit id is
551b6729578a8981c46af964c10bf7d5d9ddca83.

Chris
> 
> Thanks, Greg. I'll send the reminder.
> 
> Chris
>> thanks,
>>
>> greg k-h
>>
