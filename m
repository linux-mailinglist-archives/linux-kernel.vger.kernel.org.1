Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8667224828
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 04:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgGRC5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 22:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRC5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:57:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FAC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+2Uc220xiIEAAq1KTnqAalELI3crqv9FnpCqCw6dtXA=; b=QJlYHOeIFg+IXZPcJ5kaAln532
        H276tMlaca5dXAJLi5lG1DR2gz0VjHMqWH7k0DyyyDtRzvLIrUC7yk9AGtlPPOutbmngoz3BcF/LD
        8V5SqIjit1P+UEhSnQqRDFZnXPOiEDDap+g777gLIR1zZJt3hJNxnBKQGG21AvJFh+u/93FzoLyzp
        iivKdnoczL1uttK4Uy2+eeMm67t0hY6DzouSdk36PsFkvwoaImqvYqlfXyptMAw816fm54tjZOzih
        /cMw8J2nGmv2PYbNtz11mMzzqJ7OcU97mo7PCFpV/AcUuwcoQbyRPgqXWgi0nOhNDlE1rnAWXJlF2
        EPzbBR0A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwd2M-0006vg-OA; Sat, 18 Jul 2020 02:57:19 +0000
Subject: Re: [PATCH] highmem: linux/highmem.h: drop duplicated word in a
 comment
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
References: <57b70139-4f2d-c520-0882-f310c2b64b65@infradead.org>
 <20200718025308.GT12769@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8c4dc787-b650-da92-51d8-f617a32c1e7b@infradead.org>
Date:   Fri, 17 Jul 2020 19:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200718025308.GT12769@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 7:53 PM, Matthew Wilcox wrote:
> On Fri, Jul 17, 2020 at 07:52:07PM -0700, Randy Dunlap wrote:
>>   *
>> - * However when holding an atomic kmap is is not legal to sleep, so atomic
>> + * However when holding an atomic kmap is not legal to sleep, so atomic
> 
> instead, s/is/it/
> 

Yes, will resend.

thanks.
-- 
~Randy

