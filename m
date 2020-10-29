Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01BC29F815
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgJ2Wc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgJ2Wcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:32:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:32:46 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s7so5423655iol.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6XztGCZRt5A0usmhyuoZs86DEqCkXEdFp8vHyXCDEWQ=;
        b=D0LRm+pzmZq/nQ+lBZVuYJGnQT2nlMbokQbXZAwwpc43BFjWt3Xn39+EuCVcyq5QEC
         rHkCzHxWYgU1ocQ7QB5FRxq9OuPkCiRIjukO/slUMeNRzgshi01eqrQNiS/FbTMldBoa
         KV9qPjIMKZjF3gQvcgylWRhhkr0QGgUT1qVxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6XztGCZRt5A0usmhyuoZs86DEqCkXEdFp8vHyXCDEWQ=;
        b=Rj8nu2+ELoH7XgVnlW46xLVYIDpSX+WUGPGo0FJAO5pTGXd3NXYdbKviaq551dhJG2
         jEqieQMlgLM/uC2q0v5LCI+vSluSXC5DDdhq1Pi2nfocX4s3G7BEnh8so/It+Ab6QshU
         varAX7Mj/yuLwNr4hGZbCs8KXVemWjrB9wEN27J8d38NLyNk7rX9jTObssxyZnSre6su
         GUzas2MQQhJ5aL8wNw1mrgTDhgD9tNYb+/2GGR58uCxxmhyDRSaltBwYWyFswGy+j2YC
         dbGDjJIw/OEC5OUjeQoVCYUapJG5eGjvcpgdZOMpwBy0+XG3dhq9MJmuNSkfN5QOrnp5
         fKfg==
X-Gm-Message-State: AOAM531bxUmMMlIvl2PGhBUNduYJi4E8kozGnNkzAEj0Luj4TH3WbqBQ
        9waYoe5lo1OqGap8WQIHhm0BEg==
X-Google-Smtp-Source: ABdhPJxKschXmJbQdhcb24ydYYi8j/PZKEMmao+aUIGVI6GDyNm3EDrWX1XdPNtwzO+TkDu56va6Yw==
X-Received: by 2002:a5e:c248:: with SMTP id w8mr5393217iop.132.1604010765616;
        Thu, 29 Oct 2020 15:32:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l4sm3062134ioj.41.2020.10.29.15.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:32:44 -0700 (PDT)
Subject: Re: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201015144603.27933-1-bp@alien8.de>
 <20201015144603.27933-2-bp@alien8.de>
 <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
 <20201016083754.GB8483@zn.tnic>
 <ca53e90a-f4eb-5007-a137-62729e3d74f0@linuxfoundation.org>
 <20201029215929.GF31903@zn.tnic>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e0d61fa5-03b9-1761-1578-f4fb5ce54d96@linuxfoundation.org>
Date:   Thu, 29 Oct 2020 16:32:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029215929.GF31903@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 3:59 PM, Borislav Petkov wrote:
> On Thu, Oct 29, 2020 at 03:38:43PM -0600, Shuah Khan wrote:
>> All of the other ones should be changed as such. Why add more?
> 
> Because a patch should do one thing and one thing only. So a separate
> patch which converts them all in one go should come ontop. But if you
> insist for the ones I'm adding to have error handling, I can do that, of
> course.
> 

A separate patch is fine.


if (numwritten < 1) {
+        perror("write failed");

Please add filename to the error message.

Thanks. Since this depends on other changes, it can go through
tip once this error message change is made.

thanks,
-- Shuah
