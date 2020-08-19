Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8FD2494F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 08:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHSGUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 02:20:03 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36700 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSGUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:20:02 -0400
Received: by mail-ej1-f66.google.com with SMTP id kq25so24901057ejb.3;
        Tue, 18 Aug 2020 23:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=el+F6G6X74vs681XhpTMhoN92meVVmppJ6dMHUb8u5s=;
        b=q9OKDBF5lfC70/MY76NGmsQKAhpbFkK3NweccqZhgUy2PfAxbmqfYKlWfv2TVEpgXx
         ZtuY8rBHCPPEWaPNJ1JqSPHRyPf9hlGpE5KDkEALG3/XA3bVdlfWUn4VVQZOGm4tWLmH
         utrJjls1quog+5NBDfA+VTn5SXCiuUapEt9ayscyCH3n9qBqtFQbTqKSl2RQGF6vqOG0
         RkLuGAPqCk9RIMcDVbAXCLJw2wZnN9kRLTb8rpg5b7Lx/ZKXXNMxm8YpzQPpbuDd6ccA
         5CpB+GMXaa88wHT/Z76YStqrrNmPgVIJcur7bEZKLx4rmBiG5RGZmsmtllrPQv86GD7m
         qn5w==
X-Gm-Message-State: AOAM530xJW+XEZanonCXPdbFKgUXJ1KnTrhhxiHO/yL7xRL+PD6BG0hF
        Z7UK/XkUdZNotjLvZtitUjX09oktFuY=
X-Google-Smtp-Source: ABdhPJxZRI+rHX1AL3hw80zpDQrRYPm0EuVAmVt4YL9021IB+bNagX7l7JaJOvbIX2gil9cAe9M8gA==
X-Received: by 2002:a17:906:858:: with SMTP id f24mr23152924ejd.543.1597818000880;
        Tue, 18 Aug 2020 23:20:00 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id d2sm18214610ejm.19.2020.08.18.23.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 23:20:00 -0700 (PDT)
Subject: Re: [PATCH] n_gsm: Fix write handling for zero bytes written
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200817135454.28505-1-tony@atomide.com>
 <1b8538a8-d8b6-4287-36e1-aa1e0863ff2d@kernel.org>
 <20200818095609.GQ2994@atomide.com>
 <ea5e0639-4419-c60b-059a-8fbd057fc6e3@kernel.org>
 <20200818104714.GR2994@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <34dd61d2-01c3-dcc1-21bd-494eb90759ac@kernel.org>
Date:   Wed, 19 Aug 2020 08:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818104714.GR2994@atomide.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 08. 20, 12:47, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [200818 10:14]:
>> On 18. 08. 20, 11:56, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Jiri Slaby <jirislaby@kernel.org> [200818 08:24]:
>>>> On 17. 08. 20, 15:54, Tony Lindgren wrote:
>>>>> If write returns zero we currently end up removing the message
>>>>> from the queue. Instead of removing the message, we want to just
>>>>> break out of the loop just like we already do for error codes.
>>>>
>>>> When exactly does the only writer (gsmld_output) return zero for
>>>> non-zero len parameter?
>>>
>>> I ran into this when testing with the WIP serial core PM runtime
>>> changes from Andy Shevchenko earlier. If there are also other
>>> cases where we have serial drivers return 0, I don't know about
>>> them.
>>
>> Sorry, I don't understand: my gsmld_output() ignores the return value
>> from drivers' write and returns something greater than zero or a
>> negative error. What tree/SHA do you run?
> 
> Oh right, good catch. I also had my WIP serdev-ngsm patches applied
> that uses gsm_serdev_output() and returns the bytes written. Andy's
> patches do not touch n_gsm.c.
> 
> Hmm sounds like we should also start returning value also from
> gsmld_output()? Any objections to making that change?

No objections here.

thanks,
-- 
js
suse labs
