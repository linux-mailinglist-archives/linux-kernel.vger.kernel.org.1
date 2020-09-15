Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006C326A1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIOJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIOJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:12:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:12:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g4so2481869wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wqDzL5jXjIcU644bGfyRewIDuV/CRiP2hfEuWrticS4=;
        b=I0LTECfJFeTgfuODSS0m5seGDuAH20STqbD8aY6ZNZJS7bmqsdSKZi3N31yKfxRDMH
         96pIhM1oDDQqxTdkkVQESCIMwLi69GrhjccK9zFdgkEp3vz3Hy8dMhTjsjqBBtkSx6nE
         k46o7CSeMT765mmOx0eAYv2GH3HXm3sSBwGuBTvSWd0FgAgdOQujmerXEEi5gDb/8CVI
         r7mD+Vq9FZNqYHRegBD4xiArasYYCT5wsgSTuYiH3Egs8wfDKO7bVK66fJrDbssFaXBy
         UkWMCXYsluKl4er7GlA2ui18yE6WWI0X+J4nzgL3D9yNaW4+5MKCJjMnpB75C5FMU2hD
         BR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqDzL5jXjIcU644bGfyRewIDuV/CRiP2hfEuWrticS4=;
        b=paa0kvUGATpWwIebygrK3Tq4CKqkkuEcHkvI4iTV5kPDaMuFYY5bA8OiUUveOeyS16
         0h6DPnDoSt5Dxpw2q8TFIp7nriUcBRuPXe96MRA3OiVVY59lIHBmSly5ENZBUy1GzJ6f
         SUV11l/bULVQohTO/zGRjjrlyFGR4x4N14xxEdYSeZ8O1bshEVgH7w9FRdK9pcGpcKB3
         4BEl3tidGqlyd6+fW0+/H63WTUNIfJ23u6JV03yYncHoMWKatDmqsfvnr0+0ue/giQJ+
         H1augmMlIcntwxm846uTbiK07v25r2Jcs06V5HB3c088VGOCQUbhQ0ujtn8o23J0KsHD
         vJpA==
X-Gm-Message-State: AOAM533CTsMro7DX21AMbSxELnD1fZFkJGpztEX6AEzvJeSaxy6YaNSK
        b11uvXMtDZphk+SJOmR+ufG6NdzIo1LhNJBk
X-Google-Smtp-Source: ABdhPJxp60NPScv+VZoXofu7q1Z93POwdYx27pIbVKWrggjOKTIjLnFYw0DpvmvFvvArULBUijf1xg==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr20260166wrt.122.1600161135955;
        Tue, 15 Sep 2020 02:12:15 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ec32:668e:7a20:c1cd])
        by smtp.gmail.com with ESMTPSA id r15sm23444226wmn.24.2020.09.15.02.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 02:12:15 -0700 (PDT)
Subject: Re: [PATCH][next] mptcp: fix spelling mistake "colesced" ->
 "coalesced"
To:     Colin King <colin.king@canonical.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, mptcp@lists.01.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200915084405.7361-1-colin.king@canonical.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <d8a1bff2-4302-f48b-c7c7-5dadd95ab2b3@tessares.net>
Date:   Tue, 15 Sep 2020 11:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200915084405.7361-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 15/09/2020 10:44, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake a pr_debug message. Fix it.

Thank you for the patch!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now I don't know if it can be accepted if it was not sent to netdev ML. 
You might have to re-submit it. If you do, please replace "next" by 
"net-next" in the subject to avoid confusion.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
