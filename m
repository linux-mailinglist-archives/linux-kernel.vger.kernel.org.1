Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D2292316
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgJSHnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgJSHnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:43:49 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B433C061755
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 00:43:49 -0700 (PDT)
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 860712E0488;
        Mon, 19 Oct 2020 10:43:43 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id G7UkwFkYce-hhwqDhpS;
        Mon, 19 Oct 2020 10:43:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603093423; bh=+Kd5J1QD/xe6y0t+4TaTFNzy94FBCx7hW1LmXY8yUXo=;
        h=To:Message-Id:References:Date:Subject:Cc:From:In-Reply-To;
        b=cA4Yfod4NaUBvIt4FqVnO31emqBnw4nAgusy7xZl31njSuY5Orfj/AU6g8H2rBsD7
         8Gq0H0y2LxlYwdz4PTHY/NMuZ2osiylOuMIEkvcYjrEAsHFHp/LC5qdF2XETX7bIZZ
         c/Mo1n/86279ccWHkYlClXnXKKTrV67j6N0YfaFw=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:b479:89b3:7c96:4b4d])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id njFOgBfuN5-hhniaXFk;
        Mon, 19 Oct 2020 10:43:43 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] perf trace: Segfault when trying to trace events by
 cgroup
From:   Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
In-Reply-To: <20201009064547.62047-1-sivanichkin@yandex-team.ru>
Date:   Mon, 19 Oct 2020 10:43:42 +0300
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A368965-ACB4-47CD-902C-0B910F6BEEE9@yandex-team.ru>
References: <20201009064547.62047-1-sivanichkin@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+linux-perf-users@

Gentle ping for this patch

Many Thanks

--
Stanislav Ivanichkin

> On 9 Oct 2020, at 09:45, Stanislav Ivanichkin =
<sivanichkin@yandex-team.ru> wrote:
>=20
> # ./perf trace -e sched:sched_switch -G test -a sleep 1
> perf: Segmentation fault
> Obtained 11 stack frames.
> ./perf(sighandler_dump_stack+0x43) [0x55cfdc636db3]
> /lib/x86_64-linux-gnu/libc.so.6(+0x3efcf) [0x7fd23eecafcf]
> ./perf(parse_cgroups+0x36) [0x55cfdc673f36]
> ./perf(+0x3186ed) [0x55cfdc70d6ed]
> ./perf(parse_options_subcommand+0x629) [0x55cfdc70e999]
> ./perf(cmd_trace+0x9c2) [0x55cfdc5ad6d2]
> ./perf(+0x1e8ae0) [0x55cfdc5ddae0]
> ./perf(+0x1e8ded) [0x55cfdc5ddded]
> ./perf(main+0x370) [0x55cfdc556f00]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe6) =
[0x7fd23eeadb96]
> ./perf(_start+0x29) [0x55cfdc557389]
> Segmentation fault
>=20
> It happens because "struct trace" in option->value is passed to
> parse_cgroups function instead of "struct evlist".
>=20
> Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
> Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
> tools/perf/builtin-trace.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index bea461b6f937..cbc4de6840db 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4651,9 +4651,12 @@ static int trace__parse_cgroups(const struct =
option *opt, const char *str, int u
> {
> 	struct trace *trace =3D opt->value;
>=20
> -	if (!list_empty(&trace->evlist->core.entries))
> -		return parse_cgroups(opt, str, unset);
> -
> +	if (!list_empty(&trace->evlist->core.entries)) {
> +		struct option o =3D OPT_CALLBACK('G', "cgroup", =
&trace->evlist,
> +			"name", "monitor event in cgroup name only",
> +			parse_cgroups);
> +		return parse_cgroups(&o, str, unset);
> +	}
> 	trace->cgroup =3D evlist__findnew_cgroup(trace->evlist, str);
>=20
> 	return 0;
> --=20
> 2.17.1
>=20

