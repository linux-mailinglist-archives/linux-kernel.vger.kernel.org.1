Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E6292A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgJSPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSPcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:32:53 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4DBC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:32:52 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so516644ilj.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6IqZPH/xvsjeV+KO4PrfwtgG9S8DY4P3ygKvGFV+Wk=;
        b=Y/TH7WtZNNRhTiDN1VAyBBdljrCIJKN6XT05Ag7KnMLwK12/Ung3jtuMQBGYi5vmhL
         72/8lisWN3QniaCEz9Ib59crBAL4W1ZrUu/PaALYAA96srEE+L40iZ2Fnizhbkk2angL
         n6p7BdbI7RXC6n4N5OwCcPTdftLKF1OCH+NUNUPpmCAhDrhdkH82Rv1C7nl9I/ojaHcV
         kmS7yyp69BJmWKnQSo8qs4q3hxKII5v/b9LrtNGumGkzr/60C+mgBR70JPZ1kZ0Da7c/
         NnasKweHHQHA+GwqdLowZhENOTy302Sg6tYVr8qE71tIiiRNXAfefesK4386lqvMYonD
         vH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6IqZPH/xvsjeV+KO4PrfwtgG9S8DY4P3ygKvGFV+Wk=;
        b=N/d8D1plAioxttygQcdxrAy1cfYmRf9/Ivr6AqBgrsv18Uvil4mldM5yKL/RHNwjhP
         A9APYXXnRFAkvhD3Y/25mJzO1LzNPC6DqslKiokle0mZiiPhhbC3hvGRpn0WGiv66NKl
         e/DCFcptK/kyyeJEzBh3OVAOIo/0hhjIS/gwJP7DvS7SpNeszwo28/enIqaUQx3sFtdM
         yUHrOVwA9E7aFx2U0mTgRIoKDsAKsuhah3m0w2fnn/gReuL+h11xzF4TSq1lQ9Cvq3P5
         0E92DN7oZBuURdCFYW+R07q87qT9nwyIz3aoJYQWVnSV7w0R29DDp79E4nYCokrjttmH
         T9fQ==
X-Gm-Message-State: AOAM531noPso1Jz6sDoznXH7sXV3j4gsitNUKpzpeYzMpaKm9LV0LQPW
        B1HIqdOn7fxKw77K7z4utIRgew==
X-Google-Smtp-Source: ABdhPJybmO34vOS8G/CY+b47HRjCg2ALL11YTrOppEKdrvmkSd2kXA82tTKNLtwzSN0eoE8vTukKMg==
X-Received: by 2002:a92:dc8f:: with SMTP id c15mr387228iln.293.1603121571501;
        Mon, 19 Oct 2020 08:32:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z200sm65790iof.47.2020.10.19.08.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:32:50 -0700 (PDT)
Subject: Re: [PATCH] zram: Fix __zram_bvec_{read,write}() locking order
To:     Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, bigeasy@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
 <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
 <20201016153324.GA1976566@google.com>
 <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b50bdd18-941b-cc05-2be3-6288f227be4d@kernel.dk>
Date:   Mon, 19 Oct 2020 09:32:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 4:13 AM, Peter Zijlstra wrote:
> 
> Mikhail reported a lockdep spat detailing how __zram_bvec_read() and
> __zram_bvec_write() use zstrm->lock and zspage->lock in opposite order.

Applied, thanks.

-- 
Jens Axboe

