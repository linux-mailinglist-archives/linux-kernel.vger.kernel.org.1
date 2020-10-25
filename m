Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278EE29837D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 21:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418692AbgJYU1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 16:27:31 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9629 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbgJYU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 16:27:30 -0400
X-IronPort-AV: E=Sophos;i="5.77,417,1596492000"; 
   d="scan'208";a="474226999"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 21:27:27 +0100
Date:   Sun, 25 Oct 2020 21:27:27 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_=5BCocci=5D_Coccinelle=3A_null=3A_Optimise_disj?=
 =?UTF-8?Q?unctions_in_SmPL_script_=E2=80=9Ceno=2Ecocci=E2=80=9D?=
In-Reply-To: <bee0c5df-8f28-ee9d-99e2-abbf84df76e6@web.de>
Message-ID: <alpine.DEB.2.22.394.2010252122320.2714@hadrien>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de> <alpine.DEB.2.22.394.2010251924290.2714@hadrien> <8f58a94e-b093-a587-c56a-a0ea0fc1f3ea@web.de> <alpine.DEB.2.22.394.2010251955280.2714@hadrien> <bee0c5df-8f28-ee9d-99e2-abbf84df76e6@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1179668747-1603657647=:2714"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1179668747-1603657647=:2714
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 25 Oct 2020, Markus Elfring wrote:

> >> Would you become interested to configure a representative test environment
> >> for safe comparisons of corresponding run time characteristics
> >> of the affected software?
> >
> > In what sense could the comparison possibly be unsafe?
>
> * Our test systems are obviously different.
>   Thus concerns can be considered for reproducibility of test results
>   on other possible configurations.
>
> * We share only a tiny fraction of technical information which would probably
>   be needed for “benchmarks”.
>
>
> > Just use time and run spatch on whatever machine you want.
>
> fring@Sonne:~/Projekte/Linux/next-patched>
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20201023 && XX=$(date) && time spatch -D patch --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno1.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno1-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m54,266s
> user	10m15,553s
> sys	0m4,004s
> So 25. Okt 20:53:56 CET 2020 | So 25. Okt 20:56:51 CET 2020
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20201023 && XX=$(date) && time spatch -D context --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno2.txt 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno2-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m38,494s
> user	9m39,364s
> sys	0m4,094s
> So 25. Okt 20:58:05 CET 2020 | So 25. Okt 21:00:44 CET 2020
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout optimise_disjunction_in_eno.cocci-1 && XX=$(date) && time spatch -D patch --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno3.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno3-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m46,097s
> user	10m15,467s
> sys	0m3,984s
> So 25. Okt 21:00:56 CET 2020 | So 25. Okt 21:03:42 CET 2020
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout optimise_disjunction_in_eno.cocci-1 && XX=$(date) && time spatch -D context --timeout 9 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . scripts/coccinelle/null/eno.cocci > ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno4.txt 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201023/eno4-errors.txt; YY=$(date) && echo "$XX | $YY"
> …
> real	2m41,472s
> user	9m37,492s
> sys	0m3,834s

In the patch case, the user and system time are essentially identical.  In
the context case, the difference in user time is 2 seconds out of 9.5
minutes, 0.3%.

In the patch case, the real time is a bit slower.  But I believe that this
is due to the time to read in the data from the file system.  I also had a
number like that, but the difference disappeared when I reran it
afterwards, which meant running that case in the same conditions as the
others.

In the context case, the real time is slightly slower with your patch.

So I see no compelling evidence for making the change.

julia

> So 25. Okt 21:03:56 CET 2020 | So 25. Okt 21:06:37 CET 2020
>
>
> > Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
>
> AMD Phenom(tm) II X4 850 Processor
>
> Will any other aspects become relevant?
>
> Regards,
> Markus
>
--8323329-1179668747-1603657647=:2714--
