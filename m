Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292432AD2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgKJJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:45:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:27090 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605001508;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fYtlt3qgTK2EV8WwFnk3AJi4d+pmZFUbb1srxPBd1gs=;
        b=BTypJiJhiR/7xQCC6/hdSqrurVTWYfG36ldHAZcv/YQYfH3mP1VBkAOBlk/ibuWJRa
        6m/Me7jbd2w7Nvpo+sKY5NOFmvrzaw2TLqiAUpC1gIkf5rjKnEsE2Yd8HUzdsfXXmGi8
        AUpK7Bb2QR+NsVeoU9FMAOndvmhTEDnCNmXTFWpORWaCJYRYamBZ7yTOacxC7QfHxXWp
        A3E7AUuwM2w866H6NKqS1//EzNngqUNkUlJntAi+fASlwUh9xZngH3ARKRQUECuIesgA
        yZa7kpsmaNhafNN66k5t7PCRWelHwddEztHCEYAMwdf3UwZIwf4ZPEqHNj03MBRse/Nh
        OBBg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSfEhGW"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 47.3.3 DYNA|AUTH)
        with ESMTPSA id Y03aecwAA9j7FOH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 10 Nov 2020 10:45:07 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: jitterentropy: `jent_mod_init()` takes 17 ms
Date:   Tue, 10 Nov 2020 10:45:06 +0100
Message-ID: <23252091.ssLaC8jLEa@tauon.chronox.de>
In-Reply-To: <a422b262-3923-0d29-1a11-3498724a98ad@molgen.mpg.de>
References: <02fa159f-4f94-cfb7-1f88-bed91c6542a1@molgen.mpg.de> <4825077.WBkqHH8m98@tauon.chronox.de> <a422b262-3923-0d29-1a11-3498724a98ad@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. November 2020, 10:37:02 CET schrieb Paul Menzel:

Hi Paul,

> Dear Stephan,
> 
> 
> Thank you for the quick reply.
> 
> Am 10.11.20 um 10:25 schrieb Stephan Mueller:
> > Am Montag, 9. November 2020, 20:31:02 CET schrieb Paul Menzel:
> >> By mistake I built `XFRM_ESP` into the Linux kernel, resulting in
> >> 
> >>       CONFIG_CRYPTO_SEQIV=y
> >>       CONFIG_CRYPTO_ECHAINIV=y
> >> 
> >> and also the Jitterentropy RNG to be built in.
> >> 
> >>       CRYPTO_JITTERENTROPY=y
> >> 
> >> So, on the Asus F2A85-M PRO starting Linux 4.10-rc3 with
> >> `initcall_debug`, the init method is run unconditionally, and it takes
> >> 17.5 ms, which is over ten percent of the overall 900 ms the Linux
> > 
> > Hm, 17.5 / 900 = 2%, or am I missing something?
> 
> Indeed, that is embarrassing. My bad.
> 
> >> kernel needs until loading the init process.
> >> 
> >>       [    0.300544] calling  jent_mod_init+0x0/0x2c @ 1
> >>       [    0.318438] initcall jent_mod_init+0x0/0x2c returned 0 after
> >>       17471 usecs
> >> 
> >> Looking at the output of systemd-bootchart, it looks like, that this
> >> indeed delayed the boot a little, as the other init methods seem to be
> >> ordered after it.
> >> 
> >> I am now building it as a module, but am wondering if the time can be
> >> reduced to below ten milliseconds.
> > 
> > What you see is the test whether the Jitter RNG has a proper noise source.
> > The function jent_entropy_init() is the cause of the operation. It
> > performs 1024 times a test to validate the appropriateness of the noise
> > source. You can adjust that with the TESTLOOPCOUNT in this function. But
> > I am not sure adjusting is a wise course of action.
> 
> Out of curiosity, why 1024 and not, for example, 128 or 2048? Is there
> some statistics behind it?

See [1] section 4.3 bullet 4 is the culprit. The startup test includes the 
referenced test logic.

[1] https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-90B.pdf
> 
> 
> Kind regards,
> 
> Paul


Ciao
Stephan


