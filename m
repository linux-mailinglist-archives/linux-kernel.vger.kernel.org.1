Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3857234460
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbgGaLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:08:08 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4512EC061575
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 04:08:08 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id s81so1819401vkb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RtuJYuOeZ9aZxW7KJ9m2nVUm4WzUl8yyClqrsCRb5w=;
        b=p4vRZh00sf8zba/lrM/YmR3JmpmBBlB39gKQECas6LCuOiZJb/tlXwrpS9TB6as9cZ
         dAWaUg0BX3uq2NGxG3eX0sTRYo/004YRFDSCm7ZwNgkzyrIRXIEt0IxfmlxfTWE6sRAz
         FIdkGiwe5PNnxossM18nzlc7h/1bjc6t6/O0pewcF35Z1q9AhhRFGG8S4LSJ8DbYpA+W
         kWXsRFoYRS1jY6wri/TGLrdk7kZw0X1PM2SMOP8IyLx/63RklVMN0cGcG7PpMVwxkYp5
         x1bM+2Py+79Vb6dnQhvpKIXSSO6n+Td1LSE7Ai2mhRGvja60PjK8NP9f17aLd0NqpGt0
         ZV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RtuJYuOeZ9aZxW7KJ9m2nVUm4WzUl8yyClqrsCRb5w=;
        b=IaEX0Z3AzcapVDWLOWZqGwWaalQaQ/bTyY1vdC/hKyZA3HzW4ZurwMYOC5WUVE8tqy
         s46ouvDqyCnqariR9UDNoVfGC+yy+nXinbaYD/cVcF6hWPEYm+vj1NuUoQelEOpUhRTX
         WqciyHGa9Vdwk+5RYxeqBp9wH3MV4yYFz6Au0TbM3FjABnu3IHz1eIx1afZOGMB1ISwx
         zaQYibWexp9b4cmcuZf+2xK9eNzRwR6AmS2mza3XUrw4f7R0/wF5wpeuv5rnbJae/pkY
         5HV4JQwh71lncy+Gx4dcg7Z5p+YlFaep5CFim+ILhTyaPh1zcJbVrlNhAHS2OTmeryM7
         0wcQ==
X-Gm-Message-State: AOAM533w2ql2G2Z4nyhEIReGun4C2wOw5f4MED6kHMxKvWYhfC96m4k6
        Q0Ny8/TYAB4XVIw41/nh7ky8RBhS1tudUyfa1LEXZA==
X-Google-Smtp-Source: ABdhPJzQyptXAlQYJLkRPSg4Su00OAWYAwwnoqrl5meRHgp+FUZVASGE8GpdpE2TWoG+mVS2cMQT/lqxDPIpYdBMSCY=
X-Received: by 2002:ac5:cce9:: with SMTP id k9mr2180291vkn.17.1596193687096;
 Fri, 31 Jul 2020 04:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <20200724095232.5f9d3f17@oasis.local.home>
 <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
In-Reply-To: <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Fri, 31 Jul 2020 13:07:50 +0200
Message-ID: <CA+zpnLd+bTbhiVutj=DpfTHkJFsXqodu+PekqTPDcBB+UKsoaw@mail.gmail.com>
Subject: Re: [PATCH] RFC: selinux avc trace
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Peter, this looks like a great start.

> Perhaps the two of you could work together to come up with a common
tracepoint that addresses both needs.

Agreed.

> 1 Filtering. Types goes to trace so we can put up a filter for contexts or type etc.

That's right. I think this is the main reason why we would need
further attributes in the trace event.

> 2 It tries also to cover non denies.  And upon that you should be able to do coverage tools.
> I think many systems have a lot more rules that what is needed, but there is good way
> to find out what.  A other way us to make a stat page for the rules, but this way connect to
> userspace and can be used for test cases.

This is a great idea too.

>> On the one hand, we don't need/want to duplicate the avc message
>> itself; we just need enough to be able to correlate them.
>> With respect to non-denials, SELinux auditallow statements can be used
>> to generate avc: granted messages that can be used to support coverage
>> tools although you can easily flood the logs that way.  One other
> That is one reason to use trace.

Yes, that's right. I don't have any concern about the flooding here.
As Peter mentioned, trace is specially designed for this purpose.

On the patch, few things to note:

> ---
> +#include <linux/tracepoint.h>
> +TRACE_EVENT(avc_data,
> +        TP_PROTO(u32 requested,
> +             u32 denied,
> +             u32 audited,
> +             int result,
> +             const char *msg
> +             ),

I would not store the raw msg from avc. As we discussed, it is useful
to be able to match against the values we are seeing in the avc denial
message but these attributes should be simple (as opposed to
composite) so the filtering can easily be setup (see section 5.1 in
https://www.kernel.org/doc/Documentation/trace/events.txt). It makes
more sense extracting scontext and tcontext (for instance) which
allows for a precise filtering setup.

Here, I would also pass down the "struct selinux_audit_data" to avoid
a large list of arguments.

> +TRACE_EVENT(avc_req,
> +        TP_PROTO(u32 requested,
> +             u32 denied,
> +             u32 audited,
> +             int result,
> +             const char *msg,
> +             u32 ssid,
> +             struct selinux_state *state
> +             ),

I don't see that event being used later on. What was the intention here?

> +static int avc_dump_querys(struct selinux_state *state, char *ab, u32 ssid, u32 tsid, u16 tclass)
> +{
> +    int rc;
> +    char *scontext;
> +    u32 scontext_len;
> +    int rp;
> +
> +    rc = security_sid_to_context(state,ssid, &scontext, &scontext_len);
> +    if (rc)
> +        rp = sprintf(ab, "ssid=%d", ssid);
> +    else {
> +        rp = sprintf(ab, "scontext=%s", scontext);
> +        kfree(scontext);
> +    }
> +
> +    rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> +    if (rc)
> +        rp +=sprintf(ab+rp, " tsid=%d", tsid);
> +    else {
> +        rp +=sprintf(ab+rp, " tcontext=%s", scontext);
> +        kfree(scontext);
> +    }
> +
> +    BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> +    rp += sprintf(ab+rp, " tclass=%s", secclass_map[tclass-1].name);
> +    return rp;
> +}

As I mentioned before, this is literally repeating the avc audit
message. We are better off storing the exact fields we are interested
in, so that the filtering is precise.

Thanks
