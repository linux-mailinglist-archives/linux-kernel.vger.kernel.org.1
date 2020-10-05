Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17430282EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgJEC4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJEC4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:56:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC49C0613CE;
        Sun,  4 Oct 2020 19:56:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so5850385pfk.2;
        Sun, 04 Oct 2020 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dirGnVPf2i66e1jV8+bur5d5qGdewqbGOauFFeBS8hs=;
        b=FIntiKy2la/Zmb17ErzIl6224ZGn5giSkEiJZZaj3CjmZDe933YyqUIJdASKoDx5AU
         a7I/mlpaPpkEN/lFBe6aBh7rMhIItJP+jHmCQlPFEAYPHf4zi0PP0XwZXZKTW2PiD3tW
         MAfTorOJC2/dlOWUokhODtcRKcuCdlifn8LjX1jA6yVsfmPHBYrJomK5+6bgTxrAoYx5
         KCflEMSmHmbnp514HrF10Gcl/k2UmWoAXP5mYNgBzEbWwAvNTRasasbg3vhUp2Hn1DQB
         d7fzH6usSGBFDu6REGoa1mhodd8MdFmGGa2R8Tj4ZhbLXzJORps+UQzu2Enne9kK3mfu
         HnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dirGnVPf2i66e1jV8+bur5d5qGdewqbGOauFFeBS8hs=;
        b=alUGVxMHpT105R16wo5Dejs27O4e2FaLxZRL9cWi5gMIXgHfgQ3W8bxAKSxNbJJhyO
         zvqv4y/wwX4I6Yvs2Vmq2BdZExPwtoypFeOkgJL+4qbsIvzp6FBdiGkSygKyr9QTV0Pt
         AFeAPl/CPoaxx1a+3/6lPzzA91sQPUpuT0b2LRDzSPaq7Kk1LwSZCyg3fZXgxIryyj8W
         V67w8K+x1PGpx2PJHr5gPi53flyXT2CUxrp0d80JDdgTZxIiMzxFv7PdrsHPBmXGD7gX
         Tcw79ieT9ikcKXlzanQ5RGL5M3xfwhm5dwiFyEcMcrshNZSQyRObM2p7GBAz7UoxXUdi
         nPMg==
X-Gm-Message-State: AOAM533uLR5qDM0GeZJIm5MkeyfO0fz0w29sMyqb7//45wfmMwcy7OmP
        aoyn0B5iBG8tZXQic3qsY1JIoMpK6F7UPQ==
X-Google-Smtp-Source: ABdhPJwdtPPYmo6WE+94Iuib0gPB+kJBbtX3JIOQMEynBukPdQku3BY1vopZY40fdWUvEHBU0TZgYg==
X-Received: by 2002:a63:e445:: with SMTP id i5mr11945858pgk.185.1601866607736;
        Sun, 04 Oct 2020 19:56:47 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id l10sm8670060pgp.25.2020.10.04.19.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 19:56:46 -0700 (PDT)
Subject: Re: [PATCH 0/2] phy: phy-brcm-sata: Allow configuration SATA AFE TX
 amplitude
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20201001031916.411999-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e2ff572e-8934-bf98-0bcc-06220b277810@gmail.com>
Date:   Sun, 4 Oct 2020 19:56:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001031916.411999-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 8:19 PM, Florian Fainelli wrote:
> Hi Kishon,
> 
> This patch series allows the configuration of the Broadcom SATA PHY TX
> amplitude which may be required in order to meet specific tests.

Hi Vinod,

Would you need me to resend these two patches? For some reason 
get_maintainers.pl did not pick up your email. If not, here are the two 
patches from lore:

https://lore.kernel.org/linux-devicetree/20201001031916.411999-2-f.fainelli@gmail.com/
https://lore.kernel.org/linux-devicetree/20201001031916.411999-3-f.fainelli@gmail.com/

Thanks
-- 
Florian
