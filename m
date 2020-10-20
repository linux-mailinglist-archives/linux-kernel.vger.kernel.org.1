Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69575293CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407065AbgJTNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406801AbgJTNKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:10:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA926C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:10:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so721443ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WrpDbsMLU2h7/9RmcIUsIoBEvBYRtpHMIbTH0gGm73Q=;
        b=xnbfswqBCxhkUHjrnt6hWUK+DI9XhAPQO08asdBs9Bav52XBcHxel+URSscEZHudky
         rk/Am+d7lyBM82MSme6QVUXWx2XAI6DcBdUcwH+l0/IHDDC8K2gmAATDgacN1DDx3A4g
         Mmv3k+kT4ccCCEe+yEuNwNCQlLhRUpNrh0bL5f80TFbER9SfGp/aIvC4OnF5RwwDe6IH
         0vx7ABWnAaQf/01yAtGh4TFJf+ctRCWccA6u6Ye5jRSnQYQKf1eMvaI692VnnO3d9/6X
         aatsaDOQ43jCR3Z6/PtpSD52LfC40teEbBzAJkje6Ib+U65Urd+9r6I7D+gCRH/NPJOh
         hRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WrpDbsMLU2h7/9RmcIUsIoBEvBYRtpHMIbTH0gGm73Q=;
        b=F7+30wDkD99D/vH9c2pbaHUTmiHpQjtxzlNJOnSx7sc+2Lg4a++8Yj8roDc8qzJ2Mn
         Oj+SUdVvqvjKQeMHVbAollXOZb1OnWOn+if/9gTMwD2r68RxbYSmEegJKLKF7kcTCB7+
         17DAwRmYHY0uYeLSmrKqbKu1efFv+xF/MBiKvk3Kun8XAKbf7Hctvleu/99RqVS8RuRN
         ONiE85ClWx14H97fz7xyfMsmjdrH3zKnsTv+SeTervxmbQP4q6eStAnI8b0objRmDE++
         vYeyzy7r99DHZzEhFGfnkV/tR7CXRASutvQTnJb+eZrLiFeZjtMRDpjbHSyJEEw7NbqF
         hB4A==
X-Gm-Message-State: AOAM530Tk+nJzrRiDM7PNLfpJp8jAt23FszunyuA1hRdWpHmDEzs8Loa
        Cn75mmj4LeOyj1aC54IehrRE+Yn2y5yC/A==
X-Google-Smtp-Source: ABdhPJxLtWIvxjerdWoBcmOYPrbLx34z/N7yiyvncaTz+7frEldPX5H+YBRKJgShkmBOXKsqcSDPJA==
X-Received: by 2002:a5d:9842:: with SMTP id p2mr2056624ios.113.1603199447848;
        Tue, 20 Oct 2020 06:10:47 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r12sm1854356ilm.28.2020.10.20.06.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 06:10:47 -0700 (PDT)
Subject: Re: [PATCH] block: remove unused members for io_context
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-kernel@vger.kernel.org
References: <20201020092256.4095621-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1430b833-17c6-0fdd-a51d-b4aa68968f75@kernel.dk>
Date:   Tue, 20 Oct 2020 07:10:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020092256.4095621-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 3:22 AM, Yufen Yu wrote:
> After removing blk-sq code, there is no user of nr_batch_requests
> and last_waited in kernel.

Applied, thanks.

-- 
Jens Axboe

