Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A484826F765
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgIRHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:52:15 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37519 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgIRHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:52:14 -0400
Received: by mail-ej1-f67.google.com with SMTP id nw23so6829405ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVeD4AgSLUxv4KbwXFJdFh3q8zmR7ZKG7yv4OBGE2SU=;
        b=hatu5MIQ8AuJyT2jcV3xumi/8krlZNTvOioZPEHFgfQ07hJKXigz4+U2XbTUvAZiE5
         HmNwJ5LNjW4j5e/c6b754Crw8dFNSVwQTMh3GECV3XrD0C2kwY7RULHE8g8FthIhRMMo
         1a4CeRbqRKnTwFma7r2BxRe+rx6lN5sXPU/e5wCWfGgvEpVPMnpidA5NxInkBlR8w6q9
         DEUg/j63+pzRiKX8v3+Urp4P9QsAQr4RdhIrEtgZwX9bb90Km6V291hrU0qPr5g27Z34
         vj7jDLFAQNRGELvOIwWnwMTRLibRFlsEjPy85/++yhACGBOFDNJcIbnyqVruOTaEYQXy
         NG8g==
X-Gm-Message-State: AOAM531S94fdYLW0chdT2+lufZ8g2FvUe8MIvY4FbAuAMUh5k0rzvVhT
        E83ngEB/fqDrFqV5Q5QludrxzySlUBLgvw==
X-Google-Smtp-Source: ABdhPJy6O0InFIHrkL+jLqMkKAkedMjP16RyAufGrj5CbO1nxlr9W8/RBqwBZeRjLo1od0Qdn6/4Yw==
X-Received: by 2002:a17:906:54e:: with SMTP id k14mr34810091eja.59.1600415533126;
        Fri, 18 Sep 2020 00:52:13 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j20sm1652378ejf.27.2020.09.18.00.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:52:12 -0700 (PDT)
Subject: Re: [PATCH] vt: fix some doc warnings in vt.c
To:     Xiaofei Tan <tanxiaofei@huawei.com>, gregkh@linuxfoundation.org,
        nico@fluxnic.net, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1600415225-17736-1-git-send-email-tanxiaofei@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f03ee775-8a49-f1d0-b28b-73489f5b8be2@kernel.org>
Date:   Fri, 18 Sep 2020 09:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600415225-17736-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 09. 20, 9:47, Xiaofei Tan wrote:
> Fix following warnings caused by mismatch bewteen function parameters
> and comments.
> drivers/tty/vt/vt.c:3994: warning: Function parameter or member 'vc' not described in 'con_debug_enter'
> drivers/tty/vt/vt.c:3994: warning: Excess function parameter 'sw' description in 'con_debug_enter'
> drivers/tty/vt/vt.c:4051: warning: Excess function parameter 'sw' description in 'con_debug_leave'

It looks like I fixed those in
https://lore.kernel.org/r/20200818085655.12071-6-jslaby@suse.cz
too. Could you rebase on the top of tty-next?

thanks,
-- 
js
suse labs
