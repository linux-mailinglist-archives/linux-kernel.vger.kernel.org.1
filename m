Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23F28CA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403988AbgJMIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403825AbgJMIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602578925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/QWwyJCZVVi79Fpwwugg94L9LWczQbwfUHt0ZL/p3g=;
        b=cm3qicCZPcTEQ3IY7eKBG0DzA/LRcPTfufXqL0fSlCjoUC39E3MI7OUYHWE+yK7tleY1Wk
        trRA7SrzBerCEoSDlmrSYDo9RNHsQCbi0TU5cbk2HXf8vCQn6yB+eTJycBx4lOArxAzmKr
        ACa7fCdAdwrg7ulow8T4P0H15HeKYTI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-CoDvQx5BMAKhend5RDcSoQ-1; Tue, 13 Oct 2020 04:48:44 -0400
X-MC-Unique: CoDvQx5BMAKhend5RDcSoQ-1
Received: by mail-ej1-f70.google.com with SMTP id j2so7301281ejm.18
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L/QWwyJCZVVi79Fpwwugg94L9LWczQbwfUHt0ZL/p3g=;
        b=PgWaOu670rtuD6yRDUy4ISGubuaiDIjrngoAg8HbL6ol6NKwZL20qta52+jpQWJKn0
         xPlDhQA0IwM4Tm2PQN4pd5p/1DGLmrxGkUns26g+UNOIS8cxj86lr5gHOz9Rcy6jQvKC
         la9HIK7IgQpMYGioafJLI8oNl8r0p6GgpZym5im2CNUoC7FhzcFIPQ4UDc0sB2Xm6FwV
         Z0f7UOqkqtE212XE09yG9k/7dqMx69RJ/MZQJI9hzbbRYuvRC5XwRspi3421RmKSd4y0
         jaDseJC13ljBNJYQ3TqguXu0kG+SC3te7Z4bvboukv3Yc7naPApPSsH7gcgIVDxEQstQ
         X34Q==
X-Gm-Message-State: AOAM532XZxNykQaZmOCanZBoWB9TK8fjO7M2EoA4fAqodU6uvKe55H33
        EGyIr7YQhsBkXVC/FToDdwF1oQHyfOEQV1xUpr/Sq40VZRRRVAyAIwwo5Akehj50AGkBZ+Gqlnb
        +j49k6asCEdAwmTZ8LbgyoGJ1
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr19434261edr.247.1602578922897;
        Tue, 13 Oct 2020 01:48:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkImKSu++3puTyZJwJQzVLd6jKat579AuQM33hTsdLksyUK9sskK1mHYSCtX/CgETiRSSYEQ==
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr19434238edr.247.1602578922662;
        Tue, 13 Oct 2020 01:48:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m25sm11908739edp.36.2020.10.13.01.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 01:48:42 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Ed W <lists@wildgooses.com>, linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9fb836bc-7d8a-b6e2-8d73-8e74a8f2e38b@redhat.com>
Date:   Tue, 13 Oct 2020 10:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico and Ed W,

Quick self intro: I have take over drivers/platform/x86
maintainership from Andy; and I'm working my way through
the backlog of old patches in patchwork:
https://patchwork.kernel.org/project/platform-driver-x86/list/

On 10/12/20 9:39 PM, Enrico Weigelt, metux IT consult wrote:
> On 22.09.20 00:17, Ed W wrote:
>> Hi, I've been adding support for the PC Engines APU5 board, which is a variant of the APU 2-4 boards
>> with some nice features. The current platform driver for pcengines boards has some redundant
>> features with regards to recent bios/firmware packages for the board as they now set the ACPI tables
>> to indicate GPIOs for keys and leds.
> 
> NAK. Breaks existing userlands in the field (literally field), forcing
> users to fw upgrade is not an option (field roll would be realy expensive).

Thank you Enrico, I was wondering the same (what about userspace breakage)
when I was looking at this patch. It is good to have confirmation that
userspace breakage is a real issue here.

And I completely agree with Enrico, we cannot go and break userspace,
so some other solution will need to be found here.

I'm marking this series as changes requested in patchwork, please submit
a new version which does not break existing userspace.

Regards,

Hans

