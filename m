Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2B2F4701
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAMJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbhAMJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610528388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuTRToQJZ9ENJOQ+foe03ejm+/o+GM2tw6NDRHaUP34=;
        b=PqFcpTvdUHGQIEhZG8gLKvecDQP7lP6KStDL4/1UGgio8e4Uyd52SK85sVc19JM+37f0AN
        xbLH7nC4sLNgNmzpKnuv9rTOjIrsJzkANOrdSPnMOwA70rZ/yNzIVKxF/TdjTMyQu45E/5
        cCc9S9ODqqMkeg2Cd55nXRwVzsI9wrk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-09SX36qnP0mCktVf8W-FPA-1; Wed, 13 Jan 2021 03:59:47 -0500
X-MC-Unique: 09SX36qnP0mCktVf8W-FPA-1
Received: by mail-ej1-f69.google.com with SMTP id j14so488281eja.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QuTRToQJZ9ENJOQ+foe03ejm+/o+GM2tw6NDRHaUP34=;
        b=HeeSATAFRy1jkI8NKx3J8GZekZbJ1GiYH7LDBcvv7AEekwzZvWPE7gULz3tS96p8hf
         rmR8jR6Z2RDEaUx6iD1Ne9Qmkt4stks+Rqk9SVTdy633nRZMlGFjZAH5OKqJ+BparOwF
         Nd7sQk+a4PdQ6EbAnABq1aaZiHULnTiHx1tvqfV6Mz2+L11EpVuSygkcTQmgQHNZoygt
         vsEy91vVKFi6AOYNnc6OWOFj1docZuLX134M+TQh9CRNOFgNtr9YGnb2FvfBM/dBICAk
         OhU6DW6EvEpxbe9MZCZeHBKrCzrvVXv7cjk2fYlJx+TD4wfVgsJuiSiZG9eKGL6PKczN
         8DCQ==
X-Gm-Message-State: AOAM5339m8VqawOyWBap9ZhSuySizUndRuaNsjIBHQi8xP/gOEx0sYKZ
        GvmKCT5nHbPNWMQy2xlhEalCajQCqWvf0VO9gTafrSSdXjKqbKyGdHkBwpd2mdtZ4X+ahF6Sz3x
        ft63yz5eXswoLb1Sd/GUwwrHGsETjA168Y5yRqvxfPT1R/6owLrd84yYmwlwWrdcGyJ8VLnE+AH
        04
X-Received: by 2002:a17:906:adce:: with SMTP id lb14mr825182ejb.502.1610528385612;
        Wed, 13 Jan 2021 00:59:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFa+J3n+6YPkg6zlbrlGTjqx+UvGVawy0I7OSetvR0OSlaqpYHVx5JIy3LcDri33K59tFgZQ==
X-Received: by 2002:a17:906:adce:: with SMTP id lb14mr825165ejb.502.1610528385451;
        Wed, 13 Jan 2021 00:59:45 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id ga11sm441697ejb.34.2021.01.13.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:59:44 -0800 (PST)
Subject: Re: 5.11 new lockdep warning related to led-class code (also may
 involve ata / piix controller)
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Dan Murphy <dmurphy@ti.com>,
        linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b204637d-3b72-8320-8a62-f075467d8681@redhat.com>
 <20210112223015.GB28214@duo.ucw.cz>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f344f1db-1a7a-0a80-1cb1-f9c3fbf83abd@redhat.com>
Date:   Wed, 13 Jan 2021 09:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112223015.GB28214@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/12/21 11:30 PM, Pavel Machek wrote:
> Hi!
> 
>> Booting a 5.11-rc2 kernel with lockdep enabled inside a virtualbox vm (which still
>> emulates good old piix ATA controllers) I get the below lockdep splat early on during boot:
>>
>> This seems to be led-class related but also seems to have a (P)ATA
>> part to it. To the best of my knowledge this is a new problem in
>> 5.11 .
> 
> This is on my for-next branch:
> 
> commit 9a5ad5c5b2d25508996f10ee6b428d5df91d9160 (HEAD -> for-next, origin/for-next)
> 
>     leds: trigger: fix potential deadlock with libata
>     
>     We have the following potential deadlock condition:
>     
>      ========================================================
>      WARNING: possible irq lock inversion dependency detected
>      5.10.0-rc2+ #25 Not tainted
>      --------------------------------------------------------
>      swapper/3/0 just changed the state of lock:
>      ffff8880063bd618 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x27/0x200
>      but this lock took another, HARDIRQ-READ-unsafe lock in the past:
>       (&trig->leddev_list_lock){.+.?}-{2:2}
> 
> If I'm not mistaken, that should fix your issue.

I can confirm that this fixes things, thanks.

I assume that this will be part of some future 5.11 fixes pull-req?

Regards,

Hans

