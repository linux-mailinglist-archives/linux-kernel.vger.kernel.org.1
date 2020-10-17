Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D86291492
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439444AbgJQVDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439145AbgJQVDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 17:03:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8505C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:03:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 144so3582610pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BGqMoVrGcwrPOW2Tzp/dvmOPXADUEOQd+KpWuehOjh8=;
        b=zsc71Jioj8CZOK4DHbdUbRdFolMcxYA+ipNjRIsAlrFflzlF0bVovnzP6dz5UQeKnf
         w2YO3dNyQAURNzxYNKZkNOkQEhAVO0pphS16VzHnxNLMkpFD4ilFCwB5Nfre48yvpEzE
         HPrzACv/a6e2me+nhFMoZlI24LaVDvtymjPaLXbzZFHg1ZFrvMLlYpM4CksVW9eWhxO9
         pMqMKv7t69hpt+xUXvE+DhbwVMyz5JggQPNN6reowJz1RhPvtezN0DSFB2AysO7ztch0
         qC53MYXdG4ld1xal0lY1PaG9pm7Q+SF5W2KYpcp9HRJouZoizneGqzr4oRHgyYiHY4DQ
         BeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BGqMoVrGcwrPOW2Tzp/dvmOPXADUEOQd+KpWuehOjh8=;
        b=Y2dCMov8NoOTbZ+OdoWr8fLsljXTiVx8zFeaJDXOWqUlOuuVIFgeAnJl8QLySCtSCl
         cVIxwCczWdbduYxrgPr7MfrA/16Q6jTzZsNmRKEw1oYHnIs2dJD8j7wH1udzu2VDp6e0
         6D1mjfj1I6yobegC9QsNLIRUyrHtFfzNJb4ib1OLOWWlPVznLxPryJb1Ts+uFnLaIVhl
         b84QEqPXnycpTuin9U+kJwFYMvgEUTS4ozyYryeg86lO++zIaWVZeX1UUwWoLL6NmU5n
         QbvLL30C75bp31ZOzBJVkK7zO2kG3l5U5eMTbS5wBjzhOau7sNm1tDAKCYhVsvgrrtm6
         20+w==
X-Gm-Message-State: AOAM533OUiPQB+uKz93PSYxOI7YujtIc2WLey+DgIoT0wyIx0NG1PnlL
        mtE+rCUy0M9m8F9XTf02S+6bTTTwxbRnUJAD
X-Google-Smtp-Source: ABdhPJwvLabICYQUQtM1/QekDbsr1dqroB/guZ996lBDfnT6c6KJqmblSYsRmyOjkzESO1ZixaNpTg==
X-Received: by 2002:a05:6a00:8c3:b029:159:53cd:86df with SMTP id s3-20020a056a0008c3b029015953cd86dfmr10121248pfu.0.1602968602984;
        Sat, 17 Oct 2020 14:03:22 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y137sm7014443pfc.77.2020.10.17.14.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 14:03:22 -0700 (PDT)
Subject: Re: [PATCH] task_work: cleanup notification modes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk>
 <87tuutalre.fsf@nanos.tec.linutronix.de>
 <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk>
 <87zh4lix8l.fsf@nanos.tec.linutronix.de>
 <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk>
 <87wnzpivvx.fsf@nanos.tec.linutronix.de>
 <7e32aa44-35ff-3a48-87d0-8e7df586db1d@kernel.dk>
 <87tuusj2ch.fsf@nanos.tec.linutronix.de>
 <4a2f1a71-3548-1f13-23a4-2f7e73408cf3@kernel.dk>
 <87k0voip1w.fsf@nanos.tec.linutronix.de>
 <ffd90972-d664-b024-f537-8d02f91d12d7@kernel.dk>
 <87h7qsin38.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99a29dd4-b968-c4fb-5071-2fd9b14e020e@kernel.dk>
Date:   Sat, 17 Oct 2020 15:03:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7qsin38.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/20 3:01 PM, Thomas Gleixner wrote:
> Jens,
> 
> On Sat, Oct 17 2020 at 14:32, Jens Axboe wrote:
>> On 10/17/20 2:18 PM, Thomas Gleixner wrote:
>>
>> Thanks! Fixed the two typos, and also included the guest mode. If you're fine
>> with it now, would be great to have your reviewed-by or similar.
> 
> Sure. I assume you ship it to Linus, otherwise let me know and I'll pick
> it up.

I can, I have it bundled up with the TIF_NOTIFY_RESUME cleanup. Either
way is fine with me, so if you're good with it, I'll ship it before -rc1.

> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

-- 
Jens Axboe

