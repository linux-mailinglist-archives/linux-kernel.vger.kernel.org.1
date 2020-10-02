Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3C281966
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbgJBRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgJBRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:37:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547F1C0613D0;
        Fri,  2 Oct 2020 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=to+vK9pP2dLguamTHaczaBybq3kiyFTh/VeqEu6seGE=; b=0v7YjrRvVixifVEoCgtySQpeGD
        Drk8eBf6oWg8XNIRsgxvG89pt718BNgZVvVQ2q4D8lpnbz9LxHprroh6h22ouE//Ec/8ApgnVU/QQ
        Zbsa7aL9AlHmw/t3ityWKMEIjyRn2e96Rsuf6Wix6OjBc2WBA4oK+YFAggU6MR6JZZ770kIhZIP2a
        q1pR0WVT4TrMZXZ28BJVJdwE2StKO+mUUhoA6UuIt5ka5C+d5IY2tOGdP5nod8BgOy9yyBc5khRmD
        tn2nQYR4hrmAd2yEjbzKSYtEHb1AleKmVyHKGpltvj6X4+Zu7mKxGwxu6h/q7fxWv1SfN9oIUBa2A
        deYoazIg==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOP0A-0005nF-Pl; Fri, 02 Oct 2020 17:37:51 +0000
Subject: Re: linux tooling mailing list
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>, nickc@redhat.com,
        maskray@google.com, linux@rasmusvillemoes.dk,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org, postmaster@vger.kernel.org,
        peterz@infradead.org, behanw@converseincode.com
References: <CAKwvOdmFm9-FPrqt42NsusWRbDzNx6NF1GeSJhz_9kaAGV8eOA@mail.gmail.com>
 <20200930173719.GE2628@hirez.programming.kicks-ass.net>
 <CAKwvOdk+Rp0QGJmX07XxD8L7WVgco98LHFTu-R_2R22+UMVerQ@mail.gmail.com>
 <20200930.152652.1530458864962753844.davem@davemloft.net>
 <CA+icZUXjYTJO4cC1EAhbdqnd19HjAwyFM+iSTW37xJM5dFHQuA@mail.gmail.com>
 <20201002172238.GT28786@gate.crashing.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4cf8e2ba-3120-7f25-a9a2-1707d3f88276@infradead.org>
Date:   Fri, 2 Oct 2020 10:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002172238.GT28786@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 10:22 AM, Segher Boessenkool wrote:
> On Fri, Oct 02, 2020 at 02:01:13PM +0200, Sedat Dilek wrote:
>> On Thu, Oct 1, 2020 at 12:26 AM David Miller <davem@davemloft.net> wrote:
>>> From: Nick Desaulniers <ndesaulniers@google.com>
>>> Date: Wed, 30 Sep 2020 12:29:38 -0700
>>>> linux-toolchains@vger.kernel.org
>>>
>>> Created.
>>
>> I am subscribed, too.
>>
>> Will there be a(n)...?
>>
>> * archive (for example marc.info)
> 
> A lore archive would be good?

That has already been requested.

> 
>> * patchwork url
> 
> We do not have any repositories associated with this list, and there
> won't be many patches anyway, so patchwork will only be useful as a kind
> of mail archive.  I can ask to set one up though, if people want that?
> 
> 
> Segher
> 


-- 
~Randy

