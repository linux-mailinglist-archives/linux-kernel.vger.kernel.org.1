Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD928078D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgJATMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJATMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:12:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D4C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 12:12:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id md26so4020912ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVHKGkTv8PByBSw5x5TAqafUmlr9UdQTcHRRx3gB2PY=;
        b=wj1V3E+Xo/qZX2n2TWSTBFK1h5lLngoTdOEOoGP2nX7u0ogu4VgtfvbzyJr37mIOR3
         kkHHKyJAQ4zGeEWHu7jHqhwHa85fcXFctsNqfk0hA4oDY2Koxwh5IXm9N3FUT8dyCCSI
         ibNcKnFBgwXB2ouDk5TulMQYmXXI+Zjl9HTGNo1tpAldWFQdASR9IJm8EVd4Mahabfmo
         WMI/wbGd/mR/neJ0DwIHgEVS0jZvYPWMZ2OjaV6Sor+ORnbsMmY0udfwqgUuPK85ELGC
         TFX5jKMdaItdWj4xCGKEyOAvUuUvtxNuR2SG5Ic8SNYPt6rm7CE7J0gH7++J9KfrwwFP
         xEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVHKGkTv8PByBSw5x5TAqafUmlr9UdQTcHRRx3gB2PY=;
        b=gnia5ro+Cx2zMfU3pWRyitk+VLXbqxzV5+SIgdv+OEcFiNiISNJ47UDxmpe5Lk1TeG
         9yfGkZi7dLbVA6M+/mv6cxuI43M5DZZE96yAXAn8VHaLURbidKUY/2ZDU4l8irh6cMN8
         Rzs09JR+uGyiz4zRFlKEEoZiourwDThxw5ojWOJOF26W/NoDOpnNdVr4Ey/zmX/E1Uw2
         cqQfs6Slovi053eCBtvjWc/LvRjtxDCs479lhNpoOzT/aUbQ06GP11q4pziFFqD/zpGF
         uhsytxFZCR3U7ia2tiEnsNbnG4G1UevaeMJH3L92S5HjTIDNJCnxXrM9TU4DaDoK1X8w
         xuzg==
X-Gm-Message-State: AOAM531lDm+mcWBVY+78AIO882hPGoMu/NbeTCt+gQOQgQcDciZ7b2Gm
        eQKUmMqxjkMtGUFh1iwtTg3pBUlHoDWuQOIHf49UNw==
X-Google-Smtp-Source: ABdhPJx2xuTe9l+SDL/5xLNgCEWJKaFIrTbLSDyHIXAINehaPQgc2qztyz23QccWB3sUHSjq3YIOjigycbLia5rcLws=
X-Received: by 2002:a17:906:b88f:: with SMTP id hb15mr8349424ejb.45.1601579556191;
 Thu, 01 Oct 2020 12:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106110513.30709.4303239334850606031.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e3b7c947-c221-8be7-41ae-aed2f481d640@redhat.com> <CAPcyv4io6a7qaX+oa8uL9C0nc9J9UMx0CfC5E1DYdhSPvYVeOw@mail.gmail.com>
 <8012a7c2-750f-38e1-0df0-200b56109fd6@redhat.com>
In-Reply-To: <8012a7c2-750f-38e1-0df0-200b56109fd6@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 1 Oct 2020 12:12:25 -0700
Message-ID: <CAPcyv4hXMeb0NSLMObxZCQiVDe7ZcZT2wZk13jAqpoH5An7hnA@mail.gmail.com>
Subject: Re: [PATCH v5 01/17] device-dax: make pgmap optional for instance creation
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jia He <justin.he@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 10:39 AM David Hildenbrand <david@redhat.com> wrote:
[..]
> >> include/linux/range.h seems to have this function - why is this here needed?
> >
> > It's there because I add it later in this series. I waited until
> > "mm/memremap_pages: convert to 'struct range'" to make it global as
> > that's the first kernel-wide visible usage of it.
>
> Ah okay - I'd just place it right at the final destination, instead of
> moving fresh code around within a single series.

Yeah, it's looking like this series will all land together so I'll go
ahead and move it.
