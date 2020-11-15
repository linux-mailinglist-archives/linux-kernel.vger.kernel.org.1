Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EED2B34E0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgKOMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:20:56 -0500
Received: from host.euro-space.net ([87.117.239.2]:55876 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgKOMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XmHXTe7cxRnQuTBQKB4v6q2G6D8or4BNzeFn2Gmr0D4=; b=jIuvz2M+Emk4aaBpOiKGQP4kEd
        DCX4GjrN8wJVxuVQcfugu0I4LuvkJ/Rq+dY7TLFCy7x7I/8t8rATrrvr3YFjVSVveaOwP6EHDBKY6
        Mdd77K4KlE8zIiWf10loXcZN7TKRC0v0ttLXKRQXzj6+oJILgA4DxvCTC2kEsYdH9+yxKlJv6b9bE
        gmtP3y1edcOAk0PElv7EtFUwuz8En0/JRSMAZ38TtOf/Pfao42IsRxHjKaL8BpAQlXaniBz/l0ErO
        4loCDpTHCyaaQI9/ADnFF1o9it9qlfqa6/QecVYFWlMyRAweCF9Rng263R5eYvNm6WmY8WkPMDkDS
        pheH9LLQ==;
Received: from dynamic-078-054-118-130.78.54.pool.telefonica.de ([78.54.118.130]:55232 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kmarinushkin@birdec.com>)
        id 1keH1Y-000338-HQ; Sun, 15 Nov 2020 12:20:52 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.com>
Subject: [PATCH v3 0/4] ASoC: pcm512x: Patch series to set fmt from `set_fmt()`
Date:   Sun, 15 Nov 2020 13:23:02 +0100
Message-Id: <20201115122306.18164-1-kmarinushkin@birdec.com>
X-Mailer: git-send-email 2.13.6
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.com
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.com
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set format from `set_fmt()` func instead of `hw_params()`, plus supportive
commits

Kirill Marinushkin (4):
  ASoC: pcm512x: Fix not setting word length if DAIFMT_CBS_CFS
  ASoC: pcm512x: Rearrange operations in `hw_params()`
  ASoC: pcm512x: Move format check into `set_fmt()`
  ASoC: pcm512x: Add support for more data formats

 sound/soc/codecs/pcm512x.c | 134 ++++++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 50 deletions(-)

-- 
2.13.6

