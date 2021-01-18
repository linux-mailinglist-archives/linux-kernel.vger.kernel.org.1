Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79552FA1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404622AbhARNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404528AbhARNgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:36:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1202D2065E;
        Mon, 18 Jan 2021 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610976926;
        bh=KJkv8BLp1zqzzONnd8TlNHpETcZRxUOCJqiN3R+jOSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGJSI2AXm5zS1VasxgWirWyM6U2nwPclVuOLKArIqfaC8NcbYsjYk9Kthq37dcCsB
         ZnW2Zsk44/B3WIbzKWEsLSqVIcZqii1Mx9VFM4qvqvOR7cz3zhVVZeC1sHdnnHO69O
         IRZK+pWErVuDlyHS+M30I1f63YKf+02t4777wc+kjvfgWcTc85B6Ce8cyHe85a2M4x
         dLh5m/rvjj99fGMNr4pwF7TSzGHek+KDeiL72nlLjL4sV7JSZAgMFOHOy1oBiRZ7+6
         H0K/TXIGzk+13clEPv4sDeSJGIRMQy7frPOmR1URLdlUhHGrEa0AoF/n4dEPtP/WRv
         A/VmNt/sIwQhQ==
Date:   Mon, 18 Jan 2021 13:34:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org,
        Christian Hartmann <cornogle@googlemail.com>
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
Message-ID: <20210118133449.GL4455@sirena.org.uk>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-4-hdegoede@redhat.com>
 <20210118130227.GI4455@sirena.org.uk>
 <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 18, 2021 at 02:13:50PM +0100, Hans de Goede wrote:

> More in general I'm not aware of any (recent-ish) x86 GPIO controllers
> not being able to do active low interrupts. In theory we could hit this
> code path on ARM devices using ACPI enumeration, but I don't think it
> is likely we will see a combination of ARM + ACPI enumeration +
> WM5102 + GPIO controller not capable of active-low interrupts.

I've not seen this issue on any ARM based systems.

> This overriding of the flags definitely is necessary on the Lenovo
> devices in question. I could add a
> "if (dmi_name_in_vendors("LENOVO"))" guard around it, but that
> seems unnecessary.

Possibly just an update to the comment to make it clear that some
firmwares might legitimately set the flag?

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFjngACgkQJNaLcl1U
h9CP8Qf+MXPlUpgbAKzwajprfEMzZMYQnFLxebAZXMSPqNuvy++4sphdG5aT9igG
VqeeF6nQk3phzFmwwFVMFtKr0dRQSETqszmRprcjQM14nwLba3ZNPl7GTZpqZflc
p2vHt/95QsAWH8FZSwYyJ5Zam5Ffix3KOHij2IgP2vqNxAKVIjHO8M6KQMT4+zKt
eGMY/l1XpEnv9BUhumLJzjfeB0zGtx/uRerqI/H+7T23RasJrUGiYKmYgaHIhNuD
5jJCyabbx0mizqDLMOSD/A8VkcUGnKldvGMrVGtaCR1gREQm5Ehe2f9ztQYYt73c
9DA8YTGBfKanrS1bEYh8gZWlTBkwyQ==
=0pvY
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
