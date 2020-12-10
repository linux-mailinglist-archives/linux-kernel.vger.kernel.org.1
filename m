Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4DC2D53B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbgLJGRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgLJGRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:17:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616DCC0613CF;
        Wed,  9 Dec 2020 22:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yUO807Um276FtA7btiIrTKbtdq/+/urED8qmMHlTed4=; b=uHD/s79Zc5ENvsKx0qHo2KxKmA
        pJBiDhpJWeNP/K7QAEdEgmuAtjnhBBlL+eTqEB2F+l5Z9bSt4ZJgg8EDuPvI0OS/FrsD6V1bxjxuZ
        vdn3/eMlL+MoNqLnRzJgbj/ubvDBcir5gISijnyCscRqoKzimp6Riin/CUyC0LWLqxt7WDu8HPUN9
        XPEfymjb71OOUQEdY8t0NOA/IGnW9v7/LqMiFYG8JwnPYFx2rhbnzvSrk3U4WdI9C4ho3Z2tEkj8w
        H0r24Lod3LzAKiPxMkOUFqtSwPQyGjgKDQBFgseqbI5C/FRHsrdW4Ihcr6GSI1J1tLDAqq5GqeTe3
        w6NxkaMQ==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knFFa-0000lG-Tj; Thu, 10 Dec 2020 06:16:27 +0000
Subject: Re: [PATCH] block: blk-iocost: fix build for ARCH with missing
 local64.h files
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Peter Zijlstra <peterz@infradead.org>
References: <20201209204657.6676-1-rdunlap@infradead.org>
 <20201210060742.GA19263@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <04828b4e-8791-6f3e-8984-9de06f40c85a@infradead.org>
Date:   Wed, 9 Dec 2020 22:16:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201210060742.GA19263@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 10:07 PM, Christoph Hellwig wrote:
> On Wed, Dec 09, 2020 at 12:46:57PM -0800, Randy Dunlap wrote:
>> When building block/blk-iocost.c on arch/x6x/ or arch/nios2/, the
>> build fails due to missing the <asm/local64.h> file.
> 
> Please mark it mandatory-y if the asm-generic version is suitable
> for everyone and random pieces of kernel code are supposed to include
> it.

include/asm-generic/local64.h has comments about some $arch could do
its things better/faster instead of using asm-generic, but no $arch has
done that since 2010 when it was added.

Is that conclusive?
If it is, why even use mandatory-y?
Why not just change all occurrences of <asm/local64.h>
to <asm-generic/local64.h> ?


thanks.
-- 
~Randy
