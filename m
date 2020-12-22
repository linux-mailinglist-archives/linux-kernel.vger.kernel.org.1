Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73C32E0463
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 03:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgLVCf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 21:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLVCf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:35:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 18:35:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b5so537477pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 18:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hafxKqysiR3I961R1mf7Aw6KU3LHI/+guwcGTRcJboU=;
        b=rVI0A1zP4lfAmPzZaMaNKYyv9AixsDH+PTcUQ0prVoLxY0fTITnAKMsmy55LCk7+im
         WK8PVx6kkOUxMf9mFyA1Ylf52Di7wENvuP2PPr0/ktCK+Rn1l165JdCqsJCdix4USY6+
         Wd6gI9dMor/u8KS49yWE+wF0NEaXeacyh9WIJqDegAeoHfC5kGztSqRMTwfwGlToMIkz
         lRCuWi70ZdPFPflF64EBu1asfK/GBqJUu7JSmsl1rKCS7T7ZZEk97+h1QhcOPXPYeD2/
         1WPaLuqt4dztFwxiTU7glU/bZSdxJPL13+LgrrrwLCr95cR7UFKJbX5kI3OZr5lbkbps
         Kbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hafxKqysiR3I961R1mf7Aw6KU3LHI/+guwcGTRcJboU=;
        b=bC7ibP2DTHTPKWfHeNcCAhRpy5Twxk6Etus/3fHb/DqYP6R0Gnq/ceEPcGGCUtcjjk
         7nwqbWay80vnMBj3K6yMb3eOX6flkufqgL28Pj9T9n41Dd7TJriCj3zj0pM2A+toBYqf
         YKbhPLk/sQXo4cbPjICsUia455o+zVtE3MlLNC+AZMM7wJtGvnAB84RoqVP5g8lheYRr
         O3HuZFDFIoKZYuGiiQTdHQbqMsNn/z/ugUS5JmP8Wl8gr0YuuVciPzQx/DV0JiTgjU48
         c+2zXyXRHequvGIzQ4EgqAC8l8sNJVt4sQE0PXVoGZ99ksabUCEG09uVoFgGCtSq4qGu
         d6vQ==
X-Gm-Message-State: AOAM5329E5kPLsU/fxUDICnduQweS7OJgjFd/fWoxExsCayMJD5uFXLl
        y7/jGOqL4x73Wci9Bjqxx65Z0b30zCcbkKGc
X-Google-Smtp-Source: ABdhPJwV1isrIXyDoJHEfGX/hFpX6VWTnUX91ySgc/dsRR6v3XJER0DjquL5iqzflTnjQ9Q4rUnEuw==
X-Received: by 2002:a17:902:9302:b029:da:f6b0:643a with SMTP id bc2-20020a1709029302b02900daf6b0643amr18917320plb.33.1608604515183;
        Mon, 21 Dec 2020 18:35:15 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gz2sm17574838pjb.2.2020.12.21.18.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 18:35:14 -0800 (PST)
Date:   Mon, 21 Dec 2020 18:35:14 -0800 (PST)
X-Google-Original-Date: Mon, 21 Dec 2020 18:35:12 PST (-0800)
Subject:     Re: [PATCH v3 0/2] Let illegal access to user-space memory die
In-Reply-To: <20201204054259.32684-1-tesheng@andestech.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        walken@google.com, vbabka@suse.cz, peterx@redhat.com,
        akpm@linux-foundation.org, penberg@kernel.org,
        aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        tesheng@andestech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tesheng@andestech.com
Message-ID: <mhng-607cbd62-adc5-45a7-adde-476741f9d63b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Dec 2020 21:42:57 PST (-0800), tesheng@andestech.com wrote:
> Accesses to user-space memory without calling uaccess routine
> leads to hanging in page fault handler. Like arm64, we let it
> die earlier in page fault handler.
>
> Changes in v3:
> 	-Let no_context() use die_kernel_fault() helper
>
> Changes in v2:
>     -Add a die_kernel_fault() helper
>     -Split one long line code into two
>
> Eric Lin (2):
>   riscv/mm: Introduce a die_kernel_fault() helper function
>   riscv/mm: Prevent kernel module to access user memory without uaccess
>     routines
>
>  arch/riscv/mm/fault.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

Thanks, these will be on for-next when the merge window ends.
