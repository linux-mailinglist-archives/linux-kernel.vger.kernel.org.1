Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679AA2DCB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 04:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgLQDBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 22:01:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:41313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgLQDBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608174000;
        bh=HFOnTRxxvermaJW7G+widrnqOmmno1Uni+yaF9b9ICI=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=efrNov4edGMUg2ZQWWk9+k0IfhOjQpcwup8+7vYYVpCCNgURNh7H++SIiUJHQCTUX
         vzNGOrZ/4AzD3UIaaX2cOkR4HB4ZBj9YXSm+hEhXswt9wDPSp4ppxHyR0ymw55yZqr
         j2kivWnusXswiWk3NpGRRrToesaICdCCAyDLdzHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1k8OUp2XA7-011mBA; Thu, 17
 Dec 2020 04:00:00 +0100
Message-ID: <75c22ad01a500ecd906f0088ecd5a68161a91593.camel@gmx.de>
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
From:   Mike Galbraith <efault@gmx.de>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Date:   Thu, 17 Dec 2020 03:59:59 +0100
In-Reply-To: <61ae6135-dca7-db73-f048-0a35f69cb5c4@virtuozzo.com>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
         <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
         <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
         <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
         <19b5ee604512d09bc4b059b7e59d73681937048a.camel@gmx.de>
         <c3132ac7e0536a30aefc833df16f5a24de7e4529.camel@gmx.de>
         <61ae6135-dca7-db73-f048-0a35f69cb5c4@virtuozzo.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VT5cQ/UjYSSKolW4oILGzdDQrU5Wr2R1UmmStnucL5vBPSKhIxl
 5T+f7q4n6ydQya/a/5BrLyvc1H0ccDPAuJbUJlfPsHY6XfeTwT8RvuD6PA2yFc6wxuAg3py
 eXKnyOsFtymL4j5/wBv+oH1DzTonEW+zTNXoQV+XB7NwvGfPmfFkevR5qs1Hq/GXjMhxBDh
 cGXQKzPmklECekoOwhhrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ImbP3FgJIMA=:iWdU/NtxzLqWKwh9m6i0vR
 rbekJNxZil1FM4t+yqc/y/vHN8PmMINSuSt02KqLFzZ05ru/456tSd2JtwKbPJlKBY27Xk23p
 WCttyeTLNa9lFQU3j02jkA4De1Y58i1Gm9qsFeW1XcRJQLPrINUuFGbhLPCSLWxaPhnnSjhhj
 Nh8ealfffClDHAknA+YR5TQGqWA4bQrDZ4ehGl5kekmghuUwc/k+apqTCV6d6upG5W/yAcrIX
 rrqd3PUWdwJ7Cx0CySg32JwUK9LkRo6P05HbYDDmghY1qVcKjle49q6E4l19oVpihe5ZuHp8S
 X4oSnz1FTGbcVVMNwah3sQkisIH6n3EjP1Afnlq4bXFY/OWpMnxmg0IY7XLxFnWrWRuqsEdxG
 gjJvPeWoMc4QekhW/EsH/czAn2crv6NRyDf5LsHAEP7inp4fVc9l6+KHKnlLFIyKX5rTMzOmN
 FTInRG7c0cTST42Kbsf3VtqDefslBeYvce6WwZUWeDny3gr/XyyIB8seaeUao90ktTvmonkCH
 4025hxcg0tBENBrVJySOAE9ijwf5gh3P3g3zlKauPVphjv0HfVlMEMVvl4+wK05dyH/L1YKDX
 GRIKTYsEldpDtAPDWtQths9ZNt54Ng8PptTO7tsERsLWCTZcdwkWStTQjgvQRemOZHByIgF/d
 xz6pU7sOLYwkwr899bF3NUxShSG3vcOmNpMwxkgz57K+8tw8QpJvxTS5dQWaj3j9ZmllBBNJq
 tAjGa9Zo0fNEFHWtN6fjIxL5CKZDVEZ8rMgQGySiQifII0gqTLvu72aCe6i8CDrtphyI+66zK
 O1XNF076qmYwCb41wfqtpJ9XvyUBmbUPsrgETQnBMMcx7rgfGeOHbeo8C+Tc96Dc19QWshikp
 MpYCLgwHBib/UIhgRBXQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-16 at 18:20 +0300, Kirill Tkhai wrote:
>
> We may consider a patch like the below till updated makedumpfile is not =
published:

It's nice to be considerate to the tool folks, but that can leave a
wake of cruft (thinks printk ringbuffer.. ew), so it's probably best to
just let it break.  The why and wherefore is documented in this thread,
that's enough for anybody who needs a quick fix to get on with frobbing
their dang buggy bleeding edge kernel ;-)

> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index 2b1737c9b244..d6bcad448f52 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -8,6 +8,7 @@
>  #include <linux/ns_common.h>
>  #include <linux/err.h>
>  #include <uapi/linux/utsname.h>
> +#include <linux/kref.h>
>
>  enum uts_proc {
>  	UTS_PROC_OSTYPE,
> @@ -21,6 +22,7 @@ struct user_namespace;
>  extern struct user_namespace init_user_ns;
>
>  struct uts_namespace {
> +	struct kref unused;
>  	struct new_utsname name;
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;

