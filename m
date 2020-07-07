Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0513F21759F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 19:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgGGRvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 13:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgGGRvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:51:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F65C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:51:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d21so25261533lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6QA6/mezcfJSRx290hBZ6N6Ue/QazF7NVVhp8hA0xk=;
        b=LA+Hl1tGxadJpCa9poJS1CqtFC/tP44PXJJtF/eVZdsQj52U0njp4sZvZEgu4e67rI
         AI7LhvTEauB0GLbSj9sSd5HJKYNdAKKJZ8YHNiFfIJ3bQz99opHUHXSqGexnG848vEeN
         JtSYUc2SqwWCMyfArnAplTFqXsWk4TkzkWfJ6Ls0/mBvdKBr0ZjkeekPdX1vG0+GfQsP
         Re+8vK186GlpW+GLOL1FoVvKYiY2mjzJ3TXIy9HLzkESybsprx6o88ilo6LE46Sa+PS/
         G1xytvf9GP2TIKxuxLRzhub1FsgLPtXmuRcQiYoNMNx2e3n92KVGpv/b+tb8abu3Dlo2
         SIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6QA6/mezcfJSRx290hBZ6N6Ue/QazF7NVVhp8hA0xk=;
        b=gfPOGfc5QDTLu7zVtZXbHPk1mdKoSdPnyQQ5GHMdt0J+bqtSYGX2jucmTGVdhoMEuE
         NrtNknxO2zNWHuAAqyhK8pfslRvPTXZIAbJJaRK9GtckkyznwopIMmTm3YTMleCNB2zA
         M/uvplbxA7deZVwZGfRDDW/iB++H8yOpiacwoLaGXOUUMWGHylNFYseLznDwkX44ek4g
         CfeW/LDRo9TEwS4EliRVMmmXlTfmucSXj9nT4vnr40DNiY/EVzgTgRqSKgIy9sIu+5EF
         PRLc5fOefpqejfJogbazmNyUcRuVGv0a8K3zo0rnigUyp+CSLHw+vrCsQQScY59PlNQ0
         tm8A==
X-Gm-Message-State: AOAM530h6tFggk9L90yS31tudVMrThudunD5WKDHS7VCAhqzVPAt49/T
        y/139qsOLSngv7t0mRVXP/urxokyTQxULk4RDOfw5g==
X-Google-Smtp-Source: ABdhPJxF9OYpo+EmQXlmUz1AvD7l7Xlk9cPziN72neSXFtiB2NFQTeRVU4zFxiZu2tZcmjfHDFpcLe9DoRKdOJiuHmA=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr33254771lfq.3.1594144260026;
 Tue, 07 Jul 2020 10:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200707173612.124425-1-guro@fb.com>
In-Reply-To: <20200707173612.124425-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Jul 2020 10:50:49 -0700
Message-ID: <CALvZod7sPmxTYhZMDM+JMb0_E7mFvEK9SMOW_xkzHk9f0SCEBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: memcg/slab: remove unused argument by charge_slab_page()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 10:36 AM Roman Gushchin <guro@fb.com> wrote:
>
> charge_slab_page() is not using the gfp argument anymore,
> remove it.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
