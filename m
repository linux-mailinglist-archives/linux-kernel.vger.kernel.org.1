Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38B26DFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgIQPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgIQPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:25:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97EAC061788;
        Thu, 17 Sep 2020 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=+8Uahuv6B8JzyKr+68NNMng9KA/JRAa8Du+YW43o7PM=; b=r2V+1e1cC5J2I0YysafnwV8mdk
        v8buLS1F4VsC6NXj7s+0y5UkO8K1pwSbP091XCCQjbrbq8IQhe/jlX3JgXx+Gl4I+uAcTHISAmJvS
        whzRbgYPJ8tdC2nQfoVCKlXT4fWkL3kJGef5I1L+pvlW10BfPLQuPVUhMc2fu9LYKSfVRFJXwrGFw
        IP01eevM9gbWikpXh9pqobku9cRwpHUUQ9aW9xG4567VzBHReZmhuDSs5FRbCwr+2zkus0GBaDOml
        +rGX6EmkHCRMfOvKH4BeJCW7VHfC3iAnq0BAD08NOVC2xw45hDmRPH+7PKlcP3mvJy0LnfWbMgozm
        DJXBvvGA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvmP-0002PA-Ih; Thu, 17 Sep 2020 15:25:01 +0000
Subject: Re: [PATCH linux-next] docs:dev-tools: Fix typo in
 Documentation/dev-tools
To:     Masanari Iida <standby24x7@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        catalin.marinas@arm.com, andreyknvl@google.com
References: <20200917134407.63487-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8e79395-d281-d620-d9f8-1be53d8fa7e1@infradead.org>
Date:   Thu, 17 Sep 2020 08:24:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917134407.63487-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 6:44 AM, Masanari Iida wrote:
> This patch fixes some spelling typos found in
> Documentation/dev-tools.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  Documentation/dev-tools/kasan.rst    | 4 ++--
>  Documentation/dev-tools/kcov.rst     | 2 +-
>  Documentation/dev-tools/kmemleak.rst | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
