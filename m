Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B92EB4DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbhAEV0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbhAEV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:26:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1405C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:25:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s26so1809428lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiPY1dmibSK4MubYSnWAxTqjr55ZR2eIdX5ruC5r4mU=;
        b=fcRyS9rIphRzn2ZoD+IEC0vUmDaUtbiaQ7Rac4paDfxdsejrpkaYWyeOp0bVDldz4M
         WNIdRAZViVn48wDZ8+XxTkQtzWgHvVQ5M/5xMOZHi7kuL92XldqtcvqHFFnsr8SdkkQf
         TdZEITDAC9grqnaz61mzz9Ar6pPxpBFAFGWN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiPY1dmibSK4MubYSnWAxTqjr55ZR2eIdX5ruC5r4mU=;
        b=sn2rFW5ivDabOqhNNQRDnNb5A2zOhMZnMmSuqKjlBkU5WAXOS7w1E7D8FvZLjiB+TT
         amkcoXJOf0Zd9vBsh6UK5bF9zb+pVtrtdaRqAqf4dLWtz/WBJ1PQTCg4LooL6ONxJ+/o
         RQbqJDVtB/iPdvPJYR2qPTatUjYwKJS/KDhwm/CjMhXMuCvPtz6rzvAVkzVtNQbhJA81
         mMuguEsDZQbf761w3mUL0B9E2qqU/aHHOTXsKa/VyInjpLYIG6J5EhHts4HinHafySVL
         WCNnA4WQBV9JRoIW1Z9ajhd5t0nc6SK4PW8YqAiw+kS1PrwTED51VZXPWm247wD/KCi+
         6C1w==
X-Gm-Message-State: AOAM532/7NTFiQTd3Cf+XLVFF40xjwPLanzbbgWiZoSh0LIu9mnnMQkx
        J01TgCwlfEdKidAS86bQNrzz6/d/n1VcHg==
X-Google-Smtp-Source: ABdhPJxyewnmpecDIN9pBWjzOtwbFgkozRMKKdr+0siCQ+sPzSBrssP0Ej5uBaPViNi4m0chOsemXw==
X-Received: by 2002:a19:857:: with SMTP id 84mr535496lfi.235.1609881934328;
        Tue, 05 Jan 2021 13:25:34 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c7sm35446lfm.262.2021.01.05.13.25.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 13:25:33 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id o13so1891791lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:25:33 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr486086lfl.41.1609881933003;
 Tue, 05 Jan 2021 13:25:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whS+rzNMSsU6vRoLMzrm0JPN-OVg+BxhybMet3NpqpR-Q@mail.gmail.com>
 <20210105184653.GA88051@roeck-us.net> <CAHk-=why7Sc=bypL-rbXevtoe8GjSv2ifSH1pVZn-ziAGKR+_A@mail.gmail.com>
 <20210105205737.GB230525@roeck-us.net>
In-Reply-To: <20210105205737.GB230525@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 13:25:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whHn5PUQx6MqzfWfxu9OhOcJkOfx9OL=FUWki7vBSJywA@mail.gmail.com>
Message-ID: <CAHk-=whHn5PUQx6MqzfWfxu9OhOcJkOfx9OL=FUWki7vBSJywA@mail.gmail.com>
Subject: Re: Linux 5.11-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 12:57 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> NP. The test are running automatically anyway, so I figured I might
> as well report the results. Does that make sense, or is it just noise ?

Definitely not noise. I very much like seeing the results.

In fact, even in situations like this, where the results are a subset
of what the previous rc already had, I very much like seeing them, if
only to make sure the issues don't get forgotten about.

So please continue for as long as you have the cycles available..

             Linus
