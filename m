Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF726CC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgIPUlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgIPREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:04:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54092C02C287
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:04:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so6587600ljm.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUrT5gwD52MsR1wVTFrUE/WFQvwScZ/Kn5UNNx4HIXA=;
        b=JjID6IlfOKBWQ4lGtoBOpv1ttQeatHSDCajwiJ0azKXbH3YYrtGydW+Gxgc9Piel58
         YFhSrOBPjpmjpppbHq0U1XIL2d7aM4huBXm1h4WWTeRveWVq+kXGVPdqcbZUiqkY8pop
         Wd86Q/TDYKOncWV1Y5HGdXg4ibithp/E8iohuJpujgMxmv3d/X2gB4S8O8jMFW/FikAq
         FYHhoI1jGVqUqtPlRtThH8ISjo9nJmtJbc7R8zCOsqzCnsiOS6x38RzgGJY6PcCS1z4h
         LRNXYbtrV+wpzUFIBRj6Vj/XisBq07u82l92zuLu4ecwxS7qL7Y5yT/EKsYpV7mrhasE
         K9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUrT5gwD52MsR1wVTFrUE/WFQvwScZ/Kn5UNNx4HIXA=;
        b=VS89uWuk2IxAtxIiDjvtKsK2rkEU8ULBj/a/bxAREUW5R/RAgKMGewoSxP0XajmqnX
         0mXi3nSa2xIkiUdkJBrtCFSh7oGKuzBIgx28nDPods/HbyMeo9n47+DCa4Q9wCT8mQSL
         p++4IxjIaKHzgxdDyfKPLiYGJh8/x6vCpbsTNDEAvxo56gs8rpu0NTaV2Kf/FSFYMBJJ
         50zdHKqUdh9TFufBE2ZbyNejVVHCbUrRCOyFQSWPxEVLoJfv83sju6mvWA4htnQdO96Q
         hkHH4bl8RisfjfqqnnLVGZUD/zW38L3xs/Ur5cZSt1IprgOU9S0lSWb9NPBua5sjvWhC
         flMQ==
X-Gm-Message-State: AOAM532WRSh8L4AcWuhFgxJpwLaAXVxlwnzptIAmLx0SM91jZ69QbiIW
        9LnLI8ZAX6BTuXYv+95ZXvsdbxGaqBprOf7V5XI=
X-Google-Smtp-Source: ABdhPJyHd0Ooh4IK/vHvj2P4gv3lfDfIBiO8RqhPNolmmBPPICV/UOwNTXFmvzSGmOtJPgxjXHBzXE9TuLHprQ7UyvE=
X-Received: by 2002:a2e:a550:: with SMTP id e16mr9601438ljn.125.1600275845628;
 Wed, 16 Sep 2020 10:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com> <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Sep 2020 14:03:54 -0300
Message-ID: <CAOMZO5CZtdxbZdnXrckgYE7bzW-PDo2XOfQobuTf91C1hp462g@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_sai: Add new added registers and new bit definition
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Wed, Sep 16, 2020 at 7:23 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> On i.MX850/i.MX815/i.MX845 platform, the sai IP is upgraded.

Please avoid such internal SoC namings and use i.MX8MQ/i.MX8MN/iMX8MM instead.
