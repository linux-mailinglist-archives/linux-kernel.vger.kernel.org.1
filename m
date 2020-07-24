Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8622BB1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 02:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgGXArP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 20:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgGXArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:47:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C8C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:47:15 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m9so3433278qvx.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XYmEr/dSrcuydRY/J4CRIvkpVQzO7an5wNRsCMLzsE=;
        b=JBw9zyk5q7rkGP8BonBjp1r1uc2AVgF68/ZbcQUEb+tMYM2W2HNX0CY0yb+u5LA2Dk
         GEYkiCEsZugZmK1PmSG2dRJrZWF0HfJVfe+sQgaf6lhaNxxTPxaqzkDreHzYXRRucJE7
         vTU1pMOtKpZDDECsrxeAKEgkS2pP/M0OnmSog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XYmEr/dSrcuydRY/J4CRIvkpVQzO7an5wNRsCMLzsE=;
        b=rNuAZqYTLY/LuF630Oer6W60ViaUgS8YAacMgbkICyGwJ02q5bSNFSDw0zHWfP+Lel
         5kKClXji/7a8FKUKy7DRLRn6mLq7wCp19flJMmGLV+tRJI0ta/DSeFK8VR5ouTEFO42A
         gbpYNlw4PGqGDx4FwyK9HllQtu12OZLPkBt5ROfgOVDwL/6a9Ri6/SjuwuZPB2GonWi7
         aPkwakfs8QMtT/TXdorvBCi9KfY5AHi9qYqjv1fWmM2ZTeKA3p9KspUu47MhrnH+hAQw
         81rQPGX+qyY5//gUx4kggf7afLP5Uyw5OwVwhG7Pm/9ueKgu4klvPqbg1njDKUJ70yR3
         RFRQ==
X-Gm-Message-State: AOAM532DlmvkvB1SJj2paDSZfC+pv2WcM/prLLS+7dyaFjb1m6+0M/m0
        LojVtawf7TM71YXMMkj813yOSVvKybuxXhG1Ezq/Mg==
X-Google-Smtp-Source: ABdhPJw0FxvmAEdQYQfPclg4ExzOkN406yxubOFw3ciZJ0qoN78ocGcjb4oHIKnfAxUpb/25XGrptWf2CdL6pNNfUzI=
X-Received: by 2002:a0c:a8e6:: with SMTP id h38mr7533759qvc.15.1595551634294;
 Thu, 23 Jul 2020 17:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200710194017.1126000-1-pmalani@chromium.org>
 <CACeCKadwsH2yhqegZubgJnLy+p0CM3H1DzXiA-72Gagy2aYB-A@mail.gmail.com> <d09324a9-0a3e-3dd5-5521-dcd2d04a9d3f@collabora.com>
In-Reply-To: <d09324a9-0a3e-3dd5-5521-dcd2d04a9d3f@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 23 Jul 2020 17:47:02 -0700
Message-ID: <CACeCKae5Y9GfhAF1-geFAGDORhNfWq_kn_p3qAW_BqY+xzUaOA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: USB4 support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 8:27 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 21/7/20 21:55, Prashant Malani wrote:
> > Hey Enric, Benson,
> >
> > Just wondering if you've had a chance to review this patch.
> >
>
> It's on my radar but I'm waiting for the dependencies to be merged.
>
Understood. Thanks!

BR,

-Prashant
