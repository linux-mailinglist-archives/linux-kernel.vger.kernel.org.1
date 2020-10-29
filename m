Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6829F11A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgJ2QSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgJ2QSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:18:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BDEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so3779377ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaUwELqsVQt9AxbcgLgdQhwL5XHLBmI70FYveScDdGk=;
        b=awZmE6BOJyvX8oSchdT2OXXoJNo8nAcYfsYExvMPSIQdyjDlecCpGPTPEhMHY8BLgh
         gtR1a70EtgjfyWQTzLyYrBJjJzKhWS29dYrA52S5v36AwRmwHIif1G9ToYk4mgglyya2
         QjPosLo/exdaTsxgiw8kLShu7eqeFQs7yW1kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaUwELqsVQt9AxbcgLgdQhwL5XHLBmI70FYveScDdGk=;
        b=PLTEIlB4UaW+BbhbkkO0rzyNk+kvyldSrLMoiOSSuwf3HqZvH3F/ZApuykPYKqNe7A
         Mrj/gd9ShHtOzPaTwFJIlqqacRgBIjSixOqcAl0VLYakwhh5dgSQjBnWL0UYXbUiHCjh
         +vzLMKk7jHEYGGGVXkC/OBGG1t6OhX3Ozb9zPXPwMyXgNgbL3mWN6SaOdeefFOunft3h
         gA7Ar2b9Bi4BHR26hoBN4gTU2LtGTrNqOg3O1irUh2Xpzmanz4OpjnLfbj4ylWFT6Jof
         NU5jaBpJjCwoA8mk0NfzpJeJCNyCjKQDbktZJlh8Bjat3n/dzQcE83gKSnBraxuAMlYO
         KA/A==
X-Gm-Message-State: AOAM530h5SvDCJeLc5/0GEt75evdqQoHJAa6xxbZwMI1x8iwKRlY9BpO
        G8UPOenxAYaJo0O3wCMvwnk3YFpOldbxkg==
X-Google-Smtp-Source: ABdhPJwhI+ikYURwTNU5ckereH0USLk3d8wCcb6xpHShCUVfZjQqfOdq6Jw2aMgvanC2HVPSGGTxeQ==
X-Received: by 2002:a2e:b888:: with SMTP id r8mr2114725ljp.138.1603988318100;
        Thu, 29 Oct 2020 09:18:38 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id j19sm90853lfm.97.2020.10.29.09.18.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:18:37 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m20so3739104ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:37 -0700 (PDT)
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr2058074ljj.250.1603988316744;
 Thu, 29 Oct 2020 09:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201029002827.1729915-1-evgreen@chromium.org>
 <20201028172737.v3.3.Ibb3eedcd634298b039e3af2ec43c7860ae947916@changeid> <c244ed8a-ccd4-6e7d-501c-e3d7f2da3916@linaro.org>
In-Reply-To: <c244ed8a-ccd4-6e7d-501c-e3d7f2da3916@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 29 Oct 2020 09:17:59 -0700
X-Gmail-Original-Message-ID: <CAE=gft6aAUdzB5rPDu4E33Pt_8Q=LcB++zmQdnpiyXbqW3Mhyg@mail.gmail.com>
Message-ID: <CAE=gft6aAUdzB5rPDu4E33Pt_8Q=LcB++zmQdnpiyXbqW3Mhyg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] nvmem: core: Add support for keepout regions
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 5:08 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks Evan for doing this,
>
> On 29/10/2020 00:28, Evan Green wrote:
> > Introduce support into the nvmem core for arrays of register ranges
> > that should not result in actual device access. For these regions a
> > constant byte (repeated) is returned instead on read, and writes are
> > quietly ignored and returned as successful.
> >
> > This is useful for instance if certain efuse regions are protected
> > from access by Linux because they contain secret info to another part
> > of the system (like an integrated modem).
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Overall the patch looks good for me.
> I have applied just this patch for more testing in next!
>
> I can pick up 1/4 and 4/4 once Rob's Ack/Reviews the patch!

Thank you, Srini!
-Evan
