Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2299C2951C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503724AbgJURsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503717AbgJURsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:48:37 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30433C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:48:37 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w23so2798250edl.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
        b=DVzkzBJthtEEE9BytDByy1Zyi6AvIrMMfqilJKnpXorOKZpcoMkmRc0+51O1rnlt68
         bMY0od0cPkgr22Fq/K+EKbRk9QUUZlKvr9mGhIHdkRS+RFdmguKEoaDMpwVT2MTekysU
         aICew+9IVF+RRyoiu/PaGJVFHpxpM2ZfnviDOpSraD9hqMuMque7/usM9pzF/eaK9iyi
         qZF3JdUTjmf2nLs5oVUYf43A1aDD3wYoYI9oxDRZY55ia14p0XqJNtzi/CDl0A92VIsH
         Ytn7i5HZw9HsfFtKjUgs2Sf+IlYn4ti3aGTMDIrNugvXoKAtZI0M50rVaCu67NNkO/yB
         jfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wz+eFQ9E3XaBY60yIiY6/7ACNu1JGiJC/eGXK+f1jPc=;
        b=XPbs9kjiyGHEzwd3wbnEgfyWUtptByVeSPxJGVBdZZfJHA2Hj3L/plp33DE8pKzTQO
         U0SauI4+XUxY+Dp3ktHtsjW6/DuA/XSKetCJr5/JlFtvhzLhZW74fcOU+7oTiPqIIgZ9
         MmBiuowwvPo99QylzhRMb97gfVQT221FaV5iPFrJCVs1eE6AD8hxu5sTmEjymM1kVFEc
         u8oVaAZWX8mYVpyg4Alg/QjpSKjp9P84Nin50UMK4K9/qLHSfpHdelqRiT8pjGMLzZkx
         dwoITm75GYh5FMSrp+5/e5XT3i3AhqgPMJO1YqZQqvEFAakCZSmk+Z1/2p7R5sjh+liV
         xEwA==
X-Gm-Message-State: AOAM531bYVp/A4mIlD69dhup4gzsca2/iHEUjNSXB/u/wBjeMtxE6PbL
        6y8FVEdxbcR4+/irOLvMVeAO5QEpD0gLArO2mp65iw==
X-Google-Smtp-Source: ABdhPJyjfO8m3iOuqLFtlf+FomXd1BC4F7cQcApVrqZXlZQ1jUukEoyZcjOKoq++KT+r97hpdUtXqWK1yOAZ0wQ8O8o=
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr4292662edb.210.1603302515911;
 Wed, 21 Oct 2020 10:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com> <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Oct 2020 10:48:24 -0700
Message-ID: <CAPcyv4gOGi392Q3knF=cAuvKONnmp2AoKX82VQEQJU0c7o7AKA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:11 AM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> On Tuesday, October 20, 2020 3:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >     What does Linux get from merging mpool?
> >
>
> What Linux gets from merging mpool is a generic object store target with some
> unique and beneficial features:

I'll try to make the point a different way. Mpool points out places
where the existing apis fail to scale. Rather than attempt to fix that
problem it proposes to replace the old apis. However, the old apis are
still there. So now upstream has 2 maintenance burdens when it could
have just had one. So when I ask "what does Linux get" it is in
reference to the fact that Linux gets a compounded maintenance problem
and whether the benefits of mpool outweigh that burden. Historically
Linux has been able to evolve to meet the scaling requirements of new
applications, so I am asking whether you have tried to solve the
application problem by evolving rather than replacing existing
infrastructure? The justification to replace rather than evolve is
high because that's how core Linux stays relevant.
