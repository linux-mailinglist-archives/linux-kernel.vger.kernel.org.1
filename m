Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB1287708
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgJHPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgJHPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:21:07 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B542C061755;
        Thu,  8 Oct 2020 08:21:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ce10so8678343ejc.5;
        Thu, 08 Oct 2020 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7b9bPM9ozWv6eodPlM25Czef20DS/g6Ct72sKICVZ3M=;
        b=W9yQuzlFfqey107f7z3a98FoBs4EqT5pqQYUKi+TUBUfgNZ4+/wemOquoQFRjf1GQL
         D88bpziz/pjWU42I4bvg/Ph60wD8yU0/xoTT5u9DfQgMowILQeIO+E/h2Uik3hswBmLS
         GucDeRjQIoUkwmk2bqg9ppLbZJhcqOUYhqumimuQzMC53/EqE/I9u60mekxkUDknXtar
         2m3C0hRSekTY5++7XUJOCy+z6LRcrGzNItge0Cjgj4XrNlFqmFVANSAI3Pd9t7jb2+ov
         o8ayHVQ00ckvwqRTC0S5QIJyhhX2x6b8QIe0JtgRymQIYwsFiHYI1GXTM0dA1FHTt01V
         oOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7b9bPM9ozWv6eodPlM25Czef20DS/g6Ct72sKICVZ3M=;
        b=Hl19RwMvqRI/a2UBpJN5hen759m7BXEdfIORKzBV234eCI+94PWNTzqvDobDv7VVg3
         ke89PXpxhByfdiLmEmIQljphO12uvBbE8MxACkYllzaIIqp9FJ5sUoSSsk6o61S5fHGZ
         txlFkJhUCfd5UvPoSvpFMPuUl7YLuNn6rkqvbAx3BRwaf4/4TmUYmSt8TvFMB3crBf3G
         oSEvrGNWC2ZPEY5ajL4CvhK4dk7lAJnKHAqNQgiMOVnI3SPDcJWw12bk/5+ubuS5S/L6
         4jMw3H9H2iy+MJ1397MXSAK2PWQloHWVcz5YEq7388leGGHZWTaGZVDrDY1mASVkTJ3C
         hzNQ==
X-Gm-Message-State: AOAM5307OJYMfOcuF8Ah/nBoMkXymmn5n5CPhKiHSMesSGH/SsI+ZVUO
        den/YGPmFcR9Oz1cswJi+vt41Mwe/y0=
X-Google-Smtp-Source: ABdhPJzVCj3REfVxUBcJr6XGkysMBJeA0PuXLmQUsnoGcN8R2pHUxwepJAgSn/sYoI7dadiz4BbI1w==
X-Received: by 2002:a17:906:28db:: with SMTP id p27mr9501417ejd.424.1602170465730;
        Thu, 08 Oct 2020 08:21:05 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id mc4sm4331846ejb.61.2020.10.08.08.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 08:21:04 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] platform/surface: Move Surface 3 WMI driver to
 platform/surface
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
 <20201008143455.340599-3-luzmaximilian@gmail.com>
 <CAHp75VfPaGqb=yCpi_2f8SNzrj+0pd-r5VqAEgRgMCiJJB6D0w@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <79cf1a3a-93e1-5f34-27ae-9fea31a99df7@gmail.com>
Date:   Thu, 8 Oct 2020 17:21:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfPaGqb=yCpi_2f8SNzrj+0pd-r5VqAEgRgMCiJJB6D0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 4:54 PM, Andy Shevchenko wrote:
> On Thu, Oct 8, 2020 at 5:35 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> Move the Surface 3 WMI driver from platform/x86 to the newly created
>> platform/surface directory.
> 
>> -# place Microsoft Surface platform drivers here
> 
>> -# place Microsoft Surface platform drivers here
> 
> Not sure if we need these comments in the first place.

I thought it might look a bit weird having the "if" directly followed by
"endif" without at least a comment in between. I'll remove them if you
prefer that.

Thanks,
Max
