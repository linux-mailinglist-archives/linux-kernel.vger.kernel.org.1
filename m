Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6C2B13DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKMBfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgKMBfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:35:04 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFE4C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:35:04 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id oc3so1258517pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0c6tl60o4o4IAxwc3kn71Xsi+FyqnoS35zMm8Nu/A8=;
        b=kA6S0ea9m93bhJYaKlTi4Qzy/5x4fOLCBahvJF+5T9x5kjRpUGM7tVa3UTvqAQNFRl
         wysplxjy/dXF6mQToCCs1fOwiq2Ft59uCP6tajjhRnrqWlenE9zUdLv+8/YTPli9TqoO
         RIZrUwJHGx2I3C9V1LmXVpJPrME4tCibcB3xnos3LA/kyK8eXCLc/Ugj9niB2Ma3ATQE
         HYaKOlvU4yY4kuBQbUNYJgVl/E1jClGXzugvoElRsdfrtbGzfkKl3sIliVgPVO6ryRDt
         8O0nMHOVdsU8hWVoDXTLjkpnjrOImozh94NhP/LGuc4s3Avxnu8JCs1nFjRNJgoIPjY/
         I4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0c6tl60o4o4IAxwc3kn71Xsi+FyqnoS35zMm8Nu/A8=;
        b=fNErIYq/LEUm/CwGE/FWmgM/Oz/GLxn3MGDNyU3UX+4VDbuZ4d48lrIAo7WkDjNdC3
         1sYjLfZNFgLrehKV7xvmcy+L+LyczVDy97FYTuFII375rsNQCaA24YouA8EJpdlEQUZB
         ROG6m1ahEHsKdzIuiC6qpcP0YYP2Ma36thcn4z8V5nrx4Y3MKTii24V8NulsmML1ifLW
         hA7MFcgIB7DqsBqYBf74pz0iQRd47xD07sAIFwULW7YwdgOT69RsdPS7lYl+C1XbwX65
         yvsQtTwwUgFL1ckAhbP0LOQpCRCF5pUOZpmMxY5sG70iPEc4dhhNeIsDvIVBhW9HuJVP
         dNXg==
X-Gm-Message-State: AOAM533UCnz3otfowCYdp51DwFKZrYPOrjigavxx4jKC86RgJ419b1kq
        +4RMxCAYEZXHfNmfL2OrExwV5mXgFya4RKKfMOY=
X-Google-Smtp-Source: ABdhPJxoNm8Sv5xmJOViwzzpaxNS/W6ioEDdQ6G2TrfJaEsc13jsRF3oCqe6xvOo4EE+yywXDuFfjLNMmniMP4W7CIQ=
X-Received: by 2002:a17:902:b283:b029:d6:b2a7:3913 with SMTP id
 u3-20020a170902b283b02900d6b2a73913mr1924187plr.54.1605231301312; Thu, 12 Nov
 2020 17:35:01 -0800 (PST)
MIME-Version: 1.0
References: <eab9d7165fe30a74afc62d5b540b2dc3258196a4.1603799360.git.viresh.kumar@linaro.org>
 <20201111060226.cbq4pmwtrt7s2weq@vireshk-i7>
In-Reply-To: <20201111060226.cbq4pmwtrt7s2weq@vireshk-i7>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 12 Nov 2020 19:34:49 -0600
Message-ID: <CABb+yY1LH_3TdD4uLc297VOiuEkarWh5p4ZF2qDmbo1B0uH+dw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: arm_mhuv2: Add driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Morten Borup Petersen <morten_bp@live.dk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Usama Arif <usama.arif@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 12:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-10-20, 17:23, Viresh Kumar wrote:
> > This adds driver for the ARM MHUv2 (Message Handling Unit) mailbox
> > controller.
> >
> > This is based on the accepted DT bindings of the controller and supports
> > combination of all transport protocols, i.e. single-word, multi-word and
> > doorbell.
> >
> > Transmitting and receiving data through the mailbox framework in
> > multi-word mode is done through struct arm_mhuv2_mbox_msg. Rest of the
> > implementation details can be seen in the bindings document or in the
> > driver itself.
> >
> > Based on the initial work done by Morten Borup Petersen from ARM.
> >
> > Co-developed-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> > Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> > Tested-by: Usama Arif <usama.arif@arm.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Bindings are already reviewed by Rob and are present here:
> >
> > http://lore.kernel.org/lkml/61ca14fc441f92c1e7994e5bebae5c49811a3050.1602563406.git.viresh.kumar@linaro.org
>
> Jassi, Any inputs on this ?
>
Can we make 'single-word' as a special case of 'multi-word',  i.e,
effect single-word by specifying 1 sized multi-word.
And the names of structs and members could be lower case? It seems
very firmware style, or is it just me?

cheers.
