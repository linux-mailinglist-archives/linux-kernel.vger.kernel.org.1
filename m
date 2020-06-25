Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFA209FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405037AbgFYNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404935AbgFYNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:24:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7623BC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:24:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so3209729pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eWSfWI4wpEme8MrwfvQ7LPuMKGxIgLayOyX6JwETS9k=;
        b=TXs317Chw7NlZME2mN7859gja5QL9DFyQzGIbvLyC0Z35kZPOYP34joAI5KMOaN5PK
         Y77JHyvhP0f0iy4PPvYyb3iqfJhnEeW3XAc/Yq4Mo6Plmgmrc3xGo58DDXeQ85sneA47
         PJPwd2z3+2sBXiPkmSRiEmNcu7THXZR/EyE43riF8IF51yLxi9ckeQh1tzSL36Zp2OZd
         Y2WdMe051I5Rir1G6lfaQ5QnuC0igLb9IuHs4cFtpBkSN02avQR1M/U9A7IsJQ3qWikQ
         QO54UdFpQW+EBxCNjZ11lXroQgTPm+3/aPJPO+A6aI0CijcjTfwCCGbumI9waZ7JDcp4
         gMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eWSfWI4wpEme8MrwfvQ7LPuMKGxIgLayOyX6JwETS9k=;
        b=fQ3z/v7uOjuzFAXIQA4jjEy56LQmNuXWM0v/aLE17gJDZkQz7Zcq1md1xIvjCNx9j4
         nguLkYoaf1ed80AUEAgxyb4psb+7+7I+ajZS56HYktTPZtXb0L8ro6udRe1SlIGaDC6w
         ELatFY75wokTYLNNfn2P4zpsbOoDHtc9tkOd84OiavsmBg64ymWeu85zbzuPbkg2wj8A
         Pv54Fi315GCSOmpcf0kComRmfIerhuOG1+WgOHhraSmVNy411/NO0GIc/hhH/txJYfvC
         GBFkEVUk4hSnfVZC7ExS0XkPVx5ol6WViNqEGHvMJYdhgl79WoMgyhQh/Z8mo+g8UKXu
         BXFA==
X-Gm-Message-State: AOAM531k9hbkn0CMlHUPJKtnHNKFyCCmQOt2tfezMOAW92h1PeIWOYO4
        H/3gyiGkfBdjWdsrgQjs21DgGq5LS1bAjA==
X-Google-Smtp-Source: ABdhPJxz6W6AkCZ4Vb3R22w+iIOiwz8jbFDCPrudgODkVLqlhWeN9HIjLKRDHz7pD59URGE0+fPI5g==
X-Received: by 2002:a17:902:8690:: with SMTP id g16mr33052502plo.257.1593091465728;
        Thu, 25 Jun 2020 06:24:25 -0700 (PDT)
Received: from ?IPv6:2600:380:6c49:6812:d113:f43c:df53:19ee? ([2600:380:6c49:6812:d113:f43c:df53:19ee])
        by smtp.gmail.com with ESMTPSA id h5sm24249689pfb.120.2020.06.25.06.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:24:24 -0700 (PDT)
Subject: Re: [PATCH 5.9] io_uring: fix NULL-mm for linked reqs
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f7d8272bcf142fe2c11c85ecd86f7f75f6e48316.1593077850.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41f3f2db-bc1c-22cc-d93c-4ed31cfb225f@kernel.dk>
Date:   Thu, 25 Jun 2020 07:24:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f7d8272bcf142fe2c11c85ecd86f7f75f6e48316.1593077850.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/20 3:38 AM, Pavel Begunkov wrote:
> __io_queue_sqe() tries to handle all request of a link,
> so it's not enough to grab mm in io_sq_thread_acquire_mm()
> based just on the head.
> 
> Don't check req->needs_mm and do it always.

Applied, thanks.

-- 
Jens Axboe

