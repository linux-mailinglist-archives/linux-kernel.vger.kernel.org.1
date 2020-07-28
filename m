Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181AD230AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgG1NEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgG1NEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:04:45 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BBC061794;
        Tue, 28 Jul 2020 06:04:44 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so5690973qtn.9;
        Tue, 28 Jul 2020 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bAL6Aq3KWDEofuTw4uy1CRZnHFagUpXW9EymxiLs0/8=;
        b=ETQxn7wQmg1tdBR0z9Pwm9LU2FhCwB9T4YCOvvMN3UI3aWhWnABcAyQbJ1NUeVu2Q6
         axeeADibCYX5tgoTXojet+AhY27S5J3mjB2g56owZZ/nSdQu9/5ymXc1bBVMXQb4MKvy
         BXuA3Uon5PmB98ay0mYrcJuMvTlBqL3C4pakzxuFsBJ4iOG3yvxdzG3IHYdmoZ7a3nex
         BIlUmXmphnwne4m5ANDiBo8PAk/k3jB/zfs7kBQKa1EfqKOmVO8xgUUPDsK7P3YVJyCL
         nQEDZMGLsRr58677WDPgYw59gpAFlruqFIrRcOn8X+v6UQ3kEjtFgD47Si6g47ocMjYU
         gXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bAL6Aq3KWDEofuTw4uy1CRZnHFagUpXW9EymxiLs0/8=;
        b=OFI7STEb+DyqHjWzYbZbvoIfK/5ixO0Rwenh92KtbVIDvDtn9MBNlo3kJjd6iMySls
         W0+ykiSPnRvc7GBbbhYTelz49YOtYZ22bTpge/Akepblbru1q7YjSgaog+oBPecczeRf
         G5Q/F2/KF3r1k8wK9X9iARYrZhZh7ScuNPmb7AQKotO/RnzBrdnudZy2TkpMOZbQuzHO
         JmcyS9CZAlmu/hWYTcVqcZarlLEXAMUESaVEnmOxLb3Kc9YdFZH7s7z2s+oQPdmraMOV
         BoyspEOW9i6qvTDOu+aLjahMet/ZnCV1WqrC+I60W23VvAYmnF5F62DXHxS9NIzBwPxV
         6KJQ==
X-Gm-Message-State: AOAM530sNakW2MvI0iY3TVDRbIanFv8VwI0P02K+1toENV3vkkJJ3oND
        RCzJwytmBMTm45lTWsZk8rdwOIrv1Ls=
X-Google-Smtp-Source: ABdhPJytHLlhTJZPZ7zJmSnZHX02tzLEHhHXTQKUlRv1A9/z/cbtuX5D75npOSV17l/W8ptZF7O4MA==
X-Received: by 2002:ac8:65cd:: with SMTP id t13mr1497637qto.368.1595941483928;
        Tue, 28 Jul 2020 06:04:43 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id l11sm18030737qti.59.2020.07.28.06.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 06:04:42 -0700 (PDT)
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20200724091520.880211-1-tweek@google.com>
 <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <1859cc5b-2fb0-432b-2635-35ce79dbc244@gmail.com>
Date:   Tue, 28 Jul 2020 09:04:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 8:49 AM, Thiébaud Weksteen wrote:

> Thanks for the review! I'll send a new revision of the patch with the
> %x formatter and using the TP_CONDITION macro.
>
> On adding further information to the trace event, I would prefer
> adding the strict minimum to be able to correlate the event with the
> avc message. The reason is that tracevents have a fixed size (see
> https://www.kernel.org/doc/Documentation/trace/events.txt). For
> instance, we would need to decide on a maximum size for the string
> representation of the list of permissions. This would also duplicate
> the reporting done in the avc audit event. I'll simply add the pid as
> part of the printk, which should be sufficient for the correlation.

Ok, also please use unsigned int for the fields and %u for the cls value.

(btw top-posting is discouraged for mailing list discussions, see 
http://vger.kernel.org/lkml/#s3-9)

