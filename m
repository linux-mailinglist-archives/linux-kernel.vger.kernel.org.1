Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2260D2C13D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbgKWSo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731166AbgKWSo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:44:58 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF3F20702;
        Mon, 23 Nov 2020 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606157098;
        bh=RrUfeAtqPlw2pkJrVTmSF81Kk1DPCPCipvGVpz/M73o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlbBKyDQjb6Yo4A2e4oHkBKckmgWSnZUXvsIOYP+NU7gUipsSw4FoBza0sCOOWrzT
         uP5qU8TwdPUQYl4KuCI6f6+kK4HBYHKrYkRf4WN5YqNXOCKzh73iJTpm4CEitpX9yl
         gBhDFibHUiNCtZAEErxzV4z4lTcLefrPMwAujrq0=
Date:   Mon, 23 Nov 2020 18:44:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/5] soundwire: SDCA: add helper macro to access controls
Message-ID: <20201123184435.GQ6322@sirena.org.uk>
References: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
 <20201103172226.4278-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UJEqbsikIZBgizPR"
Content-Disposition: inline
In-Reply-To: <20201103172226.4278-2-yung-chuan.liao@linux.intel.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UJEqbsikIZBgizPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 01:22:22AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The upcoming SDCA (SoundWire Device Class Audio) specification defines
> a hierarchical encoding to interface with Class-defined capabilities.

Vinod, any thoughts on this?

--UJEqbsikIZBgizPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+8AxIACgkQJNaLcl1U
h9DSKAf7B0fvQvXeHixUX4SkhXfc30UeHn9weNSEZ/ZNa+k6GKgCHwd4ZGlscmkR
j5R1iSC+N1MKjIx48Ep2+N5PRWIRWDDFhqmD4e7iXSQFPMcfPPkM4kuvBaTZp32c
LL/8PA//RdwfXYnucWYyMnToshuzw4mOG1vr9zuTlKScC5/H9Ez0F6spXlSqtDhE
sb2yWyJJBkIQ2spXf/j7nAcNwn8en0ntW+TE94dWTnmnWeJiEwhi8WSs/C4nkPPN
8nNrhE8OiSyW5oR+H8mHc0vS2xct0QIo1OTPfqH2SwHbRYi2cX+4aPgCq9xGnOvw
5mXjdCXFxywXcrV682SlFoNVgFJp3A==
=3BdR
-----END PGP SIGNATURE-----

--UJEqbsikIZBgizPR--
