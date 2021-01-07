Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC92EC7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbhAGCNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGCNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:13:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE0C0612F1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 18:13:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l23so2751593pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4DKo8j9zd5HVNAsTP7vh/Z4vfechORbzWS0lt8jxtJM=;
        b=tTDlZ77eDD4Ql/QwKncvUibBxgVcOuFziriMe9Fu65c510MzufDAApkBRkCmZ7T+Se
         VV3oxhpiEgucluyXCRBDJaE5oj1FcUpODpL+NA1qaaY37kG4PcmraT4JFsGmwEIlBWqE
         jJuV/6mznWuhakFXhnQARwKuVOM3nxHTk1HDTOUtBwKDoMpDLD+kPGSVSNVSb3QxEga4
         RJz5ESH4T9I+Engo3JZGr9OZekVnnScSXFZsDCoJgVtbBhmC9T/TrR2xOJ4v/Ts4/VKo
         UhDcGJVHZPgA5auCP828wZrJIVLn4MF1Mdrqlejq3Q/3suVIDSYpePHFDyLmn9pM5bWq
         XGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4DKo8j9zd5HVNAsTP7vh/Z4vfechORbzWS0lt8jxtJM=;
        b=p/OGyzAlZh56o+uIn920hyhxy6zyM+/POzy5b/81YdQKwRynUg9t4LYEhmRWJYqzXF
         kBeY+KqfRcFQ34qgc8cqwfp84PzJpjVcGFybZppFA8czE5pCejs9jT6ArlyNLyGWerDr
         MYHq+A1N5PvIU5irR6KMhdARdHHt1TFzdaBeWcg+Bk15hGL8uGaGVl4LCI9uZpztMwv0
         eyVLLFqZu5dyVnScu+bdy4X6QKOyF4LIladvVmx/BZnJh+/xYHz2SRoytZ/LSkad20W7
         ZmEfIPbZaS38vyBqYV+T7CHoNDkEE6bg1qSVLDD0o/FlD+EFL+L05NyA7jG0yVl7/nfY
         5sZw==
X-Gm-Message-State: AOAM533tXB+wkPlKS7mOzFTpppaBw+wXruhthsZqWZkpMWJVRzV6PQ23
        MPHq4wcskqb1TawRI8oXQqBLRAgVx1Wo3w==
X-Google-Smtp-Source: ABdhPJyi55P4FaLeiehm3exv0s4ICVbVwfXQPiURe81s9bmktcmOCslfJ8xFNhl81y5fubuYq+TL4g==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr6977671pjb.220.1609985585530;
        Wed, 06 Jan 2021 18:13:05 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z23sm4129540pfj.143.2021.01.06.18.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 18:13:04 -0800 (PST)
Subject: Re: [PATCH] ARC: unbork 5.11 bootup: fix snafu in _TIF_NOTIFY_SIGNAL
 handling
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20210107001225.3063163-1-vgupta@synopsys.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c62fbca-87e1-f53a-26e1-35244e2e6f48@kernel.dk>
Date:   Wed, 6 Jan 2021 19:13:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107001225.3063163-1-vgupta@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 5:12 PM, Vineet Gupta wrote:
> Linux 5.11.rcX was failing to boot on ARC HSDK board. Turns out we have
> a couple of issues, this being the first one, and I'm to blame as I
> didn't pay attention during review.
> 
> TIF_NOTIFY_SIGNAL support requires checking multiple TIF_* bits in
> kernel return code path. Old code only needed to check a single bit so
> BBIT0 <TIF_SIGPENDING> worked. New code needs to check multiple bits so
> AND <bit-mask> instruction. So needs to use bit mask variant _TIF_SIGPENDING

Sorry about that, my arc asm isn't that strong :-)
Thanks for fixing it.

-- 
Jens Axboe

