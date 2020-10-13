Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94228CB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgJMJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgJMJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:43:20 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D1C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:43:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4C9VwL1222z9sTv;
        Tue, 13 Oct 2020 20:43:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1602582196;
        bh=MmYxudsBilW3b9WNXYGYtryntXggxaEOi7jovASJQnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TbpmMDPOpZh4iK+05mvGR+YpHdBzvky/qJO2ptrw12mGs43BlM7mLNbEVupP9riOG
         eCfc0DaiwcyW3xexDhTNnLl6jD6UG1883S52LG95L374IR41xGwDO/mHz5n8hW39yC
         xcabDXzrPzF+S3dXjdBCOwUnBZ7X/WAe8w9qR1lSJwuinnmBGH3TBGMHjNIT8bmuj5
         txGrKuJdwGB5T/Fcr4WczyDwbheimhsL/PBoVBb2gfBcRFrr2J88T1GVVj5YVXlbyC
         SFvA5s5QWblf+H36YBlEPnZmkdRhkTyjD7wchz6Lkdlk2KYRPyfIy0OlyFF3jeQnWw
         jTcOmIvLBZylA==
Date:   Tue, 13 Oct 2020 20:43:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [GIT PULL] objtool changes for v5.10
Message-ID: <20201013204312.6052157d@canb.auug.org.au>
In-Reply-To: <20201013082625.GA775379@gmail.com>
References: <20201013082625.GA775379@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=hSnEuRP3IUIKmelA1kxgOV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=hSnEuRP3IUIKmelA1kxgOV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Tue, 13 Oct 2020 10:26:25 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> Ilie Halip (1):
>       objtool: Ignore unreachable trap after call to noreturn functions
>=20
> Jann Horn (1):
>       objtool: Permit __kasan_check_{read,write} under UACCESS
>=20
> Julien Thierry (16):
>       objtool: Move object file loading out of check()
>       objtool: Move ORC logic out of check()
>       objtool: Skip ORC entry creation for non-text sections
>       objtool: Define 'struct orc_entry' only when needed
>       objtool: Group headers to check in a single list
>       objtool: Make sync-check consider the target architecture
>       objtool: Move macros describing structures to arch-dependent code
>       objtool: Abstract alternative special case handling
>       objtool: Make relocation in alternative handling arch dependent
>       objtool: Rename frame.h -> objtool.h
>       objtool: Only include valid definitions depending on source file ty=
pe
>       objtool: Make unwind hint definitions available to other architectu=
res
>       objtool: Decode unwind hint register depending on architecture
>       objtool: Remove useless tests before save_reg()
>       objtool: Ignore unreachable fake jumps
>       objtool: Handle calling non-function symbols in other sections
>=20
> Raphael Gault (1):
>       objtool: Refactor jump table code to support other architectures
>=20
> Vasily Gorbik (1):
>       objtool: Allow nested externs to enable BUILD_BUG()

This seems to be missing

https://lore.kernel.org/lkml/patch-1.thread-251403.git-2514037e9477.your-ad=
-here.call-01602244460-ext-7088@work.hours/

or did that get sent in a previous pull request?
--=20
Cheers,
Stephen Rothwell

--Sig_/=hSnEuRP3IUIKmelA1kxgOV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+FdrEACgkQAVBC80lX
0GzG+Qf+NAqnp9Vvlla+Dw5bbWdYOMDmmI6BtWWbHe6B4o7dZVMF3p+f1/BQJS0S
TyktL/Jc8oDxWQ69Nn7GIfmX5c/UCqSgCQYjjmHWCjwPvAAqkneTxxy1qrdEzCFQ
xDrQMVgTEKb3scjqFOPRmcC23pKsEeLMINbT+BsWL1frGL0U1cK9pPVOVcFfOLvz
1Yzo8QuIoqzDIU+J0WkFqxlqViLPWBFMNRYJVuld1wUSb7GTkhdlE5SJ0jXsQ/rN
Jssf9SdsQOQosZnfviIXICxf2MO/pSggsx6qfNFj8FrfkT0ovmy2LJ04xqbc9K5U
EybAgdIZeKDae7y6Tid252cxseWWJQ==
=JznG
-----END PGP SIGNATURE-----

--Sig_/=hSnEuRP3IUIKmelA1kxgOV--
