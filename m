Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9A291852
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgJRQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 12:20:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39835 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgJRQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 12:20:07 -0400
X-IronPort-AV: E=Sophos;i="5.77,391,1596492000"; 
   d="scan'208";a="473171051"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 18:20:04 +0200
Date:   Sun, 18 Oct 2020 18:20:04 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [Cocci] Determination of an usage statistic for memory     allocation
 calls
In-Reply-To: <2774601.u91sIFNy1E@sonne>
Message-ID: <alpine.DEB.2.22.394.2010181819210.2759@hadrien>
References: <3528117.7ODa3CK5J5@sonne> <2774601.u91sIFNy1E@sonne>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1982622638-1603038004=:2759"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1982622638-1603038004=:2759
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 18 Oct 2020, Markus Elfring wrote:

> > …
> > > +    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|
> > > +          kmalloc_node\|kzalloc_node\|kmalloc_array\|
> > > +          kmalloc_array_node\|kcalloc_node\)(...)@kok
> > …
> >
> > How do you think about the possibility for any adjustments according to the order
> > of the mentioned function names in proposed disjunctions for the semantic patch language?
>
>
> I would like to share another source code analysis approach.
> I hope that this contribution can trigger further helpful software development ideas.
>
>
> @initialize:python@
> @@
> import sys
>
> def write_identifier(source, call):
>     names = []
>     for x in source:
>        names.append(call)
>
>     sys.stdout.write("\n".join(names) + "\n")
>
> @find1@
> expression e;
> identifier call, x;
> position pos;
> type rt;
> @@
>  rt x(...)
>  {
>  <+...
>  e =@pos
> (kzalloc@call
> |kmalloc@call
> |kcalloc@call
> |kmalloc_array@call
> |kmemdup@call
> |kstrdup@call
> |vmalloc@call
> |vzalloc@call
> |kzalloc_node@call
> |kvmalloc@call
> |krealloc@call
> |kmalloc_node@call
> |kcalloc_node@call
> |__vmalloc@call
> |vmalloc_user@call
> |vzalloc_node@call
> |vmalloc_32@call
> |__vmalloc_node_range@call
> |vmalloc_node@call
> |kmalloc_array_node@call
> |__vmalloc_node@call
> |vmalloc_32_user@call
> |vmalloc_exec@call
> )(...)
>  ...+>
>  }
>
> @script:python collection1@
> call << find1.call;
> place << find1.pos;
> @@
> write_identifier(place, call)
>
> @find2@
> identifier call, var, x;
> position pos;
> type rt, vt;
> @@
>  rt x(...)
>  {
>  <+...
>  vt var =@pos
> (kzalloc@call
> |kmalloc@call
> |kcalloc@call
> |kmalloc_array@call
> |kmemdup@call
> |kstrdup@call
> |vmalloc@call
> |vzalloc@call
> |kzalloc_node@call
> |kvmalloc@call
> |krealloc@call
> |kmalloc_node@call
> |kcalloc_node@call
> |__vmalloc@call
> |vmalloc_user@call
> |vzalloc_node@call
> |vmalloc_32@call
> |__vmalloc_node_range@call
> |vmalloc_node@call
> |kmalloc_array_node@call
> |__vmalloc_node@call
> |vmalloc_32_user@call
> |vmalloc_exec@call
> )(...);
>  ...+>
>  }
>
> @script:python collection2@
> call << find2.call;
> place << find2.pos;
> @@
> write_identifier(place, call)
>
>
> Test result:
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20201016 && XX=$(date) && time spatch --timeout 23 --python python3 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . ~/Projekte/Coccinelle/janitor/report_memory_allocation_calls4.cocci 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201016/report_memory_allocation_calls4-errors.txt | echo "$(echo 'call' && cat)" | csvsql --query 'select call, count(*) from stdin group by call order by count(*) desc'; YY=$(date) && echo "$XX | $YY"
> …
> call,count(*)
> kzalloc,12652
> kmalloc,4902
> kcalloc,2564
> kmalloc_array,859
> kmemdup,797
> kstrdup,469
> vmalloc,405
> vzalloc,359
> kzalloc_node,177
> kvmalloc,154
> krealloc,151
> kmalloc_node,49
> kcalloc_node,44
> __vmalloc,34
> vmalloc_user,28
> vzalloc_node,21
> vmalloc_32,9
> __vmalloc_node_range,8
> vmalloc_node,7
> kmalloc_array_node,5
> __vmalloc_node,4
> vmalloc_32_user,1
>
> real	22m25,049s
> user	84m11,257s
> sys	0m12,168s
> So 18. Okt 16:55:08 CEST 2020 | So 18. Okt 17:17:33 CEST 2020
>
>
> The log file contains the information “9211 files match”.
> Can such facts influence the specification of efficient SmPL disjunctions another bit?

On my machine, putting the three functions that you have foudn to be the
most frequent at the end of each disjunction has no impact on the
performance.  So what do you suggest?

julia
--8323329-1982622638-1603038004=:2759--
