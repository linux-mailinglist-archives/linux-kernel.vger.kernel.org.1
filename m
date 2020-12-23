Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528B12E17F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 05:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLWEFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 23:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLWEFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:05:03 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A1BC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 20:04:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x18so8488709pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 20:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=cn58q9KeE/RU2XDvOxFGGOuHBC6aWJ/EzGUBfwiEmQw=;
        b=fc4pGtThcYUqUumDa0iLH8hbA9TqxgyvYZ84AY47qHijmFkEvwcdJi+1Ef4GwHbmpZ
         jR5KPScyf63x8djUX09npML4sBV+0doz5zBPObFo1TRqyVWasysWN6QkKVRey6PFGYmL
         PKyuQzIBO/3m0tOkLjY6I370W0tFHWDVCR/osshBgM03CL/tjUMSSuyRRGKNH47brVxz
         FebKVJ8mvol/bWKteFVYx1V1wu355sIw+NZFDDMiZJOB6YxYGLbfijMc+frCiK5jCyvr
         Qpf2bVXChs7LTJydAIxGGAHkzWM3WfuylDny7mZxKxrTHFBZYrBM7Uoja8QKn6he4WN4
         6KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=cn58q9KeE/RU2XDvOxFGGOuHBC6aWJ/EzGUBfwiEmQw=;
        b=NTFKGUaik7tV934tpR4yAcMef97u3SIX4/hIkFm7rnzR8NLTNRJ8U/UAD7YGqS7Vwf
         8MTprxKl9zROcqIVcBYpWFBdqO/zPSshjkRsVUPj7CVf3KQ3QkSvJqjY1t7lDiyzzGFu
         vwjc3E07Z0N3g7A/s6aQ1W0TT1Cr5yfSKW2BG3fWiNfEQfkWtyOq1CKFmkXxKh29+x+T
         oeqnZFTkzAD2BffnOoT2LQLgJifH28x+DNwMwfhWLMPFumJ67IauFnXEezwbIB6BPx95
         /bGlXzcN7LdWZ6uAdKAVSjU5PqbBu/XQYw3z1kuq6EgYfkO2ZH1qsUl5n02q3rpdpi6U
         jP4w==
X-Gm-Message-State: AOAM532Ndh4iqqRVCQJhKMrApKfl4NIjh3JC6rTb7INNRprgcUVZoeaJ
        4CIyPom+OjN75aCAfZKamXOv5g==
X-Google-Smtp-Source: ABdhPJyFPXkHG7iWjJmlqktQzjuKaGiXFJm2WnsQlayQ/oQsyG2xEm33F7FucnWUyHmTjCs7hDiNjA==
X-Received: by 2002:a17:902:9a90:b029:da:ba07:efdc with SMTP id w16-20020a1709029a90b02900daba07efdcmr23831204plp.1.1608696262931;
        Tue, 22 Dec 2020 20:04:22 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z5sm21767236pff.44.2020.12.22.20.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 20:04:22 -0800 (PST)
Date:   Tue, 22 Dec 2020 20:04:22 -0800 (PST)
X-Google-Original-Date: Tue, 22 Dec 2020 20:04:18 PST (-0800)
Subject:     Re: [PATCH] riscv: return -ENOSYS for syscall -1
In-Reply-To: <20201222162219.GA710211@cisco>
CC:     schwab@suse.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tycho@tycho.pizza
Message-ID: <mhng-866c451a-5886-441b-9914-acc31fe9dc71@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 08:22:19 PST (-0800), tycho@tycho.pizza wrote:
> On Mon, Dec 21, 2020 at 11:52:00PM +0100, Andreas Schwab wrote:
>> Properly return -ENOSYS for syscall -1 instead of leaving the return value
>> uninitialized.  This fixes the strace teststuite.
>>
>> Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>>  arch/riscv/kernel/entry.S | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 524d918f3601..d07763001eb0 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -186,14 +186,7 @@ check_syscall_nr:
>>  	 * Syscall number held in a7.
>>  	 * If syscall number is above allowed value, redirect to ni_syscall.
>>  	 */
>> -	bge a7, t0, 1f
>> -	/*
>> -	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
>> -	 * If yes, we pretend it was executed.
>> -	 */
>> -	li t1, -1
>> -	beq a7, t1, ret_from_syscall_rejected
>> -	blt a7, t1, 1f
>> +	bgeu a7, t0, 1f
>
> IIUC, this is all dead code anyway for the path where seccomp actually
> rejects the syscall, since it should do the rejection directly in
> handle_syscall_trace_enter(), which is called above this hunk. So it
> seems good to me.
>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>

Thanks, this is on fixes.
