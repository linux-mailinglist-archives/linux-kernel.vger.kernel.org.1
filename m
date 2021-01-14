Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B04E2F5A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbhANGTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbhANGS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:18:59 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433DFC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 22:18:19 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id q22so6568715eja.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 22:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V6f56GHlvX+30vh+DfZsExZ/lVAivzj42R6p1vKO9YA=;
        b=1VxNfJeYo2SCW48DoIhJXUv4ZH/NwkAwPSchXiBWcyb0pHcnoyYSzydSAPwShL9/w+
         LsvaAe7mF6uXUVEFgv5fSiXdCtUeZ3JEhabsZ1Ccl7uxjM2smFWVoo+HEHwyfNwaow7L
         8S9JJletV2OtIkQzBQrT4j7RXy0gfBR2aSiYdcTGriyLkQBsMghrRWwKrTSSGixJta+E
         JTAaiD6v8ePqVmOmR6wmW6fYZrqwpxpMlS8fPgie+k9CvynrC5o/6nbXAQHkMjMi+pv1
         tC0vWVPGaRdnesbjLjoyy6C8l2CbwOBjauh1Df9fiTLBZSzOFVKd8W/XZmcJvLwD0bkw
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V6f56GHlvX+30vh+DfZsExZ/lVAivzj42R6p1vKO9YA=;
        b=JxzvXMjz+Q9kr9dHNfw1XI9tssLJSVVA5s0XdUQ9UCsHFIjpg/f3q7Iib06ThRPCPM
         j6ThjAAherpmCNixlsM5cIAR5zOdJ0VcnHvGtPb6DXytPw3gAIR9QRUACQ6l9PhaevQ6
         aX+ni/+O2EtppDt/9CZDLaqct1l71Mhe11I3l2GOxxZO1veVtRmObftq1+/2jspcDNjV
         zLJD27wtj5LGqQ5Fl4H05qysBlxpsjvcU5xHhhNei1F/e5oDIIuZ9Qoll7bc8H0sc6Wh
         1XMjtxhOYVtN9tvqIbLB7NtBCV9OtEhumD0RlMY8ULufP46FVbn9J5/Nq7Oe6QtWgRBL
         S+3w==
X-Gm-Message-State: AOAM533IceDUW2eN9Iu+N06+yd1sUG+ax0eJi/3aJvxcYQ7GyhEmROR/
        eqxYHA5jt4kleGYOIyQ/Dh3/e+BmQBzE+Mjwq/TJbQ==
X-Google-Smtp-Source: ABdhPJxrgOBl9xEDA1Gqh4koRRCp2CcKtKLfmgUGiGQTbaKZpts+wK9W7/mgOVdXnyraOhZw/5TvuyhbRoA/6YubSNk=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr4116106ejz.45.1610605097907;
 Wed, 13 Jan 2021 22:18:17 -0800 (PST)
MIME-Version: 1.0
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058501210.1840162.8108917599181157327.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210114014944.GA16873@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210114014944.GA16873@hori.linux.bs1.fc.nec.co.jp>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Jan 2021 22:18:09 -0800
Message-ID: <CAPcyv4gVPMUD7P0KwAY9xk3xBkodPExeJVG6i9=9FGexbJZpBw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: Fix page reference leak in soft_offline_page()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 5:50 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Wed, Jan 13, 2021 at 04:43:32PM -0800, Dan Williams wrote:
> > The conversion to move pfn_to_online_page() internal to
> > soft_offline_page() missed that the get_user_pages() reference taken by
> > the madvise() path needs to be dropped when pfn_to_online_page() fails.
> > Note the direct sysfs-path to soft_offline_page() does not perform a
> > get_user_pages() lookup.
> >
> > When soft_offline_page() is handed a pfn_valid() &&
> > !pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due t=
o
> > a leaked reference.
> >
> > Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I'm OK if we don't have any other better approach, but the proposed chang=
es
> make code a little messy, and I feel that get_user_pages() might be the
> right place to fix. Is get_user_pages() expected to return struct page wi=
th
> holding refcount for offline valid pages?  I thought that such pages are
> only used by drivers for dax-devices, but that might be wrong. Can I ask =
for
> a little more explanation from this perspective?

The motivation for ZONE_DEVICE is to allow get_user_pages() for "offline" p=
fns.

soft_offline_page() wants to only operate on "online" pfns.

get_user_pages() on a dax-mapping returns an "offline" ZONE_DEVICE page.

When pfn_to_online_page() fails the get_user_pages() reference needs
to be dropped.

To be honest I dislike the entire flags based scheme for communicating
the fact that page reference obtained by madvise needs to be dropped
later. I'd rather pass a non-NULL 'struct page *' than redo
pfn_to_page() conversions in the leaf functions, but that's a much
larger change.
