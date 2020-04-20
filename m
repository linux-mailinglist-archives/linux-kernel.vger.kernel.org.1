Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA61B1A45
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 01:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDTXrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 19:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgDTXrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:47:16 -0400
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD138C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
        s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
        References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=2TEEWI9XLn5p0bcJKmRvNR+plNh0vjLKLOHSa3niukE=; b=n47eY79Pd1xGVVSZDl5bHbeR5j
        /Q937N5cTnKp+y8gv1U0mWyywvVpiUozko0l6SWQjYGMLmUsI7oKNWGgfXa9VAA2ErUUGtXNFqyer
        F9fxWsk1EsOcyX3LPRls/SDlbPUolKUXquKqoI2ekX3jS2DIoVpGkzU31w5A4kwGzWMA=;
Received: from [2a00:1370:8125:3f98:890:f100:d37d:7ada] (helo=home)
        by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <puleglot@puleglot.ru>)
        id 1jQg83-0006yq-S9; Tue, 21 Apr 2020 02:47:08 +0300
Message-ID: <b866b95dc3f9f92665c7826262b627ecc18ebf74.camel@tsoy.me>
Subject: Re: [PATCH v2] ALSA: usb-audio: Add quirk for Focusrite Scarlett 2i2
From:   Alexander Tsoy <alexander@tsoy.me>
To:     Gregor Pintar <grpintar@gmail.com>, tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Tue, 21 Apr 2020 02:47:05 +0300
In-Reply-To: <20200420214030.2361-1-grpintar@gmail.com>
References: <1c4b8a362761421eba0ded60bb4f0e11b7e42f3b.camel@tsoy.me>
         <20200420214030.2361-1-grpintar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

В Пн, 20/04/2020 в 23:40 +0200, Gregor Pintar пишет:
> Force it to use asynchronous playback.
> 
> Same quirk has already been added for Focusrite Scarlett Solo (2nd
> gen)
> with a commit 46f5710f0b88 ("ALSA: usb-audio: Add quirk for Focusrite
> Scarlett Solo").
> 
> This also seems to prevent regular clicks when playing at 44100Hz
> on Scarlett 2i2 (2nd gen). I did not notice any side effects.
> 
> Moved both quirks to snd_usb_audioformat_attributes_quirk() as
> suggested.
> 
> Signed-off-by: Gregor Pintar <grpintar@gmail.com>

Thank you!

Reviewed-by: Alexander Tsoy <alexander@tsoy.me>

