Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71D6287FFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 03:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJIBXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 21:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJIBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:23:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B1C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 18:23:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so5796930pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/sJCsgPrmvx1zlBU6M8v4TR3AdDB8zcW7pSVcNMUnJ0=;
        b=LBsf8YtlE4fcauqSKGpZKwD9r8ECebVGEfAlSm/bRt1yPNFgX3hIUoIC81ZytrW9Iq
         tZekgCxrAQ2MSidZR20ENUi6vIvxL2AkbWEx7t72yrpvXHbnxDhkg1m+MW4qnXvTvh4C
         V6akNy1+c8+zrjI3Co7+aJVhUansdLSbbSjoXmHdnntRmh1VNCk2CpSqNw0OUecyRjip
         yYdNGEnHJFX3M1iSdLUlgPGnWC54KKr6InLvEqlnlp7+WsJ6lbm9ISfnFGefmZ9M2v1C
         IPCbAdJ8qrFak8bZVlkuqUXSLQj6iGPWDTbmKKl2DxffIFGTkaVAa4nWLyTKXg2ebQ7U
         8L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/sJCsgPrmvx1zlBU6M8v4TR3AdDB8zcW7pSVcNMUnJ0=;
        b=Y3p3bJbJx2/CCmqNwgH3Jdyij2g9j6GuXKecSXLeYryF2NA7Xgq3nPIt+vT19r5QID
         U/cUgyL40yIbvu4fZtY/YUF+HPtWJ3n7szeq73i2GOanlD1vFPZHl34CJcIDRkY6OseK
         CWgxcXN68f4jxnblIl4DBQFkqIziieySCk8x9+xUlw8wAHIkyC3Cq4wTiPAvR1RLYbiU
         C98JEAUZViILAlQO7klcQBs8G6kbFHw/dG9Fv+MwPy9mtCzZW4tvj1ebzKVKjB7ENcWg
         N7tjItZIw0C8nTDIY5ntSwSb+WQ3HMbgHwMUPImDN6womfxfKnZWV9drA3RDwHP2Mb1W
         YGZQ==
X-Gm-Message-State: AOAM533Kc7QWQ6pnaX8Y89qDtrN1gJQQxVibkrGJCEIf4xmdAkk4VouN
        vJ20nmpw3fb7FVjGjTBFkPBcqQ==
X-Google-Smtp-Source: ABdhPJx44xaZS+LhtrGY32LuTa5Ur3kdhZkjc5PdW4N0t4veunOByWM7WLihotO1f50zjHTDBGYdtA==
X-Received: by 2002:a63:5a11:: with SMTP id o17mr1323955pgb.287.1602206585774;
        Thu, 08 Oct 2020 18:23:05 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w5sm8999927pgf.61.2020.10.08.18.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 18:23:05 -0700 (PDT)
Subject: Re: general protection fault in percpu_ref_exit
To:     syzbot <syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com>,
        bcrl@kvack.org, hch@lst.de, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, viro@zeniv.linux.org.uk, vkabatov@redhat.com
References: <000000000000b1412b05b12eab0a@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <165db20c-bfc5-fca8-1ecf-45d85ea5d9e2@kernel.dk>
Date:   Thu, 8 Oct 2020 19:23:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000b1412b05b12eab0a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 2:28 PM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Thu Oct 1 15:48:41 2020 +0000
> 
>     percpu_ref: reduce memory footprint of percpu_ref in fast path
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126930d0500000
> start commit:   8b787da7 Add linux-next specific files for 20201007
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=116930d0500000
> console output: https://syzkaller.appspot.com/x/log.txt?x=166930d0500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aac055e9c8fbd2b8
> dashboard link: https://syzkaller.appspot.com/bug?extid=fd15ff734dace9e16437
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119a0568500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106c0a8b900000
> 
> Reported-by: syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com
> Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Ming, this looks like a call of percpu_ref_exit() on a zeroed refs (that
hasn't been initialized). Really a caller error imho, but might make sense
to be a bit safer there.

-- 
Jens Axboe

