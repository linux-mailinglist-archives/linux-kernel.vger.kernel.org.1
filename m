Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43EF293D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407299AbgJTNSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406787AbgJTNSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:18:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A9C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:18:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id md26so2639043ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JDOVYVFvlW2cJ3cPdc7NzP6056HGitwNe25Sb3BmfXU=;
        b=ZOs2nJDDK9g3UIVHvcX7KWRXgeXh8T2dv0/bFyGyRawzCeji3KYSp+t6+l1G6vF+H9
         odPTy4epdtdVn0m+pXrfrXGdbZzUeJZiJSvrLlG1zxgufbiL+XsgDzrK0z1BKD5cbMnT
         giogSAfrfpkzPFzTMiT8yccQqYJJeW1yP0XNwSszji+9KGGH/RLYd0zeobJt+cPBYFSI
         rn6xSONW6cl6kr+gXHEbe4LBISWJ046AIQnWu88ZupuDX4vNLvZ5o0uef9W46tqRZSlZ
         yVh/hQkOX+p6folXPeH6rO4+RcNUZ5MZt46rNYR5g5fgPURaO6asCjBNDaaEOigWI6ub
         uemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDOVYVFvlW2cJ3cPdc7NzP6056HGitwNe25Sb3BmfXU=;
        b=iUolJ+jKKOetWKLVm9jcyW3qxf3rzjXGavTieH29p+b5chJEm+vwZOOt5hKF5dWWXk
         FkTUTSut2bh0AAi99NRmsGPQh3/1edg9kwCQwzFm/6EKPCAlwnCU9H/0jr6OTy9hJLkF
         tbt44fuBm1Ji5tgVQnER3RVySd0hk1b0q9oBXONLcSRyrnfAk32zde1TpR62C4PAb90v
         KpPAQbG2gh0msJFoKYjczaLVW+Gb8xsk8KgrD2c6yYBhLw2xCKmdprBNW5pB/hk4XjLa
         UpTWKMJQPTnlLItMUWCx/uTTtFReNKhBpZf4tzhWGWcpmRdPb9yAtt3JbG9h1oHBOymq
         s8+Q==
X-Gm-Message-State: AOAM531g6lw6TODm2eQC9UG+PzVgGRwBN1bxkVnxiLpER0NbU9zmqJUJ
        +XEAKGnKKCrFuzMvrtp0rJt1PnKEO4Yb/1dn
X-Google-Smtp-Source: ABdhPJwoKLOUtTFpoHIZQeV3sSH17MZoaevG8KEWL7kHrwUcf5yvXtqjZ1h4Kdv5ARV8Ktwi0f6VEA==
X-Received: by 2002:a17:906:bc42:: with SMTP id s2mr2982259ejv.251.1603199920554;
        Tue, 20 Oct 2020 06:18:40 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([37.184.95.216])
        by smtp.gmail.com with ESMTPSA id v14sm2387783edy.68.2020.10.20.06.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 06:18:39 -0700 (PDT)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
References: <cover.1603102503.git.geliangtang@gmail.com>
 <7766357d-0838-1603-9967-8910aa312f65@tessares.net>
 <20201019134048.11c75c9a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH net-next 0/2] init ahmac and port of
 mptcp_options_received
Message-ID: <91a59216-a1c7-1ffe-c263-b3bddcd2d801@tessares.net>
Date:   Tue, 20 Oct 2020 15:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201019134048.11c75c9a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On 19/10/2020 22:40, Jakub Kicinski wrote:
> On Mon, 19 Oct 2020 18:27:55 +0200 Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 19/10/2020 12:23, Geliang Tang wrote:
>>> This patchset deals with initializations of mptcp_options_received's two
>>> fields, ahmac and port.
>>>
>>> Geliang Tang (2):
>>>     mptcp: initialize mptcp_options_received's ahmac
>>>     mptcp: move mptcp_options_received's port initialization
>>
>> Thank you for these two patches. They look good to me except one detail:
>> these two patches are for -net and not net-next.
>>
>> I don't know if it is alright for Jakub to apply them to -net or if it
>> is clearer to re-send them with an updated subject.
>>
>> If it is OK to apply them to -net without a re-submit, here is my:
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Thanks, I can apply to net.

Great, thank you!

BTW, nice work with the maintenance of Net! More reasons for davem to 
take time recovering :)

> 
>> Also, if you don't mind and while I am here, I never know: is it OK for
>> you the maintainers to send one Acked/Reviewed-by for a whole series --
>> but then this is not reflected on patchwork -- or should we send one tag
>> for each patch?
> 
> It's fine, we propagate those semi-manually, but it's not a problem.
> Hopefully patchwork will address this at some point :(

Thank you for your reply, good to know!

Then next time, I will send these tags per patch to save you some 
semi-manual operations :)

Some preparation works have been done on patchwork side but the feature 
is not available yet:

   https://github.com/getpatchwork/patchwork/issues/113

Hopefully soon!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
