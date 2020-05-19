Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF401DA318
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgESUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:49:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307AC08C5C0;
        Tue, 19 May 2020 13:49:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n18so470239pfa.2;
        Tue, 19 May 2020 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aenpIYrVnngrn4fK+cTcXF3ze/jHvb8tpFKtot7X6BM=;
        b=lZojkQsOTx7Il2ZFpXnNUduUBKE00V0V/0VihpAd61L9RARfMFuVIjxtt9NVlm1PFV
         CNW7AqmTxPXq7tYW7KQWRgoCb+DKYLVfIJ9NjpraSUv7QcK+PS9DCsQfDzqGIFmWZ/9E
         TnDfnKQ4yDtFGScO5MOwudgQS+ZUPhdIkm44qHLZlby6QzruLQcGH/h9yg+W4g3Ol3F9
         TnIg2UIRCjHAoAOCEFX3rg5iSRCWNvQObF3aDguQbTHdFgB87LL1h9tCONnpwIVuHVGJ
         b6IxbXqTnCI9hqisyP89ofZLrtvdbLLnTnco+M5WiDW4TtHSaSMgXH/OFaOgdHWDkOS6
         f51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aenpIYrVnngrn4fK+cTcXF3ze/jHvb8tpFKtot7X6BM=;
        b=AhN/iOW3YAI/cXLXFCdy+vMYsqbGSleNnrAzIbNrDGz1t3AV8TxMtrL9+sSDAbrWti
         wwnJw2CpzBQn7GvvO6YC9wRBVEoawF79Eh++HgZmlQD1+t7txXDfvL3avgD4mYSN/dzB
         X6myw2ALimi6diK/pWJ5Vz+hUs2+wpfcuVC6B+6qtkKLLaBqGjerpaGc+UdbfS0MaIZ7
         Q8/LEOycmEln2xy/6xiaVvUw5TZhsCHdv5op1EYwYFwzc824L+Dhzt0ylguzUwEiibpx
         aq/XhbHWK9eCun5qsBIpxwj5ump4ZzUiWmmblJBDbv50AvQ6pKhKeyNc+s5tORRqJUEL
         djEA==
X-Gm-Message-State: AOAM530nUbqBnzVW4n8p+bVbAzGvB7L8+wNp6l6WQJ5SDksqctYQe90U
        HyXbq5LFTxm56eSob1SIszoo0q98PU76/QfnJydpjK1Vq+Q=
X-Google-Smtp-Source: ABdhPJzX3vgbN/wiA25x2p7isN+vtjWGL1iAT8wymJHSHkhT/17ehBBEaZ3WbJeQERLWo57KovgMv7G+ftEU9vU/anA=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr958003pgb.74.1589921396937;
 Tue, 19 May 2020 13:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
In-Reply-To: <20200516122740.30665-1-grandmaster@al2klimov.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 May 2020 23:49:39 +0300
Message-ID: <CAHp75VevnkT5BohzWxtvdsP__sD0PmsaymXKB8c1cm9JHjw50w@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
To:     grandmaster@al2klimov.de
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 3:31 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> ... for security reasons.
>
> No breaking changes as either the HTTP vhost redirects to HTTPS
> or both vhosts redirect to the same location
> or both serve the same content.

I wonder how you tested that all changed URLs continue working after this.
I met some sites where https://, alas, doesn't work as expected.

-- 
With Best Regards,
Andy Shevchenko
