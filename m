Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8E919C8DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbgDBSfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 14:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389665AbgDBSfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:35:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E092064A;
        Thu,  2 Apr 2020 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585852549;
        bh=KauE5lRKJDRHr+8/GnireyVC9maw8P+sgKRebMi2i4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksl4a9aCACwGpWiD++aXNe08DuwRgOZORkpfDwlgQLzUConv4hGPmoq1/+QH2bBpm
         ou3S0M2ruKcPVebdzQSeovQP1TYJYifJXCWabwwc7S8IfnjyKQQ3loUBm01jPGmSsB
         VP/KaCnejJDZw6idZvvDkGJSvnwz9OANxYwpgIps=
Date:   Thu, 2 Apr 2020 20:35:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jari.ruusu@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: linux-4.14.175 broke audio
Message-ID: <20200402183546.GA3234477@kroah.com>
References: <CACMCwJ++6kikxaEUon3xfwm1h3hTQ+V9BoJEAeToJQKwTufDsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMCwJ++6kikxaEUon3xfwm1h3hTQ+V9BoJEAeToJQKwTufDsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 09:06:59PM +0300, Jari Ruusu wrote:
> $ uname -s -r -m
> Linux 4.14.175 x86_64
> $ cat ${HOME}/.config/mpv/mpv.conf
> ao=oss
> vo=opengl
> audio-channels=stereo
> no-msg-color
> $ mpv track18.mp3
> Playing: track18.mp3
>  (+) Audio --aid=1 (mp3)
> [ao/oss] Can't set audio device to s16 output.
> [ao/oss] Can't set audio device to u8 output.
> [ao/oss] Can't set sample format.
> [ao] Failed to initialize audio driver 'oss'
> Could not open/initialize audio device -> no sound.
> Audio: no audio
> 
> 
> Reverting "ALSA: pcm: oss: Avoid plugin buffer overflow"
> upstream commit f2ecf903ef06eb1bbbfa969db9889643d487e73a
> restored audio back to normal working state.

Is this also an issue in 4.19 and 5.4 and Linus's tree?

thanks,

greg k-h
