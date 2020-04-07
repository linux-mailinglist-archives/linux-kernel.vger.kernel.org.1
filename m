Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCE1A03DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 02:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDGAnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 20:43:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45324 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:43:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id 71so1426680qtc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 17:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SmqCsp5QxJqlhSsYQltOb14Ug2eJJSL1fJBRe6dPxdw=;
        b=um7NZxXedFQk5SacVy6+a83LWcrVp2HQuSPCovHadsf0PyHz/f+ogGYG1+iaRFL4F6
         eR7IOFKrzGBp5xk5MV8gQuurcmw1hyfwTefhepBco90BPMkH2dT2b0hs9R9PUbzd3byF
         L3g5SCXclNDadXjNeLHeVTMzNUIUblwaKm/5ELl/fqJ+3iNlPmz5UEM76J55YPi6a5TG
         lEN7SnSQD6Af/NKs7FJg/ZSR+FMIjNtGAncfSwPlvREE6sUlOhC7KExBhdbhr+tQu8yp
         yQarjeBx12yjA7N+rmI109tF62YFdAUOWhMpd1CJUdl7DOEazNf7NtIb43hFlHno/xsE
         qgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SmqCsp5QxJqlhSsYQltOb14Ug2eJJSL1fJBRe6dPxdw=;
        b=LPnXJ6Z3gNbTlUsxnpiOLgr1plqN6Qh5U/rVVqzbboOdYDVChxF3fm2LSnCKxIf7JF
         U6nTnvNY1Q1zb56ZCDX8yfnrYe3iwgSzZ2ciJmXmGASHG5lzHIKw5p/Hda4QG1Fze+FD
         qwiRGxNucUo8BrM4ofAJ9RzzG5v9SE+mxeUs24caUHMmypxJScuNldAHSbFFmpL4cbj/
         iz1h8dpB5Fa2KQYaoI6SC1X1OFAynh113SRjDI4L6yWnt2eUKWN1IpvNltWdAbAjGc6i
         +yoYNGiMDIXZ9Z+gEV0e2k5PjnaOsqfSoWYZLwl9JPzi9yHxHegmIgeTI5SgV766H3cT
         FLAQ==
X-Gm-Message-State: AGi0PuZ6X+Tan77L+1THNb+MckdkNLbwDuGYhueLHvWnOpCY6zCMu9YL
        L6T/iek8fD8wcKdFSqJ+q8idaFii9v8rW21xjgs=
X-Google-Smtp-Source: APiQypKFLUlQyC1lpZ+FR4f1LmELwsaGrBqeC81xTHnZcXe1pvBhd2QCNb77gJY7gDkXINi1irADx/SfOkUOgOVRkBM=
X-Received: by 2002:aed:3346:: with SMTP id u64mr2137234qtd.333.1586220184881;
 Mon, 06 Apr 2020 17:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com> <20200406115804.4440-1-hdanton@sina.com>
In-Reply-To: <20200406115804.4440-1-hdanton@sina.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 7 Apr 2020 09:42:54 +0900
Message-ID: <CAAmzW4NxHW5boy6OiPcwzamwrJGXnEVNgn27ACtfDCoqQ3F24w@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 6=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 8:58, Hi=
llf Danton <hdanton@sina.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> On Fri,  3 Apr 2020 14:40:43 +0900 Joonsoo Kim wrote:
> >
> > @@ -153,11 +165,16 @@ int add_to_swap_cache(struct page *page, swp_entr=
y_t entry,
> >               xas_unlock_irq(&xas);
> >       } while (xas_nomem(&xas, gfp));
> >
> > -     if (!xas_error(&xas))
> > +     if (!xas_error(&xas)) {
> > +             mem_cgroup_commit_charge(page, memcg, false, compound);
>
> Add a tp
>                 trace_mm_add_to_swap_cache(page);

Please let me know the reason of this comment. IMO, adding a tracepoint isn=
't
good idea until it is really necessary since it is considered as
kernel ABI and it
cannot be changed easily.

Thanks.
