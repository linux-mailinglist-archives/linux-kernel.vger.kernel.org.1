Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8604D2CDD10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgLCSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbgLCSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:05:27 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94018C061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 10:04:46 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f18so3526320ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyvfbSevo8Se/4y3iGk+lQg5JO2pXQRwoWZK6AVmSCc=;
        b=Gjv1aL6P6xJwooMOiOVXI2rySRClbrUY3HGVe50LjDG6cXh38kZ+sHSB/0xeLOSW+9
         KzfnPdBnHXwJGIJd7YUlF/R7CYA7zxSe6UAPykXdN+th0PqF3iMNmSPkggw3h7OtjYFq
         jXrwfcED6y2TT4DMjNHYAYn4nz6N4tLwE3MVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyvfbSevo8Se/4y3iGk+lQg5JO2pXQRwoWZK6AVmSCc=;
        b=Pf08CVaEr3F1fhVuBQC7kh0OH13hdMSlmWr2eq6qodGa1YjBWbrde7Ymv//vCWqm77
         JfJ9ykFFaxTBADEJ/gfuWwzq3VBkMiIprTAYt5eT7EMgr2wio+kR4a0FqwQ+7Aghtup/
         7qNdfWSVe1Hm3okIZeHwGy/++5baa1XtkcZkXDy4cUfGgh2KC3podCkS3tQTXgrrzMkQ
         CfWcXYgij1wNJLlAx8jS3jEeec9rHpn2Qe3muDZyeL6WRtGlgPX4Rd6izCalubLeKTwK
         1aZMPpCMqGSUxQ1RObb1K+g0RIdu6pptttfmR+qqbDxrBfQYsk7jA0166lv7vAXkTKAX
         iFQw==
X-Gm-Message-State: AOAM532ezw1tslhDTQ0nuzs0u//1fjuL3x2Zqx1n1o6bBVMyWLawyzYN
        lF+t72U0JZmXmzMeuAIr0cmH+ifz9kXoGw==
X-Google-Smtp-Source: ABdhPJxWFpRWri1QhF8el/3F+wH2UfrhTqppSmigPMcw6D+vVw06Eua9hBAyOkStJsUzswEPbiig5g==
X-Received: by 2002:a2e:8983:: with SMTP id c3mr1680115lji.184.1607018684522;
        Thu, 03 Dec 2020 10:04:44 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u8sm752411lfo.168.2020.12.03.10.04.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 10:04:43 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id f24so3504136ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 10:04:42 -0800 (PST)
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr1626934ljj.314.1607018682473;
 Thu, 03 Dec 2020 10:04:42 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com> <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
 <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com> <20201203024504.GA1563847@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201203024504.GA1563847@iweiny-DESK2.sc.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 10:04:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWC==8VNeVG=_DwT+RT9x1uiseUDH0X9sYKMetrh6c3w@mail.gmail.com>
Message-ID: <CAHk-=whWC==8VNeVG=_DwT+RT9x1uiseUDH0X9sYKMetrh6c3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 6:45 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > What would the typical failure cases be in practice?
>
> The failure will be a user not seeing their file operating in DAX mode when
> they expect it to.
>
> I discussed this with Dan Williams today.  He and I agreed the flag is new
> enough that we don't think users have any released code to the API just yet.
> So I think we will be ok.

Ok, thanks for verification. I've applied it locally in my tree, it
will be pushed out later today with other work..

           Linus
