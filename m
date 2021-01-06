Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5F2EC60E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 23:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbhAFWKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 17:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726999AbhAFWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 17:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609970949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xTfqp/cnQanwSVgtCnzk15O1tB24PFg3CJKydXU40A=;
        b=Mgok3LkaKysddMHK1bYfmDUNHeQH6MYMsNOu0cblHJiMlY03RgOmwEiaLSGvVsXblzgLvc
        Rxjzb/hulTVNndf/N9VpTt1GPdR2Xv8zAsJQQ2xrkcgBoiJtXpDpGd7tNrLKpEyMy3g7Rh
        tfNk5UzjfasLhPRXAiq50uxZr8r2h+E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-1QrdUc1yNk2e-nMbsDv81w-1; Wed, 06 Jan 2021 17:09:08 -0500
X-MC-Unique: 1QrdUc1yNk2e-nMbsDv81w-1
Received: by mail-pj1-f70.google.com with SMTP id bj5so2635906pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 14:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5xTfqp/cnQanwSVgtCnzk15O1tB24PFg3CJKydXU40A=;
        b=NZ7lnuB+zv+u4OZfQYQo6eaGLfZ6vK81bzHA2uFq3HDWTyD4hnbnYgEkp2CgpXGbLH
         5fPyQ69lnVM02hnnIAzQcWfoYHodWuDfvGoR2puPzkYaBdpDDrDKRRbOF8c1AAhHh9PO
         Y4DQfoXEOf6ypCM4Vp+LRLx+RTrdOkMas4RmY/t4WqahAJBr5IeMmoopsierIpcVJskx
         H57HBnF4PTzYVY61r2gGJ2tMDQW/Fc9El3BkwAXriP0j08ognP4pZPVoj7A5ggzruTF6
         yw6zF6h8AsjNZUsq3HBDwZGf7qFC0dMw4e6GJ8175xF/WcOYYSVy/ycN02KLS/+9U877
         umFA==
X-Gm-Message-State: AOAM532zC+JsTeOjFOswEgJLTTJ6cZgXNHpX7d4RP4vvgJJuoiqpWwpn
        wDG9/Y0ikP8X9s++us1dzqzwwOQwFehusDEh7ckMM6/QdFEFVDe0xQNj0rPxZF09CEzRTTFl5lW
        HOI++AG6/kAegHVEJtg8QDtwT
X-Received: by 2002:a17:902:6b84:b029:dc:3423:a24a with SMTP id p4-20020a1709026b84b02900dc3423a24amr6329255plk.31.1609970947119;
        Wed, 06 Jan 2021 14:09:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXv6R1GMOq6pMfQ3fEim+tdu83D/aaUaUjNmnRljgB/CqQ96fR/ozt43mntG38d1hbdQgXaA==
X-Received: by 2002:a17:902:6b84:b029:dc:3423:a24a with SMTP id p4-20020a1709026b84b02900dc3423a24amr6329236plk.31.1609970946862;
        Wed, 06 Jan 2021 14:09:06 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l7sm2978695pjy.29.2021.01.06.14.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 14:09:06 -0800 (PST)
Subject: Re: [PATCH] rxrpc: fix handling of an unsupported token type in
 rxrpc_read()
To:     David Howells <dhowells@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <07564e3e-35d4-c5d4-fc1a-8a0e8659604e@redhat.com>
 <f02bdada-355c-97cd-bc32-f84516ddd93f@redhat.com>
 <548097.1609952225@warthog.procyon.org.uk>
 <c2cc898d-171a-25da-c565-48f57d407777@redhat.com>
 <20201229173916.1459499-1-trix@redhat.com>
 <259549.1609764646@warthog.procyon.org.uk>
 <675150.1609954812@warthog.procyon.org.uk>
 <697467.1609962267@warthog.procyon.org.uk>
 <706521.1609967368@warthog.procyon.org.uk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8db4e32e-a587-e0ab-d4a6-678cfbc7173e@redhat.com>
Date:   Wed, 6 Jan 2021 14:09:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <706521.1609967368@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/21 1:09 PM, David Howells wrote:
> Tom Rix <trix@redhat.com> wrote:
>
>> On 1/6/21 11:44 AM, David Howells wrote:
>>> Tom Rix <trix@redhat.com> wrote:
>>>
>>>> These two loops iterate over the same data, i believe returning here is all
>>>> that is needed.
>>> But if the first loop is made to support a new type, but the second loop is
>>> missed, it will then likely oops.  Besides, the compiler should optimise both
>>> paths together.
>> You are right, I was only considering the existing cases.
> Thanks.  Can I put that down as a Reviewed-by?

Yes, please.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> David
>

