Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0734D26FB75
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIRL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:29:10 -0400
Received: from smtp2.axis.com ([195.60.68.18]:1583 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgIRL1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=615; q=dns/txt; s=axis-central1;
  t=1600428472; x=1631964472;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=h4YCEEeTnq5wqR3bOx8qJ07wGEpA+/95zKv+vF6jvJo=;
  b=VZsF46akfDhGF2j2QrqQa1xsMiVOSVHsnlESQvC4GN4tk4l2Z52yeFyw
   mw/my6HEz52WRCltGb/JyIz/dpMMqBNkVjjdu+nMo4xd6PDmnEn+pIJJk
   XRphNFVHTogFsu1bAlu/HMQT6AnJGooy4Agp55RJZLWjWmYIRT1l33hN9
   +8+157Godm9jFR/KafUooHUswpHOpTtoPOLnFYM4jpj+hAzjts5wOHdLb
   xrCs0fZYbqAHC1GzVlGfy7wfZMiFxK96hLiPZzY4FvHwrAmM/TcY6Wq0n
   aViu7dniBaBDe4EmmTPH2wGMIqbKWEVHY2X2Vqkn9VhX4zrxt7Z8x0vYM
   g==;
IronPort-SDR: JB/JZc/kR1SsBLT+S5n9ea8zW0Ip7fomSAUGq5decezV3v+Y4jEOZH0IqoyV25Ka3Khnom4nXz
 4g0qSTrB5dUaEQMXQVbjU+QHmLjPYe/+vVhO9Apj5po4/9EECOw+EIL4TWjn70d7nOhz81aZq4
 J7Muo4VsnamotHR0J1zGHaBC8ZWJL1/lgftE56e2akx43sQ9i8IlBhPFerlU/69LitN5iHudtl
 zIz5pX6iq4VqcuoUqMDW2Ql7PQ0VI541A88MD88D9CrXDbt62JwKs2iE7kcJ6oaZsGnRZ7NyQu
 ycE=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="12636837"
Subject: Re: [PATCH v4] ASoC: tlv320adcx140: Add support for configuring GPIO
 pin
To:     Mark Brown <broonie@kernel.org>, Camel Guo <camel.guo@axis.com>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <dmurphy@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20200918073229.27348-1-camel.guo@axis.com>
 <20200918111823.GE5703@sirena.org.uk>
From:   Camel Guo <camelg@axis.com>
Message-ID: <b5cc9041-62ea-d578-db28-c1ab8ec50842@axis.com>
Date:   Fri, 18 Sep 2020 13:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918111823.GE5703@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX01.axis.com (10.0.5.15) To xbox06.axis.com
 (10.0.15.176)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 9/18/20 1:18 PM, Mark Brown wrote:
> On Fri, Sep 18, 2020 at 09:32:29AM +0200, Camel Guo wrote:
>> From: Camel Guo <camelg@axis.com>
>>
>> Add support to configure the GPIO pin to the specific configuration.
>> The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
>> GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
>> drive can be configured with various configuration.
> 
> This needs a DT bindings update for the new property (I thought there
> was one in prior versions)?
> 

That patch for DT bindings has no change at all. Now I resent it anyway.
