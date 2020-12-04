Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61BA2CE896
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgLDHXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:23:31 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46701 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLDHXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:23:31 -0500
Received: by mail-ej1-f67.google.com with SMTP id bo9so7170409ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YbvrdMCGT/u6kG4WJ/a1DSh9axcC6fuN1vH08BPbxJc=;
        b=sRTnUO0iMwDU+rzqauvOy8NVMtOeh+pbGl60jJWN8P1wDRqbUDvi03WTr3yxL4qYhy
         uXvRE6rP2LOdNr4G98EXLhAFnRDFawNi362DHoHO2BN4fAbW/iUW5YTTYH0ugdjgAtir
         L2JNM4Dq28vjSrPXhoRi4BNRJUgBPvEePlGGJcKe7U7bIqfqgL837dRURdQnQsQqyllT
         sirQ+ykm7zcXYn8nxVERuSfX9+lJjU8YhBRmu/Ok9kDcLPq0AlvY4CJln7bmQLquKsQu
         jtLxyJd6V67gLB4AM32/MHCY1hNhzcaLBRz7UaRtn94gEIEuVsmww7hUBEpS55B0OfhU
         A+pw==
X-Gm-Message-State: AOAM533CY6xuGN1QxyGP8g3qAlvPyWmsVAn4d/R3MktvJCJREaYdhbJP
        ZGnYVZSNoYlgo9wMQhlQ37EmFUpj2VZ+LQ==
X-Google-Smtp-Source: ABdhPJzXs/Hnj/mPdgxm983mIrQO8KWD5SzzIqlihNolfTBBnp8aQZuOhiBT3GePDYc4DAc+G/nXpg==
X-Received: by 2002:a17:906:f05:: with SMTP id z5mr6042255eji.8.1607066562737;
        Thu, 03 Dec 2020 23:22:42 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id v18sm1241626ejw.18.2020.12.03.23.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 23:22:41 -0800 (PST)
Subject: Re: [PATCH] tty: Remove dead termiox code
To:     Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20201203020331.2394754-1-jannh@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
Date:   Fri, 4 Dec 2020 08:22:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201203020331.2394754-1-jannh@google.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 12. 20, 3:03, Jann Horn wrote:
> set_termiox() and the TCGETX handler bail out with -EINVAL immediately
> if ->termiox is NULL, but there are no code paths that can set
> ->termiox to a non-NULL pointer; and no such code paths seem to have
> existed since the termiox mechanism was introduced back in
> commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
> Similarly, no driver actually implements .set_termiox; and it looks like
> no driver ever has.

Nice!

> Delete this dead code; but leave the definition of struct termiox in the
> UAPI headers intact.

I am thinking -- can/should we mark the structure as deprecated so that 
userspace stops using it eventually?

-- 
js
