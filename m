Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30722B520C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgKPUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:10:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43374 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKPUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:10:15 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605557414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hip29GgOHdlU4DaSoAJHUmxKsbppIef8ECoF06JixvQ=;
        b=SuhLqM0c7uAp8MitI6xwhmkVIfJbXPflHEQv4W3/lXoaqVD1jeIjRnz3BcTPKlqdXXblZj
        WAF/GBreecLDrzh1C4DJUGGXyuzICeY6KOCdiVfBF0oCnW2Ymceq9T4NZ8bOX6TZEHp6Ol
        RIirlessYIzBMSHl7KVEtU7Ct5Iu85mTw/UeKkoZubODMqoQjqB7DdWIkBrUaAaqIWV4ta
        8ShEUEcyjO6j5UM3f1QYPSUCvi6hAgw9xzNfsBFVBkHyUmPCVDo3yhOTNC2wKXCzx0WBJ/
        5p1LwjnZs3uRq5z/nxSOpJFfM79sN+1pMaXRHPJYQNfbWr1eqMuWN+oQFIJxsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605557414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hip29GgOHdlU4DaSoAJHUmxKsbppIef8ECoF06JixvQ=;
        b=Flc6kmBHGj2nOUvf6spYNHGNfCMbKiAFykVOgsTHuBtPWbT4rfuZOiylNuPxxBEVrIHQKc
        nPLZSAcu71AbA/Aw==
To:     Corentin Labbe <clabbe@baylibre.com>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] x86/defconfigs: enable HDA realtek codec
In-Reply-To: <20201115182246.9208-1-clabbe@baylibre.com>
References: <20201115182246.9208-1-clabbe@baylibre.com>
Date:   Mon, 16 Nov 2020 21:10:14 +0100
Message-ID: <87sg99xduh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15 2020 at 18:22, Corentin Labbe wrote:
> I have lot of board booting with "hdaudio hdaudioC0D2: Unable to bind the codec".
> This is, for all of them, due to missing the HDA realtek codec.
>
> In fact CONFIG_SND_HDA_CODEC_REALTEK was already enabled via commit 5cb04df8d3f0 ("x86: defconfig updates")
> but removed later via commit 8b1bb90701f9 ("defconfig reduction")
>
> Anyway, one of those system is part of kernelCI and having
> CONFIG_SND_HDA_CODEC_REALTEK back will permit more testing.

Using an overlay to ensure that the bits which are needed by a
particular hardware is working just fine and even allows to do
randconfig testing.

Thanks,

        tglx
