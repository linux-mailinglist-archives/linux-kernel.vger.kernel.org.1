Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1285A23DECF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHFRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbgHFRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FAAF20855;
        Thu,  6 Aug 2020 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596713335;
        bh=SXBG3d+40joIiETd4BEf9KDW1I5AsutaJSgaQGqb84k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GhjzyO5t2lZbx98Q4lcj/h975RF5zZJUyBjr+rFxL4lOT4zkMZ+laBDYkGRDrNGcD
         AuWB7JBjFZDDD8OD3InXu+oEKrgfO/dhCmOmGpz7N9lQ9YzpQUis7j5JPU9cYSi1FU
         +aLOSKQ+1x1WjqtDMFGVRCEsS5xQ/qF2OFHxa4Zw=
Date:   Thu, 6 Aug 2020 12:28:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Replacing component->name with codec_dai->name
Message-ID: <20200806112831.GA6442@sirena.org.uk>
References: <20200806101451.7918-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20200806101451.7918-1-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Hedonist for hire... no job too easy!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2020 at 03:44:12PM +0530, Ravulapati Vishnu vardhan rao wrote:

> Replacing string compare with codec_dai->name instead of comparing with
> codec_dai->component->name in hw_params.

Why?

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8r6V8ACgkQJNaLcl1U
h9C99wf+Iwfs3UAnESFIX3Jun3tiCmnkiuI29dljakUab4crGEgKNWCADublBHk/
8d8piOMAHBtWET14c2kaaCFv8h+6R8YxULrI5lPtMpCt9HZ+AiE4WozIy40VoWk9
u3DhDuk69o5ghnTlETNo5fdtYURPk45dZ6mgZYKlVX/vuIZLtGOK5n+UJT3yCn8p
5tbr/j4E8nIkTHhicgYAB62oSvedeRZeFuuGD6LodfgIexQsNVke8UEXgHftCkrd
Tnxx3YUc8eEPomhMY/v8S33ICO9Y6P5jabrGZSFKLaI5Bc1236r2SPAhPMYep9bO
IKSc8vpRI5xBjJhnVrX+BNUjFTNFpw==
=bFdy
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
