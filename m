Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512242F57BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbhANCFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbhAMW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:29:04 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB70C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:28:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h17so2768264wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gw6KCQyZlAETzQeR8t7iFTKSpvbq9ubGSQ+L/qE5s5U=;
        b=NZeJhs0dFJ/mCp9Qk77D1/8Ha5gNn26QuSCGj7G8sCNDD/is2aU0Xqgo+FoerLqx/h
         FjmAiZ5Duy3qX7H49qyCrvlcEshZUqa93hJ/zSEnxlFMUwUn3IUdVCbJ3JxWtX1+mi4T
         6KLAfg3fK5ThetV+pociHxf0ims1tHXb9W8iCRcKWoNz+GpY72Scm9SDo4daXCkSZdnr
         5d0rK5O+3UAFwHEmqzin8r8ylbqMWm7LYFEtoRFGqlZLUFFV/uoAfeK4W8wckza5cRhT
         OcZsjhShT9BXii67BoKG6MCY/oUiEbR1x0fUOxN7byQgtRjr1qEucLo6OfFONt260nP+
         eKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Gw6KCQyZlAETzQeR8t7iFTKSpvbq9ubGSQ+L/qE5s5U=;
        b=dfuo0UaXYbyLuF5m1/EyTshgpTKiExC8dAfcLtm7wX/01JtQrLIU3plEe59a7e9Pzi
         yu1WmXEzq+d6UigLLTIkC4nRQi98KiV63LuSLpIszAfFstKMePFbIh4FH4vB6veeWKMv
         KJ6ZDRRH4BIiU68674uYKwPUgYlhcUz7fVWl+qfqoZV79uiq7691cd/7DjkBxqTbpmy7
         q53lWj3IE9no8jQrG53JIKEDM9RRy2mLkviEEfWzvdsDFiwL3WwAixkdxi3or5YMeVAo
         8aLqw4BBZTz+7Mq2iYDopRzHOvLIJwXRx83JxkC8rN/KruzUKRVaatEJdl3ZOIq4P3BT
         Ixhg==
X-Gm-Message-State: AOAM532ZUrUWlKMc/CpSm+uLvAMO8kkEbqzdR09khzgv9bqb4xn2qkbO
        t2vy8p5OtgkXd4b3g0i731k=
X-Google-Smtp-Source: ABdhPJxEAmpHTfv6Ma7Z5qo9QVvYRwp4sEliKWEwEqjQKxrl6Q/ZeoUSkbjzBwgtdM7Ds9YxYdqbaA==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr1186200wmi.45.1610576887338;
        Wed, 13 Jan 2021 14:28:07 -0800 (PST)
Received: from rz.localhost.localdomain (dynamic-002-247-253-074.2.247.pool.telefonica.de. [2.247.253.74])
        by smtp.gmail.com with ESMTPSA id h5sm5898239wrp.56.2021.01.13.14.28.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2021 14:28:06 -0800 (PST)
Sender: "Richard Z." <rdzidlic@gmail.com>
From:   Richard Z <rz@linux-m68k.org>
X-Google-Original-From: Richard Z <rz>
Date:   Wed, 13 Jan 2021 23:27:57 +0100
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210113222757.GA6265@rz.localhost.localdomain>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 11:55:06PM +0100, Arnd Bergmann wrote:
> After v5.10 was officially declared an LTS kernel, I had a look around
> the Arm platforms that look like they have not seen any patches from
> their maintainers or users that are actually running the hardware for
> at least five years (2015 or earlier). I made some statistics and lists
> for my lwn.net article last year [1], so I'd thought I'd share a summary
> here for discussion about what we should remove. As I found three
> years ago when I removed several CPU architectures, it makes sense
> to do this in bulk, to simplify a scripted search for device drivers, hea=
der
> files and Kconfig options that become unused in the process.
>=20

> * m68k/{apollo,hp300,sun3,q40} these are all presumably dead and have not
>    seen updates in many years (atari/amiga/mac and coldfire are very much
>    alive)

me and a few other guys are still running m68k/q40. I did not compile
a new kernel for some time but will try.

Regards
Richard

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBX/9z7Ks1ukX5mVu3AQL2RhAApyetHb4tTSC0l6iQ3NNvE6wZ91SZ8XIj
cQnYc06ZoKjCnc61XaQsGnE9wxLdgQGff/xRvnZscujlzu0wOJO7e4gsJP3yJooE
uPcH/jvJ+/N4JBN8koPbY5buj60XK/LddzXJaNtYCZpUF21/y5E43CXP6Glp+oxg
ynQlcRWqBFkFKIH7toZnJNvS3sqo6nWzTCTn5TvPnYruu3HAYunZhf8A6EzR06Gb
rjydy0B69xEhicmouPDYRSSZ1/2B9hRzWeOWjJGiSbf7H6BVMQRmueWMoCqI04iI
twbnNiyt9YhqqTWfkMhpRNrWZQOi3NaOi+truqIaEPjJJINk8y+vl+lKimcWF5Gb
XC9M2WqAhdkvItk0U5fVMtRYtqXjIfqIuPmKcRAEA5VGyCilRsP3hMdTIvCWf1uT
0eDLYQPcV0Vl/nP547XAqwNb3Z5qcU0VnThd0MFNeG+o4OY376IUoZVnt8NjFxP1
xpSaaNGOF09o1oQpvcIn3vPHyxRoaOJCT3S1a8hRVjapPryFf+inY01eU7o3Wz7K
sybjFk6OoTfvayFKgxluG8fGXw+w0EkjfKu3PjtJhLxW8neqqlU0nuEuy3wd7vyl
YGhQIdCT4EYGeBbW4BtCwkCTjYyU4j5+FQnGyYThIMRG1QGtoczMVF7q+dQl/bnE
gGOUyq8xkog=
=Bo9S
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
