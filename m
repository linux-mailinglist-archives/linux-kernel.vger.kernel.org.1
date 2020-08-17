Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501DD2465FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgHQMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 08:06:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39582 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgHQMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:06:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id c10so12056798edk.6;
        Mon, 17 Aug 2020 05:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=POjo4N2UW/F7P1/0nbB8JMCRtfCFZzWav36q5a69RDA=;
        b=TJhDssrtTcqP+JMBEW0SX+UgrKVExCMcryGzM6IHvFxTksev1ILph/iIwi0YPAZRXg
         BPO1aydN841WUcp2uDfUsXBT01GLg7UgMVJAY9DAvgfsY+OtYvbA16RMpBk5pGCtzxvx
         kona72GRcLoGPrvzODmD9TXvQbJU533OT24qiWNzyQfqcHPvPIep1eutjUkjI8616maX
         1SNg9/A80y7Cb7fElWOyLRD49MQCO5DXKLpUaxM2/67QBmDsU05HAsO0xp6QX4HLcBmg
         dKi3M9Ct/oLbDaOrMeSfVMAWmwdzWsEXfpc+zjF7/8PlQ9Eek78hmrbw68Fq3y4uSACg
         demA==
X-Gm-Message-State: AOAM533ytMzR8Mrlmie3zws4G94k4+FjKGi9i5I7iXd9oTaOqvPTCIbf
        Un/P5ToU3TiYvBROohojgFdnsjc+DycJcg==
X-Google-Smtp-Source: ABdhPJymaBf/U0ztL2RTmFCygw0OMokmDearJJKeNRZeMimIQb6zEmgevVCQjBVqVE1yCVN8TRNY2Q==
X-Received: by 2002:a05:6402:1e2:: with SMTP id i2mr14330135edy.70.1597666001072;
        Mon, 17 Aug 2020 05:06:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.242])
        by smtp.googlemail.com with ESMTPSA id u6sm14397329ejf.98.2020.08.17.05.06.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 05:06:40 -0700 (PDT)
Date:   Mon, 17 Aug 2020 14:06:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: jz4780_nemc: Fix an error pointer vs NULL check
 in probe()
Message-ID: <20200817120638.GB2346@kozik-lap>
References: <20200803143607.GC346925@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803143607.GC346925@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 05:36:07PM +0300, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers.  This bug could lead to an Oops during probe.
> 
> Fixes: f046e4a3f0b9 ("memory: jz4780_nemc: Only request IO memory the driver will use")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/memory/jz4780-nemc.c | 4 ++--

Thanks, applied.

Best regards,
Krzysztof

