Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3632E2D50BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgLJCPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLJCPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:15:36 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D64C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 18:14:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id i3so2583412pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 18:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tqYt7x5l7ChS2b75CAGcZm7MBLEYVuTF7osXF52G8Po=;
        b=rT+O8Q8aty5iKeOIzFBtXojHut1jcvFJfRHTulPh2QlvAh5UkiC4gc37ajD6/aMDcy
         qLjnFEeANDWqDfIlTHgL856Lh0PYN/TkINVJULc0bODDJLQf+7J2usPQQ8e5TM1S6igw
         mAb1TLd3WIGklO+I4JdAE+TP9OsEDAiMxhNoKARVzdsy015EDadwezR/fVSh65gEQqcb
         xmCHTqOD92wJhkzMTcKf05rHGUltpB2ZVPyvQATBb7gC+IQQP02zYLRN+5vmRdMxUavO
         rmnKMVWBzIZbyVyDIx5pp4TLI2m6I6D+SiYBLeVmOft2MqK6LITFb7CnYvQUM8SNeZFM
         GnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tqYt7x5l7ChS2b75CAGcZm7MBLEYVuTF7osXF52G8Po=;
        b=MJcn+XFLUDK4fjz/xIR2WoCAWS6P7L7tISdPAVgt9IOU7pIXs0NSyQXBLzPpgyKYaS
         DGFBQqkKx9ITHqiOHNwL+P6bZlqR8Aqt34aFubI30CywKKK/hxC384JsFKzyvjLkWpfn
         ZHNs2NG9CK67x8F3oXV/lyf50Hsm+bhujk1GP3emBxIvqQcqpSpg8DqRu9ZZVMqHJaiw
         LR7qcoWnoCFXl0EaI6ISOvg89p7ICll3URlrXi83Ugsz36Xz+AqKOaJ/jyFcclXm9Un4
         1kpyISPKhfPNwbO0ZwlkerfTF8i9b/I0cG4UAco9WTTDvJbVGahKovz1efF6aYkw+h21
         aAQA==
X-Gm-Message-State: AOAM532aCZvlh1T+G/t/iG/+HrEY96zu1WXh1ZQ8wXLiEHzhGdmVvLB2
        HktmokZrqtoqSDpQAEVQgNQ=
X-Google-Smtp-Source: ABdhPJwYwIrej0X4TLUrkQJqaiiNZrL+KnjY/BU4gXxR7PmF54P4iyXhbGaO3tXbvAqocUe3CjLCWw==
X-Received: by 2002:aa7:9f0f:0:b029:19b:c68f:61cd with SMTP id g15-20020aa79f0f0000b029019bc68f61cdmr4745491pfr.45.1607566489817;
        Wed, 09 Dec 2020 18:14:49 -0800 (PST)
Received: from [192.168.0.104] ([49.207.210.144])
        by smtp.gmail.com with ESMTPSA id na6sm3319746pjb.12.2020.12.09.18.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 18:14:49 -0800 (PST)
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Cc:     syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
 <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
 <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
 <1215c353-3c3f-0a61-00a3-021f0c2f0032@huawei.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <38c68ef8-4b9b-cfc1-d8ad-cfeb4c2de845@gmail.com>
Date:   Thu, 10 Dec 2020 07:44:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1215c353-3c3f-0a61-00a3-021f0c2f0032@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/20 7:40 am, Chao Yu wrote:
> On 2020/12/10 10:00, Anant Thazhemadam wrote:
>>
>> On 10/12/20 7:16 am, Chao Yu wrote:
>>> Hi Anant,
>>>
>>> I've posted a patch a little earlier. :P
>>>
>>> https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u
>>>
>> Ah well, that's alright, especially considering that your patch looks better.
>> Glad that bug has been fixed nonetheless. :)
>
> Anyway, thanks a lot for taking time to fix f2fs bug. :)
>
> I prefer to add your Signed-off-by into "f2fs: fix shift-out-of-bounds
> in sanity_check_raw_super()" if you don't mind.
>
>

Sure, I'd appreciate that. Thank you! :D

Thanks,
Anant

