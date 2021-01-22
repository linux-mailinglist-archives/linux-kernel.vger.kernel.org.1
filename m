Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5C3010DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbhAVXUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 18:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAVXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:20:32 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7752C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:19:51 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r189so7886053oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rrEawmDhNbvC3ZRUyuDABJFIFtqmVIBXaZAG0SlGvVg=;
        b=kxD7UEa8PuSzjCxBMEbiSxHtWTdN+ivDj9bSFtvqip0S81TJ2+lX5RWSX95+hDn3aZ
         y5NEX6TAzs9Wpn6HoOPjV5tKJKwVT8lSazcG/ADK70BHaW+51D6d+eoBrMDX3OT0wN0C
         AVAdA6kzegrZl6qpWOStS6EcvE1jYO41qCAzEI384o5TQj+xslBm6r19k7TZfllB/89k
         L1cFHW7O7LAcWj2+ETQNnyVEKXO0CgqBOI6bHWSKjgs7rdQm1gL8DPznllOZjOMdG3nK
         led5SRVfrHOxMzpfxi02sJOt+86MBLmI3Z2h0baK7jbkUDbnh/xqLAcu6T1vQ9UVjAHV
         bAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rrEawmDhNbvC3ZRUyuDABJFIFtqmVIBXaZAG0SlGvVg=;
        b=keIT/07KBLN7v3/fAdZXzUqP3ZI74Cz7IhaGHmCG6XqVBWVoxfDenK9TJoKak744wq
         GkqBbVJMqd4iwGsXwDZlFoRsOnKtlpfLq7D5S/9HBJNkovnhgnE5naR+yrUx4T+j8eGF
         lw1dcKEsX7Rz5R2hWYj6UDQWbE6OdRxewthWnDbDvwyGTXFm7xtNhKGBxmuNDDz98bnZ
         6LjVrbDyv+dE07FNkdFQoCuog905n9HwQu6knS/Y1h+ZM/gpa/ksOZ/HSh+sfG/gFKho
         uyosZNBuqGhjboIJNjivChA9XcSxcrc2oyEQJXB1f/T3iZ204e2atWjnoUwHmUH/Qhex
         7dSw==
X-Gm-Message-State: AOAM530u67rUyflwifQajwWRAe0u6xwBeouXFJl0uF/xcvPka0V9N7d4
        nWXfn0QOnn7cnJ8XRgaP6gexuA==
X-Google-Smtp-Source: ABdhPJyu+cUAY9TnRrBqDllGidzhQE9q/TrcaqMSMZFrIvNzemiGzngm8TzqmPB8i2CUVCtoNJE/0w==
X-Received: by 2002:aca:dd08:: with SMTP id u8mr4782911oig.85.1611357590959;
        Fri, 22 Jan 2021 15:19:50 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x188sm1172940oif.46.2021.01.22.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 15:19:50 -0800 (PST)
Date:   Fri, 22 Jan 2021 17:19:48 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Pan Bian <bianpan2016@163.com>, Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: qcom: Put child node before return
Message-ID: <YAtdlKe7q4JskefR@builder.lan>
References: <20210121114907.109267-1-bianpan2016@163.com>
 <CACRpkdZzVY=AKFhW-hEmCAHmdMgVF8=hQeE8a8W=2W0h44eQVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZzVY=AKFhW-hEmCAHmdMgVF8=hQeE8a8W=2W0h44eQVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Jan 16:47 CST 2021, Linus Walleij wrote:

> On Thu, Jan 21, 2021 at 12:49 PM Pan Bian <bianpan2016@163.com> wrote:
> 
> > Put child node before return to fix potential reference count leak.
> > Generally, the reference count of child is incremented and decremented
> > automatically in the macro for_each_available_child_of_node() and should
> > be decremented manually if the loop is broken in loop body.
> >
> > Fixes: 335a12754808 ("bus: qcom: add EBI2 driver")
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please submit this patch for inclusion through the ARM SoC tree.
> 

Any objections to me picking it in the Qualcomm tree? Or that's what you
indirectly meant?

Regards,
Bjorn
