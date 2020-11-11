Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0732AF53A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKKPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKKPmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:42:13 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A3FC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:42:12 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id l12so2382578ilo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z9fVURIh1ER6ryj3li/bebG5BOkx6rFg0fsV5guNvWI=;
        b=Ho3JBDNNIVPE4/GwgCS1VzTOC770TDnSxBlntV0nhBGRbxZ59U7hm7+NsBw51FiB0u
         g3/XOj+ah9TAuRr4+bcoruY7D1dHifRt0oGdxEU6ZfygBGeqWmWn4ous38dhWzM3mni/
         dtGoIZHhv0siIg/+usU/s+an5Is2f65bPVOrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z9fVURIh1ER6ryj3li/bebG5BOkx6rFg0fsV5guNvWI=;
        b=F9muDKK6+h9SBii7PEgelORF+Cg47indRuQOVH8yg3pLuqcZW6tXJjkLlAJDx4TYgI
         wjPzWvOcfy68poXoil2ErVrLmzcZdgv9TZEfdwMXqieWvw2I0nHZ1TReCSKS3iyxyxoP
         t13lgCLOunZiPMQmd4CLxWQoPczmV94GwaJLTjZC1G74aY52ZmrZU/6+DCFHDHl7Ub64
         h+J4I+9FjWv9/uD67Nng8LEVOy7r3ACf4mFpZIh8mIJ5M/Zbqb9Uw57m6WzxtUqcXqEJ
         nheMl55UgVa8blre0SkZukHgdKcezmIUc/VExykHqpTPj8U2EB3+bF2CQ8AD4Sw+zCR6
         ZELQ==
X-Gm-Message-State: AOAM531GR0M0vMtd2/8eKLCtxailNQ9dalc4vJDjd+8W9t/KDSlzWldv
        3Hvqx5LWG1TOSkFtVy0R2sIWGw==
X-Google-Smtp-Source: ABdhPJwsr569jIVesYjxm/+fgY2MvsX62MIEDQSgyZMjjD+bNdv4lH2nZ/r/ftaN0VOKuA7ob5LlTg==
X-Received: by 2002:a92:c88c:: with SMTP id w12mr20306988ilo.204.1605109332217;
        Wed, 11 Nov 2020 07:42:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i18sm1471925ile.73.2020.11.11.07.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 07:42:11 -0800 (PST)
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201110210316.GO17076@casper.infradead.org>
 <11b5153f-e092-d1c9-deb1-e81a171bb866@linuxfoundation.org>
 <202011101619.341C9C7E64@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d0d6a857-6e12-1a41-c4bf-8fcc92d94d0a@linuxfoundation.org>
Date:   Wed, 11 Nov 2020 08:42:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <202011101619.341C9C7E64@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 5:20 PM, Kees Cook wrote:
> On Tue, Nov 10, 2020 at 03:58:48PM -0700, Shuah Khan wrote:
>> Yes we have some instances where unsigned is being used. I considered
>> going to unsigned. Changing the API to unsigned has other ramifications
>> and cascading changes to current atomic_t usages that are up counters.
> 
> As in, existing callers expect the "read" value to be int?
> 

Correct. In addition, these values are returned by other functions as
signed and it will result in lot of churn to use unsigned.

thanks,
-- Shuah
