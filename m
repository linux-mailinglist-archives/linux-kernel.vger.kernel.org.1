Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E21B3072
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 21:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDUTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 15:35:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59471 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbgDUTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587497707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDbNCpaQ63uuID2gepUGZxv4j3nJ6Y3J26CZxvwRo5k=;
        b=PWAo4xkzu6z29Jox/HJYN/892kVtmn4xyQqMKfFOXAiS3YMtFiBeYy/JMGMfL4Sa/izDzR
        hVUfqa+Z5kYuzK6y/+JtcnmaAz1TWaDW2VE9xt7ysUavrNZfl3vAVJPwRdd2OcnvvRAMyc
        Xgk6kkzgiK20nBW75m8AZpFyJNB5SU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-3wgr-Z2eMkSi9uCIkh26bQ-1; Tue, 21 Apr 2020 15:28:56 -0400
X-MC-Unique: 3wgr-Z2eMkSi9uCIkh26bQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 178FF8024D3;
        Tue, 21 Apr 2020 19:28:55 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-241.rdu2.redhat.com [10.10.114.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A37D7B3A8C;
        Tue, 21 Apr 2020 19:28:49 +0000 (UTC)
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
 <20200421105948.4f5a36f5@gandalf.local.home>
 <22ccb042-7d6f-3717-4024-9ec094b2f363@redhat.com>
 <20200421151649.11300568@gandalf.local.home>
 <3a747a8f-629e-f9d2-088d-963791d99486@kernel.dk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7faa2e43-5b3b-fe36-2f51-3791490048fb@redhat.com>
Date:   Tue, 21 Apr 2020 15:28:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3a747a8f-629e-f9d2-088d-963791d99486@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 3:17 PM, Jens Axboe wrote:
> On 4/21/20 1:16 PM, Steven Rostedt wrote:
>> On Tue, 21 Apr 2020 14:36:29 -0400
>> Waiman Long <longman@redhat.com> wrote:
>>
>>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>>
>>>> -- Steve
>>>>  
>>> OK, will send a v2 patch to update the commit log. Thanks for the review.
>> I think Jens already took this patch.  Doesn't sound like a v2 is needed.
> I did, with modified subject line.
>
>
Oh, I see. Thanks for taking that.

Cheers,
Longman

