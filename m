Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8662F35ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbhALQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbhALQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:41:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45CC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:41:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CE7031F44B67
Subject: Re: [PATCH 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
To:     Mark Brown <broonie@kernel.org>, Guenter Roeck <groeck@google.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
 <20210107135459.GB4726@sirena.org.uk>
 <CAGvk5PqMCEib8Yr=V4SxT0BBMoC1+yGXm0y+52+LwC5dPQUVnA@mail.gmail.com>
 <20210112004207.GN4728@sirena.org.uk>
 <CABXOdTc-HkVW7UuDLoWf2opVO1n-W2EF-E2hJEm_D6=2P32_qw@mail.gmail.com>
 <20210112141036.GC4646@sirena.org.uk>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <253ab603-f082-6e96-9303-7e127e743906@collabora.com>
Date:   Tue, 12 Jan 2021 17:40:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112141036.GC4646@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/1/21 15:10, Mark Brown wrote:
> On Mon, Jan 11, 2021 at 05:52:31PM -0800, Guenter Roeck wrote:
>> On Mon, Jan 11, 2021 at 4:42 PM Mark Brown <broonie@kernel.org> wrote:
> 
>>> TBH that seems like a big enough change to split out from this and done
>>> as a separate series, I'd be perfectly happy to apply your original
>>> change.  I guess part of doing that sync up should ideally be to
>>> refactor things so that it can be done mechanically in future.
> 
>> Being able to do it mechanically was the idea for introducing the script.
>> Unfortunately it doesn't help to have such a script if people don't use it.
> 
> Looking at the issues Yu-Hsuan mentions and briefly at the code I guess
> there's some updates needed with the script for namespacing around at
> least pd_ to avoid the need for hand massaging things, that'll put
> people off using the script.
> 

I even didn't know about that script :-(, or forget about it, assuming the files
are async again, I think I'm fine on only introduce that line of code instead of
a full sync (and lets think how we can do better work on this and solve in the
chrome-platform tree). I have some comments on patch 2, though.

Cheers,
  Enric
