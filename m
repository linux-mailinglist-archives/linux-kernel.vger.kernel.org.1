Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF622610E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGTNhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgGTNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:37:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E38C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:37:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so9735009lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZpmJNm5svvA/q8QYSzXvhKNzY6B8Xy3vujJIZLAStM=;
        b=SIDUIDG45TYLv0MQNd91uyzaG/HErMTaLiKHtiImWrZlz+LLDWEZIqj2Y6VxWKrwL8
         qYaOyIttnLdemwULBUEDSvrr4KNE0funOsAsaOki6E/lWs35hzgyuPmKPguyNZ9l6eJ0
         w/sBCFOuVt2oTKZbQAMTEDfHPbjOKbUFPh2mg1b3N2/4KdDvz6yQlyK9v+QOkenoDf7J
         tQ3G4em7JuN0dfnBCJCpVRlDBRNBzEyVyQA7L0D7Gemk5yl909FGHf6R+R4y5dXoPzY1
         5SAtx8OoHVwNPCb90dC4tEMsu8rHT5fsOUDayhRy84Jac2481uEoaKKoaq+/pKvxbaFc
         z8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZpmJNm5svvA/q8QYSzXvhKNzY6B8Xy3vujJIZLAStM=;
        b=PWt5UDDKP8iLjb3t0mVrDgS7SYJ+8siFw75akOHBqBGiKdX/mqoO0EhelzcmI9sP7W
         cDMPIOA4B7uPTEJtmYfYlVlPF0dZeHCNCR9Z42uoIZw6ocom44NU1MCJkYrwGMMMB+C5
         4qWmEZ6epHJaYyar0svdD3OrK3k0yydwC0IqlR7wlIJS7Oy7VIfWr2x5Z/00vkqojIDX
         dQrCCIOCtW7Du6AF5qcnKV/Rt4YzLCC1JCmngtBM0mnPv2jji9aXJse7sQoo9eDOEGWm
         3Hf0o54XvqCGXazraaIKvqKGcG+LtX0iu9VyvFtZ/bI0QcBj4mIwJtdIgsI4NWnJ7fqQ
         pT/A==
X-Gm-Message-State: AOAM531D1cbg3JdrLJD3FtSluvVoxR2CKxbFqW6WjDnjwvXti1cbBztW
        uDiPBSUCHyTMq0T8lXEsHvkh6OI08Ny6IMSho3qX+c+a0V8=
X-Google-Smtp-Source: ABdhPJyeI8DhmKgFkx1TCYW+jjWYvCzPJDpdQsRNI5NM2yaxoScX02vNkP8GoJ9I9L2/Z6Qh/FKgCLUXYorCAWtQnX0=
X-Received: by 2002:a05:6512:3150:: with SMTP id s16mr10919499lfi.47.1595252266604;
 Mon, 20 Jul 2020 06:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200715024701.28356-1-yuehaibing@huawei.com>
In-Reply-To: <20200715024701.28356-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 15:37:33 +0200
Message-ID: <CACRpkdYmdRN+KTkQ5WdE1_+9mqqRVxZo3++RvKBYNg6_xOQZ1w@mail.gmail.com>
Subject: Re: [PATCH -next] soc: integrator: Drop pointless static qualifier in integrator_soc_init()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 4:47 AM YueHaibing <yuehaibing@huawei.com> wrote:

> There is no need to have the 'struct regmap *syscon_regmap' variable
> static since new value always be assigned before use it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
