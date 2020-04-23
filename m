Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73AA1B5FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgDWPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729176AbgDWPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:47:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706FCC09B040;
        Thu, 23 Apr 2020 08:47:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e26so6933625wmk.5;
        Thu, 23 Apr 2020 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gexsfzJrWQOn4i3Pq7SNyCJbao42w3cesdQKpJpl5r8=;
        b=hrwao3YwPmfTB2ywD7Jch6LubuZqoTMsMePjZGu0bDegj53Uu4CilC25U98EjqH8Uq
         f4+98L+bniHA0DwjGKutR6f3EqykCxgTLKmp1ve2FvOzJ9kr1JzFh4mXiabgJzCH46U4
         3tz+5skehkyqQO+ZJ6HeiT3axwKotBq2ezejAlsTj1mr+sqTobtdiVyfyBPxoQzJ4ly3
         2ZoVgQL/HUg4F6nPQDr8Ykv5IzZwZszZX9e2Rs4xLeaIn0+f7Itjk4kaPMR9VkpcBgWP
         9N4AUDqO1Qhrlao0siWFf5xP8hLgzDxiJR9vQ5NYMaFxctPukkacxm6YpvrWXHc7FdU0
         zbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gexsfzJrWQOn4i3Pq7SNyCJbao42w3cesdQKpJpl5r8=;
        b=QbdwVYy3axavP4QuEsSqOaYsUIYEpgQJzbVzTpdnPT7H9WoPU8G5Tl5TkzdSFRC92b
         eyvKOS+vlq2zFAm/B96rehGRLP6Hu2YEu9Ln4QlawaST/FJdf262sdWV16THV0SYrhOi
         2oX3Fpuldk9seCAw/wuyzbh9tGGMx9XY8B4xt5AptAjG4Iap+3T8WrhwqWK22M/tOmZQ
         kNOEmzYDPulSdxHAp00xxht2r6Ru6OZ+7XCCNeue5yuCmLsDerWjxNUGp8TrlpphIKxM
         xlYqxd94XQcGgxEgygza0b38HDkO5h//LEDl9YZDFrTo2AI55gXT+HxtDTDiIulPPHC2
         1VmQ==
X-Gm-Message-State: AGi0Puap7o6mQC0tgcZEzYnrxXw5Gf0AaT+QimaYyoQyhEa3gUCa31+4
        VEZQ6tJlx1SITRwcMJP08LbawiA2
X-Google-Smtp-Source: APiQypJAhweB5DTJ9gVc3XAzKWIz4J2EmUXYFAeqSON8LkVyBJRSY8a4TlgTT3EAPufV9JrRElWatw==
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr4819878wmt.98.1587656819721;
        Thu, 23 Apr 2020 08:46:59 -0700 (PDT)
Received: from [10.230.188.26] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a24sm4072415wmb.24.2020.04.23.08.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 08:46:57 -0700 (PDT)
Subject: Re: [PATCH -next] tty: serial: bcm63xx: fix missing clk_put() in
 bcm63xx_uart
To:     Zou Wei <zou_wei@huawei.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1587472306-105155-1-git-send-email-zou_wei@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4d5b3f7c-e516-2a4e-3594-1f8f705c16ab@gmail.com>
Date:   Thu, 23 Apr 2020 08:46:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587472306-105155-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2020 5:31 AM, Zou Wei wrote:
> This patch fixes below error reported by coccicheck
> 
> drivers/tty/serial/bcm63xx_uart.c:848:2-8: ERROR: missing clk_put;
> clk_get on line 842 and execution via conditional on line 846
> 
> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")

The driver was doing that prior to being moved, and since this is an 
error path, I am not sure the Fixes tag is really warranted.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
