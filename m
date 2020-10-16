Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA0290855
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410096AbgJPP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405209AbgJPP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4307C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:29:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a1so1718156pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ATPJ8G5Rmg2jkq9+2I73bf4/KgUptQXil2wgPNMHeQk=;
        b=Q44QOqngKKJ/Zmzmj6EmNbdx8ZS2w3pCGWlQWQVYcPlSztZkmr/0S1llaVBI1hiDJB
         1d6/uTZOJ4LAmH5oKWTI/3bgjb3zMQAzvIk0xgLmrnpD+BjG8muHCv4tZIhJtnq6Wpx2
         hEzspvd1UFlDMse7XufdYo7lR3ph/OdbAEgupMV7hT4MtQWne11+S1qKp2XHW7MIoCkX
         ceQohpfd6pXkCn3eWKVA4gYr0KiYkyQCyrCvJ1fTNbr54ubMlx6gsjKJHGoL6IwP8Dgx
         bO2HY/c1FCDbBNNbTW1owULlU5Ys6+1FkAmDX1KgOrB6quRjz8QL7CrHE4l8e4iJEQv7
         sUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ATPJ8G5Rmg2jkq9+2I73bf4/KgUptQXil2wgPNMHeQk=;
        b=VwhFYpTd0gF6fGMlpXbyl2FcFzeQM97vwMExPqxwA16bXdcu7n268GjROP5i/sLM7q
         TQQevs8qyrXYxKgXp0LaxsfpotuJLONjnbtxF3LztxYGKXcHVKWIUZfMrZuGyyEAtRHd
         2SpS532md3a5DxSCey2tY82TKQut4GezOIPxyvoZoSO3DQ7sPD3nYSo7fho4NJMjhpsP
         gHu9QcUXTHyMAeToCJ4+gMekU6k3JiMJe8Zz/gyrrqsC7KhMETydpp6k/wZf/43g4c8Z
         RKyr17h9GszOViGBmAIeOuCEa0gL+EPtcO0Aoj5VYkQJ+IkELyvLYktjXFzLb8kjCvYO
         rveQ==
X-Gm-Message-State: AOAM532jjxEand9kXUmBARr4BkUxZnIncqc+2O4ZPcjOaMmfL9C5V7kr
        3jEv+9+irj2EMJ/z1MuR7o58AwjGNVA/XRHF
X-Google-Smtp-Source: ABdhPJyCjZq9ngO0zedh/4UnOXi8mIRRpTCWkpmy4XRTD6RWyWtogUjES0IBbmEJUp22Yke7kN59dg==
X-Received: by 2002:a17:902:c408:b029:d4:c99a:19e8 with SMTP id k8-20020a170902c408b02900d4c99a19e8mr4674795plk.8.1602862151187;
        Fri, 16 Oct 2020 08:29:11 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q5sm3210581pfb.184.2020.10.16.08.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 08:29:10 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: fix out-of-bounds write to array
 devices->info[]
To:     Colin King <colin.king@canonical.com>,
        Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201016143351.677352-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36ff7b17-eb2f-780d-17ca-269a8f5d4aac@kernel.dk>
Date:   Fri, 16 Oct 2020 09:29:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016143351.677352-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 8:33 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an off-by-one array check that can lead to a out-of-bounds
> write to devices->info[i].  Fix this by checking by using >= rather
> than > for the size check. Also replace hard-coded array size limit
> with ARRAY_SIZE on the array.

Applied, thanks.

-- 
Jens Axboe

