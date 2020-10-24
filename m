Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905D0297D1E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761236AbgJXPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761217AbgJXPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:18:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED5C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 08:18:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so2537149pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9apYr1PnAcamgaBsGfZvO0Dx8QTS9EhAuIzo4V252PU=;
        b=JJsQ63TzEPMQsm+f1CGaEkqtrMn8ccgK20jvLHrXjIY5chY3D8EOEKBvChZtvl1R/L
         FeDbq3j3NqcmzYKIOy2etgyICTZuUr9aBhzGWzWEo7SxN7xtGPLEZi/UyJ+XKlQxkeQJ
         db+viWz7xXm0MzHWrDF+xeFXgKafEX6Js3QT40TI3P4+AopV7x3FcAJHoWhD7RwTIJQq
         HLKHSvSgzojeN9L0NFgtyWG7sY1ZtVb5CTAzfCDqdCbKs/9uXlSZdTbLJ9BwM+nrjd0n
         h1WF3ShooMxpRMcYxcCXFSeE3YtB4zJKWkESUsPKHojMl4siwOIs3mQsYdVDYVyixYK2
         TOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9apYr1PnAcamgaBsGfZvO0Dx8QTS9EhAuIzo4V252PU=;
        b=L3eromcGGjPRJJiqIC89fLQWd+XAeQjJRSnIScFRGTHa/4aeYU0rcuneWeGeH98FK3
         k6+QlcyT+M6RBia9B5wy/1uO3lwbHRlGCc5QHC1VOo2Js1JuSd7n5BToRZlrjyXH49qk
         VZpz1EXGQrLoIj/Wcvgk8ZdW7+bxfNqVxvG/vCvEV5OfezNSUpYNfOcEnQMQrNjfX0qC
         kNiUP2my5+Bx8MgCk0oLgnykqHFcxWV7dTX2zEmKPPGq9Xt1wjiNpOzh/e2jbQN5momz
         9rFPA442AD5RqIHUR3eiZ8xVN0RvqMKLK7SFSdw296Blnpy6wuKfreH2c2dWapYC8Rd1
         exbw==
X-Gm-Message-State: AOAM533qAaIwIU6xIC0GTC+aYhwxlhNJNLx0GJk9cFf7DYaQkFnQR5do
        4mb0u6IudKBCwQ5oT94QHf3/6w==
X-Google-Smtp-Source: ABdhPJxkDmRJ4odIPmUCWZQCfEU1rUSF2D4jGG4cPtQymExfV59gbdRXPXb1y1713+NLBh5cAbhwWw==
X-Received: by 2002:a17:902:a612:b029:d6:6ae:4d47 with SMTP id u18-20020a170902a612b02900d606ae4d47mr4203461plq.50.1603552718220;
        Sat, 24 Oct 2020 08:18:38 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v186sm6098580pfv.135.2020.10.24.08.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 08:18:37 -0700 (PDT)
Subject: Re: [PATCH] KVM: vmx: rename pi_init to avoid conflict with paride
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20201024081024.2798990-1-pbonzini@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <224b8101-6829-0948-864a-95c403db3b51@kernel.dk>
Date:   Sat, 24 Oct 2020 09:18:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201024081024.2798990-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/20 2:10 AM, Paolo Bonzini wrote:
> allyesconfig results in:
> 
> ld: drivers/block/paride/paride.o: in function `pi_init':
> (.text+0x1340): multiple definition of `pi_init'; arch/x86/kvm/vmx/posted_intr.o:posted_intr.c:(.init.text+0x0): first defined here
> make: *** [Makefile:1164: vmlinux] Error 1
> 
> because commit:
> 
> commit 8888cdd0996c2d51cd417f9a60a282c034f3fa28
> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> Date:   Wed Sep 23 11:31:11 2020 -0700
> 
>     KVM: VMX: Extract posted interrupt support to separate files
> 
> added another pi_init(), though one already existed in the paride code.

Thanks, works for me.

-- 
Jens Axboe

