Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1F289EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgJJHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbgJJH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:29:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C7C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 00:29:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d1so424267pfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CGaRnUXGGA+4gEMvMrlGGBPIeMqxnDwVXY+Ah17vxLA=;
        b=TSsTJ3I9KNL0rzGvFXhmgm94hUPSSolCBOZL/c4RsSJyDJ98vRHs0GdqhE/5ysb4Sg
         AX/sKGh4Yg6Ks8nVJUwmw5T9SezcRS3UdxShu1RtZ+pGGgApolzPGfmE2lhdEA2TryFw
         ItgX9zItj8vCfpuimo2pya/8cTwunHDyizE5JgqArjRI5PJBS3O59IHARlv3OUus4+we
         Ju8y0cnJFWbX2RQED4/I0BrgSp2woqmcAMJuEENUEZX8LDxlnX0QPYkKA07iYCPl8DuG
         97wP3tVjff3EJFllm02TQlnLTQi+xgBkrqVRs0v5ZCwDg6BYz49oIPNfGBTLkHWNngMZ
         EboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CGaRnUXGGA+4gEMvMrlGGBPIeMqxnDwVXY+Ah17vxLA=;
        b=YjLi+fE7r/uGq2dSPT+sfHM0ZCmUZytdvr75hlXxJ6Od7SRrEznRZ5oJaKJG+NZatB
         xaectphhwEA01wlMMTMLRX9Am2z3RLsByuEf0FJN/QOicP07e2gAg9pYt9Cb99tK728u
         FvpW9LyEhe/fCCuVkwa163tZ0J8m218vUr4eaQp8OUMo1V64r9ck70svyKdnQbQ4/qFk
         exXR5D2K8Rea86Yr52HHwbl/TBQdgKvj2qa8hH5dAZ4r13h6Aua/UpZakLygzJhPijgA
         DZyInpTYAvGcQfMf91Q/upbPFHSgseX1pMhsuOLQtrKAT1n3ywRnfYon4w8uzjJEU/zw
         rilg==
X-Gm-Message-State: AOAM530qRTQEDR5YqG9aUBPx2jdBpfCpQ79d5Hb5BAiHlXXFzygZvHvz
        8bGVyUdsXqHPX8aXvntcLUfen26Fke55AvLHC0U=
X-Google-Smtp-Source: ABdhPJwlXmxcTfrJh3wNGrdy2Xxb8lFF+gr6n/eqqGy4Q1xdCUefYbC8xcsMrs12A9H+atR+fNX8zQ==
X-Received: by 2002:aa7:98ce:0:b029:152:5ebd:428 with SMTP id e14-20020aa798ce0000b02901525ebd0428mr15174034pfm.4.1602314957423;
        Sat, 10 Oct 2020 00:29:17 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.200.2])
        by smtp.gmail.com with ESMTPSA id m6sm13766634pjn.47.2020.10.10.00.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 00:29:16 -0700 (PDT)
Subject: Re: [PATCH] staging: comedi: check validity of wMaxPacketSize of usb
 endpoints found
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201009162030.293781-1-anant.thazhemadam@gmail.com>
 <20201010070007.GB132110@kroah.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <b84879e9-425e-6354-d21a-cd7c5d237be5@gmail.com>
Date:   Sat, 10 Oct 2020 07:29:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010070007.GB132110@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-10-2020 12:30, Greg Kroah-Hartman wrote:
> On Fri, Oct 09, 2020 at 09:50:29PM +0530, Anant Thazhemadam wrote:
>> While finding usb endpoints in vmk80xx_find_usb_endpoints(), check if 
>> wMaxPacketSize = 0 for the endpoints found.
>>
>> Some devices have isochronous endpoints that have wMaxPacketSize = 0
>> (as required by the USB-2 spec).
>> However, since this doesn't apply here, wMaxPacketSize = 0 can be
>> considered to be invalid.
>>
>> Reported-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
>> Tested-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>> ---
> You sent 2 patches with the same subject, which one is the "latest" one?

This patch (that you have replied to) is the "latest" one.

> Please always version your patches and put below the --- line what
> changed from the previous version, so that maintainers have a chance to
> know which to accept...

The other patch (with the same subject line) wasn't supposed to be sent out.
I realized there was a coding style error in that while sending, and cancelled
sending it, but it got sent nonetheless.
I would have included a v2 tag in this patch itself, but I didn't realize that the
previous one got sent until afterwards. :(
I'm sorry for that.

> Can you fix this up and send a v3?

Shouldn't I resend this patch as a v2 instead? Since there wouldn't be any
changes from v2 (this patch) to v3 otherwise (unless of course, somebody could
suggest some more changes that could be made to this patch itself).

Thanks,
Anant




