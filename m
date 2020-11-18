Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB732B8277
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgKRQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKRQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:58:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB35C0613D4;
        Wed, 18 Nov 2020 08:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OLiv4AGEtXr2TSyDL2HPnVGELo0cjp6BgdhiaEAlc+w=; b=PbLE4QvkFiOAnemBa+9rA2SFG/
        C/rV1dHz9ergTdIEXyQIGqP/HKhnEZCFTdMWiIaq+M/i2pZO6pNAFEm/aQdQL7pgBcppYXEl0Gsjh
        47QyqllWq25PB8EahwS2dv19g3vjLTD5JMeP1iQbpvu18ELMpZlVIbw85ajdY4q0y0Wt1jhj1ItNd
        36Bq4mxAuscJgqt02qaqauUeIWrytiJYwyPTSs9eq92wmzxnSAjnWaeg9Pnvw1KESUm0YbBkRbhxd
        V7ZlNDF+voNa/ju8gvuMPjG4KqjQFk20rvHimS/Afu+hch6ejW2esGsB1E7eHiKIr5DU6rIUsWHnH
        NdMbb3hQ==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfQnG-0000Ar-4C; Wed, 18 Nov 2020 16:58:54 +0000
Subject: Re: [RFC] Add kernel-doc test script
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
 <20201117213051.GA29991@casper.infradead.org>
 <20201117223612.GN1235237@habkost.net>
 <16145b8b-3213-8bc9-1826-d3ae006f78fa@infradead.org>
 <20201118130344.GD1509407@habkost.net>
 <b0d6dc09-49ea-f96e-278a-6fc0f78de810@infradead.org>
 <20201118165730.GL1509407@habkost.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <289ee6ca-1c36-02ac-65bf-fbf834568c73@infradead.org>
Date:   Wed, 18 Nov 2020 08:58:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118165730.GL1509407@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 8:57 AM, Eduardo Habkost wrote:
> On Wed, Nov 18, 2020 at 08:32:35AM -0800, Randy Dunlap wrote:
>> On 11/18/20 5:03 AM, Eduardo Habkost wrote:
>>> On Tue, Nov 17, 2020 at 04:23:49PM -0800, Randy Dunlap wrote:
>>>> On 11/17/20 2:36 PM, Eduardo Habkost wrote:
>>>>> Add a kernel-doc test script to tools/testing/kernel-doc.
>>>>>
>>>>> radix_tree_lookup_slot test case provided by Matthew Wilcox.
>>>>>
>>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>
>>>> Very good idea.
>>>>
>>>> I have had a kernel-doc test source file for (?) 10-12 years,
>>>> while I was the docs maintainer.
>>>
>>> Is that test source file recoverable somewhere?  It probably has
>>> useful test cases not included here.
>>
>> Sure.  Of course, it may be out of date by quite a bit.
>> I last updated it in 2016:
>> -rw-r--r-- 1 rdunlap users  41737 Jun 17  2016 megatest.c
>>
>> (attached)
>>
> 
> Thanks!  Are the contents licensed under GPL 2.0?

Sure!

-- 
~Randy

