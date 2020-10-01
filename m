Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74128046C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbgJARAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:00:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:00:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601571642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FBxjpUPAONJ+XqUQuZPU/FmGyoPMABIG8dYwepWTg9o=;
        b=nhlNWx9WKyL/R8ePbdgLs+VJsvxFk3kt2QqgvZxDohm1sNNcQukYleQjt8TxHMeHWc+KG4
        Bpi0vvxmAB/rl2mmaVD2UwnbgRwMogFFKIU5CnqlDsIIRnpV/O/OjQGzd/rXf+d+3gZNmE
        d4L3k7kbRYqNo3CclC3b/kt+poFTwFA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C78D4ADBB;
        Thu,  1 Oct 2020 17:00:42 +0000 (UTC)
Date:   Thu, 1 Oct 2020 19:00:36 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20201001170036.GA29848@blackbook>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20201001002710.748166-5-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Wed, Sep 30, 2020 at 05:27:10PM -0700, Roman Gushchin <guro@fb.com> wrote:
> @@ -369,8 +371,12 @@ enum page_memcg_data_flags {
>   */
>  static inline struct mem_cgroup *page_memcg(struct page *page)
>  {
> +	unsigned long memcg_data = page->memcg_data;
> +
>  	VM_BUG_ON_PAGE(PageSlab(page), page);
> -	return (struct mem_cgroup *)page->memcg_data;
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +
> +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
Shouldn't this change go also into page_memcg_rcu()? (I don't think the
current single user (workingset_activation() would pass a non-slab
kernel page but for consistency sake.)

Alternatively, I'm thinking why (in its single use) is there
page_memcg_rcu() a separate function to page_memcg() (cross memcg page
migration?).

Regards,
Michal

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl92CywACgkQia1+riC5
qSiqEA//SFQ/WkWbKkYPDQ+OghC6osKkFtrUsL47bJda7RmwZBt8HEdVQF80bilH
FT6WJF9TiSW7ezR3Gj6KrmHBKvy8vYOOiTRLv4qQG/ThSpGdrxlT7L9u1BMrWW0c
3aCNmHUGCpUU03dMaa9H8KfhPY6pRON/wz26at9xsGPgMkn0EBrzOA8WDBOxLhtS
mVXj8wKPbX2UY8VewV6chYIlucx4joCnbw4xjbNcoW1+XJ6bglBWX0dS1dwz/hoV
fLxdMdXlCs5fM53Xzqlv2BgHkV//l3oCUN2G8wi4EKSg+iit9mBRnYDPQ/pOXN7o
uXWjxQBZMBxCt1Ct5avF3P/Af5CLhVbUPwsNItDlMTTZDoUV1/4drfH5uikMw4/k
ORS9BkU2Bl1SFL6ivYtxFqSrEAbzzj2RuDyMBc6GnlvkNO8lva2wyCrPUuIFsDT9
W+88q8gNSq0B6MsiLfP6/cIqaesm/9lRIjEKmnRlD8x8B5lV/bMFa4C0wAOc6zyw
yxxBD0b7cAVlRaBD/SADEzfEE+M9A36X/sgnl0LJSFKSozPgabUekUgoRSHkZLVw
wfITwV7HvYux5uWXCeyIQI18iO45F9GDh/sArHiYCwQUVsri8QTNgJbn3dl4tNBu
hE3nDTgseJJb6l0AFTepeiecNjTmvj0sT2vUSxHXjizC//zhVVI=
=l/la
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
