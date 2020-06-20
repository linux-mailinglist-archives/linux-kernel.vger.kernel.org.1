Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102032026C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 23:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgFTVTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 17:19:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44718 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgFTVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:19:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh7so5629168plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=25eSrepyVILhrv7XgPWvBbKHc9Y423BPGYOb7vQWjWs=;
        b=t/Am+hFLmddRtCKiXi0HbUHiPvo3BwDUiHiS7fW1vmwLBIr+dyLNnWTKqSTGvW/t41
         aK4swZ5bkA/22fovt5YvZ/ax72Zzd1mSdWWpP7CYOPx/B08WSIQExrzQEwBIIsXOUZwR
         KZy9FMIclUUsq55bLNqYjSGKckeCTZWE9H4m2L+qfIuGTRP2IgD5FYvo/jkbqo0n5sw/
         sB7rlC0H55rGS7hVSpHlb/d1x/4N1cftR54gNfOTHHqzuSss/BnGFjGqF8tD6opKiCbT
         bo2AmTJwOWE5mf/K8Wa6r87Yp1loNPlH3VT1RLHmpq3LY3dw9fhJFFIDvabWlAlgD3dR
         H29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=25eSrepyVILhrv7XgPWvBbKHc9Y423BPGYOb7vQWjWs=;
        b=Xm0YsHnu+uRBWB3sIM/s/VzJQ0A7XCesO4ZrPYExaN1xq+QEpLoeoxn2X8w1GvwOTn
         ZhKkrXxZQB88BSiW+KZ5qcXbwJsrA3TF7bqwMPqS8bYuoVHQjj6tsWs0sKi1fWnYDRbx
         BcEPTQMoXm3rAofOAEFQx/P3/515DmDgDXOUGD63fu1ue31/Sg6maHirZ5z7a/uEUWGx
         Ydbx2fkRWAK6LcdgiEzfv4RtndwvjNfwRBZTdwAA28Df9wGbTVADIkoix1l/1waRvmL0
         Oi0grKBfy4hggiVgSUU4lK9jpv7vN+zWgFOfyYXB2tTDBjSoDiWzu/U1xNp5MtpW2Thz
         qBOg==
X-Gm-Message-State: AOAM530hEF7zWlUDa0L1ItCphIWT5mtQB+66BMMTC+R51aVOYsfnHak5
        JNmfDBxyEpm++k0Crj00inIoATsTQuA=
X-Google-Smtp-Source: ABdhPJw6HucljAEvnDkOHfNh65rF9/hxbjXXyREwSSmUNEASTpR9xRKv8GzwdP0MYN2zYK/4mRcMAQ==
X-Received: by 2002:a17:90a:3b09:: with SMTP id d9mr10818806pjc.225.1592687908863;
        Sat, 20 Jun 2020 14:18:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d2sm5301327pfc.1.2020.06.20.14.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 14:18:28 -0700 (PDT)
Subject: Re: [PATCH v7 0/8] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200619204730.26124-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d2ef645-9790-21b9-51bd-de7987158c78@kernel.dk>
Date:   Sat, 20 Jun 2020 15:18:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 2:47 PM, Luis Chamberlain wrote:
> Its been a fun ride, but all patch series come to an end. My hope is
> that this is it. The simplification of the fix is considerable now,
> with only a few lines of code and with no data structure changes.
> 
> We were only creating the debugfs_dir upon initialization only if
> you had CONFIG_BLK_DEBUG_FS for for make_request block drivers
> (multiqueue). That's where the UAF bug could happen. Folks liked
> the idea of open coding the debugfs initialization even if
> CONFIG_BLK_DEBUG_FS was disabled, given that debugfs code will
> simply ignore that code if debugfs is disabled, but to make
> the fix easier to backport, that shift is done now in another
> patch. Likewise, although we were only creating the debugfs_dir
> only for make_request block drivers (multiqueue), the same new
> additional patch also creates the debugfs_dir for request-based
> block drivers. That *begged* us to just rename the mutex to
> clarify its for the debugfs_dir, blktrace then just becomes
> its biggest user.
> 
> The only patches changed here is the last one from the last series,
> which actually fixed the UAF oops, and that one is now split in 3
> patches, which makes a secondary fix much clearer.
> 
> I've waited a while to post these, to let 0-day give me its blessings,
> both for Linus' tree and linux-next. No issues have been found. I've
> also taken time to run blktests prior and after this series and I have
> found no regressions. In fact, I think I should just extend blktests
> with the break-blktrace tests, I'll do that later.
> 
> Luis Chamberlain (8):
>   block: add docs for gendisk / request_queue refcount helpers
>   block: clarify context for refcount increment helpers
>   block: revert back to synchronous request_queue removal
>   blktrace: annotate required lock on do_blk_trace_setup()
>   loop: be paranoid on exit and prevent new additions / removals
>   blktrace: fix debugfs use after free
>   blktrace: ensure our debugfs dir exists
>   block: create the request_queue debugfs_dir on registration

Applied for 5.9, thanks.

-- 
Jens Axboe

