Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E520973F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 01:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgFXXra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 19:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387881AbgFXXra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:47:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00C3C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:47:29 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so2756689edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Fvdsiz8MkdsVL2lFPEcvvla/ra3rq7tEtUzSg1iTxM=;
        b=IOqtxZqbihUe4NvFtQ7g5qCSWj8O1LYkVEuxXmcx7dHb4dYyDa8iAUfuh0i7p2GGkV
         ujBwdaGwcX63sAQjzq+Si9yp9Db3wkCa/Lb7FZuHkD0kofSwJKZF8YFC7F73T6nwmANU
         N7YkcpDdMnA2oBJbSlfeTqbxeS9/iXdZyMFJP/f1rfGicLsgwtAq763avr7uQnJFmVWW
         9uF/KIOnWchdRqfQzo8geoUqkLEanZer5/kccG4QPofmpB2bLHD9RIUAVOaaaM47ntSH
         WLK3eKki5Q5S7J/fmjlWULSqZ1ZeO7EdROH8VvshTht+VAy2gLNGZu8kjxw1xhh2zStY
         hR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Fvdsiz8MkdsVL2lFPEcvvla/ra3rq7tEtUzSg1iTxM=;
        b=RvGQtQn1g84uEFtYe1byiNlZylRKjSYtA99Ywn83Iekykk5AwOPTcYV69V3mv85dN0
         5+hjFqnth7Wrivsqt3bIT7ZWlzqEfPjl5HfBbmkVZzPHWBJt1ukQA5VDTEBulImlzI/v
         4rcvoJodxWvDYM9jMiHn4We1nDgf9PxGZVUXP59bDsDihhtzU8WlE8C6oaBCYMTrn5mX
         SkLzhKmEjPblOeryHTLzuRZ6uLbz0I9sSpL7x6v72c6/8SBwUYf7twgIlTq2eW0X4KQY
         leUTFnP1PujYrLViMb95pVa14xfFYWt83Q7S5YEdFcVaxkhgSN/A14pJ+WacCEXnZmtc
         yTAA==
X-Gm-Message-State: AOAM533hcylfRhO3mSZEW65IGqyBVH/6c0ei15NTLVQZTKvs0g27xUfv
        y8Pfde3wlfL1yoT6RsCvzO43RU+rohlS0Bw+wvM8Jg==
X-Google-Smtp-Source: ABdhPJxbo2NKGbxKrMC0oomx6UxUfdokYoRowgva3p9GbPKrR0Y07IbrBNnZTSvmoU+o5BxWQjKJJIAA1KBN+5nJ+8E=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr14314671edj.93.1593042448202;
 Wed, 24 Jun 2020 16:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz> <20200624061340.GA11552@L-31X9LVDL-1304.local>
 <CAPcyv4gEUq0yyz00AbQQSyo_acj1wUCZPse5vEff_Bq7GmeksQ@mail.gmail.com>
 <20200624220552.GA15016@L-31X9LVDL-1304.local> <CAPcyv4iHM2d0qZFsznwv20Z+rTcj-8CZTDBQv1kJ50FwZuM90Q@mail.gmail.com>
 <20200624224410.GD15016@L-31X9LVDL-1304.local>
In-Reply-To: <20200624224410.GD15016@L-31X9LVDL-1304.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jun 2020 16:47:17 -0700
Message-ID: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 3:44 PM Wei Yang
<richard.weiyang@linux.alibaba.com> wrote:
[..]
> >So, you are right that there is a mismatch here, but I think the
> >comprehensive fix is to allow early sections to be partially
> >depopulated/repopulated rather than have section_activate() and
> >section_deacticate() special case early sections. The special casing
> >is problematic in retrospect as section_deactivate() can't be
> >maintained without understand special rules in section_activate().
>
> Hmm... This means we need to adjust pfn_valid() too, which always return true
> for early sections.

Right, rather than carry workarounds in 3 locations, and the bug that
has resulted from then getting out of sync, just teach early section
mapping to allow for the subsection populate/depopulate.
