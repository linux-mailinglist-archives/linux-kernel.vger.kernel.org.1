Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93892A9613
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgKFMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:17:15 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17071C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 04:17:15 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id f140so965528ybg.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 04:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqfIsNEjsKrt4kdC4DaJrSPlEefpbQse4P7YaoOqW9M=;
        b=VD1HSg9DAnRhD9QqAuEuTpZvuBtVS/xj8qIkD7u90LXglk/3ZO6dXB+gc4z6yKT84B
         2lpiZV0hPFJITr/onj13/iFZST36UVUVdXN5Bnczu9b0p/7q/bNggbwOUUCrmr4F8xPa
         2FVNWYAkdMTqd4VvRRGdn5alnIop2fNXWzWGd8lH5i5Fy9UN5GO+1IT8l3gAUx1rCyh3
         ISTjsWooHiLDAz3cUgQVe8ikDdNT35K/az6b5e9pulPxLq1xgwoMcVhuxQysQ2T27Bf8
         U3AP3++lwTxmzCPynkEDOyf6DoY1h7pLZfqml7CO1tW618qsZcTH6VDJiht39hXzoZZ9
         GTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqfIsNEjsKrt4kdC4DaJrSPlEefpbQse4P7YaoOqW9M=;
        b=LIED0hgH2JyXQ77c19vBBfn1tamn891INNLFeqaE8Nl9fIfHNd9OCAWL6odS5Sd4SW
         7poaifyVk7PRsRnnfqbtFBEnIpjKgvxYYDv0HRXUOfXzQOu/0WAtsl05bVY9awQbofm8
         gD8aN71UbgzmvpTGi2YsKsKmqsOpskr+RHZobgK++c054R8ZDzWwBKGLU1GZ9hIgLFNm
         RNFyJ2k9SW+bJ8WtTirLwHEWK0WHAtPnWIogtGjU7x+dAHHqqvWLUaYRqusgW77ARKPI
         8jVzxcxqXy6FVT1mGYpb43/nTJTVdGLBAwdT8l87FKCafZ53LmL0VHbeHYyd2SDIaqGe
         gMKQ==
X-Gm-Message-State: AOAM530ihx1BFgGgq9hjt1a3t5Y9QwLSO1liu9Dtb3LH92FHxzKeKenM
        6fpD69f9bz2LbEejQsrfYktxoK80K4yvzb4nMaQ=
X-Google-Smtp-Source: ABdhPJyBK9j3lnI8h+gfuOxKbNBl9vtHgce0kiD37XYmQsTAV2IGyxIAReaOYLzCkEdCztv7Gmz4XNep+DEA0skcnGU=
X-Received: by 2002:a25:4102:: with SMTP id o2mr2227672yba.115.1604665034446;
 Fri, 06 Nov 2020 04:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20201103095828.515831-1-poeschel@lemonage.de> <CANiq72mDG8YJLcpKuE+noUQY5B9K6Cc71ado_dyLFVVf_xzKwA@mail.gmail.com>
 <20201106101135.xesjdqg2z3hgpqnv@lem-wkst-02.lemonage>
In-Reply-To: <20201106101135.xesjdqg2z3hgpqnv@lem-wkst-02.lemonage>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 Nov 2020 13:17:03 +0100
Message-ID: <CANiq72niN_gB7Nq_+Vnf9CrBhFZF0_cew-kdj=rAURJ0DWJxnQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] Make charlcd device independent
To:     Lars Poeschel <poeschel@lemonage.de>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 11:11 AM Lars Poeschel <poeschel@lemonage.de> wrote:
>
> I got an email [1] with a report about a build failure in
> hd44780_common. The fix is simple but I don't know the process from here
> on. Should I post a v7 of the whole patchset or only a follow-up patch
> for the fix ?

Either would work (I can rebase it on my side). However, in order to
give credit to Randy, if the fix is integrated into a previous patch,
then I am not sure where we would put the Reported-by.

Randy, what people usually do for your reports on -next (or what do you prefer)?

Cheers,
Miguel
