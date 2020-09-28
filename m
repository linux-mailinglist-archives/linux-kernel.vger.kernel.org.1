Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29A427B29D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1Qyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1Qyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:54:52 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4458C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fNzs8XptD8xG9LjR//k8ImuZIeWP3Q6aSamXLwbwJTI=; b=lZJRbDzIWwyHuDK1P0wbvAf3EJ
        5SRPJNQ+YQGBOX0N0GFnwMvKS41pnGOEtCUbSZl9YUKDdxCchaG+d5W1leWzrW2Cj5MWZANCW4Ze6
        z163+/MzphhS8/nB2AGT4vNR88WQPOnf2LG/S8dTODzPz1GeXQGXmV9x/Eh1zEH0974knBbGGQmaj
        WSEWYlHXtrquhMJ1BbTrxWpZYH9e0ZeDiIpVqqHFpgIJJve+ksJXpDgUz3r3WWp5O0Pw6KUh8Snl+
        NTf2PYMocMThZu4SC/kCLditpPReJg7wa+DlgijisTn//l2/GhSYR66VsMCP/0rEOnObZUQHKFuOa
        sxTZpx7w==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=46834)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kMwQL-00072X-LQ; Mon, 28 Sep 2020 18:54:49 +0200
Subject: Re: 5.9-rc7: BUG: kernel NULL pointer reference
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <eaa6a3d3-670f-b976-d65e-582b728d4567@skogtun.org>
 <CAHk-=wja+yd0Qc5=mR1=3-fKZUQNL2A6tUnob6HmjLhi9Ly8sA@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <55df6de8-67aa-82b5-e2c6-a34dde4dcd60@skogtun.org>
Date:   Mon, 28 Sep 2020 18:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wja+yd0Qc5=mR1=3-fKZUQNL2A6tUnob6HmjLhi9Ly8sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [28.09.2020 18:22]:

> On Mon, Sep 28, 2020 at 7:07 AM Harald Arnesen <harald@skogtun.org> wrote:
>>
>> I will try bisecting if no-one has a simple explanation.
> 
> There's a simple explanation, no need to bisect.
> 
> I'll push out the fix asap,

Everything is OK now.
Thanks!
-- 
Hilsen Harald
