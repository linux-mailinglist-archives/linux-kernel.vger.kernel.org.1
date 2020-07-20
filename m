Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD5225DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 13:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGTLrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 07:47:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728524AbgGTLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595245667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynpLds+mNFt1PnIoPvN1ltsQTgb/FhKjLQm67olPb38=;
        b=IRkt7CJkY7uEqCpJuW+TcSw+7pUaDsGmoLB402mxtVxlp5xBLVtSCqSMZTWM7OaipP1Th3
        0aDtZt205sxH6hv/vPGKkPk0SRQUoD29WIMI8DTLuZsHn3mJR07qwaXbNWwi++fgegbUhU
        bbMrIx2W5pfh1EBcHIdDsYD8hs34154=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-zbtqdPoRO16Rp1Y661hzMg-1; Mon, 20 Jul 2020 07:47:45 -0400
X-MC-Unique: zbtqdPoRO16Rp1Y661hzMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52DBE18C63C0;
        Mon, 20 Jul 2020 11:47:44 +0000 (UTC)
Received: from [10.10.114.255] (ovpn-114-255.rdu2.redhat.com [10.10.114.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B39112DE64;
        Mon, 20 Jul 2020 11:47:43 +0000 (UTC)
Subject: Re: [PATCH] Revert "kbuild: use -flive-patching when CONFIG_LIVEPATCH
 is enabled"
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        live-patching@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <696262e997359666afa053fe7d1a9fb2bb373964.1595010490.git.jpoimboe@redhat.com>
 <fc7d4932-a043-1adc-fd9b-96211c508f64@redhat.com>
 <9c53c755-a497-25f0-40ae-7e435be3269b@linux.vnet.ibm.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <940c041f-84e8-337b-ae98-1086119ddf9a@redhat.com>
Date:   Mon, 20 Jul 2020 07:47:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9c53c755-a497-25f0-40ae-7e435be3269b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 4:50 AM, Kamalesh Babulal wrote:
> On 20/07/20 9:05 am, Joe Lawrence wrote:
>> On 7/17/20 2:29 PM, Josh Poimboeuf wrote:
>>> Use of the new -flive-patching flag was introduced with the following
>>> commit:
>>>
>>>     43bd3a95c98e ("kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled")
>>>
>>> This flag has several drawbacks:
>>>
>>> [ ... snip ... ]
>>>
>>> - While there *is* a distro which relies on this flag for their distro
>>>     livepatch module builds, there's not a publicly documented way to
>>>     create safe livepatch modules with it.  Its use seems to be based on
>>>     tribal knowledge.  It serves no benefit to those who don't know how to
>>>     use it.
>>>
>>>     (In fact, I believe the current livepatch documentation and samples
>>>     are misleading and dangerous, and should be corrected.  Or at least
>>>     amended with a disclaimer.  But I don't feel qualified to make such
>>>     changes.)
>>
>> FWIW, I'm not exactly qualified to document source-based creation either, however I have written a few of the samples and obviously the kselftest modules.
>>
>> The samples should certainly include a disclaimer (ie, they are only for API demonstration purposes!) and eventually it would be great if the kselftest modules could guarantee their safety as well.  I don't know quite yet how we can automate that, but perhaps some kind of post-build sanity check could verify that they are in fact patching what they intend to patch.
>>
>> As for a more general, long-form warning about optimizations, I grabbed Miroslav's LPC slides from a few years back and poked around at some IPA-optimized disassembly... Here are my notes that attempt to capture some common cases:
>>
>> http://file.bos.redhat.com/~jolawren/klp-compiler-notes/livepatch/compiler-considerations.html
> 
> Hi Joe,
> 
> The notes link you shared is not accessible.
> 

Oops, lets try that again:

http://people.redhat.com/~jolawren/klp-compiler-notes/livepatch/compiler-considerations.html

-- Joe

