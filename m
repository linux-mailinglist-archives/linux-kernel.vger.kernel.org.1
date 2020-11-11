Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F12AEFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKKLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:34:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:34:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id j7so2211369wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niEGeS46KL7j58Ce9WSBmdiEs6qSuttHC6cIJBZy55s=;
        b=MM3rfh9rI9dpMI3bJTJ+z7wvvfQe6L4NaalgD/EHAldD/J8wp53ud6uDEHd6e/UYjS
         0Tsvb7d1SeHczGLY3bl3JnATZFP4JUPgn4zweOmmzFYyBNCC3wf5bTB5x0L6OfPzE6GZ
         ZdkoezDmOeV9U/g4/Wn/ZU2uRDuMhd+7TBpLUC/6DfDSoqCQaEtEdjgJMKxgaP0wLdUx
         8SsH+Sv46Aq8CO/g7qGA3RO6YxfQRG484odfYhIvEu3MGXOAF76tqLQ2d6lvK0Q8NX/K
         abPZWQAdOBjLl2kCJXc4P3AZLtA1ho95WILzwfMOceHVSyaVfXTKUxqWPabqleUfTBk1
         xV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niEGeS46KL7j58Ce9WSBmdiEs6qSuttHC6cIJBZy55s=;
        b=mHZm1os0rDZzeTpcUGvxG3MZzcZYNgn/zo1kU5+y2YdDkjDnFRkMpEskodMsOI4FHi
         Q1HkITM9CnSVTXKm6xM96+19MdPtobahvC7YDUB+cjT1gMHRAG4Y5tKd5Hqn3hbizXIN
         elsaDqLmft7pIT4V1ya130KzCHB5cY0pNIbHeYZrQuHetm6BVE9JptFjGQD2ih9FIxsm
         r0FBrT/Z+YaqN8xb6MLb7jaD2Tkx/P5TjFiFpVqq8teW/mOiehHKK+eStlZsTQXUfpTC
         FJenxzigeYLdJu2SHMpOiq7hN6oQgFpLHgmoZumbdxJ4gR3DodybOqSpRj/McPr3D4h/
         ADkA==
X-Gm-Message-State: AOAM533Mo9udgLa1NdIKr7mXZj2XYpqkFcHEhJGu0wOkfRg8mE90kjpW
        nJXGJC2xGGKRpNPBVee3ZxbB21jOb08jI+XyiyidH8fe4WM=
X-Google-Smtp-Source: ABdhPJzqMGxYjq54v5r6rhAjiwFGezolawt597/YGfmIx5uV5AcA9v5GJehwnHOw6hvo9y2RaUr2ARyheW6hX8/YN1s=
X-Received: by 2002:a5d:670f:: with SMTP id o15mr12832593wru.204.1605094472719;
 Wed, 11 Nov 2020 03:34:32 -0800 (PST)
MIME-Version: 1.0
References: <1605017534-87305-1-git-send-email-franck.lenormand@oss.nxp.com> <1605017534-87305-2-git-send-email-franck.lenormand@oss.nxp.com>
In-Reply-To: <1605017534-87305-2-git-send-email-franck.lenormand@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 11 Nov 2020 13:34:20 +0200
Message-ID: <CAEnQRZATCNaed_Jn=RQ3KL8iE1hYYgVP3wwskTiK1g_+F81Ucg@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] firmware: imx: scu-seco: Add Secure Controller APIS
To:     franck.lenormand@oss.nxp.com
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux@rempel-privat.de,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, qiangqing.zhang@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 4:15 PM <franck.lenormand@oss.nxp.com> wrote:
>
> From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

Looks good to me. Thanks Franck!

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
