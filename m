Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9396282BFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJDR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgJDR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 13:27:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EFC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 10:27:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so867778pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tj85vc+tFzKQ8Ts1wgqekj2S97wfjTOBg845eefHhNk=;
        b=XzvA1ibYwKJjhuT5kV/gBCfVWaqWGosfZel3llNCYnpQOhIwyifIfQ8jyAzGMCIcmz
         IXTW5yCQRCQ2yNTHAg7p09RQDe/XmI4dzRB2/fGwR1YO26n1KCD+Y278Fm7nYK2uvkYq
         BnVLgkcDRg4Qk73FZ1UcCv1xE8xXDkPncjHn244CzbcWYTd+uPWiIW8uqjWy0tTLLWpP
         mhbXT33DK5yrAgz0kRvpl+10PFWL6PP6DYdEg0LSt9atD8Cn6f0y3vb0HuU6A9naQDHf
         7iM+AA6xDNobK8ePVCyQRSie1VOiOrI55NOMBapYv7yN9quU4/JsEqcKt/WbW81cjsZH
         CO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tj85vc+tFzKQ8Ts1wgqekj2S97wfjTOBg845eefHhNk=;
        b=BjUIPZsZ9vsmXOcwSuQ7OZj4WGIiYR/Z2us96fY1LRApgBoCZvM+/O9dUBaCX/nO3Z
         wgSsjxC8SBT7n36dvnmGWl2qIFbkCjIanUVGagB+w2zHSnlPjBoLQ75FxQHKxuT+TXaT
         z4z4TgQWTBnldmSvT+slCBolM/6LpJYN3ZXKKBg3bvDuY01TvX+o+r35z+OS3LLPboGT
         kW5vzq+7Rx9yEsRTb3uCVSORehMDtFiPFJn18gA2BlfMOqlqSKB6i7f+tOeWG6aNgwcX
         qgfFPkuP55EBFWsx7dWe+U8J8BnE7raKZlpWRa8xVrJyu7rgmgHxg0MgNVP0o461/icc
         0EPw==
X-Gm-Message-State: AOAM531wY94DW1n468GHldGcbyWjZcIPSklbPvaigQ+6EA3wtjZnQUCf
        dY5hs1Ss1zsoX8hPj83as3IkQQ==
X-Google-Smtp-Source: ABdhPJwj4IDhoydeLRkvglo0zKQhrjklU5j3+KfqxjL9fpv2XPSptrijTRwQ5V5iJTKPN9mcSPtL2Q==
X-Received: by 2002:a17:90a:5292:: with SMTP id w18mr13086015pjh.72.1601832466217;
        Sun, 04 Oct 2020 10:27:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 16sm7810102pjl.27.2020.10.04.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 10:27:45 -0700 (PDT)
Date:   Sun, 04 Oct 2020 10:27:45 -0700 (PDT)
X-Google-Original-Date: Sun, 04 Oct 2020 10:27:39 PDT (-0700)
Subject:     Re: remove set_fs for riscv v2
In-Reply-To: <CAK8P3a3ONxXm_MWKn9BSswtLH3etVwOUh52NYoXpj032=WP0gw@mail.gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-de10f104-52e9-4531-8d33-981b0692682a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 12:13:41 PDT (-0700), Arnd Bergmann wrote:
> On Sat, Sep 26, 2020 at 7:50 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> I'm OK taking it, but there's a few things I'd like to sort out.  IIRC I put it
>> on a temporary branch over here
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-remove_set_fs
>>
>> under the assumption it might get lost otherwise, but let me know if that's not
>> what you were looking for.
>>
>> Arnd: Are you OK with the asm-generic stuff?  I couldn't find anything in my
>> mail history, so sorry if I just missed it.
>
> For some reason I had missed that __copy_from_user() change earlier,
> but I had a closer look now and this is all very good, feel free to
> add an
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.  These (along with the rest of Christoph's patch set, and a merge from
base.set_fs) are on my for-next.
