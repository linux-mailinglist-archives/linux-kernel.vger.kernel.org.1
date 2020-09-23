Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14516275F34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIWRy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgIWRy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600883666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sokdh26ArEfE8v9Yk4X6wHJe97Xz4ftXB2OeeqEReqQ=;
        b=Cj6vl7HM4cBqd26TY+pBqDVfdOKITeEJMVts1ifaRagqyafjxquyFsotEv45aXRXwQhA5F
        SPfDZSyP6aFeXDaVuYyYcQWyBrIqA/anPQfjDo0Lgw5VU9AutsXmxsEuwcCbYSrzyhZVg6
        tJUpWmmF1Wprsurubjpbb2IyfMDjtl8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-uKpa70ANOXucCKoCfj35Og-1; Wed, 23 Sep 2020 13:54:24 -0400
X-MC-Unique: uKpa70ANOXucCKoCfj35Og-1
Received: by mail-wr1-f71.google.com with SMTP id y3so126162wrl.21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sokdh26ArEfE8v9Yk4X6wHJe97Xz4ftXB2OeeqEReqQ=;
        b=Bgsb2My0sP4BjyEnyZY4VbxFLe/AHNJFx2Clr8sTtnwux3kNFrZ6FnDB0uU2O75jPV
         nE7/1T4zPW+FXfOEV/bDRqAhhqt7C6yD5wiylbISBhbZR0hgGjn8xhkO5fCUXqsc8cVj
         oLJykfrF2D4Qhmp29vew0pQSY0arbgo+mO6RKICHAwhgdtw3QPchhr33wZCxG9qn+pJi
         T1Eji58lBZYlXC/2z8euY8kj1+mi2pxr4HVZHd6ClLRz7m1HXlJGVRHkPTRFLwnF/UIa
         KpbEqezgUQ2xQoQeS57kwW2YmmeQzcyvrDpd2PlMXQ+t/XWEcE5GEx49x0by7yCTGk3g
         PUzg==
X-Gm-Message-State: AOAM532r+OEXlCg7lb1EBz8TFZd0cvVaiKg2dLGSgKjpezuTr/hi/4rg
        K9KjK3fCEeCknoZ1xrdxMq1H1kW4BxF6CWLy4Hm9qEgGfxR++4/f6ZUews/o0VxQ1IHohe/6R8i
        sKpQIm6Y+NFtkHpe+bsuPNG9i
X-Received: by 2002:a7b:c359:: with SMTP id l25mr656619wmj.125.1600883663644;
        Wed, 23 Sep 2020 10:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRfJQO+DYDQ/8NQseyaBmBthL3c0+ii5eknDiTDp6Y8jOu0lIrscI04iYYUfyZuI5Qau2zkg==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr656603wmj.125.1600883663404;
        Wed, 23 Sep 2020 10:54:23 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id y6sm535432wrt.80.2020.09.23.10.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 10:54:22 -0700 (PDT)
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
To:     peterz@infradead.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vincent.donnefort@arm.com
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <87v9g7aqjd.fsf@nanos.tec.linutronix.de>
 <86929eee-36da-93a5-5280-00e6df1ef496@redhat.com>
 <87v9g4ao8h.fsf@nanos.tec.linutronix.de>
 <20200923170809.GY1362448@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <ba44b3fe-352c-384e-5bde-c26e3a03011d@redhat.com>
Date:   Wed, 23 Sep 2020 19:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923170809.GY1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 7:08 PM, peterz@infradead.org wrote:
> On Wed, Sep 23, 2020 at 10:31:10AM +0200, Thomas Gleixner wrote:
>>    In practice migrate disable could be taken into account on placement
>>    decisions, but yes we don't have anything like that at the moment.
> I think at the very least we should do some of that.
> 
> The premise is wanting to run the M highest priority tasks, when a CPU
> drops priority, it tries to PULL a higher priority task towards itself.
> If this PULL selects a migrate_disable() tasks, it means the task is in
> the M highest prio tasks.
> 
> Since obviously that task cannot get pulled, we should then pull the
> current running task of that CPU, this would then allow the
> migrate_disable() task to resume execution.
> 
> I'll go try and cook up something along those lines...
> 

sounds promising...

-- Daniel

