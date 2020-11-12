Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1D2B084B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgKLPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:20:21 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4568C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:20:20 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id y11so2888018qvu.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDRYcXH2Tlj+IsIFX0IkGhrvzNzP1X0UM9xeo7JwYWg=;
        b=qp58B68OPcq6WzCKL4Pxf4Cr2rWBYMhIbERa2fIh0ekx+BVEyeZ1gfxwljBJfv+0i+
         FDpnQacMYMr6b8ydDk8N6u74cXlmI0bIANHfXGNa8s+7AAkL/IdR1kwaEQWwUMOCz1Wf
         fVKQFvFLdo+9bJraJJ5FXNKnSdpATqUvDGKoWj6WX1s8f2OlOUd6XEhUxTPdKhbxYwn0
         Lhag4BnDc6o0IH25tzvxoqMZIBJ1sILoIw/c02tF+vwlIoAAvuXg0H2csYQyn5WOyf6O
         X7RRl/uK9LOCITHE0XPrpTfyrBonx23oEpvCJGqBsP+EanQVT55ivxKYFLsCcBRCBx2N
         GS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDRYcXH2Tlj+IsIFX0IkGhrvzNzP1X0UM9xeo7JwYWg=;
        b=oS643Sozo/G/X75bNY/S0J6msn7FoJaSmZHOQ/bpPF3WmULnX1OIpOhU3GeTvVa1cP
         VLLM4KpNa5mf+Z4snRYz3WjvNU/z61klT5y7RP0QX2uqhzjoD8iIhquReEiZjqWGBzyA
         clsKsdFJEspBwvkQOIs35+7jTF/j9NJEKo2JDkN/3FUNsDhFmz4ovsi/TpaifQ/xYPcd
         KOb2qfxTyH4cOGCRtbKrkChCHOmEZEXCvfySAmW+/Y1hQdNFtKuS4LP9LCWXdqK+Lwmc
         vCW0vhKOYwpTtfuG59Y3WLgsIgzlCC1QyWfrOv/9SxFO053ihxH3WDRuQZyJzKTfF/Pa
         tdvw==
X-Gm-Message-State: AOAM531+OU0Hpktz6zZ+lLvl8MUJKAwiNZqjwrwG3HgxTduOV7uK7u0R
        hpsWtbpcReLHHmwVJl9KDYe24w==
X-Google-Smtp-Source: ABdhPJypfB00vA2U1wYcu9CcFQg2UwLr3WnG0G63MjEHHhSJSPCac+fmNLrV3dVmsCiQGd6yuXJUIg==
X-Received: by 2002:ad4:524b:: with SMTP id s11mr223505qvq.3.1605194420152;
        Thu, 12 Nov 2020 07:20:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:7257])
        by smtp.gmail.com with ESMTPSA id k31sm4693276qtd.40.2020.11.12.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:20:18 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:18:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm: slub: call account_slab_page() after slab page
 initialization
Message-ID: <20201112151828.GA873621@cmpxchg.org>
References: <20201110195753.530157-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110195753.530157-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:57:52AM -0800, Roman Gushchin wrote:
> It's convenient to have page->objects initialized before calling
> into account_slab_page(). In particular, this information can be
> used to pre-alloc the obj_cgroup vector.
> 
> Let's call account_slab_page() a bit later, after the initialization
> of page->objects.
> 
> This commit doesn't bring any functional change, but is required for
> further optimizations.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
