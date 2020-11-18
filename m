Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A692B8150
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgKRP5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:57:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbgKRP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605715030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MUNtPoxOzFRYk7ZaLZB61FQy8r/ffEvOd46mt4ErR8=;
        b=c9iM5Sva+UKR6Vj/39sQ8xiZ6dqq+KR5tXM9ogF308r5LF1+ffIbLXuaREGLrEYvUMKH39
        vCzBgSQnfiT8Re7FnR98YIZsbVHTLSvi4ig011wFB52Tfx1vtKVHyZ8Iot0pLqKPXa7jGT
        NdCthu9yCAkof92GzFQRDM6Rud1uFNA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-Qw8z7D_qOpuNeg6gq8YLCw-1; Wed, 18 Nov 2020 10:57:08 -0500
X-MC-Unique: Qw8z7D_qOpuNeg6gq8YLCw-1
Received: by mail-qv1-f71.google.com with SMTP id y21so1601552qve.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7MUNtPoxOzFRYk7ZaLZB61FQy8r/ffEvOd46mt4ErR8=;
        b=W/5/0vYg5Cga/vEHwd9q+fu/5ggGGuepHQPXEhwiymPlJXcnQDJfBu6V4JWKgNK3ih
         PvSRGHgR6EAf1/C201C6ui/2MJ5K8UXNSpGDLQmijwE7LM7J7VncMLx2zYqJrrlR3zRf
         3JfqTqbDELuqGeySOzEgbYCjKBcW0bqN/2Oh+LCAjq1pjOLxt3dSt2BjNeJVzPAE/sp4
         I9sfJ0xjp3gl8r4N73fXVH9ZDLiyDWIV5sQwqgRaYNPzU90IkNOKQ0pZaPokWazwgXjF
         YYa9JxH53Ig2BdFpsbZKpoHVZ6T2/y31qFJsAFChb++NHc9OexldYBk2u0y9pX238ht2
         h52g==
X-Gm-Message-State: AOAM533jn4nM4xDAz8V+/CRs00EZpJh46fhQi5CP2LYDVMzfKGWHJSye
        /cCtw9eiC7QLOmTyNg/yR4doGpcGaq0AgvfZmMWdKcVBk3I86J56M7txkvx005aBiGZmZi4ch3T
        V/KSLg4/u9CjsGWqlY87vFDeq
X-Received: by 2002:ac8:2fa2:: with SMTP id l31mr5297257qta.86.1605715027757;
        Wed, 18 Nov 2020 07:57:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsDbT1P6U1bP9LZOVd6Q0kOCs3g4rLcoASoTUrH3oZa0kODquz39ngYh2mNa3cUkK4wh2T2g==
X-Received: by 2002:ac8:2fa2:: with SMTP id l31mr5297232qta.86.1605715027554;
        Wed, 18 Nov 2020 07:57:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 189sm12287408qkn.125.2020.11.18.07.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 07:57:07 -0800 (PST)
Subject: Re: [PATCH v5 5/6] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-6-russell.h.weight@intel.com>
 <3c531b5d-0620-5239-06a7-02a01381c436@redhat.com>
 <4819688e-4967-360d-6ba7-36b93735b42d@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3fe70aff-b0ac-22dd-5f90-53924b20d8ef@redhat.com>
Date:   Wed, 18 Nov 2020 07:57:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4819688e-4967-360d-6ba7-36b93735b42d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/20 4:10 PM, Russ Weight wrote:
>
> On 11/15/20 6:17 AM, Tom Rix wrote:
>> On 11/13/20 4:55 PM, Russ Weight wrote:
>>> Extend the MAX10 BMC Secure Update driver to include
>>>
>>> +
>>> +	status = rsu_stat(doorbell);
>>> +	if (status == RSU_STAT_WEAROUT) {
>>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>> If wear out is going to flood logs, move this to a warn once.
> There is no danger of flooding. The WEAROUT error will only be seen after 1000
> flash updates have occurred - an unlikely condition. It will also only occur
> once on an update, and only if they attempt to flash within 60 seconds of
> power-on or within 60 seconds of a previous flash.
>> Maybe make rsu_stat a function.
> Is there a reason to prefer a function in this case? Or should I change
> rsu_stat() to RSU_STAT() to make it more clear that it is a macro?

i was thinking a function could manage the warning messages.

If it will not flood, it is ok as-is.

Tom

