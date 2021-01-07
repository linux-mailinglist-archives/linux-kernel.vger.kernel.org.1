Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE392ED2FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbhAGOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAGOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:46:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE10C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 06:45:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e25so5780325wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 06:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QB0S0Y5U+ARFOleYx/eJAtsfe0KVrVk0V/q2KSZYjNo=;
        b=uXy916hmWj9wSMjjFM196YIPTgkU5VVpP+P6+IkFosUGRe1iZ0dPFpcA6UprN1HvRr
         8VSI+owGXWz+nCdg3l9fWE4nQjZwiZVpGAG2rx3jkaITPb+2aTXeAYfCkrKBDxNku/TT
         GBaR3/YGqDsVOEDwCs42/rmEp6Ii+JuNtD1YI+8qTpHpK2YBLn/c/rcHHRT93ejUpwv/
         34677ScSWNT3zpciZlOab8FRKln8hvesLx8466U8WrSa4PGGvronBJRczHa2/0hvyWtS
         l8sjbX04/d8nEPRUfw9kavIgT/w505aS8gZ9ER7QyO0KdEon5P/PITjRnB3K1wpVRLjJ
         3DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QB0S0Y5U+ARFOleYx/eJAtsfe0KVrVk0V/q2KSZYjNo=;
        b=MLDFbnrp0b8zKcQ0kNKTNinvK7e/rw+JM3pYShn4mzCk7X4Off1RKyhx1+tGLDgyNk
         suNV0BEiCYljt3SOhmVJS4hb90UpAg4ARmHErSbbtr2lGPZ8LOgpm5nK2GnbSGR2qKtn
         cAgX475dFFx+QsTaD8oVFQ6P7/K5dYJL7da/UyeKcYTUd5vNtKVBZnkOocDiJ9lE449N
         YDTuRxFFCNCti6qwpILQ72pfX6CUgivdE8jcwgB8lfwd1OPQQk4h08QC5XHoIP41Ffb2
         2fpHtrVF3uJA0lFUmnWwX01CH+kxoJh/Z91LVEewZLG6IQPFOouI+XoAGQBh4hk2VDrF
         xp5A==
X-Gm-Message-State: AOAM530xNAzSaCPss2KlXFes/7Zmvq62si3+1kgUVYyswMWcNCl6M29k
        /bIpMwSV0Hw28PcuxE7f3D0=
X-Google-Smtp-Source: ABdhPJxSyxhvFefzjKqcRR/odlKAbw8R0ckddb+jAK0q7/x4r2IXAYl1m/bIhhPLgIP4oRrYWpEa6g==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr8612225wmb.12.1610030735583;
        Thu, 07 Jan 2021 06:45:35 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id v20sm9101570wra.19.2021.01.07.06.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:45:34 -0800 (PST)
Subject: Re: [PATCH] software_node: Add kernel-doc comments to exported
 symbols
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, sakari.ailus@linux.intel.com
References: <20210104234736.419493-1-djrscally@gmail.com>
 <20210105145329.GO4077@smile.fi.intel.com>
 <3d92e535-c955-502a-24ac-0655752796fc@gmail.com>
 <20210107141932.GJ940479@kuha.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <2e0ca2e5-feaa-bd3b-c680-0ad7c7c2d651@gmail.com>
Date:   Thu, 7 Jan 2021 14:45:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107141932.GJ940479@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki

On 07/01/2021 14:19, Heikki Krogerus wrote:
> On Tue, Jan 05, 2021 at 03:39:42PM +0000, Daniel Scally wrote:
>> Hi Andy
>>
>> On 05/01/2021 14:53, Andy Shevchenko wrote:
>>> On Mon, Jan 04, 2021 at 11:47:36PM +0000, Daniel Scally wrote:
>>>> A number of functions which are exported via EXPORT_SYMBOL_GPL() lack any
>>>> kernel-doc comments; add those in so all exported symbols are documented.
>>> Thanks, it's helpful!
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> after addressing few nitpicks
>> Thanks for reviewing
>>>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>>>> ---
>>>> With a view to maybe writing some documentation once the fwnode_graph_*()
>>>> functions are also added.
>>> FWIW, Heikki used to have a draft patch of swnode documentation, not sure
>>> what's the current status of it.
>> Oh cool ok; I'll defer to him then.
> I actually had a similar patch prepared as part of the series adding
> the documentation for software nodes, but your comments are better
> than mine. So, after you have addressed Andy's comments:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Great, thanks - and for the other R-bs just now also. I'll send a v2 of
this one tonight/tomorrow (depends how much else I get through)
