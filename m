Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6FB20C416
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 22:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgF0UeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 16:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgF0UeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:34:10 -0400
Received: from localhost (p5486ce85.dip0.t-ipconnect.de [84.134.206.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4635E2067D;
        Sat, 27 Jun 2020 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593290050;
        bh=segUnkkM0ym2Pq+Au80JsQLoVJBRsCGKm5wd3StbI14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNYn8E90/T7mUMJLxCKexwBv/Oa2VO3Cntnv5BuirVd054CnYASPP5o6WMWEj86qy
         aIi5DkGXA58syZNHZ/UGknTTe8eXZIM1/h6fgX0XFJcmKiurSBvbJmp4EIZpuXWLOH
         uqhY0/hJswlCte7+KH1QFl9tZou742ESWlnEt2W4=
Date:   Sat, 27 Jun 2020 22:33:57 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] misc: eeprom: eeprom_93cx6: Repair function arg
 descriptions
Message-ID: <20200627203357.GA954@ninjato>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20200626130525.389469-7-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> @@ -270,7 +270,7 @@ EXPORT_SYMBOL_GPL(eeprom_93cx6_readb);
>   * @eeprom: Pointer to eeprom structure
>   * @byte: Index from where we should start reading
>   * @data: target pointer where the information will have to be stored
> - * @words: Number of bytes that should be read.
> + * @bytes: Number of bytes that should be read.

Now we have 'byte' and 'bytes' here as arguments which is confusing. I
think renaming 'words' into 'num_bytes' would be even better.


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl73rTEACgkQFA3kzBSg
KbaBzA//dLI5VkiLGrU7srp/U5c4psR79hClXFkbf/Ki9UWEBgl011V9+LTe+lQk
r4OI7bKMBBZbw/U4TV27Eb2wD6fZ3TWbVEF5X/hWTEbAnP3ZgteH+CgV3Qp3antd
k6ZF1ENnu7bGCIksTCyrHiEf2o7eeE7k9uYIN1fGCc2HMeqJTfaXZfiuQWPLcIsq
Bm+Fbz+K8wG5HO8xi8QRWU3QQSAgLPsHaeHLVH4wWgtnmw7LI9FZgeYmlPSHa9Gu
x39+p2WNzGuna4FmepxQ4CZ6qBtJiPqvgBnVbz7q//mlqwIb66WxyydGXEi3FdLG
noFhSZx9eQKJiDN4Msy/2z1aa6+4JMP7sEfNJGosYg+V2a4B6ZsBjFBp3PAriGzz
oOOLRQh+bbXaZ5Loam0Eyh99fVFPmHb+9heoqzT8x1gH4Fbyzj6jjXJnlPToJaOc
ralvHcf7UH7/wXkO3gBWrOuEsV0IbI6yqds4LmCwA3Yjf3JfbdWsJMl7TMOYAc6q
XlYwFrpTcLyi6Jh2JQYSXu4mYMwEfRaRIsy5bVMH+q9hNlbQ06Y8Bl0dfRV66vl1
+VzMZ3WjyRQ4b16hs/Gx6bV0zU0pzvG14Dld4XPj6vKlrqnqFjs+aTVLBHnn+3Jv
9/lG7OLbdliAy/12VJAw4RKKCX2oYgia9bmxDP1D5UMUy5eXMNk=
=NGax
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
