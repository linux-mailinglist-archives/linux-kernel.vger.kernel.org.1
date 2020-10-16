Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997AB290AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391984AbgJPR0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:26:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391855AbgJPR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:26:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602869197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7adOyJQobTs7oFN7R41/ee6ZODNptFcC0aLMfk4q+Q=;
        b=cvs1EqQJad6ys0IgBRtNq+qkk7IAGgPYw8pc+utGMKssl6HaCS8gQoJoBHSjjuuEmU1ksy
        Ds1TvB9F1dI6TZbBH9+Ek+woExdQtDWvp9GT5QRl0QoCdLF2WHvKMhuVxJucc50i5/U3+M
        k/KNwdhcwmKXqSKlzi+r3bAGjhwnk5k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29212AC19;
        Fri, 16 Oct 2020 17:26:37 +0000 (UTC)
Date:   Fri, 16 Oct 2020 19:26:35 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     Roman Gushchin <guro@fb.com>, ltp@lists.linux.it,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201016172635.GB102311@blackbook>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <87sgaesba0.fsf@suse.de>
 <87pn5irz2m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <87pn5irz2m.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2020 at 04:05:21PM +0100, Richard Palethorpe <rpalethorpe@suse.de> wrote:
> I'm don't know if that could happen without reparenting. I suppose if
> use_hierarchy=1 then actually this patch will result in root being
> overcharged, so perhaps it should also check for use_hierarchy?
Right, you'd need to distinguish whether the uncharged objcg was
originally (not)charged in the root memcg or it was only reparented to
it. (I originally considered only the genuine root objcgs.)

In this light, homogenous charing to root memcg looks really simpler but
I wonder what other surprises it brings about.

Michal

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl+J18cACgkQia1+riC5
qSgBlA/9E7AebKZQjQP9HUGpWS+49sRCns58CiQJhFugbkHlJl5PsgvI9rQs9j6k
AhG6e0WZlMb35II+naqx3kNnAYoRiw8xWcuAH+lvWFXKI1saYN4UOjKNzigojTw0
x3fi9bRJveQtpwPY6IwXbiOJkYZnEplEskwiqbY0kCFZMhQlvnBfJIAzegEa5Jty
ZCcqYPMxcfczsm3+vtrcHDWBXzujoxp9QPyyNWmRAkIjgTebO3ZmGRieCVmuPTm7
PY1nCA/65amYSsxBPvo+L7U5a4jKOV04pSLg0PeBByJbiy3TEoLi0938arMVg7P5
MT2PdqfzJ5W1T+7zh1SsRWV2/7b05JLVHnLPTL3SlvNIn2GIouSWSnAbdiZvqenB
XFafC+4PbL0xTdo5Lrp3pqTgw8kwScNUz/5FnRAdNw7eET2bGRQ46ah3EBQsoqNw
kOv07/gipMp3BBNJy6JHV+hSwK8CfOvy45FuyIJ6TAzYKZdOaBVWv4kt2eesHj+I
qzGRmmhS1rPcSzMtZU2rBIXcWfy7tgUsPdyEOgx+0VE10O0Vn0qFEWcupTSLYykv
8C301Q+aMnXbFcytJ5dSixD3oxzI5OP3x8VIkyuuoFe9MsRJZuBwBAYS6Vl+Wwd4
fmJBhroGerid+YzHDvvB0zeNr+j4IBjztGGJznC0/Mgm/Bf3rn8=
=j9PI
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
