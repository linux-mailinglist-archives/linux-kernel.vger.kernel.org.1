Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E528E414
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgJNQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbgJNQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:11:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422E3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ta6mruCMduE6D2ZZOTxtdTJ7Lw97dPEZg8G/P2qpIFQ=; b=kG402yilk0a0iijiythGFY+38f
        xwgChbCR26RXdFAQmksT6g7EPCAa02pwGNiWHGBRf7YuvO1U1S4HB7z5NRFlomciEVkl2Aj6sOmhn
        1z6Aso7xrYJ2gVuJmeKsw+PFP0XlFBrqftxJU21pMnawKs5RLoRFqSME49KFIW9cdhmQITry3FPzZ
        fI135hmb9mm3+jCr3aSCOaYAjMnoVj0O+n2Ak8HAQIKKxeRGBZ8KT/Cx4e78UJsUDOtijFoFx4ogw
        GBLEBnx+nAEp2drLdPpBEurMME4EGX7yBGvFJDwQgSnE/WchC0yzCijGJiAz0fkqgbOCvsGhhd12T
        ol0gBcTw==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSjNC-0000GQ-WD; Wed, 14 Oct 2020 16:11:31 +0000
Subject: Re: [PATCH 0/3] ASoC: sof: cleanup Kconfig files
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
References: <20201014025633.4879-1-rdunlap@infradead.org>
 <86a0251d-3d0d-bff8-a591-22d184c40fc7@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b7a7c3c-217d-27a5-4cca-26e8ec88778d@infradead.org>
Date:   Wed, 14 Oct 2020 09:11:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <86a0251d-3d0d-bff8-a591-22d184c40fc7@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 7:37 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/13/20 9:56 PM, Randy Dunlap wrote:
>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Cc: Daniel Baluta <daniel.baluta@nxp.com>
>> Cc: sound-open-firmware@alsa-project.org
>> Cc: alsa-devel@alsa-project.org
>>
>> Some general editing of sound/soc/sof/ Kconfig files:
> 
> Thanks Randy!
> 
> That looks all good to me, but I see you didn't CC: Mark Brown and Takashi Iwai so not sure if Mark can apply this directly. Might need to resend the series?

Oops, my bad.

> I also can take this series in the SOF tree and combine it with other changes I am making to Kconfigs to remove hard-coded exclusions, that would mean less churn on the same files.

Please go ahead with this.

>>   [PATCH 1/3] ASoC: sof: imx: fix Kconfig punctuation
>>   [PATCH 2/3] ASoC: sof: intel: fix Kconfig punctuation and wording
>>   [PATCH 3/3] ASoC: sof: Kconfig: fix Kconfig punctuation and wording
>>
>>   sound/soc/sof/Kconfig       |   42 +++++++++++------------
>>   sound/soc/sof/imx/Kconfig   |   10 ++---
>>   sound/soc/sof/intel/Kconfig |   62 +++++++++++++++++-----------------
>>   3 files changed, 57 insertions(+), 57 deletions(-)
>>

thanks.
-- 
~Randy

