Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C658A2C2964
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbgKXOXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388843AbgKXOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:23:19 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:23:16 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id v9so6851226uar.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9aWE8uwLcST815ETGDNopl3X1aPGXP5aK+bslaDOm0=;
        b=Wv37v5rpVApnirYnmz6Tp42C5v0zC+3iYfUaLhkm76QUTu19zaID9N6U+CDCqI+ZV6
         c5iDUiqlwJ+xG0K5BLygeByAkjP9aKWB+Gm6LDkMNu+TfQ+Ce7VFKxvv55G0hWl/Gc80
         MWmnXrdMvX3104nS6o5LnldzFrXdHD6CCTgrunH2QXLPRv2YkQVaQmv0Qq/2yWT2Mkrz
         TmRdkZQOfGHO7UEIMAUcWkUGOgJ0vrIZsxvDSoUvhnDHtRp0XDzZaQGXgocirvAGkK//
         f7CAWRau63bwEXPROMW3Yi6mzQibY7hFY62BSibmiJ9S0tWVHssYFMyHtmDS9T9kBW43
         uD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9aWE8uwLcST815ETGDNopl3X1aPGXP5aK+bslaDOm0=;
        b=rE2y4Cp+lwwRRm5fwGUgm55z/Q8elY6TRvRuvH3V9rgki2JGQXrB5c6OXCRpUOi0ZP
         ZvBC1vPzm0DUvTFBf8TUsfgtMf4gHZE7GbN+I5XooW/xXzwMa5swPn0Al4q/oPStUVi5
         8ys8B/yvhUnly1n2lmV++ldxp3U92D/29DfBpxKXi5EUuRrNEEZKGLGDZkGRtBMXzWlR
         IG2J4sDyHn2QRdWK62/nYcNtbIwpBDz4Jd3h+HhkL6C+pjUSakgXGHRPfVwsrY+CAX3v
         ZqbFxPkbwFjN6OSqIM6coCO9ecPY8XnXlexR7sKiyBlnH09BtlMutjApTQEhjfau74Sy
         a+vQ==
X-Gm-Message-State: AOAM532nJm/qTCAaSQtAQIjIbfeE8Hyg9qkstVSqOQct3WHgQgKx85ou
        cP3qtcHPTxPynN60lDoa2gCcodzlEqFN46qRpqdaFA==
X-Google-Smtp-Source: ABdhPJwBdd8AJ+i2pqoufDRPkyhArvXhuBYL4RfsrY0amm3+GeefYPdvSQa6YNvxG9RbeERNB5mkMtl9vfaJfWAxqXU=
X-Received: by 2002:ab0:60b1:: with SMTP id f17mr2910153uam.104.1606227795487;
 Tue, 24 Nov 2020 06:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20201123111925.28999-1-bbudiredla@marvell.com> <20201124113720.GA30440@infradead.org>
In-Reply-To: <20201124113720.GA30440@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:22:38 +0100
Message-ID: <CAPDyKFrmdGQ4--Ng_Thf2yb5py=XvAhf027j4pq++Z-djfUoJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 at 12:37, Christoph Hellwig <hch@infradead.org> wrote:
>
> Please hold this off for now.  I have a major rewrite of the pstore/blk
> interface pending..

Sure, thanks for letting us know!

Kind regards
Uffe
