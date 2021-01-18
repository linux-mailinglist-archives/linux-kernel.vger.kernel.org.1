Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449B82FA155
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392184AbhARNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:23:33 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10545 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392170AbhARNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:23:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60058b990000>; Mon, 18 Jan 2021 05:22:33 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 18 Jan 2021 13:22:28 +0000
Date:   Mon, 18 Jan 2021 15:22:25 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
CC:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        <daniel.vetter@ffwll.ch>, <sam@ravnborg.org>,
        <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: Change eats memory on my server
Message-ID: <20210118132225.GA51141@mtl-vdi-166.wap.labs.mlnx>
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
 <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
 <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
 <c9078ed1-a3c6-32b9-b76f-cc511cb54c83@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c9078ed1-a3c6-32b9-b76f-cc511cb54c83@suse.de>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610976153; bh=XHGVjxJF4mqdIXeQSNYsc7Nx4uEaV/sS9REKWovmbJ4=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:Content-Transfer-Encoding:
         In-Reply-To:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=Zi3cv2e0qoNhJCXXaKcHKAUBcJ4NJ9+MBgkImtIWtQ3WuhNUpdCAjWmYWSJjg6pL+
         cL+9WaNukgbjI0tEiC5g+jBbduR6O8ehbrJpObcMmza07NPOv6pf6pp4abIqxMLJFt
         CJNhz4jTubv850hACzENZWmhtDdJU1RCuHM3GZZOLtLwmQe49p+jFCr1g07asvrVVl
         5FpoYshrINKX9gUZl+Zf3mW8uPlViVLoVsjX70FOYBntvbiKgCyfTu8iOjXf5WnWWw
         HWynIjPu3eSbb+ktd8lFQqj1+9NElDg2RTORBxfWoHf0tsMay/4iE5Z8ml2hEpBEFG
         3d1QU49elEtsg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 02:20:49PM +0100, Thomas Zimmermann wrote:
> Hi
>=20
> Am 18.01.21 um 14:16 schrieb Eli Cohen:
> > On Mon, Jan 18, 2021 at 10:30:56AM +0100, Thomas Zimmermann wrote:
> > >=20
> > > Here's the patch against the latest DRM tree. v5.11-rc3 should work a=
s well.
> > >=20
> > > I was able to reproduce the memory leak locally and found that the pa=
tch
> > > fixes it. Please give it a try.
> > >=20
> >=20
> > As far as I am concerned, this issue is fixed by the patch you sent.
> >=20
> > Thanks for looking into it.
>=20
> OK, great. I'll prepare the real patch soon. Can I add your Reported-by a=
nd
> Tested-by tags?

Yes, sure.

>=20
> Best regards
> Thomas
>=20
> >=20
> > Eli
> >=20
>=20
> --=20
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
>=20



