Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FFD27F7FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgJACdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgJACdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:33:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59285C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:33:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so1103298pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szEH88A0/Fe3KCIqfU88gWrIHjPg0MiBPUXzh5BVuQc=;
        b=VzI+G1yuJHR6XFfHqWs1mvZ7H3XPFmKhhAuRcY9FJ8aDSAk0c7e5FwsvLHU2jpT2aX
         jjqScL0TplPzpvqohSCgj7cbX1ur2vD2qocEVP8PWtrPvdzL7vznGq/7BrsySPoMF4gR
         iPaB+MW43bQg/hICcHDMhkYAyaxmEADQ5ET0V2Ra/yLIWG3O1LVQF1ubTK5bUIabUm5R
         sehUpacKrvO+m2dE4QWpxlvRYjOqr5QPafrqJTdTBv0GeS4G9axlIIq1Ug5SbV7PbcTZ
         0la/b6FfywYgaiPgmxGQ0ougOg3udbbb5f1U2zi+L6n5FKWvG0P+BzuQyp/KfYTaO6QQ
         N+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szEH88A0/Fe3KCIqfU88gWrIHjPg0MiBPUXzh5BVuQc=;
        b=KkU+CiYMJo9QL1g0r4Jj5GMlfWdxQ1iVujY0996M4cpIfHNbfm94XDLtdgo6g9QwhY
         ZpYqq8hpac233jZfgWU0cdC92aSO3YCOrJiPRsmqG9LwHbgDIdfmxDTJvvKUolIj6De8
         5DxLN+1oDTQli3HPqXOzFD74CQGafqu00UMSDGPgrEQCAMZkDthr+5hu51J5dX7PVDKj
         u30HMnpB0rQ57LkRCZ+ZHCd6WNe97hzt3H6mnSgXE3A683urGF/gebiHBLg7fuxXoLUV
         8gXfaU4wtpClumxeMs8ArxPossJ263Eiho7kgSSChytlB/tcWGDAyAUj6ao9JMjHMr7x
         NsCQ==
X-Gm-Message-State: AOAM5319XBqFzx0slT1vbxdzNA0a1FmJkmhtKMof0auvclqk1826+Hag
        JsOeOQcnrTtHGKOH/m9d5Uk=
X-Google-Smtp-Source: ABdhPJxiaPFw4hnS2QSvem755MILzVoHL72ye03TJ5ggxmcHgCKe3Rsk9AGKbs69LuJBEhX7kcMJmQ==
X-Received: by 2002:a17:90a:aa8c:: with SMTP id l12mr5011946pjq.114.1601519619789;
        Wed, 30 Sep 2020 19:33:39 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id kt18sm3544305pjb.56.2020.09.30.19.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 19:33:39 -0700 (PDT)
Subject: Re: [PATCH v5 11/15] misc: bcm-vk: add BCM_VK_QSTATS
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-12-scott.branden@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e7b3a4b6-0662-6ead-8ddb-0cf6324a9bd2@gmail.com>
Date:   Wed, 30 Sep 2020 19:33:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001012810.4172-12-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 6:28 PM, Scott Branden wrote:
> Add BCM_VK_QSTATS Kconfig option to allow for enabling debug VK
> queue statistics.
> 
> These statistics keep track of max, abs_max, and average for the
> messages queues.
> 
> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---

[snip]

> +#if defined(CONFIG_BCM_VK_QSTATS)
> +	/* clear qstats */
> +	for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
> +		memset(&vk->to_v_msg_chan.qstats[i].qcnts, 0,
> +		       sizeof(vk->to_v_msg_chan.qstats[i].qcnts));
> +		memset(&vk->to_h_msg_chan.qstats[i].qcnts, 0,
> +		       sizeof(vk->to_h_msg_chan.qstats[i].qcnts));
> +	}
> +#endif
>   	/* clear 4096 bits of bitmap */
>   	bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);

It was not clear from looking at this patch how are the statistics 
exposed and how does one actually get them?
-- 
Florian
