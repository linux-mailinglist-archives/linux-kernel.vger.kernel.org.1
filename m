Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1928DFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgJNLOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgJNLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:14:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E53C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:14:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b26so1784322pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43x3rKcA2RyvqYiM6kbwL04G0XHRff3aQFwR3Tk95j0=;
        b=Ofsg01VIqtGta8qTAhXBMpCT5/mtiFiUuxL51MlYGqzMY7QgRpwuE6vWvJGk4/qnQj
         jiiLioo7k1XTq4qCfR+r8bBT7xQyPTx06lj7s1unv/dNrpIEXK2ZYP30rRSd8PQspUrf
         Yp7QVkgnz+h1Tn5S0BfVuMZUysIasWo03AUK5uwkjr/JGGK2X3pEkj1AYfUXPOLuctPI
         SdWykLU989sp+1SqVdEMa7P28TK50WOew1CqL8tJL4uB9gd1EHhq09FhbkmpsSxMp0uc
         ezKtskKYmnnAONmyIwvn506ixdp7NLl98jRspmGRYD7UwydhpEHC7IsoAwrTABzgowZF
         ULLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43x3rKcA2RyvqYiM6kbwL04G0XHRff3aQFwR3Tk95j0=;
        b=ScGxMJ6nSMrKVwvkIhFAygISRWCGgvAr+7gJC24lTVvivzvOb8SMlw+mq0A8/+FAuB
         nq83CH3CQAFnZRDmba2SVY/NtuHzbqCwG8mya9KIeuLkJ/ZeldgsuLTw6rH3vaF3E8hD
         UZi2BhX6iYCJ5o6U3UjDEBex2HIm3XI5if5YEfAG0kHQYaUl7RgJzbz1LLVEfJah6i63
         bHb9Q6JRBonjrz5JhMbGXP+fw1/191twnY1ny9XiyqgkdDoUV7KCGt3t1wNwHCT7fb8r
         sJCbebAqUqKSYr3ydtnh2k07V4mem/AFmfL3/XzJ6vCvwAVz175VvWh1SyQpZl/7sKaZ
         2CNA==
X-Gm-Message-State: AOAM530Ul0G57GbOYWDg4FPBFmZw6fyngup/rre8nGRJnVZfpP+heQBW
        BHXUCguVPdVK95pqwq3og9U=
X-Google-Smtp-Source: ABdhPJyBfeSMBAFaa0Rs/TBYcwJvnYQzn0er8KZob1Tl2FQ88Rmo8DA/RB06vimCYn/tlWPmqby8dA==
X-Received: by 2002:a62:7f81:0:b029:152:6197:f1f2 with SMTP id a123-20020a627f810000b02901526197f1f2mr3860145pfd.49.1602674051626;
        Wed, 14 Oct 2020 04:14:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a404:280a:90bd:7a49:dcda:1fb1])
        by smtp.gmail.com with ESMTPSA id jx17sm2745454pjb.10.2020.10.14.04.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:14:10 -0700 (PDT)
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
 <alpine.DEB.2.21.2010140734270.6186@felia>
From:   Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Message-ID: <d04f2b9c-e3e7-e68b-55c0-5444dae1746b@gmail.com>
Date:   Wed, 14 Oct 2020 16:44:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2010140734270.6186@felia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/20 11:16 am, Lukas Bulwahn wrote:
> 
> 
> On Tue, 13 Oct 2020, Ujjwal Kumar wrote:
> 
>> checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
>> files. The script leverages filename extensions and its path in
>> the repository to decide whether to allow execute permissions on
>> the file or not.
>>
>> Based on current check conditions, a perl script file having
>> execute permissions, without '.pl' extension in its filename
>> and not belonging to 'scripts/' directory is reported as ERROR
>> which is a false positive.
>>
>> Adding a shebang check along with current conditions will make
>> the check more generalised and improve checkpatch reports.
>> To do so, without breaking the core design decision of checkpatch,
>> we can fetch the first line from the patch itself and match it for
>> a shebang pattern.
>>
>> There can be cases where the first line is not part of the patch.
>> For instance: a patch that only changes permissions without
>> changing any of the file content.
>> In that case there may be a false positive report but in the end we
>> will have less false positives as we will be handling some of the
>> unhandled cases.
>>
> 
> I get the intent of your addition. However:
> 
> I would bet that you only find one or two in a million commits, that would 
> actually benefit for this special check of a special case of a special 
> rule...
> 
> So given the added complexity of yet another 19 lines in checkpatch with 
> little benefit of lowering false positive reports, I would be against 
> inclusion.

Yes, it is a subtle change.

> 
> You can provide convincing arguments with an evaluation, where you show 
> on how many commits this change would really make a difference...

Some statistics:

I aggregated commits which involved 'mode change' on script files.
Totaling to 478 (looked for logs of only executable files in the repo).

At current state,
checkpatch reports 26 ERRORS (false positives)
with 'hashbang' test we have 5 false positives.

Without 'scripts/' directory test, 
checkpatch reports 82 ERRORS (false positives)
with 'hashbang' test we have 35 false positives.

> 
> It is probably better and simpler to just have a script checking for
> execute bits on all files in the repository on linux-next (with a list of 
> known intended executable files) and just report to you and then to the 
> developers when a new file with unintentional execute bit appeared.
> 
> Keep up the good work. I just fear this patch is a dead end.
> 
> There is still a lot of other issues you can contribute to.
> 
> Just one bigger project example: Comparing clang-format suggestions on 
> patches against checkpatch.pl suggestions are fine-tuning both of them to fit to 
> the actual kernel style.
> 
> Lukas
> 

Thanks
Ujjwal Kumar
