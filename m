Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5811F1657
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgFHKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 06:06:35 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:9182 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbgFHKGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:06:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gTRr0G62z2d;
        Mon,  8 Jun 2020 12:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591610792; bh=Xrng9HgE5HPvIAp1NSK4MnUJUDNRKMXBFpteoCe0zYw=;
        h=Date:From:Subject:To:Cc:From;
        b=YtIFvNqvAgjAXTyf+AhtXaVrR7FsPn42OVG+x8gNrWDykD5AAnSh8U17Toy7c27Mm
         sWWzHnXRiNKpBHvJ2eyDgTSLtJlLCzVElljrXW1XiJUnPI5yClZZb9vIPdE8BsNiL+
         /dH1BS1D/f5490Z50t3q5TCFZzX9tfzKar4ffgRMPmVmZTAymFEYsL6Q/4g0JuOjYZ
         DxTlYgihFZFrsgV7twUoUmOzUVF3bC5tJSx6naxrgInPZ2d58z5201NBD/IVHHjSww
         fXbA4gSyu6lF9ooRp9zvdXbRv4bioQ9X/NcDtBuJRL58M09jR2EUh9q/ix11tIBf/X
         eBOMxOOiM3/1w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 08 Jun 2020 12:06:30 +0200
Message-Id: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/2] ALSA: pcm: stream linking locking fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches fixing locking issues for SNDRV_PCM_IOCTL_LINK handling:
first adds a check preventing linking a stream to itself, second quiets
lockdep warning about nested locks.

Michał Mirosław (2):
  ALSA: pcm: disallow linking stream to itself
  ALSA: pcm: fix snd_pcm_link() lockdep splat

 sound/core/pcm_native.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.20.1

