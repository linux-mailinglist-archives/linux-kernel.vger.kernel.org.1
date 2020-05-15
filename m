Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4771D4A28
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 11:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEOJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgEOJ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:57:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD0FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:57:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b6so1595993ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMOYfNEZkqpOwxdikoGlBP08jiU7JwSsPnMDuh6RRyE=;
        b=vvym3etztXXVkCTEQIqmvLL646Wn7PUlNmNteiiX6vD251ott7ib0iMU9IjQnQFeVI
         FygmI1w9w1/01lephMRKe6MOthQRKu5pYu1s0lcDU2/gPbfLXhYeRnp7USSWHbHlWs0B
         rVJ4Nqg/ZxXx10axnj/G1/srp7CmkxfmABm4ln+bf5dkgOS1LfL/BoHPOA8IHWCXAACr
         Biu0lPHJ+c6M9Wxt38SliC9NcBYeJ/587R++nAXrIfAKNyghAmcfIyJvyD2l2JBbr+Og
         IaFcU2fxuS2Vae73zPp70EBnZuF8vg0ydQEve2p8PA53EmtX+Yw5m2d0Sss0vLrODiib
         /Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMOYfNEZkqpOwxdikoGlBP08jiU7JwSsPnMDuh6RRyE=;
        b=q+7Iz6ycjZoMjZKhg1/1tqwVr0TL9+T42UKW7j6CJMeMSs2iHQ+PhZCiHXGiOxRsrI
         ZiOgaMejZVPK3chWRoJZqppnGwOijEZh9V/+jcADnfyzDFo4rbvSYrAwniLSaztuYjd/
         9U88RRC2uvUELUIXjTIsdtvuAdNbSMLn7GhH111NyRjnk3Pwh510qrdd6a6cXHwoO5Kd
         zunNKzCteJtUTIsf6OBAQE/SImd+gJI+LnpHfeaznbxY/MJz/0oFpR47iM9eD6pzfEod
         QVAqLWfbDwDAp6WvHG61kItaIUrUvDdkJy7WDJA5U0+veoWUECIbSckIjQLZAaxACp/8
         Xc3Q==
X-Gm-Message-State: AOAM533Oj0ji3KVgh0hK0hkqICZ1d1w1aukJATPFXcAbREZHK8pZkyoJ
        jT0hehN7R/q2LdEPIrzw0ZIEMmgHVyTbhTqZYLvgFw==
X-Google-Smtp-Source: ABdhPJzunetbL+zFc/cF/yJgQXxIwApcv4HFPrGl6rmOuOSSwSlKzA8Z3vhz3J17EH6DBzXvxjZbuHqvjb10wXIVlaQ=
X-Received: by 2002:a2e:3517:: with SMTP id z23mr1740322ljz.147.1589536650637;
 Fri, 15 May 2020 02:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200514082428.27864-1-etienne.carriere@linaro.org>
 <20200514142924.GC23401@bogus> <CAN5uoS_bimZsFqwaODRRWeCe15JMepQa2z9J0+dq7qNfwxRsug@mail.gmail.com>
 <20200515093424.GC23671@bogus>
In-Reply-To: <20200515093424.GC23671@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 15 May 2020 11:57:19 +0200
Message-ID: <CAN5uoS9Ar5MZRufsf-x=xjm29VfpYAB2T-L=T-Q+-zPiJoKqQw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix SMCCC_RET_NOT_SUPPORTED management
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Or consider part of the SCMI-SMC transport API that output arg a0
> > shall be 0 on success, SMCCC_RET_NOT_SUPPORTED if function ID is not
> > supported and any non-zero value for non-generic **error** codes.
> >
>
> I prefer that. Anyways I will check and if anything changes I will ping
> back on this thread.

I don't have a strong opinion on whether considering or not 0 as
success, for whatever the function ID used here for SCMI message
notification.
We can assume at least 0 is default returned in a0 when the function
ID is used in SCMI SMC transport.
Thanks for the feedback.

> --
> Regards,
> Sudeep
