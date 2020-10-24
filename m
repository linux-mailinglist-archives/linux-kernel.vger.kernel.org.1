Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FFA297F87
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 01:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762934AbgJXX3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 19:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgJXX3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 19:29:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D35C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5xjWrW3AnAivnG9ZA6h7p+ZwOrfNhNJvyr+GYf7Re/8=; b=E9rGCnk4GKdRAxEuff3pQ0ST+k
        qwRM3pwGC/ZhsJmKMdo+jjvkuDvZ73vVcNWb4tPiXxepdsdY3YZW5b0MYezVxsk+F98gMHg2FnS7L
        mN0yFPLFht8twgl0tpKNVlhV7pGjQoltBrwR0no/th53u5Cn38RGG/meGbMKNB9ZCb+25VDS8EvjJ
        6wEhFz7VfmUTOyY1q1CJGfQswFO0hndicFPJlbcPqv4CCxCTinUgww6ja2P/uWzXqYIJXkCrhMipo
        T1wFQQqXOQfDMy+9ef427nnoKLoHJIB6jpnun3lTa22KrHuz/BR0JGsTqg7xcFggIHOI4ePt5AhMm
        Lr80xLYg==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWSyp-0003vz-S2; Sat, 24 Oct 2020 23:29:48 +0000
Subject: Re: [PATCH v3] checkpatch: extend attributes check to handle more
 patterns
To:     Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <20201024090557.45092-1-dwaipayanray1@gmail.com>
 <1d9d4793a6f89dda2e06ae73065ed7a28b50e02f.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5964afb2-c014-6894-242d-caca3b179f5c@infradead.org>
Date:   Sat, 24 Oct 2020 16:29:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1d9d4793a6f89dda2e06ae73065ed7a28b50e02f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/20 4:21 PM, Joe Perches wrote:
>> +				if (exists($attr_list{$curr_attr})) {
>> +					my $new = $attr_list{$curr_attr};
>> +					WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
>> +					     "$new$params is preffered over __attribute__(($attr))\n" . $herecurr);

					                     preferred

Sorry if that has already been mentioned.

-- 
~Randy

