Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BACC2BB16E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgKTR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728370AbgKTR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605893259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBlEgbLZs7AvDq7L3CpN4OLqF8+f4MmKhyEP6BHda2g=;
        b=ILm8VrqYokotidFnr3BJ4cNZdt/7RzKiPu56qleh1uV+J8O1NDHfON+ipfNIKOpS6k+qhZ
        STP2GJvjFlvaaX+rQ397CARipEnoIzLGgZnlCqIr+/cxXHwiRVx2+MTnCE2TEx9iMh36oI
        CB2z8dxszd6lnl65JqZHWxntW86j0+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-YRnh0r55NoO0Om4HkkJWNg-1; Fri, 20 Nov 2020 12:27:35 -0500
X-MC-Unique: YRnh0r55NoO0Om4HkkJWNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 931B58145E5;
        Fri, 20 Nov 2020 17:27:34 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-157.rdu2.redhat.com [10.10.118.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56A2C60853;
        Fri, 20 Nov 2020 17:27:33 +0000 (UTC)
Subject: Re: [PATCH 2/5] locking/rwsem: Prevent potential lock starvation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-3-longman@redhat.com>
 <20201120144438.GG3040@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9de07371-b479-8e05-c810-6f7a12918919@redhat.com>
Date:   Fri, 20 Nov 2020 12:27:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120144438.GG3040@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 9:44 AM, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 10:04:26PM -0500, Waiman Long wrote:
>> +	long rcnt = (count >> RWSEM_READER_SHIFT);	/* Reader count */
> I'm thinking you can do without that comment, the variable name is clear
> enough.
>
Sure.

Thanks,
Longman

