Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06FE2B820D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgKRQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:38:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04050C0613D4;
        Wed, 18 Nov 2020 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kaWjsdpjpN5LXJFbr3apPZfPhM8ZPQRzOwRezmytxfc=; b=ni/KvVsTrsHhVTTp0uXSKdQdPP
        efSxTQtf/JZCqql1NhPqJavZka9wb99k2Ywx2fwo4ZDZqscHX/MSGVx6Wr8GDlLLNYfMwmgnVimHN
        zwOWozkN62VhGkvcUK3OREauyrp8JjjUp6FZiqMh3baw7vKAEcRztk0Ov0/13i28qJoXAka5xXj2e
        zNrA1ZoX/xaugEYwvZ8jvz5BdIZ9z7B1awQWzZpUoJ8bLr3BkQtaAGQw9YcU0ZetHIlIyqjr2oE3D
        Yo5WxTTX/ywVaiabqlAbGkwygLFqzhFNS4z/K8Ai5XUP8jqOC1sLI79+yGjOk1anso5scLD67WP/U
        3q/IJY/Q==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfQTY-0005Dn-Uf; Wed, 18 Nov 2020 16:38:33 +0000
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com> <20201118154944.GB545@redhat.com>
 <20201118160748.GA754@redhat.com>
 <7ae2b73e-e6e5-3357-11e4-efd93e93ba35@de.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3116ea60-1dc3-9c15-31ec-5ce8ef72ba1a@infradead.org>
Date:   Wed, 18 Nov 2020 08:38:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7ae2b73e-e6e5-3357-11e4-efd93e93ba35@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 8:35 AM, Christian Borntraeger wrote:
> 
> 
> On 18.11.20 17:07, Mike Snitzer wrote:
>> On Wed, Nov 18 2020 at 10:49am -0500,
>> Mike Snitzer <snitzer@redhat.com> wrote:
>>
>>> I don't think my suggestion will help.. given it'd still leave
>>> persistent_memory_claim() without a return statement.
>>>
>>> Think it worthwhile to just add a dummy 'return 0;' after the BUG().
>>
>> Decided to go with this, now staged for 5.11:
>> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=a1e4865b4dda7071f3707f7e551289ead66e38b1
>>
> 
> Looks like a sane solution. Thank you for following up.

Yes, thanks again.

-- 
~Randy

