Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CEC2A7A97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgKEJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKEJbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:31:11 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3128C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:31:09 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id x1so987741oic.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVlXt5BRht7Msns3dWc+vm5sdIuxtjpHGFdLpNX48Es=;
        b=mbxPu3UK+fq+Ovztx/9psvRxP4INSGNNfXhjyN/7XZpPdiOw2hPOZxHaFYALt2WoDr
         CgEgMHhRqQAcwMqHx632hYUobRS2jbmpsVh110y0vHVbR5VGP6VIE4gko2uzJYGCKpf7
         L7LrnnBbbdNJzkb/3rs6argzCy8hPxzZUkRM/8G1p4BEhB+hfPZufa2IiMm2JNg873/u
         7zvk97cP1azTwPr9HYOR2XSnOkQznxnZda6ZlyYtCY1hlxFbFAKjhq83k+/l1TSKXI8k
         yaKy7x6Jk1w2ZZ20pv1lRoAnev2cAK8T1npaVL7mq4iYlvYO9S2gkPGMuDxhh/UJOLoD
         G6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVlXt5BRht7Msns3dWc+vm5sdIuxtjpHGFdLpNX48Es=;
        b=Oxv1dqSrx2HQx0nE8aQYIxkkRYlNIBJffm2Op8S7VT6pYETEEsipWh7Ux0tZFco0Nz
         f2pAjDO5+vKORIcCFZgjrfQxNVyVlGmsNyZOyjAesvMjEkBWa9Gb9KXT1LbwaCov081x
         sfn+zgf4VpCQUUqRTHaUQki28VdmyXG2hHVyawjdaw7EAkWBroDQxpq47rFDbqhQ1ybi
         AE9Z46hBJQ3qt817TOQy6DUK0LiHRIKSCGkb0eepDdo8IsEfCjJaiQxvmdqGpVS0UKmB
         +K7gjAQygllgAp/ZSVsmPzoEsJNhex5B0oZ54elkkmJ55b9HBXRV2JFU3cAoIG/MJxVr
         SWkg==
X-Gm-Message-State: AOAM530qh4g0A//fLJdycTWOLu9CYchsULHzlx9ZslB6RTjRS0rGCWvH
        s185T1VKPFUV5XJcIxY3SYWkZ+4du7fc47Dy2e7X2w==
X-Google-Smtp-Source: ABdhPJyrSKMg3Pisi32xbZXMPw/5VQzRrgQcEcttOCy/1JMCHMRUwxra8w/HmkA2JEIXs+L57kUi1P3riqpHoDNYjsM=
X-Received: by 2002:aca:4b82:: with SMTP id y124mr973648oia.35.1604568669184;
 Thu, 05 Nov 2020 01:31:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602838910.git.zong.li@sifive.com> <b10784643665ad56ca41ea6754c7f28f8be1c7ca.1602838910.git.zong.li@sifive.com>
 <160454434294.3965362.6100009498384462585@swboyd.mtv.corp.google.com>
 <CANXhq0qpEXejD765A5S5KfbuYQc=in5sFdEmk5K=BzZy2L=nmQ@mail.gmail.com> <87a6vw40v4.fsf@igel.home>
In-Reply-To: <87a6vw40v4.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 5 Nov 2020 17:30:58 +0800
Message-ID: <CANXhq0qmo4Vct3KAc9S71O1M6DwPpmU3AFPgnEFO=1BDdmcavQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: sifive: Extract prci core to common base
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        linux-clk@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 5:19 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Nov 05 2020, Zong Li wrote:
>
> > I tried to add -M and -C option to find renames and copies, but it
> > doesn't detect anything here.
>
> -C40 finds a copy drivers/clk/sifive/{fu540-prci.c => sifive-prci.c}.

Thanks! I used the default value of these options, I would create the
patch with -C40 in the next version.

>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
