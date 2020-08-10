Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946282411A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHJUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHJUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:21:12 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F5C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:21:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t6so11040188ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c6pBI5MxnpEnuKghhV5aUeX0ikCMORE+D9KtpC4PopE=;
        b=A1rXdbYy1kXnW/tuHp39B8KffjUxifEmL9Qu6yjTyt6goBHyod8D0PlStOGnhPUVyo
         tdtP2tJuZfX87pflPW51ULFOYWEK7s7Hw6KaPPzrilRkge9mNUan12XJQulg/xM3TND+
         6r11y7ISHDPFn4rYeCD++ekNXS2yq+fGhn5V2UEW91FsjvOJUgLmXrqLbz1M3bMViyQy
         qnWrl4rLOV7FrKFEJmOwyHtL4aPqnOgbF/s9DNoLEr0CwxkMO0qg0Z4k5/+aWUsMN6z9
         911wvcQtKqWmP9NC0pVVqE2sA2PdeSZ0xD7IHBOFPTJu/5dQFmyxpoLVQ9a3xqyNwu9u
         Fz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c6pBI5MxnpEnuKghhV5aUeX0ikCMORE+D9KtpC4PopE=;
        b=iMTUsRPoV0qYlA2dwkNHwbxryxsDsRHabNsKIWywSDd4MTGRAUlvoVjJlwyWlR22k0
         4cNTaJAoXjvZ9vk0cPZ8J3vnMKUKPleiFjycjRazFY2S3bWITmlyrZjMi7W74MF+Pmnh
         L0jvJ8pgfrJgnx87va154nTw+CAknE4VoP5g5swf43MlHhg4eXiEbyUKv8whFT8Evh62
         y/ExLlUnpNzEtft6gpB2JoV66H3vBZt4s+nh+LUx/HgjGAdmj5mzqR1T6aVQc8+RKkJs
         1pN4NftzzF6Nek8G3Pm2bX9xxLkd67XEFlSyciKVnXOBbYhXGMfLQALqGaUhFE9OKNF6
         Wfpg==
X-Gm-Message-State: AOAM533E3HR5sNzXr6FkzSpg9C8scRs6fG45Kj5MDgEdrCSgDVj2mKK4
        UE8ACLURgmcZll7OsFVIhn7MhHUG
X-Google-Smtp-Source: ABdhPJz1tYB1BL/08O4TtcbTxN7dvYB5B5s0KlZy+GCj64qNYoBaOcFO4h5Tk9svhqOODSSiuZ7+mg==
X-Received: by 2002:a2e:b056:: with SMTP id d22mr1336821ljl.248.1597090869388;
        Mon, 10 Aug 2020 13:21:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id a24sm8230066lji.36.2020.08.10.13.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:21:08 -0700 (PDT)
Subject: Re: regulator: deadlock vs memory reclaim
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
 <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
 <20200810201846.GA12091@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d9c3f307-e124-ea5e-c036-71138f9232f4@gmail.com>
Date:   Mon, 10 Aug 2020 23:21:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810201846.GA12091@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 23:18, Michał Mirosław пишет:
> On Mon, Aug 10, 2020 at 11:15:28PM +0300, Dmitry Osipenko wrote:
>> 10.08.2020 23:09, Michał Mirosław пишет:
>>> At first I also thought so, but there's more. Below is a lockdep
>>> complaint with your patch applied. I did a similar patch and then two more
>>> (following) and that is still not enough (sysfs/debugfs do allocations,
>>> too).
>> Then it should be good to move the locking for init_coupling() like I
>> suggested and use GFP_NOWAIT for the two other cases. It all could be a
>> single small patch. Could you please check whether GFP_NOWAIT helps?
> 
> This would be equivalent to my patches. Problem with sysfs and debugfs
> remains as they don't have the option of GFP_NOWAIT. This needs to be
> moved outside of the locks.

Ah okay, you meant the debugfs core. I see now, thanks.
