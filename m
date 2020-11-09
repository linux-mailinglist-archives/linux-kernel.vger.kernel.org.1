Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339422AB1B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgKIHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIHYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:24:25 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E863FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:24:23 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id e7so7257330pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lqMYwwMl0ypEimyxNBVna3vHcWpc7jgH7vZyN2G5QD0=;
        b=blIZh/hqJGkQtDcSvMEQ0sS2bCYWiVTFhH5wiuXxfpuVTu9drxOImK5VNQEHy/E8kC
         8elmHPlnfMv7qvz97GoYYeE7w5oU3oY7zLOXoQqteCCfei56Nlz6jcqsuXZYckp2KPAA
         FwSuiHBeNFjprasRknDB79TP6llXm/xoIIuCPsyqW4SOEk4z9NRXMgtxZxnjKGfxk7cc
         OmeO3ZiqVtAOf9rbxbV2hQ9+E68rLwqgF6DTvAEKtIExPPH4aqMEWa9g6LaUbvWXt33d
         vrXlvtLUOLovAPjbdBRfOFWX/h+eFz17xM+m6tr+rLqwjErz6y9N44fIVZVlh8coPDIG
         gcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqMYwwMl0ypEimyxNBVna3vHcWpc7jgH7vZyN2G5QD0=;
        b=f5DSzguUDhLjOJHAUt9cFxp8wQy0mdv29ZPoNvS5Jyw1wr8v/kld/TU7GnybscBhSs
         EXKE5MjojGM3Jmji/l+TZvcaBZ6PxBAU6OtOp94YZjwfttSfRvTnAeWe4OU5wPsS+VQR
         U4v+TC1S+QFLnpPxECJgauu/FNRR3kLHZjwnFvmmaIs6fHhPUaedlep2LFOaLb52frWX
         Fs7J/fhdnWtUJv30kqXYyw3GDOqXU/wcFQFCDM+jKGYVwUohfGKB/w9L6llz8Wo3nNYa
         t+NvPYNPG98muhyWZoYvDC5saSDqq5+4iBcGtC0BOrVsg6zlqCozKYFnXno/VX5uGh+G
         5few==
X-Gm-Message-State: AOAM530R175Tba+gFwpgnBlbX/49OJBFqTmd2xCC7x8hFuHKiY6xvN7I
        CTCIcZ4Ea6BEl6bBYzt/X6kcuagi+hJ5fw==
X-Google-Smtp-Source: ABdhPJydcUYEfCdapfYosHMqKKc2du+YyBB5AuS530hat/9V373/Lh577nYI7mVZZ5C/4iy0V/KCJA==
X-Received: by 2002:a65:4cc9:: with SMTP id n9mr12183722pgt.236.1604906662983;
        Sun, 08 Nov 2020 23:24:22 -0800 (PST)
Received: from ?IPv6:2402:3a80:415:19be:b84e:68cf:38c6:95bd? ([2402:3a80:415:19be:b84e:68cf:38c6:95bd])
        by smtp.gmail.com with ESMTPSA id y8sm10200089pfe.33.2020.11.08.23.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 23:24:22 -0800 (PST)
Subject: Re: [PATCH] checkpatch: add fix for BAD_SIGN_OFF
To:     Joe Perches <joe@perches.com>
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20201108134317.25400-1-yashsri421@gmail.com>
 <e8fef5fbd71331b010988769b249af6a79048f48.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <9a5411a0-0f47-71ef-5dd5-404bf20154e6@gmail.com>
Date:   Mon, 9 Nov 2020 12:54:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8fef5fbd71331b010988769b249af6a79048f48.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 1:27 am, Joe Perches wrote:
> On Sun, 2020-11-08 at 19:13 +0530, Aditya Srivastava wrote:
>> Currently, checkpatch warns us if the author of the commit signs-off
>> as co-developed-by.
> []
>> A quick manual check found out that all fixes were correct in those
>> cases.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -2827,8 +2827,11 @@ sub process {
>>  # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
>>  			if ($sign_off =~ /^co-developed-by:$/i) {
>>  				if ($email eq $author) {
>> -					WARN("BAD_SIGN_OFF",
>> -					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
>> +					if (WARN("BAD_SIGN_OFF",
>> +						 "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline) &&
>> +					    $fix) {
>> +						fix_delete_line($fixlinenr, $rawline);
>> +					}
>>  				}
>>  				if (!defined $lines[$linenr]) {
>>  					WARN("BAD_SIGN_OFF",
> 
> Looks OK to me.
> 
> Another option might be to add a Signed-off-by: line derived from
> any "From:" line when:
> 
> 	if ($is_patch && $has_commit_log && $chk_signoff) {
> 		if ($signoff == 0) {
> 			ERROR("MISSING_SIGN_OFF",
> 			      "Missing Signed-off-by: line(s)\n");
> 
> etc...
> 

Yes, I just noticed. Thanks for the suggestion. Will do.

Thanks
Aditya
