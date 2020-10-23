Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC132967F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373800AbgJWAa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373792AbgJWAaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:30:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96A6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:30:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l18so2108874pgg.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l3qcvdtan5dRvVPenI5CllkZ6Ty3UdDPZyBIxdORfFE=;
        b=L+oYxbd6BfZRhIxnb3+SepAKFoG0NtpjVRy8NAR9HrfTHZ88C9L+22i54mFhUZFen3
         saw8Gc+xc6SaqhdhGtzN6DyAhlKu4Vr8nx/xAzPRuWdHLCs1S6r9UV9Gg5IJ0fGmOnZz
         zLBI2jHn2uBLs6Q5HJ9aBTRPgXqaX2bX6yQu8zYG4UtBGQ4e06xNo2OJUZ2Kkpf48ZBI
         9mylobKBvOICOkYktb6CgDu8bkW2BEhJa1sPmhPsVoMHBIwhbGpvgbSCx3K3nadWUUjw
         T/UOEvQoplSgkeCVV39lrPwPg1ahaiDg9Dvtk2VqnesqGbglDjielZtGsAUkL6w3z/rn
         OaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l3qcvdtan5dRvVPenI5CllkZ6Ty3UdDPZyBIxdORfFE=;
        b=tlQb3vsWxVMmG33v9CBALy5r0NHxsiSw66aQNEX42ydKR4PsaYY35hLLYUD2kh91ZM
         rgqdSJHEYdK06F1y1yMkq2xVJE+iyKJlm1fALIMCzJC4oDISTAzubUGnlk1qjmvxam60
         ogwngMRCGie/K2TiIPf9LbNQIgZ5fzuyjOvzfWT2SonUxbSXm5ZeX7lTxSTrKLEfDupN
         rdDT0hgSIJnLyS2FDL+nnrdhQ+7574CBs3q1I5kPaO7IJXPnijnVTgtINzNQEMzK+Fs4
         73lQ7gRlC2mnZICa37oGGrt1GLabUl8GJDAzwbjdJyjfnRerCL3RviiH76IyBPDa5yy9
         JmAA==
X-Gm-Message-State: AOAM532x+JM7XFWWON61r4VOX+QtAKKEaS23VbDt8KshqjD9l22wjm4R
        LGi1hryzMojEUdiAT7D5W6StHspTjMj9mQ==
X-Google-Smtp-Source: ABdhPJzRn1L8whkpveiSYUzNPhqhdmqk0fgt0PRA2LFodj6Qd5PrePl3B6VZedAGMunmN3idimZLYQ==
X-Received: by 2002:a17:90a:c28c:: with SMTP id f12mr4594071pjt.146.1603413055146;
        Thu, 22 Oct 2020 17:30:55 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id hg15sm3089785pjb.39.2020.10.22.17.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 17:30:54 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201023104840.7a94077e@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9e12abf-4413-bca9-e8fb-bbfcac38182d@kernel.dk>
Date:   Thu, 22 Oct 2020 18:30:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023104840.7a94077e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 5:48 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (KCONFIG_NAME)
> produced this warning:
> 
> fs/io_uring.c: In function 'loop_rw_iter':
> fs/io_uring.c:3141:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  3141 |    iovec.iov_base = (void __user *) req->rw.addr;
>       |                     ^
> 
> Introduced by commit
> 
>   a5371db1e38d ("io_uring: make loop_rw_iter() use original user supplied pointers")

Thanks, not sure why I didn't use u64_to_user_pointer() in the first
place - updated now.

-- 
Jens Axboe

