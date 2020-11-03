Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB27C2A4837
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgKCOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:32:20 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:57632 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgKCObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:31:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id A709B7E7;
        Tue,  3 Nov 2020 15:31:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z5wq4LF1p61K; Tue,  3 Nov 2020 15:31:43 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 832168EE;
        Tue,  3 Nov 2020 15:31:43 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kZxLa-00G3Ep-JD; Tue, 03 Nov 2020 15:31:42 +0100
Date:   Tue, 3 Nov 2020 15:31:42 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] speakup: Fix var_id_t values and thus keymap
Message-ID: <20201103143142.c3juf3lqj4wz5nge@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20201012160646.qmdo4eqtj24hpch4@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012160646.qmdo4eqtj24hpch4@function>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

This is a change that should got into 5.10, in the meanwhile the bug
(appeared in 5.8) is very inconvenient for users.

Samuel

Samuel Thibault, le lun. 12 oct. 2020 18:06:46 +0200, a ecrit:
> commit d97a9d7aea04 ("staging/speakup: Add inflection synth parameter")
> introduced a new "inflection" speakup parameter next to "pitch", but
> the values of the var_id_t enum are actually used by the keymap tables
> so we must not renumber them. The effect was that notably the volume
> control shortcut (speakup-1 or 2) was actually changing the inflection.
> 
> This moves the INFLECTION value at the end of the var_id_t enum to
> fix back the enum values. This also adds a warning about it.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Kirk Reiser <kirk@reisers.ca>
> Reported-by: Gregory Nowak <greg@gregn.net>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Tested-by: Gregory Nowak <greg@gregn.net>
> Fixes: d97a9d7aea04 ("staging/speakup: Add inflection synth parameter")
> ---
>  drivers/accessibility/speakup/spk_types.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/spk_types.h b/drivers/accessibility/speakup/spk_types.h
> index 7398f1196e10..91fca3033a45 100644
> --- a/drivers/accessibility/speakup/spk_types.h
> +++ b/drivers/accessibility/speakup/spk_types.h
> @@ -32,6 +32,10 @@ enum {
>  	E_NEW_DEFAULT,
>  };
>  
> +/*
> + * Note: add new members at the end, speakupmap.h depends on the values of the
> + * enum starting from SPELL_DELAY (see inc_dec_var)
> + */
>  enum var_id_t {
>  	VERSION = 0, SYNTH, SILENT, SYNTH_DIRECT,
>  	KEYMAP, CHARS,
> @@ -42,9 +46,9 @@ enum var_id_t {
>  	SAY_CONTROL, SAY_WORD_CTL, NO_INTERRUPT, KEY_ECHO,
>  	SPELL_DELAY, PUNC_LEVEL, READING_PUNC,
>  	ATTRIB_BLEEP, BLEEPS,
> -	RATE, PITCH, INFLECTION, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG,
> +	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG,
>  	DIRECT, PAUSE,
> -	CAPS_START, CAPS_STOP, CHARTAB,
> +	CAPS_START, CAPS_STOP, CHARTAB, INFLECTION,
>  	MAXVARS
>  };
>  
> -- 
> 2.20.1
