Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65A26C0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIPJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgIPJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:39:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:39:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6850129B1E6
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: Support pd_info v2
 format
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200909040400.908217-1-swboyd@chromium.org>
 <720fcfbb-3f3a-9679-bd33-56d7f65651a5@collabora.com>
 <CACeCKacudCkMoT40UJaf8PKUQu9G0csBmhih8cBO2Y3TAhV-0Q@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7b391f5e-8200-ddc5-eb56-164c6006a134@collabora.com>
Date:   Wed, 16 Sep 2020 11:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CACeCKacudCkMoT40UJaf8PKUQu9G0csBmhih8cBO2Y3TAhV-0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 15/9/20 17:34, Prashant Malani wrote:
> HI Enric,
> 
> On Tue, Sep 15, 2020 at 5:48 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Stephen, Prashant,
>>
>> On 9/9/20 6:04, Stephen Boyd wrote:
>>> Let's try to read more information out of more modern cros_ec devices by
>>> using the v2 format first and then fall back to the v1 format. This
>>> gives us more information about things such as DP mode of the typec pins
>>> and the CC state, along with some more things.
>>>
>>> Cc: Gwendal Grignou <gwendal@chromium.org>
>>> Cc: Prashant Malani <pmalani@chromium.org>
>>> Cc: Guenter Roeck <groeck@chromium.org>
>>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>> ---
>>>
>>
>> I saw some discussion going on in gerrit (a pity the discussion didn't happen in
>> mainline) Did you end with a conclusion? Can I remove this patch from my backlog?
> 
> My apologies for not posting the comment here.
> To summarize: the userspace EC utility ectool [1] can offer the
> equivalent output, but with better formatting. So I believe the
> decision is to use that instead of this patch.
> I also posed a counter-question: can we remove this debugfs pdinfo
> file entirely, since we can pull this information using ectool?
> 

If I am not mistaken pdinfo is used by your userspace, so, assuming we don't
break (or we have a plan to not break) things I'm fine with it. In general,
delegating things to userspace and get rid of kernel code is good for everyone.

Thanks,
 Enric

> [1]: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/util/ectool.c
> 
> Best regards,
> 
