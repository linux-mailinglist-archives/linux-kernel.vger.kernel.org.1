Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7B19C7DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbgDBRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 13:22:53 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33866 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgDBRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:22:52 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D9E941C306B; Thu,  2 Apr 2020 19:22:50 +0200 (CEST)
Date:   Thu, 2 Apr 2020 19:22:49 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH RT 2/3] irq_work: Fix checking of IRQ_WORK_LAZY flag set
 on non PREEMPT_RT
Message-ID: <20200402172248.GA12483@duo.ucw.cz>
References: <20200331163453.805082089@goodmis.org>
 <20200331163513.674653275@goodmis.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20200331163513.674653275@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 4.19.106-rt46-rc1 stable review patch.
> If anyone has any objections, please let me know.
>=20
> ------------------
>=20
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>=20
> When CONFIG_PREEMPT_RT_FULL is not set, some of the checks for using
> lazy_list are not properly made as the IRQ_WORK_LAZY is not checked. Ther=
e's
> two locations that need this update, so a use_lazy_list() helper function=
 is
> added and used in both locations.
>=20
> Link: https://lore.kernel.org/r/20200321230028.GA22058@duo.ucw.cz
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looks okay to me, thank you.

Acked-by: Pavel Machek <pavel@denx.de>

I'm currently playing with 4.4.X branch, but I'll eventually test it.

Is it possible that 4.4.X branch needs similar patch? My code review
suggests so...

Best regards, 	      	   	 	     	  	     Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoYfaAAKCRAw5/Bqldv6
8rvMAJ9zGqy4ZDx7FvLivm5f2ywl93j8VwCfZLomiXJhxi7ZvJ2OOiqkpaawfN4=
=fJIu
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
