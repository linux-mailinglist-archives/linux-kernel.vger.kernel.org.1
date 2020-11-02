Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029FD2A370E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKBXRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:17:51 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C94C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 15:17:51 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id u62so16631027iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 15:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76wzgH+ulnX5dR7fbtCrLUNwOup4/JPWu6FMZzfCIOY=;
        b=bqcl/LODVNFwQWdCMXEmfVx956kuOJ7q6V4JOMev+jj5q9X0qocVWbgE4WGybS0/1D
         8ZnSR/Cd9u6tVYu6qwndIhjZU7L0iLKCZMbkQnhPNg2fNHqGW0lWeL8R5/Du1JLThd4x
         shSIPEnUjnASC1NEkcDxHi+ejeJxHfckSd5DnXqwIELHgOMaJI8cQTlO5JX25XRtOP+F
         Covz5Zd+ZNdjVMN6vqws5GN9DA9G+3+8QPzl2GKcp1QaRyr/hJIhGN+2j2fmoVb43ORR
         8lLdo3FR/QzNo8xtEv4dDgmlGxzRkWXFTb6gjlkxi80yiff5n9878GRQO8YHCy76/G9A
         16XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76wzgH+ulnX5dR7fbtCrLUNwOup4/JPWu6FMZzfCIOY=;
        b=dqTS1Y5TYFFAnuGDLFdeqKeH1W+1UfBnCQfkPsrOpYGgOaFwLfqXWwJnb/8rmE3B4A
         7l7LL9v3RLPLKL06XS8aHsxdyV87QaH6k/2KdxohOR5hdAR2x9rSpT3zlqF93MoQgh8m
         Q7WKU/VKGFDcEWIXhcziWQ7hI3C+XwTFELY1mgpAwzDYxsqeJ6Ucrmf1+Pea3wWBVHgT
         asoNPo3NpUaFyMNhz7DzovTY1r2aOmeXKlY/3y42x4ovsFUjRYKKcnmJngTJ/51BjvPb
         F2TiFnnDO1aMo+zhXhmBbnQf8mLT5FvhhwNZ7lWnTggbilLnQZ/eYrJ9AisHoRN/6H3O
         REEg==
X-Gm-Message-State: AOAM530/7/SkaplLBCR5GG4T3frqHIT7wbdKnkUErpWsaYVmvNoeKZxc
        IHiWg13nvW2ydGNKIgBjMZsidVWbsOKeNXu0e28ITBpi1Wk=
X-Google-Smtp-Source: ABdhPJzsaYcp6dQkNcXPIwxhTOw6uYO5/GycJnkjpUvp9aCzNokRv8kOazLBfEv9xf8+jhnZPb1fxbsHURbsSW9AA/8=
X-Received: by 2002:a05:6638:d7:: with SMTP id w23mr2439989jao.131.1604359071323;
 Mon, 02 Nov 2020 15:17:51 -0800 (PST)
MIME-Version: 1.0
References: <1966437.kWHqOGhHGQ@alarsen.net> <20201102201536.1267680-1-ztong0001@gmail.com>
 <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
In-Reply-To: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 2 Nov 2020 18:17:40 -0500
Message-ID: <CAA5qM4DC25+o1kJ_+3pMDHYsDfEeim=_3fLVsJ3pqSUAGZpdvw@mail.gmail.com>
Subject: Re: [PATCH v2] qnx4: do not interpret -EIO as a correct address
To:     David Laight <David.Laight@aculab.com>
Cc:     Anders Larsen <al@alarsen.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David,
Please take a look at v3 patch to see if it makes more sense.
Thanks,
- Tong
