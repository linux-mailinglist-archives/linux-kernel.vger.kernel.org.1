Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E402A09D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgJ3P1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbgJ3P1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:27:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F1C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:27:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s24so1059330ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kT6xj1Vg1avCvf83jif61+Gcst08Py5XBYy759x7DZQ=;
        b=hoPtNwVwt8sdIwotEDaBeeIXbIOm5ZiWEWDawiGxpt/NONLxZ/I2IclmI5xNNZbyh2
         2gFiBu2DLhjDzMmnCB+XXY7sY9v1Fs+Jhm5lU7zq+gqDQo5id5TJXmpM4esrP3MO+wfe
         TDjxcCX9ddrFrHZ4UzlAnmogHTkvQXMoSs1AIYEODIYhJ2ygJfs2cpMiav7qTG1K27L9
         XDttUwfL0qOtq7gBRN/Zc8A/63k+tKCfq0WutbskBUJxe12etltVvsNqkB9wNLgfzs+3
         z+F4vS7SBGdoiEyOtqvRSPdt8rf9FwALBIbVyChZuMS8IiG79MGSBl9AZSFhwnSptKYU
         x1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kT6xj1Vg1avCvf83jif61+Gcst08Py5XBYy759x7DZQ=;
        b=D2BXiIZWQHJm9zajH3hJLIujs6ddKx+Mgx6wYSBv5XiURdTKu2b0wEQVbzUHck1ojy
         Ew5UZ0chiYCo2VUZ3NovHDApE0xiG0fftgJ7l0nvJMhKVS88J1CSNIn7tordKyBHRvIj
         iT+xMf7dt07p1MzfdrFyBDERCHGX2XeSNMrCEvxXFkdaDINZPIZlknTQoj3dgHqPIlSh
         /OqB0U7rKGAxkjsoXLrlVaEFnw4+v/ql0N39fe0J3xI1deFTLirnv0J9q/jWGoYoRI8q
         o4uZnxYFy/zwF9wwsXbLWglPy8LGacIbatDO5UfaAcINXyjGMjIhBGbe1ZZnSgyMI/68
         594w==
X-Gm-Message-State: AOAM531Zh0hMc6EoKsYZvURVMUplj0H+1ypd79mPGwLLcBtF4DZPgJZ6
        hfnldNh6/hZA0rTIHuNkB3jmnHlw6t3RVA==
X-Google-Smtp-Source: ABdhPJxHqoZ5EhicbB7dSv8JmLiPqTdqwE5qEr5k9JRdHSPGfwBtOeIMnDWtk0kttP7u4LsHsJ46sw==
X-Received: by 2002:a5d:9850:: with SMTP id p16mr2277072ios.22.1604071642324;
        Fri, 30 Oct 2020 08:27:22 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t16sm5953083ild.27.2020.10.30.08.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 08:27:21 -0700 (PDT)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     Qian Cai <cai@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <251c80d6-a2d0-4053-404f-bffd5a53313e@kernel.dk>
Date:   Fri, 30 Oct 2020 09:27:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030152407.43598-1-cai@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 9:24 AM, Qian Cai wrote:
> We will need to call putname() before do_renameat2() returning -EINVAL
> to avoid memory leaks.

Thanks, should mention that this isn't final by any stretch (which is
why it hasn't been posted yet), just pushed out for some exposure.

-- 
Jens Axboe

