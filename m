Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E448C2A5579
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbgKCVSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388441AbgKCVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:18:47 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5098EC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 13:18:47 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id d24so20593649ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1oznCzOsfgXOnjkPl5WF72YkAccBrOZyur/fVTJggM=;
        b=UsJWIiTtAjnFwwv9bApjy2GgCUu0iWbipJntRxQ6dEMLm/5hQFlYzx3Z6xGETmnheM
         B7JlGY+lLtiGBnD0phF7JVug3zOEtgz5GP0Kz+9uTq5kvb+twlgPsPfsuywtXAFYWuqi
         eeaItfZdMpLcVhi/fbUDjY3vh0yHHGCIJmC2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1oznCzOsfgXOnjkPl5WF72YkAccBrOZyur/fVTJggM=;
        b=IG/B7CzF2koDPTdAiak+8oh2aom+yezXhaSyl7EbfqGt35nO94I3KYsd+OE+tHDdT4
         b2Snq7YftweF9C3NbueSMB8Be/S9doWZdoXD58c/+QDEtiIAkczcugjsA3IiOmsjrlG/
         mosgpzXkOhFaj5GN8CjQStuGDwzsnDUskUL+GQpG1bSyzVeYU8Z7Gd++NSnbfph+OEt5
         p+gyQhNQ1B/fwGJKuxDdAEYv8zzrGQq158I8Z1W8EfhgZAM68Nlv4TrfHsTR+l/+M3v/
         aoguhM2vw3H1GemsMQd6EnTHytTt3f7my9Wt9s65Xp6hSadJg6r5OwyUeWxWvQZCgs0z
         uB6A==
X-Gm-Message-State: AOAM531Z1u9fABq/HuS5bCCNtKAm58bNpqJ37NyHGP0pqxJ5eDdgxc24
        5RJHqkWfuu7VGX2WYgEtLJUoTVN5cAF+eA==
X-Google-Smtp-Source: ABdhPJxc4goW/n8oY61jZrdXX53Pn0gHKjKweNBPZi1N1D6KzK08Gox3CEnOyQUMgaeA0lGWpVtSUw==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr8711301lji.70.1604438325522;
        Tue, 03 Nov 2020 13:18:45 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v20sm19598ljj.50.2020.11.03.13.18.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 13:18:44 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 11so1081076ljf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:18:44 -0800 (PST)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr9088907lji.102.1604438323851;
 Tue, 03 Nov 2020 13:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20201103124420.46bf5a37@lwn.net>
In-Reply-To: <20201103124420.46bf5a37@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Nov 2020 13:18:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghhw0SpqSKKUqt5eum=UfLD3Qa0suoRxLy_cJc4hChug@mail.gmail.com>
Message-ID: <CAHk-=wghhw0SpqSKKUqt5eum=UfLD3Qa0suoRxLy_cJc4hChug@mail.gmail.com>
Subject: Re: [GIT PULL] Docs-build warning fixes for 5.10-rc3
To:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 11:44 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> This pull contains a series of warning fixes from Mauro; once applied, the
> number of warnings from the once-noisy docs build process is nearly zero.
> Getting to this point has required a lot of work; once there, hopefully we
> can keep things that way.

I wonder if it is quiet enough that we could make new doc build noise
trigger some kind of linux-next warning?

I know Stephen was at least looking at doc build warnings justding by
the thread a couple of weeks ago.

             Linus
