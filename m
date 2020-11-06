Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C64B2A9020
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgKFHQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKFHQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:16:25 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD991C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:16:24 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f38so265036pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JK18Rhy91HwT2txRvUrbyN9C7BXKAqk0ab4AsbXgEMM=;
        b=OMswEcKlZ6u7lVSY5ZjSSjpAAlU8mNOo9Eab9GBjF7Pgt3q5emL/wrqJkccjhl5+NJ
         K5bUWEbteB646OruN6awgDclp8Lzv5xqRT+JScSZ5SJAVlaTlxFksMNjS/m1cXSqW022
         LOudcHy9smFLD8XB2TORYPNdms6hsEuAYfpjorA8jIXUolnD49bLaUTj3tk6yMcnIuP1
         mPKyjeauP4jYBIY1oc23BsZ4xGY1a270f+xshybPS05i03DPE2i6b2dH9KGme/JPtxNk
         fm5RjSsuPG4IctFnTMrugDND7eZAEL26f+jIHd7KzpLqTOoH34VEe+OZma5PpEOMy9vw
         Ou+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JK18Rhy91HwT2txRvUrbyN9C7BXKAqk0ab4AsbXgEMM=;
        b=NSwXA7Bv07oN/fReG80CfVIDagdKyJkOeOESb7s56bWzSSO7y7Y9G6fVFADaOkQhz3
         iSWCKaixM3TXacHzcde50y7ygNupJhM4ZsX0i5nNIiNpbfaL+isg3l0Y0KTSDwT+noLN
         yswDhB9UcBULlKJ5/hbtxHHy86xpINdPwVSMnp8oF+eIhZths6ERIBlBXI6A6u76tETF
         PMsKzprPMVaCw+VZD9ua4PBFuC/TYhX5FlANdJuaJJZWougjQ4k6nmoc8Yzzdkxn4qNQ
         ELQLgHEpMX3Kn92lbQybVhKSrCwO6oLzmwn7uUUs8bVv0pmFo14XD9dBUQ0uPsJUZfDj
         wlkw==
X-Gm-Message-State: AOAM531hh0u0IN1Yt14UOSEInJIGSvDpDCXPVku060fIvcCg8CTv2Yjh
        SOuZViHUVSjQOEkcu8vL6h2e3g==
X-Google-Smtp-Source: ABdhPJz+ePL3+cF7buh0lCKBX22R8mn3p0gqXYRUxKc69GWG/jhsr0wV1j83B8aR9Cp3xNgjLldqkQ==
X-Received: by 2002:a17:90a:a394:: with SMTP id x20mr978947pjp.213.1604646984348;
        Thu, 05 Nov 2020 23:16:24 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id t26sm863991pfl.72.2020.11.05.23.16.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:16:23 -0800 (PST)
Date:   Fri, 6 Nov 2020 12:46:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2 07/22] drm/msm: Do rpm get sooner in the submit path
Message-ID: <20201106071621.j732gt4nqifjrccd@vireshk-i7>
References: <CAKMK7uHAgVUPHOPxDdt3LeAWqokxfuzqjZj4qqFkoKxFbRbRrg@mail.gmail.com>
 <20201020112413.xbk2vow2kgjky3pb@vireshk-i7>
 <CAF6AEGsCj-AtFozn8d1xiNNFNbuMJ0UxS-eMhBVXiQ7rKahKnQ@mail.gmail.com>
 <20201022080644.2ck4okrxygmkuatn@vireshk-i7>
 <CAF6AEGv6RMCsK4yp-W2d1mVTMcEiiwFGAb+V8rYLhDdMhqP80Q@mail.gmail.com>
 <20201027113532.nriqqws7gdcu5su6@vireshk-i7>
 <20201103054715.4l5j57pyjz6zd6ed@vireshk-i7>
 <CAF6AEGtgUVXm6Wwod0FC38g91Q8CotLFSoC4NmXx7GzcA=1mOA@mail.gmail.com>
 <20201104030353.ny7zvakgb4fsye6r@vireshk-i7>
 <CAF6AEGv215ixcAWmaOWs7UKAqmbMs=aFyTBBYLU-bt8XBnWb7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGv215ixcAWmaOWs7UKAqmbMs=aFyTBBYLU-bt8XBnWb7g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-20, 11:24, Rob Clark wrote:
> On Tue, Nov 3, 2020 at 7:04 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 03-11-20, 08:50, Rob Clark wrote:
> > > sorry, it didn't apply cleanly (which I guess is due to some other
> > > dependencies that need to be picked back to v5.4 product kernel), and
> > > due to some other things I'm in middle of debugging I didn't have time
> > > yet to switch to v5.10-rc or look at what else needs to
> > > cherry-picked..
> > >
> > > If you could, pushing a branch with this patch somewhere would be a
> > > bit easier to work with (ie. fetch && cherry-pick is easier to deal
> > > with than picking things from list)
> >
> > It has been in linux-next for a few days. Here is the HEAD to pick
> > from. There are few patches there since rc1.
> >
> > commit 203e29749cc0 ("opp: Allocate the OPP table outside of opp_table_lock")
> >
> 
> sorry for the delay, with that cherry-picked, I'm getting a whole lot of:

Ahh, sorry about that and thanks for reporting it. Here is the fix:

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c718092757d9..6b7f0066942d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -112,8 +112,6 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
        struct opp_table *opp_table;
        struct device_node *opp_table_np;
 
-       lockdep_assert_held(&opp_table_lock);
-
        opp_table_np = of_get_parent(opp_np);
        if (!opp_table_np)
                goto err;
@@ -121,12 +119,15 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
        /* It is safe to put the node now as all we need now is its address */
        of_node_put(opp_table_np);
 
+       mutex_lock(&opp_table_lock);
        list_for_each_entry(opp_table, &opp_tables, node) {
                if (opp_table_np == opp_table->np) {
                        _get_opp_table_kref(opp_table);
+                       mutex_unlock(&opp_table_lock);
                        return opp_table;
                }
        }
+       mutex_unlock(&opp_table_lock);
 
 err:
        return ERR_PTR(-ENODEV);

-- 
viresh
