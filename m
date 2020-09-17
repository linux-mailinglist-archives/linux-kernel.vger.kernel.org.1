Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5126DA17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIQLY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgIQLWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:22:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD5A208DB;
        Thu, 17 Sep 2020 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600341772;
        bh=rRYqKFg3eq+KIiDzrp/w0D7DA9qE/P3g9mLUTK1A5PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoYIs0OAEO3i97Tf50r0rApNFo4sg6yjnRVmA8XqMZtUSaD0hD79RmqmbEa52pp3y
         HVnYruRA9kaX8+KYlk2gle9cfa78yo434MUn8ai44F3APgVMBDOvCfsc/xVrN+AbZ6
         2K7oLPAICVxPOd5EHZt8j8nuUpE95eHS0ZVNG/CI=
Date:   Thu, 17 Sep 2020 12:22:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: Add support for 12/20 register formatting
Message-ID: <20200917112203.GB4755@sirena.org.uk>
References: <20200916160552.1062243-1-ribalda@kernel.org>
 <20200916162824.GC6374@sirena.org.uk>
 <CAPybu_20oay941cqHqa_D13cN0XCrk=Pa113ZuwbbAuVC3yX3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <CAPybu_20oay941cqHqa_D13cN0XCrk=Pa113ZuwbbAuVC3yX3A@mail.gmail.com>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 08:31:54AM +0200, Ricardo Ribalda Delgado wrote:
> On Wed, Sep 16, 2020 at 6:29 PM Mark Brown <broonie@kernel.org> wrote:

> > What exactly is the format you're trying to describe here?  It sounds
> > like there's two blocks of padding in here (I'm assuing that's what
> > dummy means) but what's the exact arrangement here and what are the
> > commands?  It sounds like this might not work ideally with things like
> > the cache code (if it makes things seems sparser than they are) and
> > might not be obvious to someone looking at the datsheet.

> The format is

> XXXXCCCCAAAADDDDDDDDDDDDDDDDXXXX

> Where X is dont care, C is command, A is address and D is data bits. I

> Shall I add this to the commit message? I want to send a V2 anyway,
> because I screwed up the identity (ribalda.com instead of kernel.org)

Yes, please.  I was fairly sure it worked, it was just a question of if
it was ideal for the format described.  The only issue I can see with
the above is that the users will need to left shift their data - on the
face of it it would seem better to add a facility for padding the LSBs
of the data field to the core so that users can just use the data field
as documented.

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jRtoACgkQJNaLcl1U
h9DgFAf6AkNxuuI8Zoyx+GO304rvAN+N5MpZtKzDRjgd/DwBvU2adlMGVEtuo+dt
lCyR1lTifzXAhtAjutlNXUqGQ+Ya+s9sZfKfpVmjDO0dIAoZGFMUB5I4DnKIUdO8
P+NSAcsqOUvq1SFvMP/gXmzyoRJWR6m4QCbljqXsBEH6NLFFnGhvzmiJ67tJSJcn
OhsFTNK9sYKiCyAWsi50xf7TdlfZ2NH2xUiJf9s9fV5FwhLu8i8wG7fkeeYMBXIc
3Y8I1lYRVtyTSpodKk3v7h9eOixXUzFF8Bg90NBEoTeXHyo9h1jrbNjWosEwi8Fa
90+wycHhIrm9PcO4V8K1hoCcJxBtGw==
=FTWa
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
