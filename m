Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E302E2C4608
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbgKYQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:54:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgKYQy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:54:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E1EEABCE;
        Wed, 25 Nov 2020 16:54:55 +0000 (UTC)
Subject: Re: [PATCH 1/7] mm,hwpoison: Refactor get_any_page
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-2-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1f2561be-15bb-9c74-16e3-719ddc310cb3@suse.cz>
Date:   Wed, 25 Nov 2020 17:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119105716.5962-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 11:57 AM, Oscar Salvador wrote:
> When we want to grab a refcount via get_any_page, we call
> __get_any_page that calls get_hwpoison_page to get the
> actual refcount.
> get_any_page is only there because we have a sort of retry
> mechanism in case the page we met is unknown to us or
> if we raced with an allocation.
> 
> Also __get_any_page prints some messages about the page type
> in case the page was a free page or the page type was unknown,
> but if anything, we only need to print a message in case the
> pagetype was unknown, as that is reporting an error down the chain.
> 
> Let us merge get_any_page and __get_any_page, and let the message
> be printed in soft_offline_page.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <Vbabka@suse.cz>

