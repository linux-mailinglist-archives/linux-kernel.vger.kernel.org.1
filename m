Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5217B29D655
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgJ1WOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbgJ1WN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:13:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9A5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:13:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w65so627480pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gwnayf2MecvT+5s8JJfNOkhG8pZYF6/aAm6DfyGpa0A=;
        b=WRdCdJCaebH5bgPaIQhOnD53UOJdg70cdtkXZGfIXymymGkUFWXOhcyMvlrv8gk3QH
         XJPrkmgU2fG6GpqJb3EL9lEvK3pJl/M7BaZQspMZ5DvCKKT1FEpn0ypiz4vfCIWHlrMc
         4qXIchkWd86YiODOrIRH4OuRDyb2ZVF3rqW18Gnmishi4EBEHKGqhIVozpl7EUuEGrey
         DPlRlB9bPRlulrnKtTJbb4qTQ9aj9pU1KFYVlYpSuQSjA20bk8jmI6tVCiRIn1hg5ohm
         kIsQmUsQ5lLucng7Hw46mPqaYkDLpMUnX7+rDp4DLgFySQI8sJUHXO8lvMumk0DGCp7G
         c4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gwnayf2MecvT+5s8JJfNOkhG8pZYF6/aAm6DfyGpa0A=;
        b=uSEB+Afk10LfqMJ7WS/uTeGZqq1h9PvshEc2U0Yybyz/AhJ5G8dAGHtAYkWhV8hjkW
         UrKN8Ej1bASKRtB6AdXofVna1J7pWKTCXJ4kOsAcv3Td/v1xHPOR2/waxEZ+cQmsHPtw
         lkXKuZP8f/T5k6IBnLWhfVXvO02GWcA49kHj0gKQQwA8X51ocueOJAU73Pcod4GEQEP9
         1S4gfkDp7tUuDJU4FJuCXr+Wbol1dNuwEcu5X4R6oYQZYfEgHhhxMj9h1/z7RNNPDH7d
         e62pwDogFLJpwIyUdONebEnUqnhikiWlLa8EaCI7B6KVNQgUOEsLnQAgubHucyjTGz5k
         95/g==
X-Gm-Message-State: AOAM533WYosWoP5JpJDZMYXlLVU14sZd1mVaeQktYft4hMs2Ors9scdJ
        pycpfQFGwTrJxO+/uM97xWS3uXBjy2y61Tca
X-Google-Smtp-Source: ABdhPJx7+AEZUMe/EsIWyfYB5EYL402/n/2TUFC/pw6DyMAI8l7Fu1l1s7kGjxT1nPAj+GaH11JRIg==
X-Received: by 2002:a63:7408:: with SMTP id p8mr414749pgc.273.1603906958000;
        Wed, 28 Oct 2020 10:42:38 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id ng7sm47242pjb.14.2020.10.28.10.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 10:42:37 -0700 (PDT)
Subject: Re: WARNING in xfrm_alloc_compat
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        syzbot <syzbot+a7e701c8385bd8543074@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000021315205b29353aa@google.com>
 <20201028104509.GB8805@gauss3.secunet.de>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <86a1f30b-388f-6760-b59b-349d2d8b0d8c@arista.com>
Date:   Wed, 28 Oct 2020 17:42:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201028104509.GB8805@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 10:45 AM, Steffen Klassert wrote:
> Same here, Dmitry please look into it.

Looking on both, thanks!

> I guess we can just remove the WARN_ON() that
> triggeres here.
Thanks,
          Dmitry
