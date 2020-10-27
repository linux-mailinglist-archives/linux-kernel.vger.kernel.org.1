Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3396929A6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894951AbgJ0IdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894935AbgJ0IdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:33:17 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82A32070E;
        Tue, 27 Oct 2020 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603787597;
        bh=wdgjE1mW9Gtb6qoZEGa/P3kKvyZpArLH7eHRde/bpmA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LlworunyfhWsNDoJJ1Nea71XDrxG3oj2OJ6mvb99C87rZULcu15ZO1DLx4iaQ9EvU
         TYoe76CYZmN286N0bO9g0W4tdT+jcVN07Q5xDVlanl7YPWkT2JMTVwMsRA9R0l/wFS
         RproVUIBnrb6vgCoXrSyEcUAjdLOTVE4AxOLL+m4=
From:   Felipe Balbi <balbi@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3] usb: dwc3: core: fix a issue about clear connect state
In-Reply-To: <20201020135806.30268-1-zhengdejin5@gmail.com>
References: <20201020135806.30268-1-zhengdejin5@gmail.com>
Date:   Tue, 27 Oct 2020 10:33:09 +0200
Message-ID: <875z6wdq62.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Dejin Zheng <zhengdejin5@gmail.com> writes:
> According to Synopsys Programming Guide chapter 2.2 Register Resets,
> it cannot reset the DCTL register by setting DCTL.CSFTRST for core soft
> reset, if DWC3 controller as a slave device and stay connected with a usb
> host, then, while rebooting linux, it will fail to reinitialize dwc3 as a
> slave device when the DWC3 controller did not power off. because the
> connection status is incorrect, so we also need to clear DCTL.RUN_STOP
> bit for disabling connect when doing core soft reset. There will still
> be other stale configuration in DCTL, so reset the other fields of DCTL
> to the default value 0.

This commit log is a bit hard to understand. When does this problem
actually happen? It seems like it's in the case of, perhaps, kexecing
into a new kernel, is that right?

At the time dwc3_core_soft_reset() is called, the assumption is that
we're starting with a clean core, from power up. If we have stale
configuration from a previous run, we should fix this on the exit
path. Note that if we're reaching probe with pull up connected, we
already have issues elsewhere.

I think this is not the right fix for the problem.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+X20YRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYvPBAA0dAVUpFk1ZWtu2G8dmKzdZH5mqolEUqW
Vr8KwPcqSwv6nDdBvFGJjVd0qYXWWDD5DWk7Sn/YN485BOKEHHaMIF0P08dANIW7
AFYa8QjP2iW1gfQAqTXNJLpzzC9n1/AqChugYnBAQDCmnbjddIYW7T/qhBhllhDj
uDFJVRnFPMJi1Zn3HabDFprQ1L1uh0EdvtvggX91J7TggNGV9aeCsnWNkloVFExG
ZqVuLqPogpZeMhIges6U0Qd16E94g4d+pkPw8DluQGH7++tNXItsh7kVQ5/MJ40r
rk6XsGL/fy3So3F9HsTZKSJKmO1av3XobfyUiyi7AR1RsW1S5KoyGtuY/GJunsad
9mOQmYk3LmxaaL1w05eTcqOi1IlEEusi9So7rNEUNzfPMyZedXbay8HY6WPdXgxo
2VoNph/hD5uKTH6UeeHcuBi5M3KZQ5JbnMKuelxHCaovS/i49o2jqKBVu4Tmb5Ne
0/EAOo6uET4DMKzpGC5k/lNf8h10775E+vNIbDQBsw3VRIiQv3PF2sTvrphlM8Jn
fYi2STtU7HeVmWClJlDMdne2V/CgnWFofMfIxMxQvSINjnW9XLH04ynEqmRItBoW
ZTTqPZBfE2FIIgPUTx3ftUby3qOCS0vlqOc7oLXM4F0GIZlRYOQxMQJJBQAQlfrq
lxS8TOqH5jU=
=D0Nn
-----END PGP SIGNATURE-----
--=-=-=--
