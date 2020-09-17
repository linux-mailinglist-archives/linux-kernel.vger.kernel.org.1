Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16626D3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIQGdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIQGde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:33:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB1C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:33:34 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q10so466830qvs.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=C33+1DOqnTOdhGEShIG3XwfWH0GCMYX8FFAlfTyHRQk=;
        b=RZMGGdrUq5VvBwNoudF+YLRuvCQOaepLpAKGZTFjM1tgqFw2xBnoKhcDdkVPEGTYt4
         R2dNLvD6wlqoz0+RPcN0qHmUozglwOIL1qFO7CVY4JEAjh8dTHbUjKMSABe0j9K/PZ+7
         4oFdFEVAUBLyJuz+zRKwGX67a+oMOEuB1j6P37HLxnjdKUSd/wJyUaNpN0WuWYpcEPCN
         s79iBtph4ObtoCWxx2N0SAy4w9bluc7xsXC67ey7DXeCH2CrH1mRfcQtIzvAnHDBDfRW
         74Az4lWPq+cmouAnZIm1I4Y4t+iygx/lg7JaQsg+yOrQQixpOCXiTngrKTDy8OjzGtH4
         SzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=C33+1DOqnTOdhGEShIG3XwfWH0GCMYX8FFAlfTyHRQk=;
        b=P4SIcKMNQReLyEJGlNb6izJNjG2+5dVRc5wpRIzDoOMQfBhQFUr1Och8WMzN8z+K6i
         s2BFOb6kOmnhO4IxPMrKa6H/v0w4iqzsBwEowAG18RQSKJI3RiKTvt4/sPnpyAaGfFg7
         0qZOOUpx5CP/anyov1ifjUw/kkZjrzEJZtqHWViyOhYdzfsrA5U2sYoy64zS62EREIGD
         DjJNPpAvWHgDNILRtWuMnNcqQi7WjfcIREARgSqFrxcJHZ+5e5Yd4dh2rVyK54BNAo/k
         JtZysOdb6DYKb2NFaYH2UaQQ1eAOZbYUqRlyrEtZXZf/+08xdpXR7McZYYYBZrfdkOyn
         XfDw==
X-Gm-Message-State: AOAM532J9pwCJ75xvYwLVdGD/STtSF4HO/ZS5ZHW1w5KflsS26NTu7ve
        kL460Zs3GNowC3bXsTpvuVbN+uRRjqC0/oPPlk6j5W9ipB4=
X-Google-Smtp-Source: ABdhPJzSj82M17alFDek6U+fYB0GBjnfm5rfbgVwaP6KwQ4CDHW0KnAQEKKIPAZAxHTp1klKnimcbdal/i8MfWvQk60=
X-Received: by 2002:ad4:45b3:: with SMTP id y19mr10773997qvu.59.1600324412443;
 Wed, 16 Sep 2020 23:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200917020021.0860995C06B9@us180.sjc.aristanetworks.com>
In-Reply-To: <20200917020021.0860995C06B9@us180.sjc.aristanetworks.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Wed, 16 Sep 2020 23:33:21 -0700
Message-ID: <CA+HUmGjX4_4_UXWNn=EehQ_3QtFPZq8RJU146r-nc0nA8apx7w@mail.gmail.com>
Subject: Re: [PATCH] net: make netdev_wait_allrefs wake-able
To:     open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, xiyou.wangcong@gmail.com,
        ap420073@gmail.com, andriin@fb.com,
        Eric Dumazet <edumazet@google.com>, jiri@mellanox.com,
        ast@kernel.org, Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Francesco Ruggeri <fruggeri@arista.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline void dev_put(struct net_device *dev)
>  {
> +       struct task_struct *destroy_task = dev->destroy_task;
> +
>         this_cpu_dec(*dev->pcpu_refcnt);
> +       if (destroy_task)
> +               wake_up_process(destroy_task);
>  }

I just realized that this introduces a race, if dev_put drops the last
reference, an already running netdev_wait_allrefs runs to completion
and then dev_put tries to wake it up.
Any suggestions on how to avoid this without resorting to
locking?

Thanks,
Francesco
