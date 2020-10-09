Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE02886A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbgJIKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJIKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:15:19 -0400
X-Greylist: delayed 112 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Oct 2020 03:15:19 PDT
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB0C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 03:15:19 -0700 (PDT)
Received: from [2a04:4540:1402:cc00:2006:326b:997b:7e12]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kQpQj-0004jT-VT; Fri, 09 Oct 2020 12:15:18 +0200
Subject: Re: [PATCH V4 0/4] mac80211: add multiple bssid support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org
References: <20201009101317.4657-1-john@phrozen.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <d14d2925-d1d7-d499-e91c-8a6b64444f52@phrozen.org>
Date:   Fri, 9 Oct 2020 12:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009101317.4657-1-john@phrozen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oops, CC'ed the wrong ML, sorry ...

On 09.10.20 12:13, John Crispin wrote:
> Changes in V4
> * move multiple bssid config from add_interface to start_ap
> * add ema support
>
> John Crispin (4):
>    nl80211: add basic multiple bssid support
>    mac80211: add multiple bssid support to interface handling
>    mac80211: add multiple bssid/EMA support to beacon handling
>    mac80211: don't allow CSA on non-transmitting interfaces
>
>   include/net/cfg80211.h       |  33 ++++++++
>   include/net/mac80211.h       | 118 +++++++++++++++++++++++++-
>   include/uapi/linux/nl80211.h |  21 +++++
>   net/mac80211/cfg.c           | 113 ++++++++++++++++++++++++-
>   net/mac80211/debugfs.c       |   1 +
>   net/mac80211/ieee80211_i.h   |   2 +
>   net/mac80211/iface.c         |   6 ++
>   net/mac80211/tx.c            | 157 +++++++++++++++++++++++++++++++----
>   net/wireless/nl80211.c       |  34 ++++++++
>   9 files changed, 464 insertions(+), 21 deletions(-)
>
