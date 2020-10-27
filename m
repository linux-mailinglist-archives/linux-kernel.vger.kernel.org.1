Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C712329AB40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1749392AbgJ0LyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S367978AbgJ0LyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603799650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcz7Jh3j3aQGwV+LI07wyYiNRQxa8Qovi53GHA6Gqy0=;
        b=El20sh9sVXbfKdy3sN8v4lpETtvxPlUspp3PwpDwoEnvbcTTmkAyGMKCmobUJ1k1F6yyN9
        OjOq/10wKOtP98v6zsIYdYIx9Mvjup3ZWEaXvT2l9paJag2HPy9njGvuziSpWD/2UPcqp/
        c4Sen2NQzanoZOP5ByU3uDnanO+BuwQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-jMDKppbaOtiquwpprNiSSw-1; Tue, 27 Oct 2020 07:54:08 -0400
X-MC-Unique: jMDKppbaOtiquwpprNiSSw-1
Received: by mail-ed1-f71.google.com with SMTP id t4so576835edv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 04:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wcz7Jh3j3aQGwV+LI07wyYiNRQxa8Qovi53GHA6Gqy0=;
        b=OGG8hH3oze6kuxoEfhIKbiJLDW0jW1SWrJRJ0OIhhLKHEvBBsfndd4pfbKqTWutptp
         75OJEs5VxX2Du3uv8XYPovkF28IuE7oxcNM+yTIEUy+sx67hG1ybtqrlY29fUNlNXJ/G
         ES7q9UsrnU6kpfKnfEQ07NmkPJiIaZzDK6NS1TtyNz9ufd81y/L0YKMo8+adbCAvCtmI
         5xZN6eDNoi6H52By4QFmw7pTGuA/tQ3ST3t8XTsvfYXwLrwWzjsliskyIkN7oH1vxyNR
         IiVaGsjZj5plCjZNl20aXalLn++N9wTKQVjMFAl3R1a774BRZblHIoAgCVYnsh+tQSNd
         FhyA==
X-Gm-Message-State: AOAM5305sm/yfjNXvbaAuduDutv1CmLdgWLF0Atqgf7VCyK+h8GtI37D
        hMKMp0iwuqWH1lzDmRO/oXJ3clg1py8h/2iLzS0iBVAvG8Fm/2XxAPz5oaPMWJ0Mi9OwqDE4Axg
        wce6pZuKe796klH3S9ZnFkb3b
X-Received: by 2002:a17:906:3e48:: with SMTP id t8mr2007252eji.104.1603799647131;
        Tue, 27 Oct 2020 04:54:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6dQuaGLcdO4jOMamhPnr6gep/CM2TLxXgKYxUPWXuFnpPAvU7Fy+O7IlgITHOocrLrwUSQ==
X-Received: by 2002:a17:906:3e48:: with SMTP id t8mr2007237eji.104.1603799646898;
        Tue, 27 Oct 2020 04:54:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id h15sm890976ejf.50.2020.10.27.04.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 04:54:06 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] platform/surface: Create a platform subdirectory
 for Microsoft Surface devices
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <20201009141128.683254-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <63c4454f-a8a9-badd-421c-ea6b018bf01c@redhat.com>
Date:   Tue, 27 Oct 2020 12:54:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009141128.683254-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/9/20 4:11 PM, Maximilian Luz wrote:
> As has come up in the discussion around
> 
>   [RFC PATCH] Add support for Microsoft Surface System Aggregator Module
> 
> it may make sense to add a Microsoft Surface specific platform
> subdirectory. Andy has suggested drivers/platform/surface for that.
> This series follows said suggestion and creates that subdirectory, as
> well as moves Microsoft Surface related drivers over to it and updates
> their MAINTAINERS entries (if available) accordingly.
> 
> This series does not modify any existing driver code, symbols, or help
> text.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up there once I've pushed my local branch there,
which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

