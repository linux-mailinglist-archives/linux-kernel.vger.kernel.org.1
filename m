Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC01F6ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgFKPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgFKPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:16:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9754C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:16:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so2788678pfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Wzj/6YJUHkYVTM6L7OjwBpDRpF+0Bo6tec4TfXLqcw=;
        b=hIXDzAZnr9+g6rNc5rgs19E0NWXMj94q0FcoRTIFO07Bu3APgCTC2Udk222dEj8Veb
         xdlrNLbqHHGAOTqVf9fsKCyeuYSwUZngTGRosPxF4febY+lmkPCtFWUdlGNqd+pk3Kb9
         YIYTp4c5DyalNb7Q4KzQ01rzqR+rpFWXhSKcyange+wCzyVs7YPgtr4jQTk3HrLXDLea
         rAHCa/21pG0JMRaQRKxAlzvhvVrrh3DMNS9OP1qs/EqjMu33Zekele5WpFL3TorGvc9r
         3Hom9bGQxaTUythX/J9Zp4zWe3ESVKJp8Ja+6EMmcS3YNO3RDjp4Z3oPFDoIcccZ40Dq
         +XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Wzj/6YJUHkYVTM6L7OjwBpDRpF+0Bo6tec4TfXLqcw=;
        b=bLkXfGLBE1BZ9VzrPOE5wmySXXldDhtO3xnoz8EDoKS3HrV9HcfNyzMWkFnNp2RcN1
         Gm+qWFeakS0Z0nO7eGBjJdMD/uMdX6ksluOPvrafJnpDsAPn2C62EoteE0QyJ/X09/cy
         z9iQlDbE7GDnYEsadK2BkBnFVdFSIXs9sTN2CpcEj+ZbNmYsKnb8rLhsax/W6WaAyQ5r
         vwUkz6xK6f4TCuONfWitnBJ6eP5Gom3CKSD1uAngkeSqDW1zOiDK+fysho6ruwOOFYp/
         pjkSh0rvkUgrszWwRi4GjNXfGu+zahQNm7dJIvJ7Z1bOFuAcrnjBKyjIl62JoZ6lcFuq
         Qx5A==
X-Gm-Message-State: AOAM530EQfY1Tlko7nRVTsww8tS14fKdjEV42jnGzasFMNCMCN2PLoDd
        YbAmF9ezJMeOSOOP0jSYBItvRDYWKQMxjA==
X-Google-Smtp-Source: ABdhPJyxbwLNFGeh47w7TpUaWru6e0CkefHtWL0j+9FKnzj8KhAuJi3W+16DMcpUr84qEr2q3biO2g==
X-Received: by 2002:a63:6b86:: with SMTP id g128mr7219789pgc.445.1591888591908;
        Thu, 11 Jun 2020 08:16:31 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j2sm3097654pjf.4.2020.06.11.08.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 08:16:31 -0700 (PDT)
Subject: Re: [PATCH] umem: remove redundant initialization of variable ret
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200611143527.925712-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cec98bd3-9d88-60e9-21b3-b85d16348685@kernel.dk>
Date:   Thu, 11 Jun 2020 09:16:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611143527.925712-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 8:35 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

