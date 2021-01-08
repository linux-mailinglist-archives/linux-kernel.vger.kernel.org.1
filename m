Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33582EEE38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbhAHH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 02:59:22 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43559 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 02:59:22 -0500
Received: by mail-ed1-f42.google.com with SMTP id y24so10259548edt.10;
        Thu, 07 Jan 2021 23:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XgxocXanKUK3WcPXgyk3GPEznii50h5p/rUjDFov25U=;
        b=ITzrritX5ftF8Y6LvsAH//UkP0cN/z4klfw+wMPGq+HN4CsWlQZ5Keloy1/5B/jBsx
         HBjtFGHs5ybA607SXg64VMJUhILP5knDF6EWbOBDjtVFkcK2mkuZN3ZaeuELtxg2onqR
         HCJXRfwO9HFsiNgKNZeETNA9dFAwL+tt2E3U0CyrqipCkPe8Z0WBizPeJ+SsK6UqVuiy
         q6ow6yYJZikXnq+his3uqE4jPWW6TOvBtXhczjfPXiocvzXevUtdqMqlEoDGCq9LoVwT
         ybALo4Wq9w7oWypZn61Rc4g6QfUkFYCCDpGKf2iWHRgTBlc9M2BVjwnbb6Je/JvJDiR0
         838w==
X-Gm-Message-State: AOAM532oHqS9MKWLr289bLvo0xZE7f1qM9I3SnZI/CKq36/clDkMkqtG
        biG2zVCw0takZpni9myZAot7Trxsbgw=
X-Google-Smtp-Source: ABdhPJxGkO9yrJAbN8iv6b2UqNFjlclNpzeu4rLyZ13WMxnHxbrNVfbXZuQk3HPAPONW6G0L7+4sDQ==
X-Received: by 2002:a50:9ee6:: with SMTP id a93mr4504876edf.174.1610092719982;
        Thu, 07 Jan 2021 23:58:39 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id a10sm3259591ejk.92.2021.01.07.23.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 23:58:39 -0800 (PST)
Subject: Re: [PATCH v2 1/1] tty: serial: owl: Add support for kernel debugger
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
References: <036c09732183a30eaab230884114f65ca42ca3b9.1609865007.git.cristian.ciocaltea@gmail.com>
 <X/cm1+wVQpoXj5Xr@kroah.com> <20210107181604.GA427955@BV030612LT>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <02c664f5-8107-7757-2e20-c446a0458539@kernel.org>
Date:   Fri, 8 Jan 2021 08:58:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107181604.GA427955@BV030612LT>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 01. 21, 19:16, Cristian Ciocaltea wrote:
> Hi Greg,
> 
> Thank you for the review!
> 
> On Thu, Jan 07, 2021 at 04:20:55PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Jan 05, 2021 at 07:02:02PM +0200, Cristian Ciocaltea wrote:
>>> Implement 'poll_put_char' and 'poll_get_char' callbacks in struct
>>> 'owl_uart_ops' that enables OWL UART to be used for kernel debugging
>>> over serial line.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> [...]
> 
>>> +
>>> +static void owl_uart_poll_put_char(struct uart_port *port, unsigned char ch)
>>> +{
>>> +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
>>> +		cpu_relax();
>>
>> Unbounded loops?  What could possibly go wrong?
>>
>> :(
>>
>> Please don't do that in the kernel, put a max bound on this.
> 
> I didn't realize the issue since I had encountered this pattern in many
> other serial drivers, as well: altera_uart, arc_uart, atmel_serial, etc.
> 
>> And are you _SURE_ that cpu_relax() is what you want to call here?
> 
> I'm thinking of replacing the loop with 'readl_poll_timeout_atomic()',
> if that would be a better approach.

It might be better, yes. Either way, if you add a bound to the loop, you 
definitely need a more precise timing, so ndelay/udelay instead of 
cpu_relax.

thanks,
-- 
js
