Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B897285999
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgJGHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgJGHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:33:20 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B79C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:33:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so1159093lfj.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:message-id:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+yhAtKBkJAhd84Dg7hmzBchD0bnksTdEsvNNdIrfzU=;
        b=r86zR5CSiSdiaQOjoa/A8EDooKjhNyFIVPPxIsH0NcfFkcCH2wGYXZvgMw4WNpUfjN
         wp+WYl6jQ5qPOHnH+HO7tgxbr0PfbKGYJcBmUn4m4sDf3JU5OuSdypBT3U2P3uhj43nD
         Wjv2GArTiOxtr0UjpGuyWCkDdsn+VHfaIUulqXlbXYooq29TR5Y7SHk5O2aX3GWKaPDO
         fHDn8Kv0Ec2RFIdZ6T0qwpH/JzAD9qkzj5fjD2S6y++H9i9DRd5cPAGyv3aH4HPI2QT/
         XOizhVEn8nlG4WF6EZ92FXpBOWnfncOXnUUMDYmQcs+U2tt9Z6r4bkP6ipbbFAU5gEjt
         gw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:message-id:to:cc:subject:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+yhAtKBkJAhd84Dg7hmzBchD0bnksTdEsvNNdIrfzU=;
        b=KicJ9JYxfPkiOUdck7dOomvfk9fYw00/JXJDxEL1mwo3GWUK0tMODVg5+QLzMgFn+8
         huobsIrOfwCc52leMdq/bKdu6XDGZpXbPpf99v96aZNtj+aAoHDh1kvv1jSL2/2sGrfx
         ElQ3SFLx+m0Yjk2/cRcRy9IwnXAXVbM+4HZO/yj1juQTW6L5JkGHq1l0CNiQzJ4JB2UP
         CiL1i2tyV8t6bMYWMMHcqP5gdIeG4Ayd1hZXB3mSfh682WJ6/95hL3ZBjS9/Ly1Umvx/
         CKWqqipvy1Au0rmcBIq1GI308yy/YBwMSMW49dw8n8tPaOOwsLPfbJ2eh8r7QmQChE5x
         W9Jg==
X-Gm-Message-State: AOAM533+G8c6fx9diZMcIhVoR2mLC/IfO9iNJ5k8TYJGaYQdrck7oXmX
        3sjKOz45hW6p8ZwfWfMeyiepSg==
X-Google-Smtp-Source: ABdhPJyO4JVtlsxVmVera4axbDrjS/Qfw7ukoANOngtFtqjd/hzKbeyjxyppntyjZG4oAWKR1LpSqA==
X-Received: by 2002:a19:68a:: with SMTP id 132mr494362lfg.429.1602055998298;
        Wed, 07 Oct 2020 00:33:18 -0700 (PDT)
Received: from [192.168.1.25] (128-70-41-239.broadband.corbina.ru. [128.70.41.239])
        by smtp.gmail.com with ESMTPSA id o18sm200728lfl.282.2020.10.07.00.33.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 07 Oct 2020 00:33:17 -0700 (PDT)
Date:   Wed, 7 Oct 2020 10:32:27 +0300
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
X-Priority: 3 (Normal)
Message-ID: <1561045277.20201007103227@wirenboard.ru>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Evgeny Boger <boger@wirenboard.com>
Subject: Re: [PATCH 2/2] w1: w1_therm: Add support for GXCAS GX20MH01 device.
In-Reply-To: <20201006151915.77d044a4@coco.lan>
References: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru> <20200904160004.87710-2-ivan.zaentsev@wirenboard.ru> <20201006151915.77d044a4@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday, October 6, 2020, 4:19:15 PM, Mauro Carvalho Chehab wrote:

>> diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
>> index f1148181f53e..00376501a5ef 100644
>> --- a/Documentation/w1/slaves/w1_therm.rst
>> +++ b/Documentation/w1/slaves/w1_therm.rst

>>  
>> @@ -130,4 +131,12 @@ conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
>>  power), the driver returns a conversion error. Bit mask ``2`` enables poll for
>>  conversion completion (normal power only) by generating read cycles on the bus
>>  after conversion starts. In parasite power mode this feature is not available.
>> -Feature bit masks may be combined (OR).
>> +Feature bit masks may be combined (OR). See accompanying sysfs documentation:
>> +:ref:`Documentation/w1/slaves/w1_therm.rst <w1_therm>`
>> +

> As warned by Sphinx, this cross-reference is broken:

>         .../Documentation/w1/slaves/w1_therm.rst:125: WARNING:
> undefined label: w1_therm (if the link has no caption the label must precede a section header)

Would this be ok?

"More details in Documentation/ABI/testing/sysfs-driver-w1_therm"

> Not sure what you wanted to point here.

A link to a driver's sysfs interface, but sysfs docs are text
files and seem to not be included in Sphynx Docs.

-- 
Best regards,
 Ivan                            mailto:ivan.zaentsev@wirenboard.ru

