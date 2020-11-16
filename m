Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666BB2B4869
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgKPPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgKPPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:05:02 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:05:02 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so12989180qte.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=peTt0Mms593LoO2PuBM0TsDE6Qx7ZUxtRHVaaA7svoQ=;
        b=fC+kroDrq/xQNERtX2LSop7OnuNHBHz0/y4czDoPzD7cZxnES8q9cVAs7oX6ahdnlj
         zXDSmm5lzULZ10/1hXLEE8ap6dkFoJ5my9w5/hYYxQWO4UpAOrE55MdPief+W6/1wryc
         SRLvAq5OwGepX4bsQkYtUYZRzoARKuLZHhVANG8Sx9bZ1ik0c4ah7kt5Zz1lMM0yg8ix
         dTMw/Bh8F2LYa7zvULStn6+kJoCinrjKjmr8KiRh5U5KM9I6d5/u5kui70NRxQojrqFQ
         RdCfk/0zWo3DEdCYwsH0HIxUSqo9rQsTAKY0woboCf4uFMSjilQNgTyPaJ6e3HRteFuk
         LTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=peTt0Mms593LoO2PuBM0TsDE6Qx7ZUxtRHVaaA7svoQ=;
        b=KVD/y9vodfbrfxNNWa4DCZFg9Vri6BHbvmBQXpB8QkOlmz/Z6txYd7PTSWX0fZT5gg
         tYQIZJDVb12CmvkPpG2i7LMkmSS51LTkiV3ag4x9ACIMxFHbH04JZ84CFYPZixdNJQTA
         uwCD7jEz3//4Sa6J18vB5sjHlQzuOAcqEtht31GJsN/que0qYYxMsAlv4i9HEFGZNA56
         idnzNxvBpdT0LfYUsQKr57JSajk2RGMpQOBToqZ/7CVUdIV8P6TqshY8oYfFr9LJ7yRY
         2v0tyl5/xqWf/i/Va8PfcCwJ7QOvUuygxBv7Oe3zyIpMZSEdmBRYuf/gEoVb4ZRSQrtX
         1Xpw==
X-Gm-Message-State: AOAM530s9gHGmwIJDgi89eg9vhXgJpvQTlLJ31tiOKLavXyUXJ5vROad
        THSz9z9KG3+gjFTpNLFpmx6Gnu3lZ/UIng==
X-Google-Smtp-Source: ABdhPJyyp+H0t/+lgxpeH7Lpcz4n2yK+AjYpBwtxMnJifPiMCJH5whrQtJ+kLkdq8JVXAQ3f6RXEXA==
X-Received: by 2002:ac8:5b94:: with SMTP id a20mr14538722qta.223.1605539101637;
        Mon, 16 Nov 2020 07:05:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e49])
        by smtp.gmail.com with ESMTPSA id o187sm12299486qkb.120.2020.11.16.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:05:00 -0800 (PST)
Date:   Mon, 16 Nov 2020 10:03:09 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-ID: <20201116150309.GA924708@cmpxchg.org>
References: <20201110195753.530157-1-guro@fb.com>
 <20201110195753.530157-2-guro@fb.com>
 <20201112162303.GB873621@cmpxchg.org>
 <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
 <20201112171239.4f8ef107f741c3462556731f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112171239.4f8ef107f741c3462556731f@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:12:39PM -0800, Andrew Morton wrote:
> On Thu, 12 Nov 2020 16:19:26 -0800 Roman Gushchin <guro@fb.com> wrote:
> 
> > >From 8b28d91475d54c552e503e66f169e1e00475c856 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Wed, 16 Sep 2020 15:43:48 -0700
> > Subject: [PATCH v2 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
> >  caches with SLAB_ACCOUNT
> > 
> > In general it's unknown in advance if a slab page will contain
> > accounted objects or not. In order to avoid memory waste, an
> > obj_cgroup vector is allocated dynamically when a need to account
> > of a new object arises. Such approach is memory efficient, but
> > requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> > because an allocation can race with a different allocation on another
> > cpu.
> > 
> > But in some common cases it's known for sure that a slab page will
> > contain accounted objects: if the page belongs to a slab cache with a
> > SLAB_ACCOUNT flag set. It includes such popular objects like
> > vm_area_struct, anon_vma, task_struct, etc.
> > 
> > In such cases we can pre-allocate the objcgs vector and simple assign
> > it to the page without any atomic operations, because at this early
> > stage the page is not visible to anyone else.
> > 
> > v2: inline set_page_objcgs() and add some comments, by Johannes
> 
> Had me confused!  I was looking for the inlined function
> set_page_objcgs().  I think "open-code" is a better term here than
> "inline".
> 
> Here's the -fix:
> 
> From: Roman Gushchin <guro@fb.com>
> Subject: mm-memcg-slab-pre-allocate-obj_cgroups-for-slab-caches-with-slab_account-v2
> 
> open-code set_page_objcgs() and add some comments, by Johannes
> 
> Link: https://lkml.kernel.org/r/20201113001926.GA2934489@carbon.dhcp.thefacebook.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Thanks! For the combined patch:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
