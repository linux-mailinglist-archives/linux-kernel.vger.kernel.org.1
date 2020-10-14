Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AF28E889
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbgJNVqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:46:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgJNVqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:46:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2AB2AF49;
        Wed, 14 Oct 2020 21:46:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jan Kara <jack@suse.cz>, kernel test robot <rong.a.chen@intel.com>
Date:   Thu, 15 Oct 2020 08:46:01 +1100
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/writeback] 8d92890bd6: will-it-scale.per_process_ops -15.3%
 regression
In-Reply-To: <20201014101904.GA11144@quack2.suse.cz>
References: <20201014084706.GB11647@shao2-debian>
 <20201014101904.GA11144@quack2.suse.cz>
Message-ID: <87pn5kfply.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14 2020, Jan Kara wrote:

> On Wed 14-10-20 16:47:06, kernel test robot wrote:
>> Greeting,
>>=20
>> FYI, we noticed a -15.3% regression of will-it-scale.per_process_ops due
>> to commit:
>>=20
>> commit: 8d92890bd6b8502d6aee4b37430ae6444ade7a8c ("mm/writeback: discard
>> NR_UNSTABLE_NFS, use NR_WRITEBACK instead")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> Thanks for report but it doesn't quite make sense to me. If we omit
> reporting & NFS changes in that commit (which is code not excercised by
> this benchmark), what remains are changes like:
>
>         nr_pages +=3D node_page_state(pgdat, NR_FILE_DIRTY);
> -       nr_pages +=3D node_page_state(pgdat, NR_UNSTABLE_NFS);
>         nr_pages +=3D node_page_state(pgdat, NR_WRITEBACK);
> ...
> -               nr_reclaimable =3D global_node_page_state(NR_FILE_DIRTY) +
> -                                       global_node_page_state(NR_UNSTABL=
E_NFS);
> +               nr_reclaimable =3D global_node_page_state(NR_FILE_DIRTY);
> ...
> -       gdtc->dirty =3D global_node_page_state(NR_FILE_DIRTY) +
> -                     global_node_page_state(NR_UNSTABLE_NFS);
> +       gdtc->dirty =3D global_node_page_state(NR_FILE_DIRTY);
>
> So if there's any negative performance impact of these changes, they're
> likely due to code alignment changes or something like that... So I don't
> think there's much to do here since optimal code alignment is highly spec=
ific
> to a particular CPU etc.

I agree, it seems odd.

Removing NR_UNSTABLE_NFS from enum node_stat_item would renumber all the
following value and would, I think, change NR_DIRTIED from 32 to 31.
Might that move something to a different cache line and change some
contention?

That would be easy enough to test: just re-add NR_UNSTABLE_NFS.

I have no experience reading will-it-scale results, but 15% does seem
like a lot.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+HcZoOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbktnQ//Wz7j0MLuDVxAX0s3N1XVhdNL1RjAH1dvVmsa
c4OeECJNbY9O4OubfR7krntaLWPj8rzOGaQy/13/WR1FxvJWlsmv/NYcPoUxZLAx
pe+Srawhz0KsZ2peL0kGdYXtg/Es7UV/2IrKIOv75WxGZvpj9q58e0H4wBpRIVwK
avg6W0OX4Lb+0M98llSL38f0oXrZCDhA55VEBeRTgclEKZp9O49eUg5LPGxLhZfe
PMFyUDYaL7Rq+jP4kMNvpikbJabi/jyMbYA/AnuL8mf6Hxiu9+SN4OX9CKUXH7pt
CbqDnXhQNWIk+Wl31YP2Qm8qlLbIynY3RDh/Se7S2m/o4ZrT2dbpAG67G5LMhv2h
tM9dBr1JBjOpuB0IW97prQ7zeR39RS3o7nbrqQLz/NyGmKfZJuIoXj/3gUj0Ilc8
0q1U0/MwpANNMjwqw6z58c/Ds9Z1qTrPvKfIF7fmFNw03prRHHUDu9BA2eT8SGBY
WxfPN/8SoxOLg6hcADt1GSm6l8g/vuFaFx5ac/Y6CA1Fp+kanUXTES08pTM71FeW
FxSsLPqtTUhWPsY3nKV0kDx9FACaDnW38J96FKwYB1h/5nLXa7LCwYsaDjjF+ax7
lmF8hWr39BD4dLs0GbSoQ/B+KP5+9lMSPK0LFSmf7B/nWhkmGnvEHgpan7m/j4tE
HQLQrcU=
=Pelj
-----END PGP SIGNATURE-----
--=-=-=--
