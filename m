Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1442C8F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgK3UyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgK3UyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:54:06 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A7DC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:53:26 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n14so8470467iom.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9rDynQqHXhgZs9ftFTlmJDLgTibcXlW3yFxe96RFBI=;
        b=iGcC1c2hU3KQgI2w6wqHMPB6GtcOK5VoRew9n+BLojZC8SXEmvbk0KxdJq5e0QwAEk
         LU8MfhdLCx+dv0Ng1gYOVI6jmujT9HFNJfD6Kp4wCqDjdvtUXAJszPyPkOzVvh2X8y9M
         ohxnjFajCfnOuXGyrGvDsBV2+dNz7gwbahwic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9rDynQqHXhgZs9ftFTlmJDLgTibcXlW3yFxe96RFBI=;
        b=Ix7omH/nc7zzmG9j7fKXe2PjG0yCPRWwJzN6kgzJom7jFjrzi60GQxAVfuh6VqY4JJ
         wYxrPkrWnuJKwtSoPy2izhDvUYTUnt8Mre4V/FotdWo1YAXLAk7a68tlW862bUsywHim
         YGm+lRHZVKDBU9YzDjsTWHH4A0Gz50wihybS+EGfxrjGmSUqiOeodNP8rRVaYEf2r9u4
         SANhUkPhCkxeErREoRWCGU7bJH8O99fkKVWC6ARoCbrgaDm2lUQQk21IqsmDwgOkAPqJ
         SuMzOzDe96zng4rFY+360GVvCrTQuPfabItavhWPZUymprXKn3EIjSD0FWoBiEMPKNFK
         gKfA==
X-Gm-Message-State: AOAM530azdF4V+5t3eAwkOl6YYv+nDUCQSa9yEUPvhYSTscMniZ77Waw
        LhSt4nj/1agbR+hlKEIoxgE99g==
X-Google-Smtp-Source: ABdhPJzpLX/1Xj+NdKPbYjj9zSIm6cXU7z4S5oKnJz/TXHAVXI8FskRRkiOizmoXCyJNAcAnMgc+Jg==
X-Received: by 2002:a02:a419:: with SMTP id c25mr13981481jal.91.1606769605942;
        Mon, 30 Nov 2020 12:53:25 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l6sm11963425ili.78.2020.11.30.12.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:53:25 -0800 (PST)
Subject: Re: linux-next: manual merge of the tip tree with the cpupower tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@suse.de>
Cc:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201123134259.2dc63db7@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e66c627b-0666-ee4f-fc3e-57cb2ad98fb9@linuxfoundation.org>
Date:   Mon, 30 Nov 2020 13:53:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201123134259.2dc63db7@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/20 7:42 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in:
> 
>    tools/power/cpupower/utils/helpers/misc.c
> 
> between commit:
> 
>    748f0d70087c ("cpupower: Provide online and offline CPU information")
> 
> from the cpupower tree and commit:
> 
>    8113ab20e850 ("tools/power/cpupower: Read energy_perf_bias from sysfs")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thanks. Fix looks good to me. I will mention it in my pull
request to Rafael.

thanks,
--Shuah
