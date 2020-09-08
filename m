Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D95261CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgIHT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:26:31 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41528 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731033AbgIHQAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:05 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 66589A005F;
        Tue,  8 Sep 2020 16:43:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 66589A005F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599576199; bh=fWg1F4HBXXeFn5yX5XPjD+9rQALUCRRfNZ57jitMmTM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eE+Fr4kP1DP6AKnaHZ6YJKKuD6CouldmenwXH/SkpL5EcJwkTIPyIk1Ys8NxApTr/
         JJA4I+Bq/yKhlvGw5WmHJQS1f8c3MEJvHyKY5BGGIQ/1ycTTlHMLms9bmQW8zOUgCJ
         1wD4dy7knC9PuLY8cUKtWdUrFK4zL1ZXZt6n4PnQ=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  8 Sep 2020 16:43:03 +0200 (CEST)
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
 <20200908121133.GA5551@sirena.org.uk>
 <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
 <20200908143312.GC5551@sirena.org.uk>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <70eef32b-7f57-6868-edb7-f6452aa346c4@perex.cz>
Date:   Tue, 8 Sep 2020 16:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908143312.GC5551@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 08. 09. 20 v 16:33 Mark Brown napsal(a):
> On Tue, Sep 08, 2020 at 02:28:48PM +0200, Jaroslav Kysela wrote:
>> Dne 08. 09. 20 v 14:11 Mark Brown napsal(a):
> 
>>> I don't have this patch and since I seem to get copied on quite a lot of
>>> soundwire only serieses I just delete them unread mostly.
> 
>> It can be fetched from lore (mbox format):
> 
>> https://lore.kernel.org/alsa-devel/20200818140656.29014-2-yung-chuan.liao@linux.intel.com/raw
> 
> Sure, I can go get stuff from the list archives but my list of things to
> go through is in my inbox.
> 

Okay, please, Bard resend this patchset as v2 (with already agreed Acked-by:)
otherwise it won't be applied. I believe that an ack on my follow-up with the
check of the original message should be sufficient, but apparently it isn't.

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
