Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C346F2F95FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 23:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbhAQWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAQWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 17:36:27 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 14:35:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id g12so21094853ejf.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 14:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulnCSQ44YUhN9X9MAQEMcAc8eh88jI5ZhULk5yuUjlY=;
        b=nH6qQH3CSPydxTALD0skXPT4yCLrsSN7lTRp33mztLs5kVypDJKD4NNP92U3YRluSZ
         V+hoAv2K5mVRcBQ5S3eeqQDll9xwE7NEfJAmv4WqMBrWXiERvLx0mWx4l+AXB3Q/2dMg
         Zr7Hg6UBkpaPU34GaYIwFVG+jxpiO9LoUhfmMD5oKP6EkYO1wTjH/J6DDvTMJfMcO/f8
         NnsawZSVh+dT1z7sADQMkyeF3waZCMRoP6LGK4ken2P/hV2gykYfNU9OdBI6XPXsB2tF
         QObiY285JpBicH0RDp2SUsdQ8Y584b9e1XuwY7V44Nfpdc7t8FZ+1MqczgTeDNmHQFwI
         sA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulnCSQ44YUhN9X9MAQEMcAc8eh88jI5ZhULk5yuUjlY=;
        b=HSxlj9EF8xK45nN4xqSRudRp3TFgMKRlaMdIv+tIAOHytk72Xmd7HrgUPjm8sX0zkB
         E5qeggDcPcJlAS7ziFtuKCM2Fxp16Gzc6fvQMsQdPVP0X8Q3telnXre5MHDH/rpLG4tw
         5Swogv/q5YgEXA1aww9oKWMVevn1+Dv77AwaF0pWcf5NswtPP+ajmqpQTg/Fuw8tWX+t
         vsn5YCbftzoTWp7/XhOWCmHAwLbzQps4etiZaaTKDEw3lcnA4LMSnscSyFzyeOaZ9pZO
         b8C5tXRoTsPhR2fsQPCDG2OCNk84jBl9kNVLMA1aNah4etFvcVYnt1Pak8IjtHIJs3Md
         2Lyw==
X-Gm-Message-State: AOAM533fA3RLf1Gm+I1fS11H5NZWB3Y55uP/bjUf5+7uAJALAUvT+zKi
        TDc0ARgsPbDA5SYii5fC0osiNKPSG2lnIXjAiGEQew==
X-Google-Smtp-Source: ABdhPJykQ4aN9XzIZG+k5ieNSCq/ExStxGPgoeTqRdHv4EkpXsssxJrXDWF2Ue2urWeIOyT9kmFppL4L52qSdP+zDxY=
X-Received: by 2002:a17:906:e085:: with SMTP id gh5mr951255ejb.418.1610922945887;
 Sun, 17 Jan 2021 14:35:45 -0800 (PST)
MIME-Version: 1.0
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058501210.1840162.8108917599181157327.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210117140142.ab91797266e0bef6b7dba9f9@linux-foundation.org>
In-Reply-To: <20210117140142.ab91797266e0bef6b7dba9f9@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 17 Jan 2021 14:35:36 -0800
Message-ID: <CAPcyv4jGXoMA2=OGa42_SuOiPjHUH2o_1YE5jQxU51PyKn6b2w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: Fix page reference leak in soft_offline_page()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 2:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 13 Jan 2021 16:43:32 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The conversion to move pfn_to_online_page() internal to
> > soft_offline_page() missed that the get_user_pages() reference taken by
> > the madvise() path needs to be dropped when pfn_to_online_page() fails.
> > Note the direct sysfs-path to soft_offline_page() does not perform a
> > get_user_pages() lookup.
> >
> > When soft_offline_page() is handed a pfn_valid() &&
> > !pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
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
> A cc:stable patch in the middle is awkward.  I'll make this a
> standalone patch for merging into mainline soon (for 5.11) and shall
> turn the rest into a 4-patch series, OK?

Sounds good to me.
