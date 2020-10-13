Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69828D4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgJMTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbgJMTuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:50:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1DCC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:50:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so1092706lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oStFpL1sAklg8aQ9yJTrzYQkDSOL/BdJXdvIHiiieQ4=;
        b=EgxwghXHbFhUzfXmwnW3oWkcTuf9hghKJ+L0vimiZ2lNhz9ijKRICn6R1+VFJwxRfd
         3DO4aIph84yByZbN+yybxkssHP/RBykec4Cl4VJE58xKoOtU7gZtEMDeQg0S2eROjjBH
         rhqhqOEG94lka1wG1vNOxQhSRsutJq3Z20kn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oStFpL1sAklg8aQ9yJTrzYQkDSOL/BdJXdvIHiiieQ4=;
        b=TPhkbgdTb9po/6mWX6zeR7vfzkWnwsOY5FpCKUGcKtfc7CzHdaOnjnS6aznFT89jrn
         ae8OF87VURkVPl5yIjrg4sQ8K9D34y/+IQdCOTDt29SjCZDt2GZZXxCiW8fvhWAikyuu
         NrkTGdUexyalCorjy2RtE6+h324+k+q7Rza9bl7Wq+Bqg6hkXhQFGGNDP37ME8cAu/ye
         z21pwgw4AclL1bOtJxU46aegzXZNDP0Ww2+ZhnzzB1pzAS9FZzcy88+k/YKyJw/yuE6+
         dCiVHJAaF5Ap8O1u7mPzAhTS0DeOzFJmVP7nEs71bke3Gz6ifCWO06A/jnGEZge9kFxG
         md3Q==
X-Gm-Message-State: AOAM530wp4eEh1v1BbdDTz8WYB6CJWtIyY3ifHNtuGV2K1gdenqj6pe5
        agKW5Yb0wi9wsIzNNBKEGUG6FS4jDkVrrA==
X-Google-Smtp-Source: ABdhPJxchILebyNFHv4zSTru8JCql2wvoi/IgFq2xMJhrQx6roVaHJL+VhWGwEz1o5Ipwg7pVgLK8A==
X-Received: by 2002:a19:7418:: with SMTP id v24mr311401lfe.440.1602618646697;
        Tue, 13 Oct 2020 12:50:46 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id o23sm199289lji.68.2020.10.13.12.50.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:50:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id l28so1040112lfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:50:45 -0700 (PDT)
X-Received: by 2002:a19:cbcb:: with SMTP id b194mr322674lfg.133.1602618645500;
 Tue, 13 Oct 2020 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <36a6706d-73e1-64e7-f1f8-8f5ef246d3ea@kernel.dk>
 <CAHk-=wgUjjxhe2qREhdDm5VYYmLJWG2e_-+rgChf1aBkBqmtHw@mail.gmail.com> <a81737e4-44da-cffc-cba0-8aec984df240@kernel.dk>
In-Reply-To: <a81737e4-44da-cffc-cba0-8aec984df240@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Oct 2020 12:50:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAYpRhQkaFvqu+CnNcTHiMFrry_Ma6S8xGT_3BDEJkpA@mail.gmail.com>
Message-ID: <CAHk-=wjAYpRhQkaFvqu+CnNcTHiMFrry_Ma6S8xGT_3BDEJkpA@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring updates for 5.10-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 12:49 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> What clang are you using?

I have a self-built clang version from their development tree, since
I've been using it for the "asm goto with outputs" testing.

But I bet this happens with just regular reasonably up-to-date clang too.

            Linus
