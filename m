Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F383521BD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGJSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:33:14 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5FC08C5DC;
        Fri, 10 Jul 2020 11:33:14 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k18so5184793qtm.10;
        Fri, 10 Jul 2020 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TK+rDfPiXDQ6Wu0ZZ4teUJXL+8D2schXrnWNQq/FvPI=;
        b=hGBtdSgNTkNUEE7x3DH3AHt0Qa/l2KdiClP88SJGpoDyI/aeCg/X2CWVGTebhWfTm7
         P4+1ZHGPKnxWDAswdTk6DLMza/UTmbHCD4xOBpOpw9C+7lzpehbnv3Y6hZwafLxXwl7z
         aEHmsiHH0cL0GZwzZD3enn/Ds7OdN+HlguPhIvpHQ1qPQ2kcs+E2wCOWE7n4pumRL0gJ
         oA/fDcPTyAeQZH4/J84K7W/VQf7VaYzyWY/IAzlejHCgm6CnslA34rw9zrXApn07dNSe
         DhJuM+oBc3bB7s+X22Y+B56L4MgMKThGBAyS8eoo+7jvWLkKkrR/DK/a5ZejUmXnV/Rg
         y1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TK+rDfPiXDQ6Wu0ZZ4teUJXL+8D2schXrnWNQq/FvPI=;
        b=pqZ/a5+VXKsPZhvaev0diN8LH8N1BIaBgZDbdRmfYwFwRnYbhRt9mhqqBGMAJuJmNf
         s3LpmhXBYpuoLum3XqTVwYiqFtiU0n7NPEaFp6AVyEmL9UIYRQVaPcFjZYCPdug6rwNK
         u47Ju5fzC4z3YDGOj2CLaUnKTUsFHdsz5F+CRFnOjBhAOl2J549xb7VT5uAaU1jmzdnJ
         657MuxOZ9eJbyRSs1EtGedxQBNIhs8V+jhrwsMw/cf63AGKvSeL4Mc1CW6kf3u1BGgzW
         4UR/KQWr0f7vuJjt+1py3kDPm1AW1t8vCHo7zLWnEDdW2GuZGgINSitB1LMXiysNXT+G
         9uHQ==
X-Gm-Message-State: AOAM533/AxcT6ovPTWJO7BMiV54bbmQJskXmICHC2tnNOkY95VKMYCvx
        y88/UXc3fphpoevQkyb9IfTyFshMrbY=
X-Google-Smtp-Source: ABdhPJx86wfeZryei9Se+7s7/y7sXiGegaCswPNlv78kzGV7L3SRbYE0nhSOc+Bm+d+yx9QN3006Hg==
X-Received: by 2002:aed:21e1:: with SMTP id m30mr44596251qtc.367.1594405993859;
        Fri, 10 Jul 2020 11:33:13 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k14sm9234818qtb.38.2020.07.10.11.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 11:33:13 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.28.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <xmqqh7ugwen6.fsf@gitster.c.googlers.com>
 <01e87be3-3911-afc1-e738-69446275c8c0@gmail.com>
 <xmqqa707uzf6.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6989c299-0431-d751-33e4-a94bd78dcafc@gmail.com>
Date:   Fri, 10 Jul 2020 14:33:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqa707uzf6.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2020 12:07 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 7/9/2020 5:40 PM, Junio C Hamano wrote:
>>> An early preview release Git v2.28.0-rc0 is now available for
>>> testing at the usual places.  
>>
>> This might be part of your new process, or it might be an
>> oversight. It seems that GIT-VERSION-GEN did not update with
>> this RC, so the built version will still have a 2.27 start [1].
>>
>> This differs from previous rc's [2].
> 
> Sorry, I screwed up.  Thanks for a set of sharp eyes.

No worries. The only reason I was confused was because I
always hit a conflict on GIT-VERSION-GEN when rebasing
microsoft/git onto a git-for-windows/git version (so we
can add the ".vfs." into the version string). I had no
idea if this would cause anyone trouble.

Thanks,
-Stolee
